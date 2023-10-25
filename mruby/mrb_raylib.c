/*
    $ clang -c -I`brew --prefix mruby`/include -I../raylib_dll/raylib/src mrb_raylib.c `brew --prefix mruby`/lib/libmruby.a ../lib/libraylib.a -lm -framework IOKit -framework Cocoa -framework OpenGL -o mrb_raylib.o
    $ ar rc libmrb_raylib.a mrb_raylib.o
*/

#include <mruby.h>
#include <mruby/class.h>
#include <mruby/compile.h>
#include <mruby/data.h>
#include <mruby/string.h>

#include <raylib.h>

#include <string.h>

struct RClass* mRaylib;


// Struct

struct RClass* cRaylibVector2;
static const struct mrb_data_type mrb_raylib_struct_Vector2 = {
    "Vector2", mrb_free
};

struct RClass* cRaylibVector3;
static const struct mrb_data_type mrb_raylib_struct_Vector3 = {
    "Vector3", mrb_free
};

struct RClass* cRaylibVector4;
static const struct mrb_data_type mrb_raylib_struct_Vector4 = {
    "Vector4", mrb_free
};

struct RClass* cRaylibMatrix;
static const struct mrb_data_type mrb_raylib_struct_Matrix = {
    "Matrix", mrb_free
};

struct RClass* cRaylibColor;
static const struct mrb_data_type mrb_raylib_struct_Color = {
    "Color", mrb_free
};

struct RClass* cRaylibRectangle;
static const struct mrb_data_type mrb_raylib_struct_Rectangle = {
    "Rectangle", mrb_free
};

struct RClass* cRaylibImage;
static const struct mrb_data_type mrb_raylib_struct_Image = {
    "Image", mrb_free
};

struct RClass* cRaylibTexture;
static const struct mrb_data_type mrb_raylib_struct_Texture = {
    "Texture", mrb_free
};

struct RClass* cRaylibRenderTexture;
static const struct mrb_data_type mrb_raylib_struct_RenderTexture = {
    "RenderTexture", mrb_free
};

struct RClass* cRaylibNPatchInfo;
static const struct mrb_data_type mrb_raylib_struct_NPatchInfo = {
    "NPatchInfo", mrb_free
};

struct RClass* cRaylibGlyphInfo;
static const struct mrb_data_type mrb_raylib_struct_GlyphInfo = {
    "GlyphInfo", mrb_free
};

struct RClass* cRaylibFont;
static const struct mrb_data_type mrb_raylib_struct_Font = {
    "Font", mrb_free
};

struct RClass* cRaylibCamera3D;
static const struct mrb_data_type mrb_raylib_struct_Camera3D = {
    "Camera3D", mrb_free
};

struct RClass* cRaylibCamera2D;
static const struct mrb_data_type mrb_raylib_struct_Camera2D = {
    "Camera2D", mrb_free
};

struct RClass* cRaylibMesh;
static const struct mrb_data_type mrb_raylib_struct_Mesh = {
    "Mesh", mrb_free
};

struct RClass* cRaylibShader;
static const struct mrb_data_type mrb_raylib_struct_Shader = {
    "Shader", mrb_free
};

struct RClass* cRaylibMaterialMap;
static const struct mrb_data_type mrb_raylib_struct_MaterialMap = {
    "MaterialMap", mrb_free
};

struct RClass* cRaylibMaterial;
static const struct mrb_data_type mrb_raylib_struct_Material = {
    "Material", mrb_free
};

struct RClass* cRaylibTransform;
static const struct mrb_data_type mrb_raylib_struct_Transform = {
    "Transform", mrb_free
};

struct RClass* cRaylibBoneInfo;
static const struct mrb_data_type mrb_raylib_struct_BoneInfo = {
    "BoneInfo", mrb_free
};

struct RClass* cRaylibModel;
static const struct mrb_data_type mrb_raylib_struct_Model = {
    "Model", mrb_free
};

struct RClass* cRaylibModelAnimation;
static const struct mrb_data_type mrb_raylib_struct_ModelAnimation = {
    "ModelAnimation", mrb_free
};

struct RClass* cRaylibRay;
static const struct mrb_data_type mrb_raylib_struct_Ray = {
    "Ray", mrb_free
};

struct RClass* cRaylibRayCollision;
static const struct mrb_data_type mrb_raylib_struct_RayCollision = {
    "RayCollision", mrb_free
};

struct RClass* cRaylibBoundingBox;
static const struct mrb_data_type mrb_raylib_struct_BoundingBox = {
    "BoundingBox", mrb_free
};

struct RClass* cRaylibWave;
static const struct mrb_data_type mrb_raylib_struct_Wave = {
    "Wave", mrb_free
};

struct RClass* cRaylibAudioStream;
static const struct mrb_data_type mrb_raylib_struct_AudioStream = {
    "AudioStream", mrb_free
};

struct RClass* cRaylibSound;
static const struct mrb_data_type mrb_raylib_struct_Sound = {
    "Sound", mrb_free
};

struct RClass* cRaylibMusic;
static const struct mrb_data_type mrb_raylib_struct_Music = {
    "Music", mrb_free
};

struct RClass* cRaylibVrDeviceInfo;
static const struct mrb_data_type mrb_raylib_struct_VrDeviceInfo = {
    "VrDeviceInfo", mrb_free
};

struct RClass* cRaylibVrStereoConfig;
static const struct mrb_data_type mrb_raylib_struct_VrStereoConfig = {
    "VrStereoConfig", mrb_free
};

struct RClass* cRaylibFilePathList;
static const struct mrb_data_type mrb_raylib_struct_FilePathList = {
    "FilePathList", mrb_free
};


// Struct

static mrb_value mrb_raylib_Vector2_initialize(mrb_state* mrb, mrb_value self)
{
    Vector2* instance = (Vector2*)mrb_malloc(mrb, sizeof(Vector2));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(Vector2));
        break;
    }
    case 2:
    {
        mrb_value argv[2];
        void* ptrs[2] = { &argv[0], &argv[1], };
        mrb_get_args_a(mrb, "oo", ptrs);
        instance->x = mrb_as_float(mrb, argv[0]); // :float float 1
        instance->y = mrb_as_float(mrb, argv[1]); // :float float 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_Vector2);
    return self;
}

static mrb_value mrb_raylib_Vector2_x_get(mrb_state* mrb, mrb_value self)
{
    Vector2* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Vector2, Vector2);
    return mrb_float_value(mrb, instance->x);
}

static mrb_value mrb_raylib_Vector2_x_set(mrb_state* mrb, mrb_value self)
{
    Vector2* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Vector2, Vector2);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->x = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Vector2_y_get(mrb_state* mrb, mrb_value self)
{
    Vector2* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Vector2, Vector2);
    return mrb_float_value(mrb, instance->y);
}

static mrb_value mrb_raylib_Vector2_y_set(mrb_state* mrb, mrb_value self)
{
    Vector2* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Vector2, Vector2);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->y = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Vector3_initialize(mrb_state* mrb, mrb_value self)
{
    Vector3* instance = (Vector3*)mrb_malloc(mrb, sizeof(Vector3));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(Vector3));
        break;
    }
    case 3:
    {
        mrb_value argv[3];
        void* ptrs[3] = { &argv[0], &argv[1], &argv[2], };
        mrb_get_args_a(mrb, "ooo", ptrs);
        instance->x = mrb_as_float(mrb, argv[0]); // :float float 1
        instance->y = mrb_as_float(mrb, argv[1]); // :float float 1
        instance->z = mrb_as_float(mrb, argv[2]); // :float float 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_Vector3);
    return self;
}

static mrb_value mrb_raylib_Vector3_x_get(mrb_state* mrb, mrb_value self)
{
    Vector3* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Vector3, Vector3);
    return mrb_float_value(mrb, instance->x);
}

static mrb_value mrb_raylib_Vector3_x_set(mrb_state* mrb, mrb_value self)
{
    Vector3* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Vector3, Vector3);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->x = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Vector3_y_get(mrb_state* mrb, mrb_value self)
{
    Vector3* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Vector3, Vector3);
    return mrb_float_value(mrb, instance->y);
}

static mrb_value mrb_raylib_Vector3_y_set(mrb_state* mrb, mrb_value self)
{
    Vector3* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Vector3, Vector3);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->y = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Vector3_z_get(mrb_state* mrb, mrb_value self)
{
    Vector3* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Vector3, Vector3);
    return mrb_float_value(mrb, instance->z);
}

static mrb_value mrb_raylib_Vector3_z_set(mrb_state* mrb, mrb_value self)
{
    Vector3* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Vector3, Vector3);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->z = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Vector4_initialize(mrb_state* mrb, mrb_value self)
{
    Vector4* instance = (Vector4*)mrb_malloc(mrb, sizeof(Vector4));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(Vector4));
        break;
    }
    case 4:
    {
        mrb_value argv[4];
        void* ptrs[4] = { &argv[0], &argv[1], &argv[2], &argv[3], };
        mrb_get_args_a(mrb, "oooo", ptrs);
        instance->x = mrb_as_float(mrb, argv[0]); // :float float 1
        instance->y = mrb_as_float(mrb, argv[1]); // :float float 1
        instance->z = mrb_as_float(mrb, argv[2]); // :float float 1
        instance->w = mrb_as_float(mrb, argv[3]); // :float float 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_Vector4);
    return self;
}

static mrb_value mrb_raylib_Vector4_x_get(mrb_state* mrb, mrb_value self)
{
    Vector4* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Vector4, Vector4);
    return mrb_float_value(mrb, instance->x);
}

static mrb_value mrb_raylib_Vector4_x_set(mrb_state* mrb, mrb_value self)
{
    Vector4* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Vector4, Vector4);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->x = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Vector4_y_get(mrb_state* mrb, mrb_value self)
{
    Vector4* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Vector4, Vector4);
    return mrb_float_value(mrb, instance->y);
}

static mrb_value mrb_raylib_Vector4_y_set(mrb_state* mrb, mrb_value self)
{
    Vector4* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Vector4, Vector4);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->y = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Vector4_z_get(mrb_state* mrb, mrb_value self)
{
    Vector4* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Vector4, Vector4);
    return mrb_float_value(mrb, instance->z);
}

static mrb_value mrb_raylib_Vector4_z_set(mrb_state* mrb, mrb_value self)
{
    Vector4* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Vector4, Vector4);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->z = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Vector4_w_get(mrb_state* mrb, mrb_value self)
{
    Vector4* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Vector4, Vector4);
    return mrb_float_value(mrb, instance->w);
}

static mrb_value mrb_raylib_Vector4_w_set(mrb_state* mrb, mrb_value self)
{
    Vector4* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Vector4, Vector4);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->w = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Matrix_initialize(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = (Matrix*)mrb_malloc(mrb, sizeof(Matrix));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(Matrix));
        break;
    }
    case 16:
    {
        mrb_value argv[16];
        void* ptrs[16] = { &argv[0], &argv[1], &argv[2], &argv[3], &argv[4], &argv[5], &argv[6], &argv[7], &argv[8], &argv[9], &argv[10], &argv[11], &argv[12], &argv[13], &argv[14], &argv[15], };
        mrb_get_args_a(mrb, "oooooooooooooooo", ptrs);
        instance->m0 = mrb_as_float(mrb, argv[0]); // :float float 1
        instance->m4 = mrb_as_float(mrb, argv[1]); // :float float 1
        instance->m8 = mrb_as_float(mrb, argv[2]); // :float float 1
        instance->m12 = mrb_as_float(mrb, argv[3]); // :float float 1
        instance->m1 = mrb_as_float(mrb, argv[4]); // :float float 1
        instance->m5 = mrb_as_float(mrb, argv[5]); // :float float 1
        instance->m9 = mrb_as_float(mrb, argv[6]); // :float float 1
        instance->m13 = mrb_as_float(mrb, argv[7]); // :float float 1
        instance->m2 = mrb_as_float(mrb, argv[8]); // :float float 1
        instance->m6 = mrb_as_float(mrb, argv[9]); // :float float 1
        instance->m10 = mrb_as_float(mrb, argv[10]); // :float float 1
        instance->m14 = mrb_as_float(mrb, argv[11]); // :float float 1
        instance->m3 = mrb_as_float(mrb, argv[12]); // :float float 1
        instance->m7 = mrb_as_float(mrb, argv[13]); // :float float 1
        instance->m11 = mrb_as_float(mrb, argv[14]); // :float float 1
        instance->m15 = mrb_as_float(mrb, argv[15]); // :float float 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_Matrix);
    return self;
}

static mrb_value mrb_raylib_Matrix_m0_get(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    return mrb_float_value(mrb, instance->m0);
}

static mrb_value mrb_raylib_Matrix_m0_set(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->m0 = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Matrix_m4_get(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    return mrb_float_value(mrb, instance->m4);
}

static mrb_value mrb_raylib_Matrix_m4_set(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->m4 = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Matrix_m8_get(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    return mrb_float_value(mrb, instance->m8);
}

static mrb_value mrb_raylib_Matrix_m8_set(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->m8 = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Matrix_m12_get(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    return mrb_float_value(mrb, instance->m12);
}

static mrb_value mrb_raylib_Matrix_m12_set(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->m12 = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Matrix_m1_get(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    return mrb_float_value(mrb, instance->m1);
}

static mrb_value mrb_raylib_Matrix_m1_set(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->m1 = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Matrix_m5_get(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    return mrb_float_value(mrb, instance->m5);
}

static mrb_value mrb_raylib_Matrix_m5_set(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->m5 = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Matrix_m9_get(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    return mrb_float_value(mrb, instance->m9);
}

static mrb_value mrb_raylib_Matrix_m9_set(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->m9 = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Matrix_m13_get(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    return mrb_float_value(mrb, instance->m13);
}

static mrb_value mrb_raylib_Matrix_m13_set(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->m13 = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Matrix_m2_get(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    return mrb_float_value(mrb, instance->m2);
}

static mrb_value mrb_raylib_Matrix_m2_set(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->m2 = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Matrix_m6_get(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    return mrb_float_value(mrb, instance->m6);
}

static mrb_value mrb_raylib_Matrix_m6_set(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->m6 = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Matrix_m10_get(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    return mrb_float_value(mrb, instance->m10);
}

static mrb_value mrb_raylib_Matrix_m10_set(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->m10 = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Matrix_m14_get(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    return mrb_float_value(mrb, instance->m14);
}

static mrb_value mrb_raylib_Matrix_m14_set(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->m14 = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Matrix_m3_get(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    return mrb_float_value(mrb, instance->m3);
}

static mrb_value mrb_raylib_Matrix_m3_set(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->m3 = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Matrix_m7_get(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    return mrb_float_value(mrb, instance->m7);
}

static mrb_value mrb_raylib_Matrix_m7_set(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->m7 = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Matrix_m11_get(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    return mrb_float_value(mrb, instance->m11);
}

static mrb_value mrb_raylib_Matrix_m11_set(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->m11 = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Matrix_m15_get(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    return mrb_float_value(mrb, instance->m15);
}

static mrb_value mrb_raylib_Matrix_m15_set(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Matrix, Matrix);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->m15 = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Color_initialize(mrb_state* mrb, mrb_value self)
{
    Color* instance = (Color*)mrb_malloc(mrb, sizeof(Color));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(Color));
        break;
    }
    case 4:
    {
        mrb_value argv[4];
        void* ptrs[4] = { &argv[0], &argv[1], &argv[2], &argv[3], };
        mrb_get_args_a(mrb, "oooo", ptrs);
        instance->r = mrb_as_int(mrb, argv[0]); // :uchar unsigned char 1
        instance->g = mrb_as_int(mrb, argv[1]); // :uchar unsigned char 1
        instance->b = mrb_as_int(mrb, argv[2]); // :uchar unsigned char 1
        instance->a = mrb_as_int(mrb, argv[3]); // :uchar unsigned char 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_Color);
    return self;
}

static mrb_value mrb_raylib_Color_r_get(mrb_state* mrb, mrb_value self)
{
    Color* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Color, Color);
    return mrb_str_new_cstr(mrb, (const char*)&instance->r);
}

static mrb_value mrb_raylib_Color_r_set(mrb_state* mrb, mrb_value self)
{
    Color* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Color, Color);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->r = mrb_as_int(mrb, argv); // :uchar unsigned char 1
    return self;
}

static mrb_value mrb_raylib_Color_g_get(mrb_state* mrb, mrb_value self)
{
    Color* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Color, Color);
    return mrb_str_new_cstr(mrb, (const char*)&instance->g);
}

static mrb_value mrb_raylib_Color_g_set(mrb_state* mrb, mrb_value self)
{
    Color* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Color, Color);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->g = mrb_as_int(mrb, argv); // :uchar unsigned char 1
    return self;
}

static mrb_value mrb_raylib_Color_b_get(mrb_state* mrb, mrb_value self)
{
    Color* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Color, Color);
    return mrb_str_new_cstr(mrb, (const char*)&instance->b);
}

static mrb_value mrb_raylib_Color_b_set(mrb_state* mrb, mrb_value self)
{
    Color* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Color, Color);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->b = mrb_as_int(mrb, argv); // :uchar unsigned char 1
    return self;
}

static mrb_value mrb_raylib_Color_a_get(mrb_state* mrb, mrb_value self)
{
    Color* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Color, Color);
    return mrb_str_new_cstr(mrb, (const char*)&instance->a);
}

static mrb_value mrb_raylib_Color_a_set(mrb_state* mrb, mrb_value self)
{
    Color* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Color, Color);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->a = mrb_as_int(mrb, argv); // :uchar unsigned char 1
    return self;
}

static mrb_value mrb_raylib_Rectangle_initialize(mrb_state* mrb, mrb_value self)
{
    Rectangle* instance = (Rectangle*)mrb_malloc(mrb, sizeof(Rectangle));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(Rectangle));
        break;
    }
    case 4:
    {
        mrb_value argv[4];
        void* ptrs[4] = { &argv[0], &argv[1], &argv[2], &argv[3], };
        mrb_get_args_a(mrb, "oooo", ptrs);
        instance->x = mrb_as_float(mrb, argv[0]); // :float float 1
        instance->y = mrb_as_float(mrb, argv[1]); // :float float 1
        instance->width = mrb_as_float(mrb, argv[2]); // :float float 1
        instance->height = mrb_as_float(mrb, argv[3]); // :float float 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_Rectangle);
    return self;
}

static mrb_value mrb_raylib_Rectangle_x_get(mrb_state* mrb, mrb_value self)
{
    Rectangle* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Rectangle, Rectangle);
    return mrb_float_value(mrb, instance->x);
}

static mrb_value mrb_raylib_Rectangle_x_set(mrb_state* mrb, mrb_value self)
{
    Rectangle* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Rectangle, Rectangle);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->x = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Rectangle_y_get(mrb_state* mrb, mrb_value self)
{
    Rectangle* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Rectangle, Rectangle);
    return mrb_float_value(mrb, instance->y);
}

static mrb_value mrb_raylib_Rectangle_y_set(mrb_state* mrb, mrb_value self)
{
    Rectangle* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Rectangle, Rectangle);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->y = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Rectangle_width_get(mrb_state* mrb, mrb_value self)
{
    Rectangle* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Rectangle, Rectangle);
    return mrb_float_value(mrb, instance->width);
}

static mrb_value mrb_raylib_Rectangle_width_set(mrb_state* mrb, mrb_value self)
{
    Rectangle* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Rectangle, Rectangle);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->width = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Rectangle_height_get(mrb_state* mrb, mrb_value self)
{
    Rectangle* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Rectangle, Rectangle);
    return mrb_float_value(mrb, instance->height);
}

static mrb_value mrb_raylib_Rectangle_height_set(mrb_state* mrb, mrb_value self)
{
    Rectangle* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Rectangle, Rectangle);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->height = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Image_initialize(mrb_state* mrb, mrb_value self)
{
    Image* instance = (Image*)mrb_malloc(mrb, sizeof(Image));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(Image));
        break;
    }
    case 5:
    {
        mrb_value argv[5];
        void* ptrs[5] = { &argv[0], &argv[1], &argv[2], &argv[3], &argv[4], };
        mrb_get_args_a(mrb, "ooooo", ptrs);
        instance->data = DATA_PTR(argv[0]); // :pointer void * 1
        instance->width = mrb_as_int(mrb, argv[1]); // :int int 1
        instance->height = mrb_as_int(mrb, argv[2]); // :int int 1
        instance->mipmaps = mrb_as_int(mrb, argv[3]); // :int int 1
        instance->format = mrb_as_int(mrb, argv[4]); // :int int 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_Image);
    return self;
}

