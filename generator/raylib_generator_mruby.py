import ctypes, re, sys
import json
import raylib_parser

def sanitize_enum(ctx):
    pass

def sanitize_macro(ctx):
    # 0x____u -> 0x____
    pattern = re.compile(r'(0x[0-9a-fA-F]+)u')
    for macro_name, macro_value in ctx.decl_macros.items():
        if len(macro_value) != 1:
            continue
        m = re.search(pattern, macro_value[0])
        if m:
            ctx.decl_macros[macro_name][0] = m.group(1)

    # refer mapping
    for macro_name, macro_value in ctx.decl_macros.items():
        define_mapping = raylib_parser.get_define_mapping(macro_name)
        if define_mapping:
            ctx.decl_macros[macro_name] = define_mapping
        else:
            ctx.decl_macros[macro_name] = None

    # contatinate (SDL_INIT_EVERYTHING, etc.)
    for macro_name, macro_value in ctx.decl_macros.items():
        if macro_value == None or len(macro_value) <= 1:
            continue
        ctx.decl_macros[macro_name] = [''.join(macro_value)]

def sanitize_struct(ctx):
    for struct_name, struct_info in ctx.decl_structs.items():
        if struct_info == None:
            continue
        underlying_ctypes_type = "FFI::Union" if str(struct_info.kind) == "CursorKind.UNION_DECL" else "FFI::Struct"
        struct_info.kind = underlying_ctypes_type
        for field in struct_info.fields:
            field.type_kind = raylib_parser.get_cindex_ctypes_mapping(str(field.type_kind), field.type_name)

def sanitize_typedef(ctx):
    # refer mapping
    for typedef_name, typedef_info in ctx.decl_typedefs.items():
        if typedef_info.func_proto != None:
            for arg in typedef_info.func_proto.args:
                arg.type_kind = raylib_parser.get_cindex_ctypes_mapping(str(arg.type_kind), arg.type_name)
            typedef_info.func_proto.retval.type_kind = raylib_parser.get_cindex_ctypes_mapping(str(typedef_info.func_proto.retval.type_kind), typedef_info.func_proto.retval.type_name)
        else:
            if str(typedef_info.type_kind) == "TypeKind.RECORD":
                typedef_info.type_kind = None
            else:
                typedef_info.type_kind = raylib_parser.get_cindex_ctypes_mapping(str(typedef_info.type_kind), typedef_info.name)

def sanitize_function(ctx):
    for func_name, func_info in ctx.decl_functions.items():
        if func_info == None:
            continue
        for arg in func_info.args:
            if raylib_parser.is_raylib_callback_type(arg.type_kind, arg.type_name):
                arg.type_kind = ":" + arg.type_name
            else:
                arg.type_kind = raylib_parser.get_cindex_ctypes_mapping(str(arg.type_kind), arg.type_name)
        func_info.retval.type_kind = raylib_parser.get_cindex_ctypes_mapping(str(func_info.retval.type_kind), func_info.retval.type_name)

def sanitize(ctx):
    sanitize_enum(ctx)
    sanitize_macro(ctx)
    sanitize_struct(ctx)
    sanitize_typedef(ctx)
    sanitize_function(ctx)

####################################################################################################

def generate_macrodefine(ctx, indent = "", json_schema=None):
    for macro_name, macro_value in ctx.decl_macros.items():
        if macro_value != None:
            mrbval = ""
            if "\"" in macro_value[0]:
                mrbval = "mrb_str_new_cstr_frozen"
            elif "\." in macro_value[0]:
                mrbval = "mrb_float_value"
            elif any(elem in macro_value[0] for elem in r"\:\/"): # Math::PI / 180.0, etc.
                continue
            else:
                mrbval = "mrb_int_value"
            print(indent + "mrb_define_const(mrb, mRaylib, \"%s\", %s(mrb, %s));" % (macro_name, mrbval, macro_value[0]), file = sys.stdout)


