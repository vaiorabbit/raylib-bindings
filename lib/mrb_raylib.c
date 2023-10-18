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
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_Vector2);
    return self;
};

static mrb_value mrb_raylib_Vector3_initialize(mrb_state* mrb, mrb_value self)
{
    Vector3* instance = (Vector3*)mrb_malloc(mrb, sizeof(Vector3));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_Vector3);
    return self;
};

static mrb_value mrb_raylib_Vector4_initialize(mrb_state* mrb, mrb_value self)
{
    Vector4* instance = (Vector4*)mrb_malloc(mrb, sizeof(Vector4));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_Vector4);
    return self;
};

static mrb_value mrb_raylib_Matrix_initialize(mrb_state* mrb, mrb_value self)
{
    Matrix* instance = (Matrix*)mrb_malloc(mrb, sizeof(Matrix));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_Matrix);
    return self;
};

static mrb_value mrb_raylib_Color_initialize(mrb_state* mrb, mrb_value self)
{
    Color* instance = (Color*)mrb_malloc(mrb, sizeof(Color));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_Color);
    return self;
};

static mrb_value mrb_raylib_Rectangle_initialize(mrb_state* mrb, mrb_value self)
{
    Rectangle* instance = (Rectangle*)mrb_malloc(mrb, sizeof(Rectangle));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_Rectangle);
    return self;
};

static mrb_value mrb_raylib_Image_initialize(mrb_state* mrb, mrb_value self)
{
    Image* instance = (Image*)mrb_malloc(mrb, sizeof(Image));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_Image);
    return self;
};

static mrb_value mrb_raylib_Texture_initialize(mrb_state* mrb, mrb_value self)
{
    Texture* instance = (Texture*)mrb_malloc(mrb, sizeof(Texture));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_Texture);
    return self;
};

static mrb_value mrb_raylib_RenderTexture_initialize(mrb_state* mrb, mrb_value self)
{
    RenderTexture* instance = (RenderTexture*)mrb_malloc(mrb, sizeof(RenderTexture));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_RenderTexture);
    return self;
};

static mrb_value mrb_raylib_NPatchInfo_initialize(mrb_state* mrb, mrb_value self)
{
    NPatchInfo* instance = (NPatchInfo*)mrb_malloc(mrb, sizeof(NPatchInfo));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_NPatchInfo);
    return self;
};

static mrb_value mrb_raylib_GlyphInfo_initialize(mrb_state* mrb, mrb_value self)
{
    GlyphInfo* instance = (GlyphInfo*)mrb_malloc(mrb, sizeof(GlyphInfo));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_GlyphInfo);
    return self;
};

static mrb_value mrb_raylib_Font_initialize(mrb_state* mrb, mrb_value self)
{
    Font* instance = (Font*)mrb_malloc(mrb, sizeof(Font));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_Font);
    return self;
};

static mrb_value mrb_raylib_Camera3D_initialize(mrb_state* mrb, mrb_value self)
{
    Camera3D* instance = (Camera3D*)mrb_malloc(mrb, sizeof(Camera3D));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_Camera3D);
    return self;
};

static mrb_value mrb_raylib_Camera2D_initialize(mrb_state* mrb, mrb_value self)
{
    Camera2D* instance = (Camera2D*)mrb_malloc(mrb, sizeof(Camera2D));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_Camera2D);
    return self;
};

static mrb_value mrb_raylib_Mesh_initialize(mrb_state* mrb, mrb_value self)
{
    Mesh* instance = (Mesh*)mrb_malloc(mrb, sizeof(Mesh));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_Mesh);
    return self;
};

static mrb_value mrb_raylib_Shader_initialize(mrb_state* mrb, mrb_value self)
{
    Shader* instance = (Shader*)mrb_malloc(mrb, sizeof(Shader));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_Shader);
    return self;
};

static mrb_value mrb_raylib_MaterialMap_initialize(mrb_state* mrb, mrb_value self)
{
    MaterialMap* instance = (MaterialMap*)mrb_malloc(mrb, sizeof(MaterialMap));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_MaterialMap);
    return self;
};