static mrb_value mrb_raylib_Image_width_get(mrb_state* mrb, mrb_value self)
{
    Image* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Image, Image);
    return mrb_int_value(mrb, instance->width);
}

static mrb_value mrb_raylib_Image_width_set(mrb_state* mrb, mrb_value self)
{
    Image* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Image, Image);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->width = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_Image_height_get(mrb_state* mrb, mrb_value self)
{
    Image* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Image, Image);
    return mrb_int_value(mrb, instance->height);
}

static mrb_value mrb_raylib_Image_height_set(mrb_state* mrb, mrb_value self)
{
    Image* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Image, Image);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->height = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_Image_mipmaps_get(mrb_state* mrb, mrb_value self)
{
    Image* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Image, Image);
    return mrb_int_value(mrb, instance->mipmaps);
}

static mrb_value mrb_raylib_Image_mipmaps_set(mrb_state* mrb, mrb_value self)
{
    Image* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Image, Image);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->mipmaps = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_Image_format_get(mrb_state* mrb, mrb_value self)
{
    Image* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Image, Image);
    return mrb_int_value(mrb, instance->format);
}

static mrb_value mrb_raylib_Image_format_set(mrb_state* mrb, mrb_value self)
{
    Image* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Image, Image);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->format = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_Texture_initialize(mrb_state* mrb, mrb_value self)
{
    Texture* instance = (Texture*)mrb_malloc(mrb, sizeof(Texture));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(Texture));
        break;
    }
    case 5:
    {
        mrb_value argv[5];
        void* ptrs[5] = { &argv[0], &argv[1], &argv[2], &argv[3], &argv[4], };
        mrb_get_args_a(mrb, "ooooo", ptrs);
        instance->id = mrb_as_int(mrb, argv[0]); // :uint unsigned int 1
        instance->width = mrb_as_int(mrb, argv[1]); // :int int 1
        instance->height = mrb_as_int(mrb, argv[2]); // :int int 1
        instance->mipmaps = mrb_as_int(mrb, argv[3]); // :int int 1
        instance->format = mrb_as_int(mrb, argv[4]); // :int int 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_Texture);
    return self;
}

static mrb_value mrb_raylib_Texture_id_get(mrb_state* mrb, mrb_value self)
{
    Texture* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Texture, Texture);
    return mrb_int_value(mrb, instance->id);
}

static mrb_value mrb_raylib_Texture_id_set(mrb_state* mrb, mrb_value self)
{
    Texture* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Texture, Texture);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->id = mrb_as_int(mrb, argv); // :uint unsigned int 1
    return self;
}

static mrb_value mrb_raylib_Texture_width_get(mrb_state* mrb, mrb_value self)
{
    Texture* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Texture, Texture);
    return mrb_int_value(mrb, instance->width);
}

static mrb_value mrb_raylib_Texture_width_set(mrb_state* mrb, mrb_value self)
{
    Texture* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Texture, Texture);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->width = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_Texture_height_get(mrb_state* mrb, mrb_value self)
{
    Texture* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Texture, Texture);
    return mrb_int_value(mrb, instance->height);
}

static mrb_value mrb_raylib_Texture_height_set(mrb_state* mrb, mrb_value self)
{
    Texture* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Texture, Texture);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->height = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_Texture_mipmaps_get(mrb_state* mrb, mrb_value self)
{
    Texture* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Texture, Texture);
    return mrb_int_value(mrb, instance->mipmaps);
}

static mrb_value mrb_raylib_Texture_mipmaps_set(mrb_state* mrb, mrb_value self)
{
    Texture* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Texture, Texture);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->mipmaps = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_Texture_format_get(mrb_state* mrb, mrb_value self)
{
    Texture* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Texture, Texture);
    return mrb_int_value(mrb, instance->format);
}

static mrb_value mrb_raylib_Texture_format_set(mrb_state* mrb, mrb_value self)
{
    Texture* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Texture, Texture);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->format = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_RenderTexture_initialize(mrb_state* mrb, mrb_value self)
{
    RenderTexture* instance = (RenderTexture*)mrb_malloc(mrb, sizeof(RenderTexture));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(RenderTexture));
        break;
    }
    case 3:
    {
        mrb_value argv[3];
        void* ptrs[3] = { &argv[0], &argv[1], &argv[2], };
        mrb_get_args_a(mrb, "ooo", ptrs);
        instance->id = mrb_as_int(mrb, argv[0]); // :uint unsigned int 1
        instance->texture = *(Texture*)DATA_PTR(argv[1]); // Texture Texture 1
        instance->depth = *(Texture*)DATA_PTR(argv[2]); // Texture Texture 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_RenderTexture);
    return self;
}

static mrb_value mrb_raylib_RenderTexture_id_get(mrb_state* mrb, mrb_value self)
{
    RenderTexture* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_RenderTexture, RenderTexture);
    return mrb_int_value(mrb, instance->id);
}

static mrb_value mrb_raylib_RenderTexture_id_set(mrb_state* mrb, mrb_value self)
{
    RenderTexture* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_RenderTexture, RenderTexture);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->id = mrb_as_int(mrb, argv); // :uint unsigned int 1
    return self;
}

static mrb_value mrb_raylib_RenderTexture_texture_get(mrb_state* mrb, mrb_value self)
{
    RenderTexture* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_RenderTexture, RenderTexture);
    return mrb_obj_value(&instance->texture);
}

static mrb_value mrb_raylib_RenderTexture_texture_set(mrb_state* mrb, mrb_value self)
{
    RenderTexture* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_RenderTexture, RenderTexture);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->texture = *(Texture*)DATA_PTR(argv); // Texture Texture 1
    return self;
}

static mrb_value mrb_raylib_RenderTexture_depth_get(mrb_state* mrb, mrb_value self)
{
    RenderTexture* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_RenderTexture, RenderTexture);
    return mrb_obj_value(&instance->depth);
}

static mrb_value mrb_raylib_RenderTexture_depth_set(mrb_state* mrb, mrb_value self)
{
    RenderTexture* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_RenderTexture, RenderTexture);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->depth = *(Texture*)DATA_PTR(argv); // Texture Texture 1
    return self;
}

static mrb_value mrb_raylib_NPatchInfo_initialize(mrb_state* mrb, mrb_value self)
{
    NPatchInfo* instance = (NPatchInfo*)mrb_malloc(mrb, sizeof(NPatchInfo));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(NPatchInfo));
        break;
    }
    case 6:
    {
        mrb_value argv[6];
        void* ptrs[6] = { &argv[0], &argv[1], &argv[2], &argv[3], &argv[4], &argv[5], };
        mrb_get_args_a(mrb, "oooooo", ptrs);
        instance->source = *(Rectangle*)DATA_PTR(argv[0]); // Rectangle Rectangle 1
        instance->left = mrb_as_int(mrb, argv[1]); // :int int 1
        instance->top = mrb_as_int(mrb, argv[2]); // :int int 1
        instance->right = mrb_as_int(mrb, argv[3]); // :int int 1
        instance->bottom = mrb_as_int(mrb, argv[4]); // :int int 1
        instance->layout = mrb_as_int(mrb, argv[5]); // :int int 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_NPatchInfo);
    return self;
}

static mrb_value mrb_raylib_NPatchInfo_source_get(mrb_state* mrb, mrb_value self)
{
    NPatchInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_NPatchInfo, NPatchInfo);
    return mrb_obj_value(&instance->source);
}

static mrb_value mrb_raylib_NPatchInfo_source_set(mrb_state* mrb, mrb_value self)
{
    NPatchInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_NPatchInfo, NPatchInfo);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->source = *(Rectangle*)DATA_PTR(argv); // Rectangle Rectangle 1
    return self;
}

static mrb_value mrb_raylib_NPatchInfo_left_get(mrb_state* mrb, mrb_value self)
{
    NPatchInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_NPatchInfo, NPatchInfo);
    return mrb_int_value(mrb, instance->left);
}

static mrb_value mrb_raylib_NPatchInfo_left_set(mrb_state* mrb, mrb_value self)
{
    NPatchInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_NPatchInfo, NPatchInfo);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->left = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_NPatchInfo_top_get(mrb_state* mrb, mrb_value self)
{
    NPatchInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_NPatchInfo, NPatchInfo);
    return mrb_int_value(mrb, instance->top);
}

static mrb_value mrb_raylib_NPatchInfo_top_set(mrb_state* mrb, mrb_value self)
{
    NPatchInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_NPatchInfo, NPatchInfo);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->top = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_NPatchInfo_right_get(mrb_state* mrb, mrb_value self)
{
    NPatchInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_NPatchInfo, NPatchInfo);
    return mrb_int_value(mrb, instance->right);
}

static mrb_value mrb_raylib_NPatchInfo_right_set(mrb_state* mrb, mrb_value self)
{
    NPatchInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_NPatchInfo, NPatchInfo);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->right = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_NPatchInfo_bottom_get(mrb_state* mrb, mrb_value self)
{
    NPatchInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_NPatchInfo, NPatchInfo);
    return mrb_int_value(mrb, instance->bottom);
}

static mrb_value mrb_raylib_NPatchInfo_bottom_set(mrb_state* mrb, mrb_value self)
{
    NPatchInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_NPatchInfo, NPatchInfo);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->bottom = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_NPatchInfo_layout_get(mrb_state* mrb, mrb_value self)
{
    NPatchInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_NPatchInfo, NPatchInfo);
    return mrb_int_value(mrb, instance->layout);
}

static mrb_value mrb_raylib_NPatchInfo_layout_set(mrb_state* mrb, mrb_value self)
{
    NPatchInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_NPatchInfo, NPatchInfo);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->layout = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_GlyphInfo_initialize(mrb_state* mrb, mrb_value self)
{
    GlyphInfo* instance = (GlyphInfo*)mrb_malloc(mrb, sizeof(GlyphInfo));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(GlyphInfo));
        break;
    }
    case 5:
    {
        mrb_value argv[5];
        void* ptrs[5] = { &argv[0], &argv[1], &argv[2], &argv[3], &argv[4], };
        mrb_get_args_a(mrb, "ooooo", ptrs);
        instance->value = mrb_as_int(mrb, argv[0]); // :int int 1
        instance->offsetX = mrb_as_int(mrb, argv[1]); // :int int 1
        instance->offsetY = mrb_as_int(mrb, argv[2]); // :int int 1
        instance->advanceX = mrb_as_int(mrb, argv[3]); // :int int 1
        instance->image = *(Image*)DATA_PTR(argv[4]); // Image Image 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_GlyphInfo);
    return self;
}

static mrb_value mrb_raylib_GlyphInfo_value_get(mrb_state* mrb, mrb_value self)
{
    GlyphInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_GlyphInfo, GlyphInfo);
    return mrb_int_value(mrb, instance->value);
}

static mrb_value mrb_raylib_GlyphInfo_value_set(mrb_state* mrb, mrb_value self)
{
    GlyphInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_GlyphInfo, GlyphInfo);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->value = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_GlyphInfo_offsetX_get(mrb_state* mrb, mrb_value self)
{
    GlyphInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_GlyphInfo, GlyphInfo);
    return mrb_int_value(mrb, instance->offsetX);
}

static mrb_value mrb_raylib_GlyphInfo_offsetX_set(mrb_state* mrb, mrb_value self)
{
    GlyphInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_GlyphInfo, GlyphInfo);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->offsetX = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_GlyphInfo_offsetY_get(mrb_state* mrb, mrb_value self)
{
    GlyphInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_GlyphInfo, GlyphInfo);
    return mrb_int_value(mrb, instance->offsetY);
}

static mrb_value mrb_raylib_GlyphInfo_offsetY_set(mrb_state* mrb, mrb_value self)
{
    GlyphInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_GlyphInfo, GlyphInfo);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->offsetY = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_GlyphInfo_advanceX_get(mrb_state* mrb, mrb_value self)
{
    GlyphInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_GlyphInfo, GlyphInfo);
    return mrb_int_value(mrb, instance->advanceX);
}

static mrb_value mrb_raylib_GlyphInfo_advanceX_set(mrb_state* mrb, mrb_value self)
{
    GlyphInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_GlyphInfo, GlyphInfo);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->advanceX = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_GlyphInfo_image_get(mrb_state* mrb, mrb_value self)
{
    GlyphInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_GlyphInfo, GlyphInfo);
    return mrb_obj_value(&instance->image);
}

static mrb_value mrb_raylib_GlyphInfo_image_set(mrb_state* mrb, mrb_value self)
{
    GlyphInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_GlyphInfo, GlyphInfo);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->image = *(Image*)DATA_PTR(argv); // Image Image 1
    return self;
}

static mrb_value mrb_raylib_Font_initialize(mrb_state* mrb, mrb_value self)
{
    Font* instance = (Font*)mrb_malloc(mrb, sizeof(Font));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(Font));
        break;
    }
    case 6:
    {
        mrb_value argv[6];
        void* ptrs[6] = { &argv[0], &argv[1], &argv[2], &argv[3], &argv[4], &argv[5], };
        mrb_get_args_a(mrb, "oooooo", ptrs);
        instance->baseSize = mrb_as_int(mrb, argv[0]); // :int int 1
        instance->glyphCount = mrb_as_int(mrb, argv[1]); // :int int 1
        instance->glyphPadding = mrb_as_int(mrb, argv[2]); // :int int 1
        instance->texture = *(Texture2D*)DATA_PTR(argv[3]); // Texture2D Texture2D 1
        instance->recs = DATA_PTR(argv[4]); // :pointer Rectangle * 1
        instance->glyphs = DATA_PTR(argv[5]); // :pointer GlyphInfo * 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_Font);
    return self;
}

static mrb_value mrb_raylib_Font_baseSize_get(mrb_state* mrb, mrb_value self)
{
    Font* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Font, Font);
    return mrb_int_value(mrb, instance->baseSize);
}

static mrb_value mrb_raylib_Font_baseSize_set(mrb_state* mrb, mrb_value self)
{
    Font* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Font, Font);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->baseSize = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_Font_glyphCount_get(mrb_state* mrb, mrb_value self)
{
    Font* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Font, Font);
    return mrb_int_value(mrb, instance->glyphCount);
}

static mrb_value mrb_raylib_Font_glyphCount_set(mrb_state* mrb, mrb_value self)
{
    Font* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Font, Font);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->glyphCount = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_Font_glyphPadding_get(mrb_state* mrb, mrb_value self)
{
    Font* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Font, Font);
    return mrb_int_value(mrb, instance->glyphPadding);
}

static mrb_value mrb_raylib_Font_glyphPadding_set(mrb_state* mrb, mrb_value self)
{
    Font* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Font, Font);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->glyphPadding = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_Font_texture_get(mrb_state* mrb, mrb_value self)
{
    Font* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Font, Font);
    return mrb_obj_value(&instance->texture);
}

static mrb_value mrb_raylib_Font_texture_set(mrb_state* mrb, mrb_value self)
{
    Font* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Font, Font);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->texture = *(Texture2D*)DATA_PTR(argv); // Texture2D Texture2D 1
    return self;
}