def generate_enum(ctx, indent = "", json_schema=None):
    enum_typedefs = {}

    for enum_value in ctx.decl_enums.values():
        for enum in enum_value:
            enum_typedef_name = ctx.enum_constants[enum[0]].typedef_name
            if enum_typedef_name not in enum_typedefs.keys():
                enum_typedefs[enum_typedef_name] = []
            enum_typedefs[enum_typedef_name].append([enum[0], enum[1]])

    for enum_typedef_name, enum_info_array in enum_typedefs.items():
        print(indent + "// enum " + enum_typedef_name)
        for enum_info in enum_info_array:
            print(indent + "mrb_define_const(mrb, mRaylib, \"%s\", mrb_int_value(mrb, %s));" % (enum_info[0], enum_info[1]), file = sys.stdout)
        print("", file = sys.stdout)


def generate_structunion_rclass_datatype(ctx, indent = "", struct_prefix="", struct_postfix="", struct_alias=None, json_schema=None):
    if struct_prefix != "":
        print(struct_prefix, file = sys.stdout)
    for struct_name, struct_info in ctx.decl_structs.items():
        if struct_info == None:
            continue

        # Name of struct/class must be start with capital letter
        struct_name = struct_name[0].upper() + struct_name[1:]

        # Print body of struct from here
        print(indent + f'struct RClass* cRaylib{struct_name};', file = sys.stdout)

        print(indent + f'static const struct mrb_data_type mrb_raylib_struct_{struct_name} = {{', file = sys.stdout)
        print(indent + f'    "{struct_name}", mrb_free', file = sys.stdout)
        print(indent + '};', file = sys.stdout)
        print("", file = sys.stdout)

    if struct_postfix != "":
        print(struct_postfix, file = sys.stdout)


def generate_structunion_initialize(ctx, indent, struct_name, struct_info):
    if struct_info == None:
        return

    # Name of struct/class must be start with capital letter
    struct_name = struct_name[0].upper() + struct_name[1:]

    len_members = len(struct_info.fields)

    # Initializer
    print(indent + f'static mrb_value mrb_raylib_{struct_name}_initialize(mrb_state* mrb, mrb_value self)', file = sys.stdout)
    print(indent + '{', file = sys.stdout)
    print(indent + f'    {struct_name}* instance = ({struct_name}*)mrb_malloc(mrb, sizeof({struct_name}));', file = sys.stdout)
    print(indent + f'    mrb_int argc = mrb_get_argc(mrb);', file = sys.stdout)
    print(indent + f'    switch (argc) {{', file = sys.stdout)
    print(indent + f'    case 0:', file = sys.stdout)
    print(indent + f'    {{', file = sys.stdout)
    print(indent + f'        memset(instance, 0, sizeof({struct_name}));', file = sys.stdout)
    print(indent + f'        break;', file = sys.stdout)
    print(indent + f'    }}', file = sys.stdout)
    print(indent + f'    case {len_members}:', file = sys.stdout)
    print(indent + f'    {{', file = sys.stdout)
    print(indent + f'        mrb_value argv[{len_members}];', file = sys.stdout)
    argv_ptrs = "{ "
    for i in range(len_members):
        argv_ptrs += f'&argv[{i}], '
    argv_ptrs += "}"
    print(indent + f'        void* ptrs[{len_members}] = {argv_ptrs};', file = sys.stdout)
    format_string = "o" * len_members
    print(indent + f'        mrb_get_args_a(mrb, "{format_string}", ptrs);', file = sys.stdout)

    for idx, field in enumerate(struct_info.fields):
        if field.element_count > 1:
            if "char" in field.type_name:
                print(indent + f'        strncpy(instance->{field.element_name}, mrb_string_cstr(mrb, argv[{idx}]), sizeof(char) * {field.element_count});', file = sys.stdout)
            else:
                print(indent + f'        memcpy(instance->{field.element_name}, DATA_PTR(argv[{idx}]), sizeof({field.type_name}) * {field.element_count});', file = sys.stdout)
        elif "*" in field.type_name:
            print(indent + f'        instance->{field.element_name} = DATA_PTR(argv[{idx}]);', file = sys.stdout)
        elif any(ch.isupper() for ch in field.type_name):
            print(indent + f'        instance->{field.element_name} = *({field.type_name}*)DATA_PTR(argv[{idx}]);', file = sys.stdout)
        elif "float" in field.type_name:
            print(indent + f'        instance->{field.element_name} = mrb_as_float(mrb, argv[{idx}]);', file = sys.stdout)
        else:
            print(indent + f'        instance->{field.element_name} = mrb_as_int(mrb, argv[{idx}]);', file = sys.stdout)

    print(indent + f'    }}', file = sys.stdout)
    print(indent + f'    break;', file = sys.stdout)
    print(indent + f'    }}', file = sys.stdout)

    print(indent + f'    mrb_data_init(self, instance, &mrb_raylib_struct_{struct_name});', file = sys.stdout)
    print(indent + '    return self;', file = sys.stdout)
    print(indent + '}', file = sys.stdout)
    print("", file = sys.stdout)