static mrb_value mrb_raylib_Material_initialize(mrb_state* mrb, mrb_value self)
{
    Material* instance = (Material*)mrb_malloc(mrb, sizeof(Material));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_Material);
    return self;
};

static mrb_value mrb_raylib_Transform_initialize(mrb_state* mrb, mrb_value self)
{
    Transform* instance = (Transform*)mrb_malloc(mrb, sizeof(Transform));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_Transform);
    return self;
};

static mrb_value mrb_raylib_BoneInfo_initialize(mrb_state* mrb, mrb_value self)
{
    BoneInfo* instance = (BoneInfo*)mrb_malloc(mrb, sizeof(BoneInfo));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_BoneInfo);
    return self;
};

static mrb_value mrb_raylib_Model_initialize(mrb_state* mrb, mrb_value self)
{
    Model* instance = (Model*)mrb_malloc(mrb, sizeof(Model));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_Model);
    return self;
};

static mrb_value mrb_raylib_ModelAnimation_initialize(mrb_state* mrb, mrb_value self)
{
    ModelAnimation* instance = (ModelAnimation*)mrb_malloc(mrb, sizeof(ModelAnimation));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_ModelAnimation);
    return self;
};

static mrb_value mrb_raylib_Ray_initialize(mrb_state* mrb, mrb_value self)
{
    Ray* instance = (Ray*)mrb_malloc(mrb, sizeof(Ray));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_Ray);
    return self;
};

static mrb_value mrb_raylib_RayCollision_initialize(mrb_state* mrb, mrb_value self)
{
    RayCollision* instance = (RayCollision*)mrb_malloc(mrb, sizeof(RayCollision));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_RayCollision);
    return self;
};

static mrb_value mrb_raylib_BoundingBox_initialize(mrb_state* mrb, mrb_value self)
{
    BoundingBox* instance = (BoundingBox*)mrb_malloc(mrb, sizeof(BoundingBox));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_BoundingBox);
    return self;
};

static mrb_value mrb_raylib_Wave_initialize(mrb_state* mrb, mrb_value self)
{
    Wave* instance = (Wave*)mrb_malloc(mrb, sizeof(Wave));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_Wave);
    return self;
};

static mrb_value mrb_raylib_AudioStream_initialize(mrb_state* mrb, mrb_value self)
{
    AudioStream* instance = (AudioStream*)mrb_malloc(mrb, sizeof(AudioStream));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_AudioStream);
    return self;
};

static mrb_value mrb_raylib_Sound_initialize(mrb_state* mrb, mrb_value self)
{
    Sound* instance = (Sound*)mrb_malloc(mrb, sizeof(Sound));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_Sound);
    return self;
};

static mrb_value mrb_raylib_Music_initialize(mrb_state* mrb, mrb_value self)
{
    Music* instance = (Music*)mrb_malloc(mrb, sizeof(Music));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_Music);
    return self;
};

static mrb_value mrb_raylib_VrDeviceInfo_initialize(mrb_state* mrb, mrb_value self)
{
    VrDeviceInfo* instance = (VrDeviceInfo*)mrb_malloc(mrb, sizeof(VrDeviceInfo));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_VrDeviceInfo);
    return self;
};

static mrb_value mrb_raylib_VrStereoConfig_initialize(mrb_state* mrb, mrb_value self)
{
    VrStereoConfig* instance = (VrStereoConfig*)mrb_malloc(mrb, sizeof(VrStereoConfig));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_VrStereoConfig);
    return self;
};

static mrb_value mrb_raylib_FilePathList_initialize(mrb_state* mrb, mrb_value self)
{
    FilePathList* instance = (FilePathList*)mrb_malloc(mrb, sizeof(FilePathList));
    // TODO per-member initialization
    mrb_data_init(self, instance, &mrb_raylib_struct_FilePathList);
    return self;
};


void mrb_raylib_module_module_init(mrb_state* mrb)
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


}