static mrb_value mrb_raylib_Camera3D_initialize(mrb_state* mrb, mrb_value self)
{
    Camera3D* instance = (Camera3D*)mrb_malloc(mrb, sizeof(Camera3D));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(Camera3D));
        break;
    }
    case 5:
    {
        mrb_value argv[5];
        void* ptrs[5] = { &argv[0], &argv[1], &argv[2], &argv[3], &argv[4], };
        mrb_get_args_a(mrb, "ooooo", ptrs);
        instance->position = *(Vector3*)DATA_PTR(argv[0]); // Vector3 Vector3 1
        instance->target = *(Vector3*)DATA_PTR(argv[1]); // Vector3 Vector3 1
        instance->up = *(Vector3*)DATA_PTR(argv[2]); // Vector3 Vector3 1
        instance->fovy = mrb_as_float(mrb, argv[3]); // :float float 1
        instance->projection = mrb_as_int(mrb, argv[4]); // :int int 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_Camera3D);
    return self;
}

static mrb_value mrb_raylib_Camera3D_position_get(mrb_state* mrb, mrb_value self)
{
    Camera3D* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Camera3D, Camera3D);
    return mrb_obj_value(&instance->position);
}

static mrb_value mrb_raylib_Camera3D_position_set(mrb_state* mrb, mrb_value self)
{
    Camera3D* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Camera3D, Camera3D);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->position = *(Vector3*)DATA_PTR(argv); // Vector3 Vector3 1
    return self;
}

static mrb_value mrb_raylib_Camera3D_target_get(mrb_state* mrb, mrb_value self)
{
    Camera3D* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Camera3D, Camera3D);
    return mrb_obj_value(&instance->target);
}

static mrb_value mrb_raylib_Camera3D_target_set(mrb_state* mrb, mrb_value self)
{
    Camera3D* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Camera3D, Camera3D);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->target = *(Vector3*)DATA_PTR(argv); // Vector3 Vector3 1
    return self;
}

static mrb_value mrb_raylib_Camera3D_up_get(mrb_state* mrb, mrb_value self)
{
    Camera3D* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Camera3D, Camera3D);
    return mrb_obj_value(&instance->up);
}

static mrb_value mrb_raylib_Camera3D_up_set(mrb_state* mrb, mrb_value self)
{
    Camera3D* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Camera3D, Camera3D);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->up = *(Vector3*)DATA_PTR(argv); // Vector3 Vector3 1
    return self;
}

static mrb_value mrb_raylib_Camera3D_fovy_get(mrb_state* mrb, mrb_value self)
{
    Camera3D* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Camera3D, Camera3D);
    return mrb_float_value(mrb, instance->fovy);
}

static mrb_value mrb_raylib_Camera3D_fovy_set(mrb_state* mrb, mrb_value self)
{
    Camera3D* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Camera3D, Camera3D);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->fovy = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Camera3D_projection_get(mrb_state* mrb, mrb_value self)
{
    Camera3D* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Camera3D, Camera3D);
    return mrb_int_value(mrb, instance->projection);
}

static mrb_value mrb_raylib_Camera3D_projection_set(mrb_state* mrb, mrb_value self)
{
    Camera3D* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Camera3D, Camera3D);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->projection = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_Camera2D_initialize(mrb_state* mrb, mrb_value self)
{
    Camera2D* instance = (Camera2D*)mrb_malloc(mrb, sizeof(Camera2D));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(Camera2D));
        break;
    }
    case 4:
    {
        mrb_value argv[4];
        void* ptrs[4] = { &argv[0], &argv[1], &argv[2], &argv[3], };
        mrb_get_args_a(mrb, "oooo", ptrs);
        instance->offset = *(Vector2*)DATA_PTR(argv[0]); // Vector2 Vector2 1
        instance->target = *(Vector2*)DATA_PTR(argv[1]); // Vector2 Vector2 1
        instance->rotation = mrb_as_float(mrb, argv[2]); // :float float 1
        instance->zoom = mrb_as_float(mrb, argv[3]); // :float float 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_Camera2D);
    return self;
}

static mrb_value mrb_raylib_Camera2D_offset_get(mrb_state* mrb, mrb_value self)
{
    Camera2D* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Camera2D, Camera2D);
    return mrb_obj_value(&instance->offset);
}

static mrb_value mrb_raylib_Camera2D_offset_set(mrb_state* mrb, mrb_value self)
{
    Camera2D* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Camera2D, Camera2D);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->offset = *(Vector2*)DATA_PTR(argv); // Vector2 Vector2 1
    return self;
}

static mrb_value mrb_raylib_Camera2D_target_get(mrb_state* mrb, mrb_value self)
{
    Camera2D* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Camera2D, Camera2D);
    return mrb_obj_value(&instance->target);
}

static mrb_value mrb_raylib_Camera2D_target_set(mrb_state* mrb, mrb_value self)
{
    Camera2D* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Camera2D, Camera2D);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->target = *(Vector2*)DATA_PTR(argv); // Vector2 Vector2 1
    return self;
}

static mrb_value mrb_raylib_Camera2D_rotation_get(mrb_state* mrb, mrb_value self)
{
    Camera2D* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Camera2D, Camera2D);
    return mrb_float_value(mrb, instance->rotation);
}

static mrb_value mrb_raylib_Camera2D_rotation_set(mrb_state* mrb, mrb_value self)
{
    Camera2D* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Camera2D, Camera2D);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->rotation = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Camera2D_zoom_get(mrb_state* mrb, mrb_value self)
{
    Camera2D* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Camera2D, Camera2D);
    return mrb_float_value(mrb, instance->zoom);
}

static mrb_value mrb_raylib_Camera2D_zoom_set(mrb_state* mrb, mrb_value self)
{
    Camera2D* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Camera2D, Camera2D);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->zoom = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Mesh_initialize(mrb_state* mrb, mrb_value self)
{
    Mesh* instance = (Mesh*)mrb_malloc(mrb, sizeof(Mesh));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(Mesh));
        break;
    }
    case 15:
    {
        mrb_value argv[15];
        void* ptrs[15] = { &argv[0], &argv[1], &argv[2], &argv[3], &argv[4], &argv[5], &argv[6], &argv[7], &argv[8], &argv[9], &argv[10], &argv[11], &argv[12], &argv[13], &argv[14], };
        mrb_get_args_a(mrb, "ooooooooooooooo", ptrs);
        instance->vertexCount = mrb_as_int(mrb, argv[0]); // :int int 1
        instance->triangleCount = mrb_as_int(mrb, argv[1]); // :int int 1
        instance->vertices = DATA_PTR(argv[2]); // :pointer float * 1
        instance->texcoords = DATA_PTR(argv[3]); // :pointer float * 1
        instance->texcoords2 = DATA_PTR(argv[4]); // :pointer float * 1
        instance->normals = DATA_PTR(argv[5]); // :pointer float * 1
        instance->tangents = DATA_PTR(argv[6]); // :pointer float * 1
        instance->colors = DATA_PTR(argv[7]); // :pointer unsigned char * 1
        instance->indices = DATA_PTR(argv[8]); // :pointer unsigned short * 1
        instance->animVertices = DATA_PTR(argv[9]); // :pointer float * 1
        instance->animNormals = DATA_PTR(argv[10]); // :pointer float * 1
        instance->boneIds = DATA_PTR(argv[11]); // :pointer unsigned char * 1
        instance->boneWeights = DATA_PTR(argv[12]); // :pointer float * 1
        instance->vaoId = mrb_as_int(mrb, argv[13]); // :uint unsigned int 1
        instance->vboId = DATA_PTR(argv[14]); // :pointer unsigned int * 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_Mesh);
    return self;
}

static mrb_value mrb_raylib_Mesh_vertexCount_get(mrb_state* mrb, mrb_value self)
{
    Mesh* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Mesh, Mesh);
    return mrb_int_value(mrb, instance->vertexCount);
}

static mrb_value mrb_raylib_Mesh_vertexCount_set(mrb_state* mrb, mrb_value self)
{
    Mesh* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Mesh, Mesh);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->vertexCount = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_Mesh_triangleCount_get(mrb_state* mrb, mrb_value self)
{
    Mesh* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Mesh, Mesh);
    return mrb_int_value(mrb, instance->triangleCount);
}

static mrb_value mrb_raylib_Mesh_triangleCount_set(mrb_state* mrb, mrb_value self)
{
    Mesh* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Mesh, Mesh);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->triangleCount = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_Mesh_vaoId_get(mrb_state* mrb, mrb_value self)
{
    Mesh* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Mesh, Mesh);
    return mrb_int_value(mrb, instance->vaoId);
}

static mrb_value mrb_raylib_Mesh_vaoId_set(mrb_state* mrb, mrb_value self)
{
    Mesh* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Mesh, Mesh);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->vaoId = mrb_as_int(mrb, argv); // :uint unsigned int 1
    return self;
}

static mrb_value mrb_raylib_Shader_initialize(mrb_state* mrb, mrb_value self)
{
    Shader* instance = (Shader*)mrb_malloc(mrb, sizeof(Shader));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(Shader));
        break;
    }
    case 2:
    {
        mrb_value argv[2];
        void* ptrs[2] = { &argv[0], &argv[1], };
        mrb_get_args_a(mrb, "oo", ptrs);
        instance->id = mrb_as_int(mrb, argv[0]); // :uint unsigned int 1
        instance->locs = DATA_PTR(argv[1]); // :pointer int * 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_Shader);
    return self;
}

static mrb_value mrb_raylib_Shader_id_get(mrb_state* mrb, mrb_value self)
{
    Shader* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Shader, Shader);
    return mrb_int_value(mrb, instance->id);
}

static mrb_value mrb_raylib_Shader_id_set(mrb_state* mrb, mrb_value self)
{
    Shader* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Shader, Shader);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->id = mrb_as_int(mrb, argv); // :uint unsigned int 1
    return self;
}

static mrb_value mrb_raylib_MaterialMap_initialize(mrb_state* mrb, mrb_value self)
{
    MaterialMap* instance = (MaterialMap*)mrb_malloc(mrb, sizeof(MaterialMap));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(MaterialMap));
        break;
    }
    case 3:
    {
        mrb_value argv[3];
        void* ptrs[3] = { &argv[0], &argv[1], &argv[2], };
        mrb_get_args_a(mrb, "ooo", ptrs);
        instance->texture = *(Texture2D*)DATA_PTR(argv[0]); // Texture2D Texture2D 1
        instance->color = *(Color*)DATA_PTR(argv[1]); // Color Color 1
        instance->value = mrb_as_float(mrb, argv[2]); // :float float 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_MaterialMap);
    return self;
}

static mrb_value mrb_raylib_MaterialMap_texture_get(mrb_state* mrb, mrb_value self)
{
    MaterialMap* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_MaterialMap, MaterialMap);
    return mrb_obj_value(&instance->texture);
}

static mrb_value mrb_raylib_MaterialMap_texture_set(mrb_state* mrb, mrb_value self)
{
    MaterialMap* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_MaterialMap, MaterialMap);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->texture = *(Texture2D*)DATA_PTR(argv); // Texture2D Texture2D 1
    return self;
}

static mrb_value mrb_raylib_MaterialMap_color_get(mrb_state* mrb, mrb_value self)
{
    MaterialMap* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_MaterialMap, MaterialMap);
    return mrb_obj_value(&instance->color);
}

static mrb_value mrb_raylib_MaterialMap_color_set(mrb_state* mrb, mrb_value self)
{
    MaterialMap* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_MaterialMap, MaterialMap);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->color = *(Color*)DATA_PTR(argv); // Color Color 1
    return self;
}

static mrb_value mrb_raylib_MaterialMap_value_get(mrb_state* mrb, mrb_value self)
{
    MaterialMap* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_MaterialMap, MaterialMap);
    return mrb_float_value(mrb, instance->value);
}

static mrb_value mrb_raylib_MaterialMap_value_set(mrb_state* mrb, mrb_value self)
{
    MaterialMap* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_MaterialMap, MaterialMap);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->value = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_Material_initialize(mrb_state* mrb, mrb_value self)
{
    Material* instance = (Material*)mrb_malloc(mrb, sizeof(Material));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(Material));
        break;
    }
    case 3:
    {
        mrb_value argv[3];
        void* ptrs[3] = { &argv[0], &argv[1], &argv[2], };
        mrb_get_args_a(mrb, "ooo", ptrs);
        instance->shader = *(Shader*)DATA_PTR(argv[0]); // Shader Shader 1
        instance->maps = DATA_PTR(argv[1]); // :pointer MaterialMap * 1
        memcpy(instance->params, DATA_PTR(argv[2]), sizeof(float) * 4); // :float float 4
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_Material);
    return self;
}

static mrb_value mrb_raylib_Material_shader_get(mrb_state* mrb, mrb_value self)
{
    Material* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Material, Material);
    return mrb_obj_value(&instance->shader);
}

static mrb_value mrb_raylib_Material_shader_set(mrb_state* mrb, mrb_value self)
{
    Material* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Material, Material);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->shader = *(Shader*)DATA_PTR(argv); // Shader Shader 1
    return self;
}

static mrb_value mrb_raylib_Transform_initialize(mrb_state* mrb, mrb_value self)
{
    Transform* instance = (Transform*)mrb_malloc(mrb, sizeof(Transform));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(Transform));
        break;
    }
    case 3:
    {
        mrb_value argv[3];
        void* ptrs[3] = { &argv[0], &argv[1], &argv[2], };
        mrb_get_args_a(mrb, "ooo", ptrs);
        instance->translation = *(Vector3*)DATA_PTR(argv[0]); // Vector3 Vector3 1
        instance->rotation = *(Quaternion*)DATA_PTR(argv[1]); // Quaternion Quaternion 1
        instance->scale = *(Vector3*)DATA_PTR(argv[2]); // Vector3 Vector3 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_Transform);
    return self;
}

static mrb_value mrb_raylib_Transform_translation_get(mrb_state* mrb, mrb_value self)
{
    Transform* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Transform, Transform);
    return mrb_obj_value(&instance->translation);
}

static mrb_value mrb_raylib_Transform_translation_set(mrb_state* mrb, mrb_value self)
{
    Transform* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Transform, Transform);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->translation = *(Vector3*)DATA_PTR(argv); // Vector3 Vector3 1
    return self;
}

static mrb_value mrb_raylib_Transform_rotation_get(mrb_state* mrb, mrb_value self)
{
    Transform* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Transform, Transform);
    return mrb_obj_value(&instance->rotation);
}

static mrb_value mrb_raylib_Transform_rotation_set(mrb_state* mrb, mrb_value self)
{
    Transform* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Transform, Transform);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->rotation = *(Quaternion*)DATA_PTR(argv); // Quaternion Quaternion 1
    return self;
}

static mrb_value mrb_raylib_Transform_scale_get(mrb_state* mrb, mrb_value self)
{
    Transform* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Transform, Transform);
    return mrb_obj_value(&instance->scale);
}

static mrb_value mrb_raylib_Transform_scale_set(mrb_state* mrb, mrb_value self)
{
    Transform* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Transform, Transform);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->scale = *(Vector3*)DATA_PTR(argv); // Vector3 Vector3 1
    return self;
}

static mrb_value mrb_raylib_BoneInfo_initialize(mrb_state* mrb, mrb_value self)
{
    BoneInfo* instance = (BoneInfo*)mrb_malloc(mrb, sizeof(BoneInfo));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(BoneInfo));
        break;
    }
    case 2:
    {
        mrb_value argv[2];
        void* ptrs[2] = { &argv[0], &argv[1], };
        mrb_get_args_a(mrb, "oo", ptrs);
        strncpy(instance->name, mrb_string_cstr(mrb, argv[0]), sizeof(char) * 32); // :char char 32
        instance->parent = mrb_as_int(mrb, argv[1]); // :int int 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_BoneInfo);
    return self;
}

static mrb_value mrb_raylib_BoneInfo_name_get(mrb_state* mrb, mrb_value self)
{
    BoneInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_BoneInfo, BoneInfo);
    return mrb_str_new_cstr(mrb, (const char*)&instance->name);
}

static mrb_value mrb_raylib_BoneInfo_name_set(mrb_state* mrb, mrb_value self)
{
    BoneInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_BoneInfo, BoneInfo);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    strncpy(instance->name, mrb_string_cstr(mrb, argv), sizeof(char) * 32); // :char char 32
    return self;
}

static mrb_value mrb_raylib_BoneInfo_parent_get(mrb_state* mrb, mrb_value self)
{
    BoneInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_BoneInfo, BoneInfo);
    return mrb_int_value(mrb, instance->parent);
}

static mrb_value mrb_raylib_BoneInfo_parent_set(mrb_state* mrb, mrb_value self)
{
    BoneInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_BoneInfo, BoneInfo);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->parent = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_Model_initialize(mrb_state* mrb, mrb_value self)
{
    Model* instance = (Model*)mrb_malloc(mrb, sizeof(Model));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(Model));
        break;
    }
    case 9:
    {
        mrb_value argv[9];
        void* ptrs[9] = { &argv[0], &argv[1], &argv[2], &argv[3], &argv[4], &argv[5], &argv[6], &argv[7], &argv[8], };
        mrb_get_args_a(mrb, "ooooooooo", ptrs);
        instance->transform = *(Matrix*)DATA_PTR(argv[0]); // Matrix Matrix 1
        instance->meshCount = mrb_as_int(mrb, argv[1]); // :int int 1
        instance->materialCount = mrb_as_int(mrb, argv[2]); // :int int 1
        instance->meshes = DATA_PTR(argv[3]); // :pointer Mesh * 1
        instance->materials = DATA_PTR(argv[4]); // :pointer Material * 1
        instance->meshMaterial = DATA_PTR(argv[5]); // :pointer int * 1
        instance->boneCount = mrb_as_int(mrb, argv[6]); // :int int 1
        instance->bones = DATA_PTR(argv[7]); // :pointer BoneInfo * 1
        instance->bindPose = DATA_PTR(argv[8]); // :pointer Transform * 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_Model);
    return self;
}