def generate_structunion_accessor(ctx, indent, struct_name, struct_info):
    if struct_info == None:
        return

    # Name of struct/class must be start with capital letter
    struct_name = struct_name[0].upper() + struct_name[1:]

    len_members = len(struct_info.fields)

    # sizeof class
    print(indent + f'static mrb_value mrb_raylib_{struct_name}_class_size(mrb_state* mrb, mrb_value self)', file = sys.stdout)
    print(indent + '{', file = sys.stdout)
    print(indent + f'    return mrb_int_value(mrb, sizeof({struct_name}));', file = sys.stdout)
    print(indent + '}', file = sys.stdout)
    print("", file = sys.stdout)

    # accessors
    for idx, field in enumerate(struct_info.fields):
        if field.element_count > 1:
            if not "char" in field.type_name:
                print(indent + f'// static mrb_value mrb_raylib_{struct_name}_{field.element_name}_get(mrb_state* mrb, mrb_value self); // TODO add accessor which can handle array', file = sys.stdout)
                print(indent + f'// static mrb_value mrb_raylib_{struct_name}_{field.element_name}_set(mrb_state* mrb, mrb_value self); // TODO add accessor which can handle array', file = sys.stdout)
                print("", file = sys.stdout)
                continue # TODO add accessor which can handle array
        elif "*" in field.type_name:
            print(indent + f'// static mrb_value mrb_raylib_{struct_name}_{field.element_name}_get(mrb_state* mrb, mrb_value self); // TODO prepare Buffer version of classes', file = sys.stdout)
            print(indent + f'// static mrb_value mrb_raylib_{struct_name}_{field.element_name}_set(mrb_state* mrb, mrb_value self); // TODO prepare Buffer version of classes', file = sys.stdout)
            print("", file = sys.stdout)
            continue # TODO prepare Buffer version of classes

        print(indent + f'static mrb_value mrb_raylib_{struct_name}_{field.element_name}_get(mrb_state* mrb, mrb_value self)', file = sys.stdout)
        print(indent + '{', file = sys.stdout)
        print(indent + f'    {struct_name}* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_{struct_name}, {struct_name});', file = sys.stdout)

        if any(ch.isupper() for ch in field.type_name):
            print(indent + f'    return mrb_obj_value(&instance->{field.element_name});', file = sys.stdout);
        elif "char" in field.type_name and field.element_count > 1:
            print(indent + f'    return mrb_str_new_cstr(mrb, (const char*)&instance->{field.element_name});', file = sys.stdout);
        elif "float" in field.type_name:
            print(indent + f'    return mrb_float_value(mrb, instance->{field.element_name});', file = sys.stdout)
        else:
            print(indent + f'    return mrb_int_value(mrb, instance->{field.element_name});', file = sys.stdout)

        print(indent + '}', file = sys.stdout)
        print("", file = sys.stdout)

        print(indent + f'static mrb_value mrb_raylib_{struct_name}_{field.element_name}_set(mrb_state* mrb, mrb_value self)', file = sys.stdout)
        print(indent + '{', file = sys.stdout)
        print(indent + f'    {struct_name}* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_{struct_name}, {struct_name});', file = sys.stdout)
        print(indent + '    mrb_value argv;', file = sys.stdout)
        print(indent + '    mrb_get_args(mrb, "o", &argv);', file = sys.stdout)
        if field.element_count > 1:
            if "char" in field.type_name:
                print(indent + f'    strncpy(instance->{field.element_name}, mrb_string_cstr(mrb, argv), sizeof(char) * {field.element_count});', file = sys.stdout)
            else:
                print(indent + f'    memcpy(instance->{field.element_name}, DATA_PTR(argv), sizeof({field.type_name}) * {field.element_count});', file = sys.stdout)
        elif "*" in field.type_name:
            print(indent + f'    instance->{field.element_name} = DATA_PTR(argv);', file = sys.stdout)
        elif any(ch.isupper() for ch in field.type_name):
            print(indent + f'    instance->{field.element_name} = *({field.type_name}*)DATA_PTR(argv);', file = sys.stdout)
        elif "float" in field.type_name:
            print(indent + f'    instance->{field.element_name} = mrb_as_float(mrb, argv);', file = sys.stdout)
        else:
            print(indent + f'    instance->{field.element_name} = mrb_as_int(mrb, argv);', file = sys.stdout)
        print(indent + '    return self;', file = sys.stdout)
        print(indent + '}', file = sys.stdout)
        print("", file = sys.stdout)


def generate_structunion_methods(ctx, indent = "", struct_prefix="", struct_postfix="", struct_alias=None, json_schema=None):
    if struct_prefix != "":
        print(struct_prefix, file = sys.stdout)
    for struct_name, struct_info in ctx.decl_structs.items():
        generate_structunion_initialize(ctx, indent, struct_name, struct_info)
        generate_structunion_accessor(ctx, indent, struct_name, struct_info)

    if struct_postfix != "":
        print(struct_postfix, file = sys.stdout)


def generate_structunion_define_class(ctx, indent = "", struct_prefix="", struct_postfix="", struct_alias=None, json_schema=None):
    if struct_prefix != "":
        print(struct_prefix, file = sys.stdout)
    for struct_name, struct_info in ctx.decl_structs.items():
        if struct_info == None:
            continue

        # Name of struct/class must be start with capital letter
        struct_name = struct_name[0].upper() + struct_name[1:]

        # Definition
        print(indent + f'    cRaylib{struct_name} = mrb_define_class_under(mrb, mRaylib, "{struct_name}", mrb->object_class);', file = sys.stdout)
        print(indent + f'    MRB_SET_INSTANCE_TT(cRaylib{struct_name}, MRB_TT_DATA);', file = sys.stdout)
        print(indent + f'    mrb_define_class_method(mrb, cRaylib{struct_name}, "size", mrb_raylib_{struct_name}_class_size, MRB_ARGS_NONE());', file = sys.stdout)
        print(indent + f'    mrb_define_method(mrb, cRaylib{struct_name}, "initialize", mrb_raylib_{struct_name}_initialize, MRB_ARGS_OPT(1));', file = sys.stdout)
        # Accessors
        for idx, field in enumerate(struct_info.fields):
            if field.element_count > 1:
                if not "char" in field.type_name:
                    print(indent + f'    // mrb_define_method(mrb, cRaylib{struct_name}, "{field.element_name}", mrb_raylib_{struct_name}_{field.element_name}_get, MRB_ARGS_NONE()); // TODO add accessor which can handle array', file = sys.stdout)
                    print(indent + f'    // mrb_define_method(mrb, cRaylib{struct_name}, "{field.element_name}=", mrb_raylib_{struct_name}_{field.element_name}_set, MRB_ARGS_REQ(1)); // TODO add accessor which can handle array', file = sys.stdout)
                    continue # TODO add accessor which can handle array
            elif "*" in field.type_name:
                print(indent + f'    // mrb_define_method(mrb, cRaylib{struct_name}, "{field.element_name}", mrb_raylib_{struct_name}_{field.element_name}_get, MRB_ARGS_NONE()); // TODO prepare Buffer version of classes', file = sys.stdout)
                print(indent + f'    // mrb_define_method(mrb, cRaylib{struct_name}, "{field.element_name}=", mrb_raylib_{struct_name}_{field.element_name}_set, MRB_ARGS_REQ(1)); // TODO prepare Buffer version of classes', file = sys.stdout)
                continue # TODO prepare Buffer version of classes
            print(indent + f'    mrb_define_method(mrb, cRaylib{struct_name}, "{field.element_name}", mrb_raylib_{struct_name}_{field.element_name}_get, MRB_ARGS_NONE());', file = sys.stdout)
            print(indent + f'    mrb_define_method(mrb, cRaylib{struct_name}, "{field.element_name}=", mrb_raylib_{struct_name}_{field.element_name}_set, MRB_ARGS_REQ(1));', file = sys.stdout)
            pass
        print("", file = sys.stdout)

    if struct_postfix != "":
        print(struct_postfix, file = sys.stdout)