static mrb_value mrb_raylib_Model_transform_get(mrb_state* mrb, mrb_value self)
{
    Model* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Model, Model);
    return mrb_obj_value(&instance->transform);
}

static mrb_value mrb_raylib_Model_transform_set(mrb_state* mrb, mrb_value self)
{
    Model* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Model, Model);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->transform = *(Matrix*)DATA_PTR(argv); // Matrix Matrix 1
    return self;
}

static mrb_value mrb_raylib_Model_meshCount_get(mrb_state* mrb, mrb_value self)
{
    Model* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Model, Model);
    return mrb_int_value(mrb, instance->meshCount);
}

static mrb_value mrb_raylib_Model_meshCount_set(mrb_state* mrb, mrb_value self)
{
    Model* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Model, Model);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->meshCount = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_Model_materialCount_get(mrb_state* mrb, mrb_value self)
{
    Model* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Model, Model);
    return mrb_int_value(mrb, instance->materialCount);
}

static mrb_value mrb_raylib_Model_materialCount_set(mrb_state* mrb, mrb_value self)
{
    Model* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Model, Model);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->materialCount = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_Model_boneCount_get(mrb_state* mrb, mrb_value self)
{
    Model* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Model, Model);
    return mrb_int_value(mrb, instance->boneCount);
}

static mrb_value mrb_raylib_Model_boneCount_set(mrb_state* mrb, mrb_value self)
{
    Model* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Model, Model);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->boneCount = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_ModelAnimation_initialize(mrb_state* mrb, mrb_value self)
{
    ModelAnimation* instance = (ModelAnimation*)mrb_malloc(mrb, sizeof(ModelAnimation));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(ModelAnimation));
        break;
    }
    case 5:
    {
        mrb_value argv[5];
        void* ptrs[5] = { &argv[0], &argv[1], &argv[2], &argv[3], &argv[4], };
        mrb_get_args_a(mrb, "ooooo", ptrs);
        instance->boneCount = mrb_as_int(mrb, argv[0]); // :int int 1
        instance->frameCount = mrb_as_int(mrb, argv[1]); // :int int 1
        instance->bones = DATA_PTR(argv[2]); // :pointer BoneInfo * 1
        instance->framePoses = DATA_PTR(argv[3]); // :pointer Transform ** 1
        strncpy(instance->name, mrb_string_cstr(mrb, argv[4]), sizeof(char) * 32); // :char char 32
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_ModelAnimation);
    return self;
}

static mrb_value mrb_raylib_ModelAnimation_boneCount_get(mrb_state* mrb, mrb_value self)
{
    ModelAnimation* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_ModelAnimation, ModelAnimation);
    return mrb_int_value(mrb, instance->boneCount);
}

static mrb_value mrb_raylib_ModelAnimation_boneCount_set(mrb_state* mrb, mrb_value self)
{
    ModelAnimation* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_ModelAnimation, ModelAnimation);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->boneCount = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_ModelAnimation_frameCount_get(mrb_state* mrb, mrb_value self)
{
    ModelAnimation* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_ModelAnimation, ModelAnimation);
    return mrb_int_value(mrb, instance->frameCount);
}

static mrb_value mrb_raylib_ModelAnimation_frameCount_set(mrb_state* mrb, mrb_value self)
{
    ModelAnimation* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_ModelAnimation, ModelAnimation);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->frameCount = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_ModelAnimation_name_get(mrb_state* mrb, mrb_value self)
{
    ModelAnimation* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_ModelAnimation, ModelAnimation);
    return mrb_str_new_cstr(mrb, (const char*)&instance->name);
}

static mrb_value mrb_raylib_ModelAnimation_name_set(mrb_state* mrb, mrb_value self)
{
    ModelAnimation* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_ModelAnimation, ModelAnimation);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    strncpy(instance->name, mrb_string_cstr(mrb, argv), sizeof(char) * 32); // :char char 32
    return self;
}

static mrb_value mrb_raylib_Ray_initialize(mrb_state* mrb, mrb_value self)
{
    Ray* instance = (Ray*)mrb_malloc(mrb, sizeof(Ray));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(Ray));
        break;
    }
    case 2:
    {
        mrb_value argv[2];
        void* ptrs[2] = { &argv[0], &argv[1], };
        mrb_get_args_a(mrb, "oo", ptrs);
        instance->position = *(Vector3*)DATA_PTR(argv[0]); // Vector3 Vector3 1
        instance->direction = *(Vector3*)DATA_PTR(argv[1]); // Vector3 Vector3 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_Ray);
    return self;
}

static mrb_value mrb_raylib_Ray_position_get(mrb_state* mrb, mrb_value self)
{
    Ray* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Ray, Ray);
    return mrb_obj_value(&instance->position);
}

static mrb_value mrb_raylib_Ray_position_set(mrb_state* mrb, mrb_value self)
{
    Ray* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Ray, Ray);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->position = *(Vector3*)DATA_PTR(argv); // Vector3 Vector3 1
    return self;
}

static mrb_value mrb_raylib_Ray_direction_get(mrb_state* mrb, mrb_value self)
{
    Ray* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Ray, Ray);
    return mrb_obj_value(&instance->direction);
}

static mrb_value mrb_raylib_Ray_direction_set(mrb_state* mrb, mrb_value self)
{
    Ray* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Ray, Ray);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->direction = *(Vector3*)DATA_PTR(argv); // Vector3 Vector3 1
    return self;
}

static mrb_value mrb_raylib_RayCollision_initialize(mrb_state* mrb, mrb_value self)
{
    RayCollision* instance = (RayCollision*)mrb_malloc(mrb, sizeof(RayCollision));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(RayCollision));
        break;
    }
    case 4:
    {
        mrb_value argv[4];
        void* ptrs[4] = { &argv[0], &argv[1], &argv[2], &argv[3], };
        mrb_get_args_a(mrb, "oooo", ptrs);
        instance->hit = mrb_as_int(mrb, argv[0]); // :bool bool 1
        instance->distance = mrb_as_float(mrb, argv[1]); // :float float 1
        instance->point = *(Vector3*)DATA_PTR(argv[2]); // Vector3 Vector3 1
        instance->normal = *(Vector3*)DATA_PTR(argv[3]); // Vector3 Vector3 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_RayCollision);
    return self;
}

static mrb_value mrb_raylib_RayCollision_hit_get(mrb_state* mrb, mrb_value self)
{
    RayCollision* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_RayCollision, RayCollision);
    return mrb_int_value(mrb, instance->hit);
}

static mrb_value mrb_raylib_RayCollision_hit_set(mrb_state* mrb, mrb_value self)
{
    RayCollision* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_RayCollision, RayCollision);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->hit = mrb_as_int(mrb, argv); // :bool bool 1
    return self;
}

static mrb_value mrb_raylib_RayCollision_distance_get(mrb_state* mrb, mrb_value self)
{
    RayCollision* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_RayCollision, RayCollision);
    return mrb_float_value(mrb, instance->distance);
}

static mrb_value mrb_raylib_RayCollision_distance_set(mrb_state* mrb, mrb_value self)
{
    RayCollision* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_RayCollision, RayCollision);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->distance = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_RayCollision_point_get(mrb_state* mrb, mrb_value self)
{
    RayCollision* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_RayCollision, RayCollision);
    return mrb_obj_value(&instance->point);
}

static mrb_value mrb_raylib_RayCollision_point_set(mrb_state* mrb, mrb_value self)
{
    RayCollision* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_RayCollision, RayCollision);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->point = *(Vector3*)DATA_PTR(argv); // Vector3 Vector3 1
    return self;
}

static mrb_value mrb_raylib_RayCollision_normal_get(mrb_state* mrb, mrb_value self)
{
    RayCollision* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_RayCollision, RayCollision);
    return mrb_obj_value(&instance->normal);
}

static mrb_value mrb_raylib_RayCollision_normal_set(mrb_state* mrb, mrb_value self)
{
    RayCollision* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_RayCollision, RayCollision);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->normal = *(Vector3*)DATA_PTR(argv); // Vector3 Vector3 1
    return self;
}

static mrb_value mrb_raylib_BoundingBox_initialize(mrb_state* mrb, mrb_value self)
{
    BoundingBox* instance = (BoundingBox*)mrb_malloc(mrb, sizeof(BoundingBox));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(BoundingBox));
        break;
    }
    case 2:
    {
        mrb_value argv[2];
        void* ptrs[2] = { &argv[0], &argv[1], };
        mrb_get_args_a(mrb, "oo", ptrs);
        instance->min = *(Vector3*)DATA_PTR(argv[0]); // Vector3 Vector3 1
        instance->max = *(Vector3*)DATA_PTR(argv[1]); // Vector3 Vector3 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_BoundingBox);
    return self;
}

static mrb_value mrb_raylib_BoundingBox_min_get(mrb_state* mrb, mrb_value self)
{
    BoundingBox* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_BoundingBox, BoundingBox);
    return mrb_obj_value(&instance->min);
}

static mrb_value mrb_raylib_BoundingBox_min_set(mrb_state* mrb, mrb_value self)
{
    BoundingBox* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_BoundingBox, BoundingBox);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->min = *(Vector3*)DATA_PTR(argv); // Vector3 Vector3 1
    return self;
}

static mrb_value mrb_raylib_BoundingBox_max_get(mrb_state* mrb, mrb_value self)
{
    BoundingBox* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_BoundingBox, BoundingBox);
    return mrb_obj_value(&instance->max);
}

static mrb_value mrb_raylib_BoundingBox_max_set(mrb_state* mrb, mrb_value self)
{
    BoundingBox* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_BoundingBox, BoundingBox);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->max = *(Vector3*)DATA_PTR(argv); // Vector3 Vector3 1
    return self;
}

static mrb_value mrb_raylib_Wave_initialize(mrb_state* mrb, mrb_value self)
{
    Wave* instance = (Wave*)mrb_malloc(mrb, sizeof(Wave));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(Wave));
        break;
    }
    case 5:
    {
        mrb_value argv[5];
        void* ptrs[5] = { &argv[0], &argv[1], &argv[2], &argv[3], &argv[4], };
        mrb_get_args_a(mrb, "ooooo", ptrs);
        instance->frameCount = mrb_as_int(mrb, argv[0]); // :uint unsigned int 1
        instance->sampleRate = mrb_as_int(mrb, argv[1]); // :uint unsigned int 1
        instance->sampleSize = mrb_as_int(mrb, argv[2]); // :uint unsigned int 1
        instance->channels = mrb_as_int(mrb, argv[3]); // :uint unsigned int 1
        instance->data = DATA_PTR(argv[4]); // :pointer void * 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_Wave);
    return self;
}

static mrb_value mrb_raylib_Wave_frameCount_get(mrb_state* mrb, mrb_value self)
{
    Wave* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Wave, Wave);
    return mrb_int_value(mrb, instance->frameCount);
}

static mrb_value mrb_raylib_Wave_frameCount_set(mrb_state* mrb, mrb_value self)
{
    Wave* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Wave, Wave);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->frameCount = mrb_as_int(mrb, argv); // :uint unsigned int 1
    return self;
}

static mrb_value mrb_raylib_Wave_sampleRate_get(mrb_state* mrb, mrb_value self)
{
    Wave* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Wave, Wave);
    return mrb_int_value(mrb, instance->sampleRate);
}

static mrb_value mrb_raylib_Wave_sampleRate_set(mrb_state* mrb, mrb_value self)
{
    Wave* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Wave, Wave);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->sampleRate = mrb_as_int(mrb, argv); // :uint unsigned int 1
    return self;
}

static mrb_value mrb_raylib_Wave_sampleSize_get(mrb_state* mrb, mrb_value self)
{
    Wave* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Wave, Wave);
    return mrb_int_value(mrb, instance->sampleSize);
}

static mrb_value mrb_raylib_Wave_sampleSize_set(mrb_state* mrb, mrb_value self)
{
    Wave* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Wave, Wave);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->sampleSize = mrb_as_int(mrb, argv); // :uint unsigned int 1
    return self;
}

static mrb_value mrb_raylib_Wave_channels_get(mrb_state* mrb, mrb_value self)
{
    Wave* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Wave, Wave);
    return mrb_int_value(mrb, instance->channels);
}

static mrb_value mrb_raylib_Wave_channels_set(mrb_state* mrb, mrb_value self)
{
    Wave* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Wave, Wave);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->channels = mrb_as_int(mrb, argv); // :uint unsigned int 1
    return self;
}

static mrb_value mrb_raylib_AudioStream_initialize(mrb_state* mrb, mrb_value self)
{
    AudioStream* instance = (AudioStream*)mrb_malloc(mrb, sizeof(AudioStream));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(AudioStream));
        break;
    }
    case 5:
    {
        mrb_value argv[5];
        void* ptrs[5] = { &argv[0], &argv[1], &argv[2], &argv[3], &argv[4], };
        mrb_get_args_a(mrb, "ooooo", ptrs);
        instance->buffer = DATA_PTR(argv[0]); // :pointer rAudioBuffer * 1
        instance->processor = DATA_PTR(argv[1]); // :pointer rAudioProcessor * 1
        instance->sampleRate = mrb_as_int(mrb, argv[2]); // :uint unsigned int 1
        instance->sampleSize = mrb_as_int(mrb, argv[3]); // :uint unsigned int 1
        instance->channels = mrb_as_int(mrb, argv[4]); // :uint unsigned int 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_AudioStream);
    return self;
}

static mrb_value mrb_raylib_AudioStream_sampleRate_get(mrb_state* mrb, mrb_value self)
{
    AudioStream* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_AudioStream, AudioStream);
    return mrb_int_value(mrb, instance->sampleRate);
}

static mrb_value mrb_raylib_AudioStream_sampleRate_set(mrb_state* mrb, mrb_value self)
{
    AudioStream* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_AudioStream, AudioStream);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->sampleRate = mrb_as_int(mrb, argv); // :uint unsigned int 1
    return self;
}

static mrb_value mrb_raylib_AudioStream_sampleSize_get(mrb_state* mrb, mrb_value self)
{
    AudioStream* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_AudioStream, AudioStream);
    return mrb_int_value(mrb, instance->sampleSize);
}

static mrb_value mrb_raylib_AudioStream_sampleSize_set(mrb_state* mrb, mrb_value self)
{
    AudioStream* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_AudioStream, AudioStream);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->sampleSize = mrb_as_int(mrb, argv); // :uint unsigned int 1
    return self;
}

static mrb_value mrb_raylib_AudioStream_channels_get(mrb_state* mrb, mrb_value self)
{
    AudioStream* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_AudioStream, AudioStream);
    return mrb_int_value(mrb, instance->channels);
}

static mrb_value mrb_raylib_AudioStream_channels_set(mrb_state* mrb, mrb_value self)
{
    AudioStream* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_AudioStream, AudioStream);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->channels = mrb_as_int(mrb, argv); // :uint unsigned int 1
    return self;
}

static mrb_value mrb_raylib_Sound_initialize(mrb_state* mrb, mrb_value self)
{
    Sound* instance = (Sound*)mrb_malloc(mrb, sizeof(Sound));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(Sound));
        break;
    }
    case 2:
    {
        mrb_value argv[2];
        void* ptrs[2] = { &argv[0], &argv[1], };
        mrb_get_args_a(mrb, "oo", ptrs);
        instance->stream = *(AudioStream*)DATA_PTR(argv[0]); // AudioStream AudioStream 1
        instance->frameCount = mrb_as_int(mrb, argv[1]); // :uint unsigned int 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_Sound);
    return self;
}

static mrb_value mrb_raylib_Sound_stream_get(mrb_state* mrb, mrb_value self)
{
    Sound* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Sound, Sound);
    return mrb_obj_value(&instance->stream);
}

static mrb_value mrb_raylib_Sound_stream_set(mrb_state* mrb, mrb_value self)
{
    Sound* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Sound, Sound);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->stream = *(AudioStream*)DATA_PTR(argv); // AudioStream AudioStream 1
    return self;
}

static mrb_value mrb_raylib_Sound_frameCount_get(mrb_state* mrb, mrb_value self)
{
    Sound* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Sound, Sound);
    return mrb_int_value(mrb, instance->frameCount);
}

static mrb_value mrb_raylib_Sound_frameCount_set(mrb_state* mrb, mrb_value self)
{
    Sound* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Sound, Sound);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->frameCount = mrb_as_int(mrb, argv); // :uint unsigned int 1
    return self;
}

static mrb_value mrb_raylib_Music_initialize(mrb_state* mrb, mrb_value self)
{
    Music* instance = (Music*)mrb_malloc(mrb, sizeof(Music));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(Music));
        break;
    }
    case 5:
    {
        mrb_value argv[5];
        void* ptrs[5] = { &argv[0], &argv[1], &argv[2], &argv[3], &argv[4], };
        mrb_get_args_a(mrb, "ooooo", ptrs);
        instance->stream = *(AudioStream*)DATA_PTR(argv[0]); // AudioStream AudioStream 1
        instance->frameCount = mrb_as_int(mrb, argv[1]); // :uint unsigned int 1
        instance->looping = mrb_as_int(mrb, argv[2]); // :bool bool 1
        instance->ctxType = mrb_as_int(mrb, argv[3]); // :int int 1
        instance->ctxData = DATA_PTR(argv[4]); // :pointer void * 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_Music);
    return self;
}

static mrb_value mrb_raylib_Music_stream_get(mrb_state* mrb, mrb_value self)
{
    Music* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Music, Music);
    return mrb_obj_value(&instance->stream);
}

static mrb_value mrb_raylib_Music_stream_set(mrb_state* mrb, mrb_value self)
{
    Music* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Music, Music);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->stream = *(AudioStream*)DATA_PTR(argv); // AudioStream AudioStream 1
    return self;
}