class FunctionEntry:
    def __init__(self, original_name, explicit_name):
        self.original_name = original_name
        self.explicit_name = explicit_name
        self.retval = None
        self.arg_types = ""
        self.arg_names = ""
        self.description = ""
        self.ret_description = ""
        self.arg_descriptions = []

def generate_function_body(ctx, indent = "", module_name = ""):
    for func_name, func_info in ctx.decl_functions.items():
        if func_info == None:
            continue

        unsupported = any(("va_list" in arg.type_name) for arg in func_info.args)
        if unsupported:
            continue

        retval_type_name = func_info.retval.type_name

        print(f'static mrb_value mrb_raylib_{func_name}(mrb_state* mrb, mrb_value self)', file = sys.stdout)
        print('{', file = sys.stdout)
        have_args = len(func_info.args) > 0
        have_retval = (retval_type_name != "void")
        # Get arguments
        if have_args:
            len_args = len(func_info.args)
            print(indent + f'mrb_value argv[{len_args}];', file = sys.stdout)
            argv_ptrs = "{ "
            for i in range(len_args):
                argv_ptrs += f'&argv[{i}], '
            argv_ptrs += "}"
            print(indent + f'void* ptrs[{len_args}] = {argv_ptrs};', file = sys.stdout)
            format_string = "o" * len_args
            print(indent + f'mrb_get_args_a(mrb, "{format_string}", ptrs);', file = sys.stdout)

            for i, arg in enumerate(func_info.args):
                arg_value = ""
                if "const char *" == arg.type_name:
                    arg_value = f'RSTRING_PTR(argv[{i}])'
                elif "*" in arg.type_name:
                    arg_value = f'DATA_PTR(argv[{i}])'
                elif any(ch.isupper() for ch in arg.type_name):
                    arg_value = f'*({arg.type_name}*)DATA_PTR(argv[{i}])'
                elif "float" in arg.type_name:
                    arg_value = f'mrb_as_float(mrb, argv[{i}])'
                else:
                    arg_value = f'mrb_as_int(mrb, argv[{i}])'

                print(indent + f'{arg.type_name} {arg.name} = {arg_value};', file = sys.stdout)

            print("", file = sys.stdout)

        # Call API
        args_name_list = list(map((lambda t: str(t.name)), func_info.args))
        arg_names = ', '.join(args_name_list)

        if have_retval:
            retval_str = ""
            if any(ch.isupper() for ch in retval_type_name):
                if "*" in retval_type_name:
                    retval_str = f'/* TODO return wrapped object */ {retval_type_name} retval = '
                    print(indent + f'return self; /* TODO return wrapped object */', file = sys.stdout)
                else:
                    retval_type_name_alias = retval_type_name
                    if retval_type_name == "Texture2D":
                        retval_type_name_alias = "Texture"
                    elif retval_type_name == "TextureCubemap":
                        retval_type_name_alias = "Texture"
                    elif retval_type_name == "RenderTexture2D":
                        retval_type_name_alias = "RenderTexture"
                    print(indent + f'{retval_type_name}* retval = ({retval_type_name}*)mrb_malloc(mrb, sizeof({retval_type_name}));', file = sys.stdout)
                    print(indent + f'*retval = {func_name}({arg_names});', file = sys.stdout)
                    print(indent + f'return mrb_obj_value(Data_Wrap_Struct(mrb, cRaylib{retval_type_name_alias}, &mrb_raylib_struct_{retval_type_name_alias}, retval));', file = sys.stdout)
            else:
                retval_str = f'{retval_type_name} retval = '
                print(indent + f'{retval_str}{func_name}({arg_names});', file = sys.stdout)
                print("", file = sys.stdout)

                if "const char *" == retval_type_name:
                    print(indent + f'return mrb_str_new_cstr(mrb, retval);', file = sys.stdout)
                elif "*" in retval_type_name:
                    print(indent + f'return mrb_cptr_value(mrb, retval);', file = sys.stdout)
                elif "float" in retval_type_name:
                    print(indent + f'return mrb_float_value(mrb, retval);', file = sys.stdout)
                elif "bool" in retval_type_name:
                    print(indent + f'return retval ? mrb_true_value() : mrb_false_value();', file = sys.stdout)
                else:
                    print(indent + f'return mrb_int_value(mrb, retval);', file = sys.stdout)
        else:
            print(indent + f'{func_name}({arg_names});', file = sys.stdout)
            print("", file = sys.stdout)
            print(indent + f'return mrb_nil_value();', file = sys.stdout)
        print('}', file = sys.stdout)
        print("", file = sys.stdout)


def generate_function_entry(ctx, indent = "", module_name = ""):
    for func_name, func_info in ctx.decl_functions.items():
        if func_info == None:
            continue
        unsupported = any(("va_list" in arg.type_name) for arg in func_info.args)
        if unsupported:
            continue

        retval_str = ""
        if len(func_info.args) > 0:
            retval_str = f'MRB_ARGS_REQ({len(func_info.args)})'
        else:
            retval_str = "MRB_ARGS_NONE()"
        print(indent + f'mrb_define_module_function(mrb, mRaylib, "{func_name}", mrb_raylib_{func_name}, {retval_str});', file = sys.stdout)


def generate(ctx, *, module_name = "", table_prefix = "Raylib_", typedef_prefix="", typedef_postfix="", struct_prefix="", struct_postfix="", struct_alias=None, function_prefix="", function_postfix="", json_schema=None):
    indent = "    "

    print("// Copyright (c) 2023 vaiorabbit <http://twitter.com/vaiorabbit>", file = sys.stdout)
    print("// Autogenerated. Do NOT edit.\n", file = sys.stdout)

    print("""
#include <mruby.h>
#include <mruby/class.h>
#include <mruby/compile.h>
#include <mruby/data.h>
#include <mruby/string.h>

#include <raylib.h>

#include <string.h>

struct RClass* mRaylib;

""", file = sys.stdout)

    # struct/union : RClass and mrb_data_type

    # struct/union
    if len(ctx.decl_structs) > 0:
        print("// Struct\n", file = sys.stdout)
        generate_structunion_rclass_datatype(ctx, "", struct_prefix, struct_postfix, struct_alias, json_schema)
        print("", file = sys.stdout)

    # struct/union methods
    if len(ctx.decl_structs) > 0:
        print("// Struct\n", file = sys.stdout)
        generate_structunion_methods(ctx, "", struct_prefix, struct_postfix, struct_alias, json_schema)
        print("", file = sys.stdout)

    # function
    if len(ctx.decl_functions) > 0:
        print("// Function\n", file = sys.stdout)
        generate_function_body(ctx, indent, module_name)

    print(f'void mrb_{module_name}_module_init(mrb_state* mrb)', file = sys.stdout)
    print('{', file = sys.stdout)
    print(indent + "mRaylib = mrb_define_module(mrb, \"Raylib\");\n", file = sys.stdout)

    # macro
    if len(ctx.decl_macros) > 0:
        print("", file = sys.stdout)
        print(indent + "// Define/Macro\n", file = sys.stdout)
        generate_macrodefine(ctx, indent, json_schema)
        print("", file = sys.stdout)

    # enum
    if len(ctx.decl_enums) > 0:
        print(indent + "// Enum\n", file = sys.stdout)
        generate_enum(ctx, indent, json_schema)
        print("", file = sys.stdout)

    # struct/union define class
    if len(ctx.decl_structs) > 0:
        print(indent + "// Struct\n", file = sys.stdout)
        generate_structunion_define_class(ctx, "", struct_prefix, struct_postfix, struct_alias, json_schema)
        print("", file = sys.stdout)

    # function
    if len(ctx.decl_functions) > 0:
        print(indent + "// Function\n", file = sys.stdout)
        generate_function_entry(ctx, indent, module_name)

    print('}', file = sys.stdout)


if __name__ == "__main__":
    pass