static mrb_value mrb_raylib_Music_frameCount_get(mrb_state* mrb, mrb_value self)
{
    Music* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Music, Music);
    return mrb_int_value(mrb, instance->frameCount);
}

static mrb_value mrb_raylib_Music_frameCount_set(mrb_state* mrb, mrb_value self)
{
    Music* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Music, Music);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->frameCount = mrb_as_int(mrb, argv); // :uint unsigned int 1
    return self;
}

static mrb_value mrb_raylib_Music_looping_get(mrb_state* mrb, mrb_value self)
{
    Music* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Music, Music);
    return mrb_int_value(mrb, instance->looping);
}

static mrb_value mrb_raylib_Music_looping_set(mrb_state* mrb, mrb_value self)
{
    Music* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Music, Music);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->looping = mrb_as_int(mrb, argv); // :bool bool 1
    return self;
}

static mrb_value mrb_raylib_Music_ctxType_get(mrb_state* mrb, mrb_value self)
{
    Music* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Music, Music);
    return mrb_int_value(mrb, instance->ctxType);
}

static mrb_value mrb_raylib_Music_ctxType_set(mrb_state* mrb, mrb_value self)
{
    Music* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_Music, Music);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->ctxType = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_VrDeviceInfo_initialize(mrb_state* mrb, mrb_value self)
{
    VrDeviceInfo* instance = (VrDeviceInfo*)mrb_malloc(mrb, sizeof(VrDeviceInfo));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(VrDeviceInfo));
        break;
    }
    case 10:
    {
        mrb_value argv[10];
        void* ptrs[10] = { &argv[0], &argv[1], &argv[2], &argv[3], &argv[4], &argv[5], &argv[6], &argv[7], &argv[8], &argv[9], };
        mrb_get_args_a(mrb, "oooooooooo", ptrs);
        instance->hResolution = mrb_as_int(mrb, argv[0]); // :int int 1
        instance->vResolution = mrb_as_int(mrb, argv[1]); // :int int 1
        instance->hScreenSize = mrb_as_float(mrb, argv[2]); // :float float 1
        instance->vScreenSize = mrb_as_float(mrb, argv[3]); // :float float 1
        instance->vScreenCenter = mrb_as_float(mrb, argv[4]); // :float float 1
        instance->eyeToScreenDistance = mrb_as_float(mrb, argv[5]); // :float float 1
        instance->lensSeparationDistance = mrb_as_float(mrb, argv[6]); // :float float 1
        instance->interpupillaryDistance = mrb_as_float(mrb, argv[7]); // :float float 1
        memcpy(instance->lensDistortionValues, DATA_PTR(argv[8]), sizeof(float) * 4); // :float float 4
        memcpy(instance->chromaAbCorrection, DATA_PTR(argv[9]), sizeof(float) * 4); // :float float 4
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_VrDeviceInfo);
    return self;
}

static mrb_value mrb_raylib_VrDeviceInfo_hResolution_get(mrb_state* mrb, mrb_value self)
{
    VrDeviceInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_VrDeviceInfo, VrDeviceInfo);
    return mrb_int_value(mrb, instance->hResolution);
}

static mrb_value mrb_raylib_VrDeviceInfo_hResolution_set(mrb_state* mrb, mrb_value self)
{
    VrDeviceInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_VrDeviceInfo, VrDeviceInfo);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->hResolution = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_VrDeviceInfo_vResolution_get(mrb_state* mrb, mrb_value self)
{
    VrDeviceInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_VrDeviceInfo, VrDeviceInfo);
    return mrb_int_value(mrb, instance->vResolution);
}

static mrb_value mrb_raylib_VrDeviceInfo_vResolution_set(mrb_state* mrb, mrb_value self)
{
    VrDeviceInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_VrDeviceInfo, VrDeviceInfo);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->vResolution = mrb_as_int(mrb, argv); // :int int 1
    return self;
}

static mrb_value mrb_raylib_VrDeviceInfo_hScreenSize_get(mrb_state* mrb, mrb_value self)
{
    VrDeviceInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_VrDeviceInfo, VrDeviceInfo);
    return mrb_float_value(mrb, instance->hScreenSize);
}

static mrb_value mrb_raylib_VrDeviceInfo_hScreenSize_set(mrb_state* mrb, mrb_value self)
{
    VrDeviceInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_VrDeviceInfo, VrDeviceInfo);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->hScreenSize = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_VrDeviceInfo_vScreenSize_get(mrb_state* mrb, mrb_value self)
{
    VrDeviceInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_VrDeviceInfo, VrDeviceInfo);
    return mrb_float_value(mrb, instance->vScreenSize);
}

static mrb_value mrb_raylib_VrDeviceInfo_vScreenSize_set(mrb_state* mrb, mrb_value self)
{
    VrDeviceInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_VrDeviceInfo, VrDeviceInfo);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->vScreenSize = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_VrDeviceInfo_vScreenCenter_get(mrb_state* mrb, mrb_value self)
{
    VrDeviceInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_VrDeviceInfo, VrDeviceInfo);
    return mrb_float_value(mrb, instance->vScreenCenter);
}

static mrb_value mrb_raylib_VrDeviceInfo_vScreenCenter_set(mrb_state* mrb, mrb_value self)
{
    VrDeviceInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_VrDeviceInfo, VrDeviceInfo);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->vScreenCenter = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_VrDeviceInfo_eyeToScreenDistance_get(mrb_state* mrb, mrb_value self)
{
    VrDeviceInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_VrDeviceInfo, VrDeviceInfo);
    return mrb_float_value(mrb, instance->eyeToScreenDistance);
}

static mrb_value mrb_raylib_VrDeviceInfo_eyeToScreenDistance_set(mrb_state* mrb, mrb_value self)
{
    VrDeviceInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_VrDeviceInfo, VrDeviceInfo);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->eyeToScreenDistance = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_VrDeviceInfo_lensSeparationDistance_get(mrb_state* mrb, mrb_value self)
{
    VrDeviceInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_VrDeviceInfo, VrDeviceInfo);
    return mrb_float_value(mrb, instance->lensSeparationDistance);
}

static mrb_value mrb_raylib_VrDeviceInfo_lensSeparationDistance_set(mrb_state* mrb, mrb_value self)
{
    VrDeviceInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_VrDeviceInfo, VrDeviceInfo);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->lensSeparationDistance = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_VrDeviceInfo_interpupillaryDistance_get(mrb_state* mrb, mrb_value self)
{
    VrDeviceInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_VrDeviceInfo, VrDeviceInfo);
    return mrb_float_value(mrb, instance->interpupillaryDistance);
}

static mrb_value mrb_raylib_VrDeviceInfo_interpupillaryDistance_set(mrb_state* mrb, mrb_value self)
{
    VrDeviceInfo* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_VrDeviceInfo, VrDeviceInfo);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->interpupillaryDistance = mrb_as_float(mrb, argv); // :float float 1
    return self;
}

static mrb_value mrb_raylib_VrStereoConfig_initialize(mrb_state* mrb, mrb_value self)
{
    VrStereoConfig* instance = (VrStereoConfig*)mrb_malloc(mrb, sizeof(VrStereoConfig));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(VrStereoConfig));
        break;
    }
    case 8:
    {
        mrb_value argv[8];
        void* ptrs[8] = { &argv[0], &argv[1], &argv[2], &argv[3], &argv[4], &argv[5], &argv[6], &argv[7], };
        mrb_get_args_a(mrb, "oooooooo", ptrs);
        memcpy(instance->projection, DATA_PTR(argv[0]), sizeof(Matrix) * 2); // Matrix Matrix 2
        memcpy(instance->viewOffset, DATA_PTR(argv[1]), sizeof(Matrix) * 2); // Matrix Matrix 2
        memcpy(instance->leftLensCenter, DATA_PTR(argv[2]), sizeof(float) * 2); // :float float 2
        memcpy(instance->rightLensCenter, DATA_PTR(argv[3]), sizeof(float) * 2); // :float float 2
        memcpy(instance->leftScreenCenter, DATA_PTR(argv[4]), sizeof(float) * 2); // :float float 2
        memcpy(instance->rightScreenCenter, DATA_PTR(argv[5]), sizeof(float) * 2); // :float float 2
        memcpy(instance->scale, DATA_PTR(argv[6]), sizeof(float) * 2); // :float float 2
        memcpy(instance->scaleIn, DATA_PTR(argv[7]), sizeof(float) * 2); // :float float 2
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_VrStereoConfig);
    return self;
}

static mrb_value mrb_raylib_FilePathList_initialize(mrb_state* mrb, mrb_value self)
{
    FilePathList* instance = (FilePathList*)mrb_malloc(mrb, sizeof(FilePathList));
    mrb_int argc = mrb_get_argc(mrb);
    switch (argc) {
    case 0:
    {
        memset(instance, 0, sizeof(FilePathList));
        break;
    }
    case 3:
    {
        mrb_value argv[3];
        void* ptrs[3] = { &argv[0], &argv[1], &argv[2], };
        mrb_get_args_a(mrb, "ooo", ptrs);
        instance->capacity = mrb_as_int(mrb, argv[0]); // :uint unsigned int 1
        instance->count = mrb_as_int(mrb, argv[1]); // :uint unsigned int 1
        instance->paths = DATA_PTR(argv[2]); // :pointer char ** 1
    }
    break;
    }
    mrb_data_init(self, instance, &mrb_raylib_struct_FilePathList);
    return self;
}

static mrb_value mrb_raylib_FilePathList_capacity_get(mrb_state* mrb, mrb_value self)
{
    FilePathList* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_FilePathList, FilePathList);
    return mrb_int_value(mrb, instance->capacity);
}

static mrb_value mrb_raylib_FilePathList_capacity_set(mrb_state* mrb, mrb_value self)
{
    FilePathList* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_FilePathList, FilePathList);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->capacity = mrb_as_int(mrb, argv); // :uint unsigned int 1
    return self;
}

static mrb_value mrb_raylib_FilePathList_count_get(mrb_state* mrb, mrb_value self)
{
    FilePathList* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_FilePathList, FilePathList);
    return mrb_int_value(mrb, instance->count);
}

static mrb_value mrb_raylib_FilePathList_count_set(mrb_state* mrb, mrb_value self)
{
    FilePathList* instance = DATA_GET_PTR(mrb, self, &mrb_raylib_struct_FilePathList, FilePathList);
    mrb_value argv;
    mrb_get_args(mrb, "o", &argv);
    instance->count = mrb_as_int(mrb, argv); // :uint unsigned int 1
    return self;
}


void mrb_raylib_module_init(mrb_state* mrb)
{
    mRaylib = mrb_define_module(mrb, "Raylib");


    // Define/Macro

    mrb_define_const(mrb, mRaylib, "RAYLIB_VERSION_MAJOR", mrb_int_value(mrb, 4));
    mrb_define_const(mrb, mRaylib, "RAYLIB_VERSION_MINOR", mrb_int_value(mrb, 6));
    mrb_define_const(mrb, mRaylib, "RAYLIB_VERSION_PATCH", mrb_int_value(mrb, 0));
    mrb_define_const(mrb, mRaylib, "RAYLIB_VERSION", mrb_str_new_cstr_frozen(mrb, "4.6-dev"));

    // Enum

    // enum ConfigFlags
    mrb_define_const(mrb, mRaylib, "FLAG_VSYNC_HINT", mrb_int_value(mrb, 64));
    mrb_define_const(mrb, mRaylib, "FLAG_FULLSCREEN_MODE", mrb_int_value(mrb, 2));
    mrb_define_const(mrb, mRaylib, "FLAG_WINDOW_RESIZABLE", mrb_int_value(mrb, 4));
    mrb_define_const(mrb, mRaylib, "FLAG_WINDOW_UNDECORATED", mrb_int_value(mrb, 8));
    mrb_define_const(mrb, mRaylib, "FLAG_WINDOW_HIDDEN", mrb_int_value(mrb, 128));
    mrb_define_const(mrb, mRaylib, "FLAG_WINDOW_MINIMIZED", mrb_int_value(mrb, 512));
    mrb_define_const(mrb, mRaylib, "FLAG_WINDOW_MAXIMIZED", mrb_int_value(mrb, 1024));
    mrb_define_const(mrb, mRaylib, "FLAG_WINDOW_UNFOCUSED", mrb_int_value(mrb, 2048));
    mrb_define_const(mrb, mRaylib, "FLAG_WINDOW_TOPMOST", mrb_int_value(mrb, 4096));
    mrb_define_const(mrb, mRaylib, "FLAG_WINDOW_ALWAYS_RUN", mrb_int_value(mrb, 256));
    mrb_define_const(mrb, mRaylib, "FLAG_WINDOW_TRANSPARENT", mrb_int_value(mrb, 16));
    mrb_define_const(mrb, mRaylib, "FLAG_WINDOW_HIGHDPI", mrb_int_value(mrb, 8192));
    mrb_define_const(mrb, mRaylib, "FLAG_WINDOW_MOUSE_PASSTHROUGH", mrb_int_value(mrb, 16384));
    mrb_define_const(mrb, mRaylib, "FLAG_BORDERLESS_WINDOWED_MODE", mrb_int_value(mrb, 32768));
    mrb_define_const(mrb, mRaylib, "FLAG_MSAA_4X_HINT", mrb_int_value(mrb, 32));
    mrb_define_const(mrb, mRaylib, "FLAG_INTERLACED_HINT", mrb_int_value(mrb, 65536));

    // enum TraceLogLevel
    mrb_define_const(mrb, mRaylib, "LOG_ALL", mrb_int_value(mrb, 0));
    mrb_define_const(mrb, mRaylib, "LOG_TRACE", mrb_int_value(mrb, 1));
    mrb_define_const(mrb, mRaylib, "LOG_DEBUG", mrb_int_value(mrb, 2));
    mrb_define_const(mrb, mRaylib, "LOG_INFO", mrb_int_value(mrb, 3));
    mrb_define_const(mrb, mRaylib, "LOG_WARNING", mrb_int_value(mrb, 4));
    mrb_define_const(mrb, mRaylib, "LOG_ERROR", mrb_int_value(mrb, 5));
    mrb_define_const(mrb, mRaylib, "LOG_FATAL", mrb_int_value(mrb, 6));
    mrb_define_const(mrb, mRaylib, "LOG_NONE", mrb_int_value(mrb, 7));

    // enum KeyboardKey
    mrb_define_const(mrb, mRaylib, "KEY_NULL", mrb_int_value(mrb, 0));
    mrb_define_const(mrb, mRaylib, "KEY_APOSTROPHE", mrb_int_value(mrb, 39));
    mrb_define_const(mrb, mRaylib, "KEY_COMMA", mrb_int_value(mrb, 44));
    mrb_define_const(mrb, mRaylib, "KEY_MINUS", mrb_int_value(mrb, 45));
    mrb_define_const(mrb, mRaylib, "KEY_PERIOD", mrb_int_value(mrb, 46));
    mrb_define_const(mrb, mRaylib, "KEY_SLASH", mrb_int_value(mrb, 47));
    mrb_define_const(mrb, mRaylib, "KEY_ZERO", mrb_int_value(mrb, 48));
    mrb_define_const(mrb, mRaylib, "KEY_ONE", mrb_int_value(mrb, 49));
    mrb_define_const(mrb, mRaylib, "KEY_TWO", mrb_int_value(mrb, 50));
    mrb_define_const(mrb, mRaylib, "KEY_THREE", mrb_int_value(mrb, 51));
    mrb_define_const(mrb, mRaylib, "KEY_FOUR", mrb_int_value(mrb, 52));
    mrb_define_const(mrb, mRaylib, "KEY_FIVE", mrb_int_value(mrb, 53));
    mrb_define_const(mrb, mRaylib, "KEY_SIX", mrb_int_value(mrb, 54));
    mrb_define_const(mrb, mRaylib, "KEY_SEVEN", mrb_int_value(mrb, 55));
    mrb_define_const(mrb, mRaylib, "KEY_EIGHT", mrb_int_value(mrb, 56));
    mrb_define_const(mrb, mRaylib, "KEY_NINE", mrb_int_value(mrb, 57));
    mrb_define_const(mrb, mRaylib, "KEY_SEMICOLON", mrb_int_value(mrb, 59));
    mrb_define_const(mrb, mRaylib, "KEY_EQUAL", mrb_int_value(mrb, 61));
    mrb_define_const(mrb, mRaylib, "KEY_A", mrb_int_value(mrb, 65));
    mrb_define_const(mrb, mRaylib, "KEY_B", mrb_int_value(mrb, 66));
    mrb_define_const(mrb, mRaylib, "KEY_C", mrb_int_value(mrb, 67));
    mrb_define_const(mrb, mRaylib, "KEY_D", mrb_int_value(mrb, 68));
    mrb_define_const(mrb, mRaylib, "KEY_E", mrb_int_value(mrb, 69));
    mrb_define_const(mrb, mRaylib, "KEY_F", mrb_int_value(mrb, 70));
    mrb_define_const(mrb, mRaylib, "KEY_G", mrb_int_value(mrb, 71));
    mrb_define_const(mrb, mRaylib, "KEY_H", mrb_int_value(mrb, 72));
    mrb_define_const(mrb, mRaylib, "KEY_I", mrb_int_value(mrb, 73));
    mrb_define_const(mrb, mRaylib, "KEY_J", mrb_int_value(mrb, 74));
    mrb_define_const(mrb, mRaylib, "KEY_K", mrb_int_value(mrb, 75));
    mrb_define_const(mrb, mRaylib, "KEY_L", mrb_int_value(mrb, 76));
    mrb_define_const(mrb, mRaylib, "KEY_M", mrb_int_value(mrb, 77));
    mrb_define_const(mrb, mRaylib, "KEY_N", mrb_int_value(mrb, 78));
    mrb_define_const(mrb, mRaylib, "KEY_O", mrb_int_value(mrb, 79));
    mrb_define_const(mrb, mRaylib, "KEY_P", mrb_int_value(mrb, 80));
    mrb_define_const(mrb, mRaylib, "KEY_Q", mrb_int_value(mrb, 81));
    mrb_define_const(mrb, mRaylib, "KEY_R", mrb_int_value(mrb, 82));
    mrb_define_const(mrb, mRaylib, "KEY_S", mrb_int_value(mrb, 83));
    mrb_define_const(mrb, mRaylib, "KEY_T", mrb_int_value(mrb, 84));
    mrb_define_const(mrb, mRaylib, "KEY_U", mrb_int_value(mrb, 85));
    mrb_define_const(mrb, mRaylib, "KEY_V", mrb_int_value(mrb, 86));
    mrb_define_const(mrb, mRaylib, "KEY_W", mrb_int_value(mrb, 87));
    mrb_define_const(mrb, mRaylib, "KEY_X", mrb_int_value(mrb, 88));
    mrb_define_const(mrb, mRaylib, "KEY_Y", mrb_int_value(mrb, 89));
    mrb_define_const(mrb, mRaylib, "KEY_Z", mrb_int_value(mrb, 90));
    mrb_define_const(mrb, mRaylib, "KEY_LEFT_BRACKET", mrb_int_value(mrb, 91));
    mrb_define_const(mrb, mRaylib, "KEY_BACKSLASH", mrb_int_value(mrb, 92));
    mrb_define_const(mrb, mRaylib, "KEY_RIGHT_BRACKET", mrb_int_value(mrb, 93));
    mrb_define_const(mrb, mRaylib, "KEY_GRAVE", mrb_int_value(mrb, 96));
    mrb_define_const(mrb, mRaylib, "KEY_SPACE", mrb_int_value(mrb, 32));
    mrb_define_const(mrb, mRaylib, "KEY_ESCAPE", mrb_int_value(mrb, 256));
    mrb_define_const(mrb, mRaylib, "KEY_ENTER", mrb_int_value(mrb, 257));
    mrb_define_const(mrb, mRaylib, "KEY_TAB", mrb_int_value(mrb, 258));
    mrb_define_const(mrb, mRaylib, "KEY_BACKSPACE", mrb_int_value(mrb, 259));
    mrb_define_const(mrb, mRaylib, "KEY_INSERT", mrb_int_value(mrb, 260));
    mrb_define_const(mrb, mRaylib, "KEY_DELETE", mrb_int_value(mrb, 261));
    mrb_define_const(mrb, mRaylib, "KEY_RIGHT", mrb_int_value(mrb, 262));
    mrb_define_const(mrb, mRaylib, "KEY_LEFT", mrb_int_value(mrb, 263));
    mrb_define_const(mrb, mRaylib, "KEY_DOWN", mrb_int_value(mrb, 264));
    mrb_define_const(mrb, mRaylib, "KEY_UP", mrb_int_value(mrb, 265));
    mrb_define_const(mrb, mRaylib, "KEY_PAGE_UP", mrb_int_value(mrb, 266));
    mrb_define_const(mrb, mRaylib, "KEY_PAGE_DOWN", mrb_int_value(mrb, 267));
    mrb_define_const(mrb, mRaylib, "KEY_HOME", mrb_int_value(mrb, 268));
    mrb_define_const(mrb, mRaylib, "KEY_END", mrb_int_value(mrb, 269));
    mrb_define_const(mrb, mRaylib, "KEY_CAPS_LOCK", mrb_int_value(mrb, 280));
    mrb_define_const(mrb, mRaylib, "KEY_SCROLL_LOCK", mrb_int_value(mrb, 281));
    mrb_define_const(mrb, mRaylib, "KEY_NUM_LOCK", mrb_int_value(mrb, 282));
    mrb_define_const(mrb, mRaylib, "KEY_PRINT_SCREEN", mrb_int_value(mrb, 283));
    mrb_define_const(mrb, mRaylib, "KEY_PAUSE", mrb_int_value(mrb, 284));
    mrb_define_const(mrb, mRaylib, "KEY_F1", mrb_int_value(mrb, 290));
    mrb_define_const(mrb, mRaylib, "KEY_F2", mrb_int_value(mrb, 291));
    mrb_define_const(mrb, mRaylib, "KEY_F3", mrb_int_value(mrb, 292));
    mrb_define_const(mrb, mRaylib, "KEY_F4", mrb_int_value(mrb, 293));
    mrb_define_const(mrb, mRaylib, "KEY_F5", mrb_int_value(mrb, 294));
    mrb_define_const(mrb, mRaylib, "KEY_F6", mrb_int_value(mrb, 295));
    mrb_define_const(mrb, mRaylib, "KEY_F7", mrb_int_value(mrb, 296));
    mrb_define_const(mrb, mRaylib, "KEY_F8", mrb_int_value(mrb, 297));
    mrb_define_const(mrb, mRaylib, "KEY_F9", mrb_int_value(mrb, 298));
    mrb_define_const(mrb, mRaylib, "KEY_F10", mrb_int_value(mrb, 299));
    mrb_define_const(mrb, mRaylib, "KEY_F11", mrb_int_value(mrb, 300));
    mrb_define_const(mrb, mRaylib, "KEY_F12", mrb_int_value(mrb, 301));
    mrb_define_const(mrb, mRaylib, "KEY_LEFT_SHIFT", mrb_int_value(mrb, 340));
    mrb_define_const(mrb, mRaylib, "KEY_LEFT_CONTROL", mrb_int_value(mrb, 341));
    mrb_define_const(mrb, mRaylib, "KEY_LEFT_ALT", mrb_int_value(mrb, 342));
    mrb_define_const(mrb, mRaylib, "KEY_LEFT_SUPER", mrb_int_value(mrb, 343));
    mrb_define_const(mrb, mRaylib, "KEY_RIGHT_SHIFT", mrb_int_value(mrb, 344));
    mrb_define_const(mrb, mRaylib, "KEY_RIGHT_CONTROL", mrb_int_value(mrb, 345));
    mrb_define_const(mrb, mRaylib, "KEY_RIGHT_ALT", mrb_int_value(mrb, 346));
    mrb_define_const(mrb, mRaylib, "KEY_RIGHT_SUPER", mrb_int_value(mrb, 347));
    mrb_define_const(mrb, mRaylib, "KEY_KB_MENU", mrb_int_value(mrb, 348));
    mrb_define_const(mrb, mRaylib, "KEY_KP_0", mrb_int_value(mrb, 320));
    mrb_define_const(mrb, mRaylib, "KEY_KP_1", mrb_int_value(mrb, 321));
    mrb_define_const(mrb, mRaylib, "KEY_KP_2", mrb_int_value(mrb, 322));
    mrb_define_const(mrb, mRaylib, "KEY_KP_3", mrb_int_value(mrb, 323));
    mrb_define_const(mrb, mRaylib, "KEY_KP_4", mrb_int_value(mrb, 324));
    mrb_define_const(mrb, mRaylib, "KEY_KP_5", mrb_int_value(mrb, 325));
    mrb_define_const(mrb, mRaylib, "KEY_KP_6", mrb_int_value(mrb, 326));
    mrb_define_const(mrb, mRaylib, "KEY_KP_7", mrb_int_value(mrb, 327));
    mrb_define_const(mrb, mRaylib, "KEY_KP_8", mrb_int_value(mrb, 328));
    mrb_define_const(mrb, mRaylib, "KEY_KP_9", mrb_int_value(mrb, 329));
    mrb_define_const(mrb, mRaylib, "KEY_KP_DECIMAL", mrb_int_value(mrb, 330));
    mrb_define_const(mrb, mRaylib, "KEY_KP_DIVIDE", mrb_int_value(mrb, 331));
    mrb_define_const(mrb, mRaylib, "KEY_KP_MULTIPLY", mrb_int_value(mrb, 332));
    mrb_define_const(mrb, mRaylib, "KEY_KP_SUBTRACT", mrb_int_value(mrb, 333));
    mrb_define_const(mrb, mRaylib, "KEY_KP_ADD", mrb_int_value(mrb, 334));
    mrb_define_const(mrb, mRaylib, "KEY_KP_ENTER", mrb_int_value(mrb, 335));
    mrb_define_const(mrb, mRaylib, "KEY_KP_EQUAL", mrb_int_value(mrb, 336));
    mrb_define_const(mrb, mRaylib, "KEY_BACK", mrb_int_value(mrb, 4));
    mrb_define_const(mrb, mRaylib, "KEY_MENU", mrb_int_value(mrb, 82));
    mrb_define_const(mrb, mRaylib, "KEY_VOLUME_UP", mrb_int_value(mrb, 24));
    mrb_define_const(mrb, mRaylib, "KEY_VOLUME_DOWN", mrb_int_value(mrb, 25));

    // enum MouseButton
    mrb_define_const(mrb, mRaylib, "MOUSE_BUTTON_LEFT", mrb_int_value(mrb, 0));
    mrb_define_const(mrb, mRaylib, "MOUSE_BUTTON_RIGHT", mrb_int_value(mrb, 1));
    mrb_define_const(mrb, mRaylib, "MOUSE_BUTTON_MIDDLE", mrb_int_value(mrb, 2));
    mrb_define_const(mrb, mRaylib, "MOUSE_BUTTON_SIDE", mrb_int_value(mrb, 3));
    mrb_define_const(mrb, mRaylib, "MOUSE_BUTTON_EXTRA", mrb_int_value(mrb, 4));
    mrb_define_const(mrb, mRaylib, "MOUSE_BUTTON_FORWARD", mrb_int_value(mrb, 5));
    mrb_define_const(mrb, mRaylib, "MOUSE_BUTTON_BACK", mrb_int_value(mrb, 6));

    // enum MouseCursor
    mrb_define_const(mrb, mRaylib, "MOUSE_CURSOR_DEFAULT", mrb_int_value(mrb, 0));
    mrb_define_const(mrb, mRaylib, "MOUSE_CURSOR_ARROW", mrb_int_value(mrb, 1));
    mrb_define_const(mrb, mRaylib, "MOUSE_CURSOR_IBEAM", mrb_int_value(mrb, 2));
    mrb_define_const(mrb, mRaylib, "MOUSE_CURSOR_CROSSHAIR", mrb_int_value(mrb, 3));
    mrb_define_const(mrb, mRaylib, "MOUSE_CURSOR_POINTING_HAND", mrb_int_value(mrb, 4));
    mrb_define_const(mrb, mRaylib, "MOUSE_CURSOR_RESIZE_EW", mrb_int_value(mrb, 5));
    mrb_define_const(mrb, mRaylib, "MOUSE_CURSOR_RESIZE_NS", mrb_int_value(mrb, 6));
    mrb_define_const(mrb, mRaylib, "MOUSE_CURSOR_RESIZE_NWSE", mrb_int_value(mrb, 7));
    mrb_define_const(mrb, mRaylib, "MOUSE_CURSOR_RESIZE_NESW", mrb_int_value(mrb, 8));
    mrb_define_const(mrb, mRaylib, "MOUSE_CURSOR_RESIZE_ALL", mrb_int_value(mrb, 9));
    mrb_define_const(mrb, mRaylib, "MOUSE_CURSOR_NOT_ALLOWED", mrb_int_value(mrb, 10));

    // enum GamepadButton
    mrb_define_const(mrb, mRaylib, "GAMEPAD_BUTTON_UNKNOWN", mrb_int_value(mrb, 0));
    mrb_define_const(mrb, mRaylib, "GAMEPAD_BUTTON_LEFT_FACE_UP", mrb_int_value(mrb, 1));
    mrb_define_const(mrb, mRaylib, "GAMEPAD_BUTTON_LEFT_FACE_RIGHT", mrb_int_value(mrb, 2));
    mrb_define_const(mrb, mRaylib, "GAMEPAD_BUTTON_LEFT_FACE_DOWN", mrb_int_value(mrb, 3));
    mrb_define_const(mrb, mRaylib, "GAMEPAD_BUTTON_LEFT_FACE_LEFT", mrb_int_value(mrb, 4));
    mrb_define_const(mrb, mRaylib, "GAMEPAD_BUTTON_RIGHT_FACE_UP", mrb_int_value(mrb, 5));
    mrb_define_const(mrb, mRaylib, "GAMEPAD_BUTTON_RIGHT_FACE_RIGHT", mrb_int_value(mrb, 6));
    mrb_define_const(mrb, mRaylib, "GAMEPAD_BUTTON_RIGHT_FACE_DOWN", mrb_int_value(mrb, 7));
    mrb_define_const(mrb, mRaylib, "GAMEPAD_BUTTON_RIGHT_FACE_LEFT", mrb_int_value(mrb, 8));
    mrb_define_const(mrb, mRaylib, "GAMEPAD_BUTTON_LEFT_TRIGGER_1", mrb_int_value(mrb, 9));
    mrb_define_const(mrb, mRaylib, "GAMEPAD_BUTTON_LEFT_TRIGGER_2", mrb_int_value(mrb, 10));
    mrb_define_const(mrb, mRaylib, "GAMEPAD_BUTTON_RIGHT_TRIGGER_1", mrb_int_value(mrb, 11));
    mrb_define_const(mrb, mRaylib, "GAMEPAD_BUTTON_RIGHT_TRIGGER_2", mrb_int_value(mrb, 12));
    mrb_define_const(mrb, mRaylib, "GAMEPAD_BUTTON_MIDDLE_LEFT", mrb_int_value(mrb, 13));
    mrb_define_const(mrb, mRaylib, "GAMEPAD_BUTTON_MIDDLE", mrb_int_value(mrb, 14));
    mrb_define_const(mrb, mRaylib, "GAMEPAD_BUTTON_MIDDLE_RIGHT", mrb_int_value(mrb, 15));
    mrb_define_const(mrb, mRaylib, "GAMEPAD_BUTTON_LEFT_THUMB", mrb_int_value(mrb, 16));
    mrb_define_const(mrb, mRaylib, "GAMEPAD_BUTTON_RIGHT_THUMB", mrb_int_value(mrb, 17));

    // enum GamepadAxis
    mrb_define_const(mrb, mRaylib, "GAMEPAD_AXIS_LEFT_X", mrb_int_value(mrb, 0));
    mrb_define_const(mrb, mRaylib, "GAMEPAD_AXIS_LEFT_Y", mrb_int_value(mrb, 1));
    mrb_define_const(mrb, mRaylib, "GAMEPAD_AXIS_RIGHT_X", mrb_int_value(mrb, 2));
    mrb_define_const(mrb, mRaylib, "GAMEPAD_AXIS_RIGHT_Y", mrb_int_value(mrb, 3));
    mrb_define_const(mrb, mRaylib, "GAMEPAD_AXIS_LEFT_TRIGGER", mrb_int_value(mrb, 4));
    mrb_define_const(mrb, mRaylib, "GAMEPAD_AXIS_RIGHT_TRIGGER", mrb_int_value(mrb, 5));

    // enum MaterialMapIndex
    mrb_define_const(mrb, mRaylib, "MATERIAL_MAP_ALBEDO", mrb_int_value(mrb, 0));
    mrb_define_const(mrb, mRaylib, "MATERIAL_MAP_METALNESS", mrb_int_value(mrb, 1));
    mrb_define_const(mrb, mRaylib, "MATERIAL_MAP_NORMAL", mrb_int_value(mrb, 2));
    mrb_define_const(mrb, mRaylib, "MATERIAL_MAP_ROUGHNESS", mrb_int_value(mrb, 3));
    mrb_define_const(mrb, mRaylib, "MATERIAL_MAP_OCCLUSION", mrb_int_value(mrb, 4));
    mrb_define_const(mrb, mRaylib, "MATERIAL_MAP_EMISSION", mrb_int_value(mrb, 5));
    mrb_define_const(mrb, mRaylib, "MATERIAL_MAP_HEIGHT", mrb_int_value(mrb, 6));
    mrb_define_const(mrb, mRaylib, "MATERIAL_MAP_CUBEMAP", mrb_int_value(mrb, 7));
    mrb_define_const(mrb, mRaylib, "MATERIAL_MAP_IRRADIANCE", mrb_int_value(mrb, 8));
    mrb_define_const(mrb, mRaylib, "MATERIAL_MAP_PREFILTER", mrb_int_value(mrb, 9));
    mrb_define_const(mrb, mRaylib, "MATERIAL_MAP_BRDF", mrb_int_value(mrb, 10));

    // enum ShaderLocationIndex
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_VERTEX_POSITION", mrb_int_value(mrb, 0));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_VERTEX_TEXCOORD01", mrb_int_value(mrb, 1));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_VERTEX_TEXCOORD02", mrb_int_value(mrb, 2));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_VERTEX_NORMAL", mrb_int_value(mrb, 3));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_VERTEX_TANGENT", mrb_int_value(mrb, 4));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_VERTEX_COLOR", mrb_int_value(mrb, 5));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_MATRIX_MVP", mrb_int_value(mrb, 6));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_MATRIX_VIEW", mrb_int_value(mrb, 7));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_MATRIX_PROJECTION", mrb_int_value(mrb, 8));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_MATRIX_MODEL", mrb_int_value(mrb, 9));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_MATRIX_NORMAL", mrb_int_value(mrb, 10));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_VECTOR_VIEW", mrb_int_value(mrb, 11));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_COLOR_DIFFUSE", mrb_int_value(mrb, 12));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_COLOR_SPECULAR", mrb_int_value(mrb, 13));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_COLOR_AMBIENT", mrb_int_value(mrb, 14));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_MAP_ALBEDO", mrb_int_value(mrb, 15));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_MAP_METALNESS", mrb_int_value(mrb, 16));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_MAP_NORMAL", mrb_int_value(mrb, 17));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_MAP_ROUGHNESS", mrb_int_value(mrb, 18));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_MAP_OCCLUSION", mrb_int_value(mrb, 19));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_MAP_EMISSION", mrb_int_value(mrb, 20));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_MAP_HEIGHT", mrb_int_value(mrb, 21));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_MAP_CUBEMAP", mrb_int_value(mrb, 22));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_MAP_IRRADIANCE", mrb_int_value(mrb, 23));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_MAP_PREFILTER", mrb_int_value(mrb, 24));
    mrb_define_const(mrb, mRaylib, "SHADER_LOC_MAP_BRDF", mrb_int_value(mrb, 25));

    // enum ShaderUniformDataType
    mrb_define_const(mrb, mRaylib, "SHADER_UNIFORM_FLOAT", mrb_int_value(mrb, 0));
    mrb_define_const(mrb, mRaylib, "SHADER_UNIFORM_VEC2", mrb_int_value(mrb, 1));
    mrb_define_const(mrb, mRaylib, "SHADER_UNIFORM_VEC3", mrb_int_value(mrb, 2));
    mrb_define_const(mrb, mRaylib, "SHADER_UNIFORM_VEC4", mrb_int_value(mrb, 3));
    mrb_define_const(mrb, mRaylib, "SHADER_UNIFORM_INT", mrb_int_value(mrb, 4));
    mrb_define_const(mrb, mRaylib, "SHADER_UNIFORM_IVEC2", mrb_int_value(mrb, 5));
    mrb_define_const(mrb, mRaylib, "SHADER_UNIFORM_IVEC3", mrb_int_value(mrb, 6));
    mrb_define_const(mrb, mRaylib, "SHADER_UNIFORM_IVEC4", mrb_int_value(mrb, 7));
    mrb_define_const(mrb, mRaylib, "SHADER_UNIFORM_SAMPLER2D", mrb_int_value(mrb, 8));

    // enum ShaderAttributeDataType
    mrb_define_const(mrb, mRaylib, "SHADER_ATTRIB_FLOAT", mrb_int_value(mrb, 0));
    mrb_define_const(mrb, mRaylib, "SHADER_ATTRIB_VEC2", mrb_int_value(mrb, 1));
    mrb_define_const(mrb, mRaylib, "SHADER_ATTRIB_VEC3", mrb_int_value(mrb, 2));
    mrb_define_const(mrb, mRaylib, "SHADER_ATTRIB_VEC4", mrb_int_value(mrb, 3));

    // enum PixelFormat
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_UNCOMPRESSED_GRAYSCALE", mrb_int_value(mrb, 1));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA", mrb_int_value(mrb, 2));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_UNCOMPRESSED_R5G6B5", mrb_int_value(mrb, 3));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_UNCOMPRESSED_R8G8B8", mrb_int_value(mrb, 4));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_UNCOMPRESSED_R5G5B5A1", mrb_int_value(mrb, 5));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_UNCOMPRESSED_R4G4B4A4", mrb_int_value(mrb, 6));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_UNCOMPRESSED_R8G8B8A8", mrb_int_value(mrb, 7));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_UNCOMPRESSED_R32", mrb_int_value(mrb, 8));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_UNCOMPRESSED_R32G32B32", mrb_int_value(mrb, 9));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_UNCOMPRESSED_R32G32B32A32", mrb_int_value(mrb, 10));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_UNCOMPRESSED_R16", mrb_int_value(mrb, 11));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_UNCOMPRESSED_R16G16B16", mrb_int_value(mrb, 12));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_UNCOMPRESSED_R16G16B16A16", mrb_int_value(mrb, 13));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_COMPRESSED_DXT1_RGB", mrb_int_value(mrb, 14));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_COMPRESSED_DXT1_RGBA", mrb_int_value(mrb, 15));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_COMPRESSED_DXT3_RGBA", mrb_int_value(mrb, 16));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_COMPRESSED_DXT5_RGBA", mrb_int_value(mrb, 17));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_COMPRESSED_ETC1_RGB", mrb_int_value(mrb, 18));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_COMPRESSED_ETC2_RGB", mrb_int_value(mrb, 19));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA", mrb_int_value(mrb, 20));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_COMPRESSED_PVRT_RGB", mrb_int_value(mrb, 21));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_COMPRESSED_PVRT_RGBA", mrb_int_value(mrb, 22));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA", mrb_int_value(mrb, 23));
    mrb_define_const(mrb, mRaylib, "PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA", mrb_int_value(mrb, 24));

    // enum TextureFilter
    mrb_define_const(mrb, mRaylib, "TEXTURE_FILTER_POINT", mrb_int_value(mrb, 0));
    mrb_define_const(mrb, mRaylib, "TEXTURE_FILTER_BILINEAR", mrb_int_value(mrb, 1));
    mrb_define_const(mrb, mRaylib, "TEXTURE_FILTER_TRILINEAR", mrb_int_value(mrb, 2));
    mrb_define_const(mrb, mRaylib, "TEXTURE_FILTER_ANISOTROPIC_4X", mrb_int_value(mrb, 3));
    mrb_define_const(mrb, mRaylib, "TEXTURE_FILTER_ANISOTROPIC_8X", mrb_int_value(mrb, 4));
    mrb_define_const(mrb, mRaylib, "TEXTURE_FILTER_ANISOTROPIC_16X", mrb_int_value(mrb, 5));

    // enum TextureWrap
    mrb_define_const(mrb, mRaylib, "TEXTURE_WRAP_REPEAT", mrb_int_value(mrb, 0));
    mrb_define_const(mrb, mRaylib, "TEXTURE_WRAP_CLAMP", mrb_int_value(mrb, 1));
    mrb_define_const(mrb, mRaylib, "TEXTURE_WRAP_MIRROR_REPEAT", mrb_int_value(mrb, 2));
    mrb_define_const(mrb, mRaylib, "TEXTURE_WRAP_MIRROR_CLAMP", mrb_int_value(mrb, 3));

    // enum CubemapLayout
    mrb_define_const(mrb, mRaylib, "CUBEMAP_LAYOUT_AUTO_DETECT", mrb_int_value(mrb, 0));
    mrb_define_const(mrb, mRaylib, "CUBEMAP_LAYOUT_LINE_VERTICAL", mrb_int_value(mrb, 1));
    mrb_define_const(mrb, mRaylib, "CUBEMAP_LAYOUT_LINE_HORIZONTAL", mrb_int_value(mrb, 2));
    mrb_define_const(mrb, mRaylib, "CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR", mrb_int_value(mrb, 3));
    mrb_define_const(mrb, mRaylib, "CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE", mrb_int_value(mrb, 4));
    mrb_define_const(mrb, mRaylib, "CUBEMAP_LAYOUT_PANORAMA", mrb_int_value(mrb, 5));

    // enum FontType
    mrb_define_const(mrb, mRaylib, "FONT_DEFAULT", mrb_int_value(mrb, 0));
    mrb_define_const(mrb, mRaylib, "FONT_BITMAP", mrb_int_value(mrb, 1));
    mrb_define_const(mrb, mRaylib, "FONT_SDF", mrb_int_value(mrb, 2));

    // enum BlendMode
    mrb_define_const(mrb, mRaylib, "BLEND_ALPHA", mrb_int_value(mrb, 0));
    mrb_define_const(mrb, mRaylib, "BLEND_ADDITIVE", mrb_int_value(mrb, 1));
    mrb_define_const(mrb, mRaylib, "BLEND_MULTIPLIED", mrb_int_value(mrb, 2));
    mrb_define_const(mrb, mRaylib, "BLEND_ADD_COLORS", mrb_int_value(mrb, 3));
    mrb_define_const(mrb, mRaylib, "BLEND_SUBTRACT_COLORS", mrb_int_value(mrb, 4));
    mrb_define_const(mrb, mRaylib, "BLEND_ALPHA_PREMULTIPLY", mrb_int_value(mrb, 5));
    mrb_define_const(mrb, mRaylib, "BLEND_CUSTOM", mrb_int_value(mrb, 6));
    mrb_define_const(mrb, mRaylib, "BLEND_CUSTOM_SEPARATE", mrb_int_value(mrb, 7));

    // enum Gesture
    mrb_define_const(mrb, mRaylib, "GESTURE_NONE", mrb_int_value(mrb, 0));
    mrb_define_const(mrb, mRaylib, "GESTURE_TAP", mrb_int_value(mrb, 1));
    mrb_define_const(mrb, mRaylib, "GESTURE_DOUBLETAP", mrb_int_value(mrb, 2));
    mrb_define_const(mrb, mRaylib, "GESTURE_HOLD", mrb_int_value(mrb, 4));
    mrb_define_const(mrb, mRaylib, "GESTURE_DRAG", mrb_int_value(mrb, 8));
    mrb_define_const(mrb, mRaylib, "GESTURE_SWIPE_RIGHT", mrb_int_value(mrb, 16));
    mrb_define_const(mrb, mRaylib, "GESTURE_SWIPE_LEFT", mrb_int_value(mrb, 32));
    mrb_define_const(mrb, mRaylib, "GESTURE_SWIPE_UP", mrb_int_value(mrb, 64));
    mrb_define_const(mrb, mRaylib, "GESTURE_SWIPE_DOWN", mrb_int_value(mrb, 128));
    mrb_define_const(mrb, mRaylib, "GESTURE_PINCH_IN", mrb_int_value(mrb, 256));
    mrb_define_const(mrb, mRaylib, "GESTURE_PINCH_OUT", mrb_int_value(mrb, 512));

    // enum CameraMode
    mrb_define_const(mrb, mRaylib, "CAMERA_CUSTOM", mrb_int_value(mrb, 0));
    mrb_define_const(mrb, mRaylib, "CAMERA_FREE", mrb_int_value(mrb, 1));
    mrb_define_const(mrb, mRaylib, "CAMERA_ORBITAL", mrb_int_value(mrb, 2));
    mrb_define_const(mrb, mRaylib, "CAMERA_FIRST_PERSON", mrb_int_value(mrb, 3));
    mrb_define_const(mrb, mRaylib, "CAMERA_THIRD_PERSON", mrb_int_value(mrb, 4));

    // enum CameraProjection
    mrb_define_const(mrb, mRaylib, "CAMERA_PERSPECTIVE", mrb_int_value(mrb, 0));
    mrb_define_const(mrb, mRaylib, "CAMERA_ORTHOGRAPHIC", mrb_int_value(mrb, 1));

    // enum NPatchLayout
    mrb_define_const(mrb, mRaylib, "NPATCH_NINE_PATCH", mrb_int_value(mrb, 0));
    mrb_define_const(mrb, mRaylib, "NPATCH_THREE_PATCH_VERTICAL", mrb_int_value(mrb, 1));
    mrb_define_const(mrb, mRaylib, "NPATCH_THREE_PATCH_HORIZONTAL", mrb_int_value(mrb, 2));


    // Struct

    cRaylibVector2 = mrb_define_class_under(mrb, mRaylib, "Vector2", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibVector2, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibVector2, "initialize", mrb_raylib_Vector2_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibVector2, "x", mrb_raylib_Vector2_x_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibVector2, "x=", mrb_raylib_Vector2_x_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibVector2, "y", mrb_raylib_Vector2_y_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibVector2, "y=", mrb_raylib_Vector2_y_set, MRB_ARGS_REQ(1));

    cRaylibVector3 = mrb_define_class_under(mrb, mRaylib, "Vector3", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibVector3, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibVector3, "initialize", mrb_raylib_Vector3_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibVector3, "x", mrb_raylib_Vector3_x_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibVector3, "x=", mrb_raylib_Vector3_x_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibVector3, "y", mrb_raylib_Vector3_y_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibVector3, "y=", mrb_raylib_Vector3_y_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibVector3, "z", mrb_raylib_Vector3_z_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibVector3, "z=", mrb_raylib_Vector3_z_set, MRB_ARGS_REQ(1));

    cRaylibVector4 = mrb_define_class_under(mrb, mRaylib, "Vector4", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibVector4, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibVector4, "initialize", mrb_raylib_Vector4_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibVector4, "x", mrb_raylib_Vector4_x_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibVector4, "x=", mrb_raylib_Vector4_x_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibVector4, "y", mrb_raylib_Vector4_y_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibVector4, "y=", mrb_raylib_Vector4_y_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibVector4, "z", mrb_raylib_Vector4_z_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibVector4, "z=", mrb_raylib_Vector4_z_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibVector4, "w", mrb_raylib_Vector4_w_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibVector4, "w=", mrb_raylib_Vector4_w_set, MRB_ARGS_REQ(1));

    cRaylibMatrix = mrb_define_class_under(mrb, mRaylib, "Matrix", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibMatrix, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibMatrix, "initialize", mrb_raylib_Matrix_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibMatrix, "m0", mrb_raylib_Matrix_m0_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMatrix, "m0=", mrb_raylib_Matrix_m0_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibMatrix, "m4", mrb_raylib_Matrix_m4_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMatrix, "m4=", mrb_raylib_Matrix_m4_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibMatrix, "m8", mrb_raylib_Matrix_m8_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMatrix, "m8=", mrb_raylib_Matrix_m8_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibMatrix, "m12", mrb_raylib_Matrix_m12_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMatrix, "m12=", mrb_raylib_Matrix_m12_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibMatrix, "m1", mrb_raylib_Matrix_m1_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMatrix, "m1=", mrb_raylib_Matrix_m1_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibMatrix, "m5", mrb_raylib_Matrix_m5_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMatrix, "m5=", mrb_raylib_Matrix_m5_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibMatrix, "m9", mrb_raylib_Matrix_m9_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMatrix, "m9=", mrb_raylib_Matrix_m9_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibMatrix, "m13", mrb_raylib_Matrix_m13_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMatrix, "m13=", mrb_raylib_Matrix_m13_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibMatrix, "m2", mrb_raylib_Matrix_m2_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMatrix, "m2=", mrb_raylib_Matrix_m2_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibMatrix, "m6", mrb_raylib_Matrix_m6_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMatrix, "m6=", mrb_raylib_Matrix_m6_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibMatrix, "m10", mrb_raylib_Matrix_m10_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMatrix, "m10=", mrb_raylib_Matrix_m10_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibMatrix, "m14", mrb_raylib_Matrix_m14_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMatrix, "m14=", mrb_raylib_Matrix_m14_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibMatrix, "m3", mrb_raylib_Matrix_m3_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMatrix, "m3=", mrb_raylib_Matrix_m3_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibMatrix, "m7", mrb_raylib_Matrix_m7_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMatrix, "m7=", mrb_raylib_Matrix_m7_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibMatrix, "m11", mrb_raylib_Matrix_m11_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMatrix, "m11=", mrb_raylib_Matrix_m11_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibMatrix, "m15", mrb_raylib_Matrix_m15_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMatrix, "m15=", mrb_raylib_Matrix_m15_set, MRB_ARGS_REQ(1));

    cRaylibColor = mrb_define_class_under(mrb, mRaylib, "Color", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibColor, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibColor, "initialize", mrb_raylib_Color_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibColor, "r", mrb_raylib_Color_r_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibColor, "r=", mrb_raylib_Color_r_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibColor, "g", mrb_raylib_Color_g_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibColor, "g=", mrb_raylib_Color_g_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibColor, "b", mrb_raylib_Color_b_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibColor, "b=", mrb_raylib_Color_b_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibColor, "a", mrb_raylib_Color_a_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibColor, "a=", mrb_raylib_Color_a_set, MRB_ARGS_REQ(1));

    cRaylibRectangle = mrb_define_class_under(mrb, mRaylib, "Rectangle", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibRectangle, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibRectangle, "initialize", mrb_raylib_Rectangle_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibRectangle, "x", mrb_raylib_Rectangle_x_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibRectangle, "x=", mrb_raylib_Rectangle_x_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibRectangle, "y", mrb_raylib_Rectangle_y_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibRectangle, "y=", mrb_raylib_Rectangle_y_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibRectangle, "width", mrb_raylib_Rectangle_width_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibRectangle, "width=", mrb_raylib_Rectangle_width_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibRectangle, "height", mrb_raylib_Rectangle_height_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibRectangle, "height=", mrb_raylib_Rectangle_height_set, MRB_ARGS_REQ(1));

    cRaylibImage = mrb_define_class_under(mrb, mRaylib, "Image", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibImage, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibImage, "initialize", mrb_raylib_Image_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibImage, "width", mrb_raylib_Image_width_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibImage, "width=", mrb_raylib_Image_width_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibImage, "height", mrb_raylib_Image_height_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibImage, "height=", mrb_raylib_Image_height_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibImage, "mipmaps", mrb_raylib_Image_mipmaps_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibImage, "mipmaps=", mrb_raylib_Image_mipmaps_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibImage, "format", mrb_raylib_Image_format_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibImage, "format=", mrb_raylib_Image_format_set, MRB_ARGS_REQ(1));

    cRaylibTexture = mrb_define_class_under(mrb, mRaylib, "Texture", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibTexture, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibTexture, "initialize", mrb_raylib_Texture_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibTexture, "id", mrb_raylib_Texture_id_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibTexture, "id=", mrb_raylib_Texture_id_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibTexture, "width", mrb_raylib_Texture_width_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibTexture, "width=", mrb_raylib_Texture_width_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibTexture, "height", mrb_raylib_Texture_height_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibTexture, "height=", mrb_raylib_Texture_height_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibTexture, "mipmaps", mrb_raylib_Texture_mipmaps_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibTexture, "mipmaps=", mrb_raylib_Texture_mipmaps_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibTexture, "format", mrb_raylib_Texture_format_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibTexture, "format=", mrb_raylib_Texture_format_set, MRB_ARGS_REQ(1));

    cRaylibRenderTexture = mrb_define_class_under(mrb, mRaylib, "RenderTexture", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibRenderTexture, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibRenderTexture, "initialize", mrb_raylib_RenderTexture_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibRenderTexture, "id", mrb_raylib_RenderTexture_id_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibRenderTexture, "id=", mrb_raylib_RenderTexture_id_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibRenderTexture, "texture", mrb_raylib_RenderTexture_texture_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibRenderTexture, "texture=", mrb_raylib_RenderTexture_texture_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibRenderTexture, "depth", mrb_raylib_RenderTexture_depth_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibRenderTexture, "depth=", mrb_raylib_RenderTexture_depth_set, MRB_ARGS_REQ(1));

    cRaylibNPatchInfo = mrb_define_class_under(mrb, mRaylib, "NPatchInfo", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibNPatchInfo, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibNPatchInfo, "initialize", mrb_raylib_NPatchInfo_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibNPatchInfo, "source", mrb_raylib_NPatchInfo_source_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibNPatchInfo, "source=", mrb_raylib_NPatchInfo_source_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibNPatchInfo, "left", mrb_raylib_NPatchInfo_left_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibNPatchInfo, "left=", mrb_raylib_NPatchInfo_left_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibNPatchInfo, "top", mrb_raylib_NPatchInfo_top_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibNPatchInfo, "top=", mrb_raylib_NPatchInfo_top_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibNPatchInfo, "right", mrb_raylib_NPatchInfo_right_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibNPatchInfo, "right=", mrb_raylib_NPatchInfo_right_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibNPatchInfo, "bottom", mrb_raylib_NPatchInfo_bottom_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibNPatchInfo, "bottom=", mrb_raylib_NPatchInfo_bottom_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibNPatchInfo, "layout", mrb_raylib_NPatchInfo_layout_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibNPatchInfo, "layout=", mrb_raylib_NPatchInfo_layout_set, MRB_ARGS_REQ(1));

    cRaylibGlyphInfo = mrb_define_class_under(mrb, mRaylib, "GlyphInfo", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibGlyphInfo, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibGlyphInfo, "initialize", mrb_raylib_GlyphInfo_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibGlyphInfo, "value", mrb_raylib_GlyphInfo_value_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibGlyphInfo, "value=", mrb_raylib_GlyphInfo_value_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibGlyphInfo, "offsetX", mrb_raylib_GlyphInfo_offsetX_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibGlyphInfo, "offsetX=", mrb_raylib_GlyphInfo_offsetX_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibGlyphInfo, "offsetY", mrb_raylib_GlyphInfo_offsetY_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibGlyphInfo, "offsetY=", mrb_raylib_GlyphInfo_offsetY_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibGlyphInfo, "advanceX", mrb_raylib_GlyphInfo_advanceX_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibGlyphInfo, "advanceX=", mrb_raylib_GlyphInfo_advanceX_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibGlyphInfo, "image", mrb_raylib_GlyphInfo_image_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibGlyphInfo, "image=", mrb_raylib_GlyphInfo_image_set, MRB_ARGS_REQ(1));

    cRaylibFont = mrb_define_class_under(mrb, mRaylib, "Font", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibFont, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibFont, "initialize", mrb_raylib_Font_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibFont, "baseSize", mrb_raylib_Font_baseSize_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibFont, "baseSize=", mrb_raylib_Font_baseSize_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibFont, "glyphCount", mrb_raylib_Font_glyphCount_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibFont, "glyphCount=", mrb_raylib_Font_glyphCount_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibFont, "glyphPadding", mrb_raylib_Font_glyphPadding_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibFont, "glyphPadding=", mrb_raylib_Font_glyphPadding_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibFont, "texture", mrb_raylib_Font_texture_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibFont, "texture=", mrb_raylib_Font_texture_set, MRB_ARGS_REQ(1));

    cRaylibCamera3D = mrb_define_class_under(mrb, mRaylib, "Camera3D", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibCamera3D, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibCamera3D, "initialize", mrb_raylib_Camera3D_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibCamera3D, "position", mrb_raylib_Camera3D_position_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibCamera3D, "position=", mrb_raylib_Camera3D_position_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibCamera3D, "target", mrb_raylib_Camera3D_target_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibCamera3D, "target=", mrb_raylib_Camera3D_target_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibCamera3D, "up", mrb_raylib_Camera3D_up_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibCamera3D, "up=", mrb_raylib_Camera3D_up_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibCamera3D, "fovy", mrb_raylib_Camera3D_fovy_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibCamera3D, "fovy=", mrb_raylib_Camera3D_fovy_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibCamera3D, "projection", mrb_raylib_Camera3D_projection_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibCamera3D, "projection=", mrb_raylib_Camera3D_projection_set, MRB_ARGS_REQ(1));

    cRaylibCamera2D = mrb_define_class_under(mrb, mRaylib, "Camera2D", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibCamera2D, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibCamera2D, "initialize", mrb_raylib_Camera2D_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibCamera2D, "offset", mrb_raylib_Camera2D_offset_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibCamera2D, "offset=", mrb_raylib_Camera2D_offset_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibCamera2D, "target", mrb_raylib_Camera2D_target_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibCamera2D, "target=", mrb_raylib_Camera2D_target_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibCamera2D, "rotation", mrb_raylib_Camera2D_rotation_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibCamera2D, "rotation=", mrb_raylib_Camera2D_rotation_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibCamera2D, "zoom", mrb_raylib_Camera2D_zoom_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibCamera2D, "zoom=", mrb_raylib_Camera2D_zoom_set, MRB_ARGS_REQ(1));

    cRaylibMesh = mrb_define_class_under(mrb, mRaylib, "Mesh", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibMesh, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibMesh, "initialize", mrb_raylib_Mesh_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibMesh, "vertexCount", mrb_raylib_Mesh_vertexCount_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMesh, "vertexCount=", mrb_raylib_Mesh_vertexCount_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibMesh, "triangleCount", mrb_raylib_Mesh_triangleCount_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMesh, "triangleCount=", mrb_raylib_Mesh_triangleCount_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibMesh, "vaoId", mrb_raylib_Mesh_vaoId_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMesh, "vaoId=", mrb_raylib_Mesh_vaoId_set, MRB_ARGS_REQ(1));

    cRaylibShader = mrb_define_class_under(mrb, mRaylib, "Shader", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibShader, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibShader, "initialize", mrb_raylib_Shader_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibShader, "id", mrb_raylib_Shader_id_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibShader, "id=", mrb_raylib_Shader_id_set, MRB_ARGS_REQ(1));

    cRaylibMaterialMap = mrb_define_class_under(mrb, mRaylib, "MaterialMap", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibMaterialMap, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibMaterialMap, "initialize", mrb_raylib_MaterialMap_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibMaterialMap, "texture", mrb_raylib_MaterialMap_texture_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMaterialMap, "texture=", mrb_raylib_MaterialMap_texture_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibMaterialMap, "color", mrb_raylib_MaterialMap_color_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMaterialMap, "color=", mrb_raylib_MaterialMap_color_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibMaterialMap, "value", mrb_raylib_MaterialMap_value_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMaterialMap, "value=", mrb_raylib_MaterialMap_value_set, MRB_ARGS_REQ(1));

    cRaylibMaterial = mrb_define_class_under(mrb, mRaylib, "Material", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibMaterial, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibMaterial, "initialize", mrb_raylib_Material_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibMaterial, "shader", mrb_raylib_Material_shader_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMaterial, "shader=", mrb_raylib_Material_shader_set, MRB_ARGS_REQ(1));

    cRaylibTransform = mrb_define_class_under(mrb, mRaylib, "Transform", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibTransform, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibTransform, "initialize", mrb_raylib_Transform_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibTransform, "translation", mrb_raylib_Transform_translation_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibTransform, "translation=", mrb_raylib_Transform_translation_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibTransform, "rotation", mrb_raylib_Transform_rotation_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibTransform, "rotation=", mrb_raylib_Transform_rotation_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibTransform, "scale", mrb_raylib_Transform_scale_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibTransform, "scale=", mrb_raylib_Transform_scale_set, MRB_ARGS_REQ(1));

    cRaylibBoneInfo = mrb_define_class_under(mrb, mRaylib, "BoneInfo", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibBoneInfo, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibBoneInfo, "initialize", mrb_raylib_BoneInfo_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibBoneInfo, "name", mrb_raylib_BoneInfo_name_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibBoneInfo, "name=", mrb_raylib_BoneInfo_name_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibBoneInfo, "parent", mrb_raylib_BoneInfo_parent_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibBoneInfo, "parent=", mrb_raylib_BoneInfo_parent_set, MRB_ARGS_REQ(1));

    cRaylibModel = mrb_define_class_under(mrb, mRaylib, "Model", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibModel, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibModel, "initialize", mrb_raylib_Model_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibModel, "transform", mrb_raylib_Model_transform_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibModel, "transform=", mrb_raylib_Model_transform_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibModel, "meshCount", mrb_raylib_Model_meshCount_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibModel, "meshCount=", mrb_raylib_Model_meshCount_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibModel, "materialCount", mrb_raylib_Model_materialCount_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibModel, "materialCount=", mrb_raylib_Model_materialCount_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibModel, "boneCount", mrb_raylib_Model_boneCount_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibModel, "boneCount=", mrb_raylib_Model_boneCount_set, MRB_ARGS_REQ(1));

    cRaylibModelAnimation = mrb_define_class_under(mrb, mRaylib, "ModelAnimation", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibModelAnimation, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibModelAnimation, "initialize", mrb_raylib_ModelAnimation_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibModelAnimation, "boneCount", mrb_raylib_ModelAnimation_boneCount_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibModelAnimation, "boneCount=", mrb_raylib_ModelAnimation_boneCount_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibModelAnimation, "frameCount", mrb_raylib_ModelAnimation_frameCount_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibModelAnimation, "frameCount=", mrb_raylib_ModelAnimation_frameCount_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibModelAnimation, "name", mrb_raylib_ModelAnimation_name_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibModelAnimation, "name=", mrb_raylib_ModelAnimation_name_set, MRB_ARGS_REQ(1));

    cRaylibRay = mrb_define_class_under(mrb, mRaylib, "Ray", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibRay, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibRay, "initialize", mrb_raylib_Ray_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibRay, "position", mrb_raylib_Ray_position_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibRay, "position=", mrb_raylib_Ray_position_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibRay, "direction", mrb_raylib_Ray_direction_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibRay, "direction=", mrb_raylib_Ray_direction_set, MRB_ARGS_REQ(1));

    cRaylibRayCollision = mrb_define_class_under(mrb, mRaylib, "RayCollision", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibRayCollision, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibRayCollision, "initialize", mrb_raylib_RayCollision_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibRayCollision, "hit", mrb_raylib_RayCollision_hit_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibRayCollision, "hit=", mrb_raylib_RayCollision_hit_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibRayCollision, "distance", mrb_raylib_RayCollision_distance_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibRayCollision, "distance=", mrb_raylib_RayCollision_distance_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibRayCollision, "point", mrb_raylib_RayCollision_point_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibRayCollision, "point=", mrb_raylib_RayCollision_point_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibRayCollision, "normal", mrb_raylib_RayCollision_normal_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibRayCollision, "normal=", mrb_raylib_RayCollision_normal_set, MRB_ARGS_REQ(1));

    cRaylibBoundingBox = mrb_define_class_under(mrb, mRaylib, "BoundingBox", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibBoundingBox, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibBoundingBox, "initialize", mrb_raylib_BoundingBox_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibBoundingBox, "min", mrb_raylib_BoundingBox_min_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibBoundingBox, "min=", mrb_raylib_BoundingBox_min_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibBoundingBox, "max", mrb_raylib_BoundingBox_max_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibBoundingBox, "max=", mrb_raylib_BoundingBox_max_set, MRB_ARGS_REQ(1));

    cRaylibWave = mrb_define_class_under(mrb, mRaylib, "Wave", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibWave, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibWave, "initialize", mrb_raylib_Wave_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibWave, "frameCount", mrb_raylib_Wave_frameCount_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibWave, "frameCount=", mrb_raylib_Wave_frameCount_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibWave, "sampleRate", mrb_raylib_Wave_sampleRate_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibWave, "sampleRate=", mrb_raylib_Wave_sampleRate_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibWave, "sampleSize", mrb_raylib_Wave_sampleSize_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibWave, "sampleSize=", mrb_raylib_Wave_sampleSize_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibWave, "channels", mrb_raylib_Wave_channels_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibWave, "channels=", mrb_raylib_Wave_channels_set, MRB_ARGS_REQ(1));

    cRaylibAudioStream = mrb_define_class_under(mrb, mRaylib, "AudioStream", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibAudioStream, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibAudioStream, "initialize", mrb_raylib_AudioStream_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibAudioStream, "sampleRate", mrb_raylib_AudioStream_sampleRate_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibAudioStream, "sampleRate=", mrb_raylib_AudioStream_sampleRate_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibAudioStream, "sampleSize", mrb_raylib_AudioStream_sampleSize_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibAudioStream, "sampleSize=", mrb_raylib_AudioStream_sampleSize_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibAudioStream, "channels", mrb_raylib_AudioStream_channels_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibAudioStream, "channels=", mrb_raylib_AudioStream_channels_set, MRB_ARGS_REQ(1));

    cRaylibSound = mrb_define_class_under(mrb, mRaylib, "Sound", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibSound, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibSound, "initialize", mrb_raylib_Sound_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibSound, "stream", mrb_raylib_Sound_stream_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibSound, "stream=", mrb_raylib_Sound_stream_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibSound, "frameCount", mrb_raylib_Sound_frameCount_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibSound, "frameCount=", mrb_raylib_Sound_frameCount_set, MRB_ARGS_REQ(1));

    cRaylibMusic = mrb_define_class_under(mrb, mRaylib, "Music", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibMusic, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibMusic, "initialize", mrb_raylib_Music_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibMusic, "stream", mrb_raylib_Music_stream_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMusic, "stream=", mrb_raylib_Music_stream_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibMusic, "frameCount", mrb_raylib_Music_frameCount_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMusic, "frameCount=", mrb_raylib_Music_frameCount_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibMusic, "looping", mrb_raylib_Music_looping_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMusic, "looping=", mrb_raylib_Music_looping_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibMusic, "ctxType", mrb_raylib_Music_ctxType_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibMusic, "ctxType=", mrb_raylib_Music_ctxType_set, MRB_ARGS_REQ(1));

    cRaylibVrDeviceInfo = mrb_define_class_under(mrb, mRaylib, "VrDeviceInfo", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibVrDeviceInfo, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibVrDeviceInfo, "initialize", mrb_raylib_VrDeviceInfo_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibVrDeviceInfo, "hResolution", mrb_raylib_VrDeviceInfo_hResolution_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibVrDeviceInfo, "hResolution=", mrb_raylib_VrDeviceInfo_hResolution_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibVrDeviceInfo, "vResolution", mrb_raylib_VrDeviceInfo_vResolution_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibVrDeviceInfo, "vResolution=", mrb_raylib_VrDeviceInfo_vResolution_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibVrDeviceInfo, "hScreenSize", mrb_raylib_VrDeviceInfo_hScreenSize_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibVrDeviceInfo, "hScreenSize=", mrb_raylib_VrDeviceInfo_hScreenSize_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibVrDeviceInfo, "vScreenSize", mrb_raylib_VrDeviceInfo_vScreenSize_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibVrDeviceInfo, "vScreenSize=", mrb_raylib_VrDeviceInfo_vScreenSize_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibVrDeviceInfo, "vScreenCenter", mrb_raylib_VrDeviceInfo_vScreenCenter_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibVrDeviceInfo, "vScreenCenter=", mrb_raylib_VrDeviceInfo_vScreenCenter_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibVrDeviceInfo, "eyeToScreenDistance", mrb_raylib_VrDeviceInfo_eyeToScreenDistance_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibVrDeviceInfo, "eyeToScreenDistance=", mrb_raylib_VrDeviceInfo_eyeToScreenDistance_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibVrDeviceInfo, "lensSeparationDistance", mrb_raylib_VrDeviceInfo_lensSeparationDistance_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibVrDeviceInfo, "lensSeparationDistance=", mrb_raylib_VrDeviceInfo_lensSeparationDistance_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibVrDeviceInfo, "interpupillaryDistance", mrb_raylib_VrDeviceInfo_interpupillaryDistance_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibVrDeviceInfo, "interpupillaryDistance=", mrb_raylib_VrDeviceInfo_interpupillaryDistance_set, MRB_ARGS_REQ(1));

    cRaylibVrStereoConfig = mrb_define_class_under(mrb, mRaylib, "VrStereoConfig", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibVrStereoConfig, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibVrStereoConfig, "initialize", mrb_raylib_VrStereoConfig_initialize, MRB_ARGS_OPT(1));

    cRaylibFilePathList = mrb_define_class_under(mrb, mRaylib, "FilePathList", mrb->object_class);
    MRB_SET_INSTANCE_TT(cRaylibFilePathList, MRB_TT_DATA);
    mrb_define_method(mrb, cRaylibFilePathList, "initialize", mrb_raylib_FilePathList_initialize, MRB_ARGS_OPT(1));
    mrb_define_method(mrb, cRaylibFilePathList, "capacity", mrb_raylib_FilePathList_capacity_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibFilePathList, "capacity=", mrb_raylib_FilePathList_capacity_set, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, cRaylibFilePathList, "count", mrb_raylib_FilePathList_count_get, MRB_ARGS_NONE());
    mrb_define_method(mrb, cRaylibFilePathList, "count=", mrb_raylib_FilePathList_count_set, MRB_ARGS_REQ(1));


}
