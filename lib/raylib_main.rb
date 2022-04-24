# Yet another raylib wrapper for Ruby
#
# * https://github.com/vaiorabbit/raylib-bindings
#
# [NOTICE] This is an automatically generated file.

require 'ffi'

module Raylib
  extend FFI::Library
  # Define/Macro

  RAYLIB_VERSION = "4.1-dev"
  DEG2RAD = Math::PI / 180.0
  RAD2DEG = 180.0 / Math::PI

  # Enum

  FLAG_VSYNC_HINT = 64
  FLAG_FULLSCREEN_MODE = 2
  FLAG_WINDOW_RESIZABLE = 4
  FLAG_WINDOW_UNDECORATED = 8
  FLAG_WINDOW_HIDDEN = 128
  FLAG_WINDOW_MINIMIZED = 512
  FLAG_WINDOW_MAXIMIZED = 1024
  FLAG_WINDOW_UNFOCUSED = 2048
  FLAG_WINDOW_TOPMOST = 4096
  FLAG_WINDOW_ALWAYS_RUN = 256
  FLAG_WINDOW_TRANSPARENT = 16
  FLAG_WINDOW_HIGHDPI = 8192
  FLAG_MSAA_4X_HINT = 32
  FLAG_INTERLACED_HINT = 65536
  LOG_ALL = 0
  LOG_TRACE = 1
  LOG_DEBUG = 2
  LOG_INFO = 3
  LOG_WARNING = 4
  LOG_ERROR = 5
  LOG_FATAL = 6
  LOG_NONE = 7
  KEY_NULL = 0
  KEY_APOSTROPHE = 39
  KEY_COMMA = 44
  KEY_MINUS = 45
  KEY_PERIOD = 46
  KEY_SLASH = 47
  KEY_ZERO = 48
  KEY_ONE = 49
  KEY_TWO = 50
  KEY_THREE = 51
  KEY_FOUR = 52
  KEY_FIVE = 53
  KEY_SIX = 54
  KEY_SEVEN = 55
  KEY_EIGHT = 56
  KEY_NINE = 57
  KEY_SEMICOLON = 59
  KEY_EQUAL = 61
  KEY_A = 65
  KEY_B = 66
  KEY_C = 67
  KEY_D = 68
  KEY_E = 69
  KEY_F = 70
  KEY_G = 71
  KEY_H = 72
  KEY_I = 73
  KEY_J = 74
  KEY_K = 75
  KEY_L = 76
  KEY_M = 77
  KEY_N = 78
  KEY_O = 79
  KEY_P = 80
  KEY_Q = 81
  KEY_R = 82
  KEY_S = 83
  KEY_T = 84
  KEY_U = 85
  KEY_V = 86
  KEY_W = 87
  KEY_X = 88
  KEY_Y = 89
  KEY_Z = 90
  KEY_LEFT_BRACKET = 91
  KEY_BACKSLASH = 92
  KEY_RIGHT_BRACKET = 93
  KEY_GRAVE = 96
  KEY_SPACE = 32
  KEY_ESCAPE = 256
  KEY_ENTER = 257
  KEY_TAB = 258
  KEY_BACKSPACE = 259
  KEY_INSERT = 260
  KEY_DELETE = 261
  KEY_RIGHT = 262
  KEY_LEFT = 263
  KEY_DOWN = 264
  KEY_UP = 265
  KEY_PAGE_UP = 266
  KEY_PAGE_DOWN = 267
  KEY_HOME = 268
  KEY_END = 269
  KEY_CAPS_LOCK = 280
  KEY_SCROLL_LOCK = 281
  KEY_NUM_LOCK = 282
  KEY_PRINT_SCREEN = 283
  KEY_PAUSE = 284
  KEY_F1 = 290
  KEY_F2 = 291
  KEY_F3 = 292
  KEY_F4 = 293
  KEY_F5 = 294
  KEY_F6 = 295
  KEY_F7 = 296
  KEY_F8 = 297
  KEY_F9 = 298
  KEY_F10 = 299
  KEY_F11 = 300
  KEY_F12 = 301
  KEY_LEFT_SHIFT = 340
  KEY_LEFT_CONTROL = 341
  KEY_LEFT_ALT = 342
  KEY_LEFT_SUPER = 343
  KEY_RIGHT_SHIFT = 344
  KEY_RIGHT_CONTROL = 345
  KEY_RIGHT_ALT = 346
  KEY_RIGHT_SUPER = 347
  KEY_KB_MENU = 348
  KEY_KP_0 = 320
  KEY_KP_1 = 321
  KEY_KP_2 = 322
  KEY_KP_3 = 323
  KEY_KP_4 = 324
  KEY_KP_5 = 325
  KEY_KP_6 = 326
  KEY_KP_7 = 327
  KEY_KP_8 = 328
  KEY_KP_9 = 329
  KEY_KP_DECIMAL = 330
  KEY_KP_DIVIDE = 331
  KEY_KP_MULTIPLY = 332
  KEY_KP_SUBTRACT = 333
  KEY_KP_ADD = 334
  KEY_KP_ENTER = 335
  KEY_KP_EQUAL = 336
  KEY_BACK = 4
  KEY_MENU = 82
  KEY_VOLUME_UP = 24
  KEY_VOLUME_DOWN = 25
  MOUSE_BUTTON_LEFT = 0
  MOUSE_BUTTON_RIGHT = 1
  MOUSE_BUTTON_MIDDLE = 2
  MOUSE_BUTTON_SIDE = 3
  MOUSE_BUTTON_EXTRA = 4
  MOUSE_BUTTON_FORWARD = 5
  MOUSE_BUTTON_BACK = 6
  MOUSE_CURSOR_DEFAULT = 0
  MOUSE_CURSOR_ARROW = 1
  MOUSE_CURSOR_IBEAM = 2
  MOUSE_CURSOR_CROSSHAIR = 3
  MOUSE_CURSOR_POINTING_HAND = 4
  MOUSE_CURSOR_RESIZE_EW = 5
  MOUSE_CURSOR_RESIZE_NS = 6
  MOUSE_CURSOR_RESIZE_NWSE = 7
  MOUSE_CURSOR_RESIZE_NESW = 8
  MOUSE_CURSOR_RESIZE_ALL = 9
  MOUSE_CURSOR_NOT_ALLOWED = 10
  GAMEPAD_BUTTON_UNKNOWN = 0
  GAMEPAD_BUTTON_LEFT_FACE_UP = 1
  GAMEPAD_BUTTON_LEFT_FACE_RIGHT = 2
  GAMEPAD_BUTTON_LEFT_FACE_DOWN = 3
  GAMEPAD_BUTTON_LEFT_FACE_LEFT = 4
  GAMEPAD_BUTTON_RIGHT_FACE_UP = 5
  GAMEPAD_BUTTON_RIGHT_FACE_RIGHT = 6
  GAMEPAD_BUTTON_RIGHT_FACE_DOWN = 7
  GAMEPAD_BUTTON_RIGHT_FACE_LEFT = 8
  GAMEPAD_BUTTON_LEFT_TRIGGER_1 = 9
  GAMEPAD_BUTTON_LEFT_TRIGGER_2 = 10
  GAMEPAD_BUTTON_RIGHT_TRIGGER_1 = 11
  GAMEPAD_BUTTON_RIGHT_TRIGGER_2 = 12
  GAMEPAD_BUTTON_MIDDLE_LEFT = 13
  GAMEPAD_BUTTON_MIDDLE = 14
  GAMEPAD_BUTTON_MIDDLE_RIGHT = 15
  GAMEPAD_BUTTON_LEFT_THUMB = 16
  GAMEPAD_BUTTON_RIGHT_THUMB = 17
  GAMEPAD_AXIS_LEFT_X = 0
  GAMEPAD_AXIS_LEFT_Y = 1
  GAMEPAD_AXIS_RIGHT_X = 2
  GAMEPAD_AXIS_RIGHT_Y = 3
  GAMEPAD_AXIS_LEFT_TRIGGER = 4
  GAMEPAD_AXIS_RIGHT_TRIGGER = 5
  MATERIAL_MAP_ALBEDO = 0
  MATERIAL_MAP_METALNESS = 1
  MATERIAL_MAP_NORMAL = 2
  MATERIAL_MAP_ROUGHNESS = 3
  MATERIAL_MAP_OCCLUSION = 4
  MATERIAL_MAP_EMISSION = 5
  MATERIAL_MAP_HEIGHT = 6
  MATERIAL_MAP_CUBEMAP = 7
  MATERIAL_MAP_IRRADIANCE = 8
  MATERIAL_MAP_PREFILTER = 9
  MATERIAL_MAP_BRDF = 10
  SHADER_LOC_VERTEX_POSITION = 0
  SHADER_LOC_VERTEX_TEXCOORD01 = 1
  SHADER_LOC_VERTEX_TEXCOORD02 = 2
  SHADER_LOC_VERTEX_NORMAL = 3
  SHADER_LOC_VERTEX_TANGENT = 4
  SHADER_LOC_VERTEX_COLOR = 5
  SHADER_LOC_MATRIX_MVP = 6
  SHADER_LOC_MATRIX_VIEW = 7
  SHADER_LOC_MATRIX_PROJECTION = 8
  SHADER_LOC_MATRIX_MODEL = 9
  SHADER_LOC_MATRIX_NORMAL = 10
  SHADER_LOC_VECTOR_VIEW = 11
  SHADER_LOC_COLOR_DIFFUSE = 12
  SHADER_LOC_COLOR_SPECULAR = 13
  SHADER_LOC_COLOR_AMBIENT = 14
  SHADER_LOC_MAP_ALBEDO = 15
  SHADER_LOC_MAP_METALNESS = 16
  SHADER_LOC_MAP_NORMAL = 17
  SHADER_LOC_MAP_ROUGHNESS = 18
  SHADER_LOC_MAP_OCCLUSION = 19
  SHADER_LOC_MAP_EMISSION = 20
  SHADER_LOC_MAP_HEIGHT = 21
  SHADER_LOC_MAP_CUBEMAP = 22
  SHADER_LOC_MAP_IRRADIANCE = 23
  SHADER_LOC_MAP_PREFILTER = 24
  SHADER_LOC_MAP_BRDF = 25
  SHADER_UNIFORM_FLOAT = 0
  SHADER_UNIFORM_VEC2 = 1
  SHADER_UNIFORM_VEC3 = 2
  SHADER_UNIFORM_VEC4 = 3
  SHADER_UNIFORM_INT = 4
  SHADER_UNIFORM_IVEC2 = 5
  SHADER_UNIFORM_IVEC3 = 6
  SHADER_UNIFORM_IVEC4 = 7
  SHADER_UNIFORM_SAMPLER2D = 8
  SHADER_ATTRIB_FLOAT = 0
  SHADER_ATTRIB_VEC2 = 1
  SHADER_ATTRIB_VEC3 = 2
  SHADER_ATTRIB_VEC4 = 3
  PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1
  PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA = 2
  PIXELFORMAT_UNCOMPRESSED_R5G6B5 = 3
  PIXELFORMAT_UNCOMPRESSED_R8G8B8 = 4
  PIXELFORMAT_UNCOMPRESSED_R5G5B5A1 = 5
  PIXELFORMAT_UNCOMPRESSED_R4G4B4A4 = 6
  PIXELFORMAT_UNCOMPRESSED_R8G8B8A8 = 7
  PIXELFORMAT_UNCOMPRESSED_R32 = 8
  PIXELFORMAT_UNCOMPRESSED_R32G32B32 = 9
  PIXELFORMAT_UNCOMPRESSED_R32G32B32A32 = 10
  PIXELFORMAT_COMPRESSED_DXT1_RGB = 11
  PIXELFORMAT_COMPRESSED_DXT1_RGBA = 12
  PIXELFORMAT_COMPRESSED_DXT3_RGBA = 13
  PIXELFORMAT_COMPRESSED_DXT5_RGBA = 14
  PIXELFORMAT_COMPRESSED_ETC1_RGB = 15
  PIXELFORMAT_COMPRESSED_ETC2_RGB = 16
  PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA = 17
  PIXELFORMAT_COMPRESSED_PVRT_RGB = 18
  PIXELFORMAT_COMPRESSED_PVRT_RGBA = 19
  PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA = 20
  PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA = 21
  TEXTURE_FILTER_POINT = 0
  TEXTURE_FILTER_BILINEAR = 1
  TEXTURE_FILTER_TRILINEAR = 2
  TEXTURE_FILTER_ANISOTROPIC_4X = 3
  TEXTURE_FILTER_ANISOTROPIC_8X = 4
  TEXTURE_FILTER_ANISOTROPIC_16X = 5
  TEXTURE_WRAP_REPEAT = 0
  TEXTURE_WRAP_CLAMP = 1
  TEXTURE_WRAP_MIRROR_REPEAT = 2
  TEXTURE_WRAP_MIRROR_CLAMP = 3
  CUBEMAP_LAYOUT_AUTO_DETECT = 0
  CUBEMAP_LAYOUT_LINE_VERTICAL = 1
  CUBEMAP_LAYOUT_LINE_HORIZONTAL = 2
  CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR = 3
  CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE = 4
  CUBEMAP_LAYOUT_PANORAMA = 5
  FONT_DEFAULT = 0
  FONT_BITMAP = 1
  FONT_SDF = 2
  BLEND_ALPHA = 0
  BLEND_ADDITIVE = 1
  BLEND_MULTIPLIED = 2
  BLEND_ADD_COLORS = 3
  BLEND_SUBTRACT_COLORS = 4
  BLEND_ALPHA_PREMUL = 5
  BLEND_CUSTOM = 6
  GESTURE_NONE = 0
  GESTURE_TAP = 1
  GESTURE_DOUBLETAP = 2
  GESTURE_HOLD = 4
  GESTURE_DRAG = 8
  GESTURE_SWIPE_RIGHT = 16
  GESTURE_SWIPE_LEFT = 32
  GESTURE_SWIPE_UP = 64
  GESTURE_SWIPE_DOWN = 128
  GESTURE_PINCH_IN = 256
  GESTURE_PINCH_OUT = 512
  CAMERA_CUSTOM = 0
  CAMERA_FREE = 1
  CAMERA_ORBITAL = 2
  CAMERA_FIRST_PERSON = 3
  CAMERA_THIRD_PERSON = 4
  CAMERA_PERSPECTIVE = 0
  CAMERA_ORTHOGRAPHIC = 1
  NPATCH_NINE_PATCH = 0
  NPATCH_THREE_PATCH_VERTICAL = 1
  NPATCH_THREE_PATCH_HORIZONTAL = 2

  # Typedef

  typedef :int, :ConfigFlags
  typedef :int, :TraceLogLevel
  typedef :int, :KeyboardKey
  typedef :int, :MouseButton
  typedef :int, :MouseCursor
  typedef :int, :GamepadButton
  typedef :int, :GamepadAxis
  typedef :int, :MaterialMapIndex
  typedef :int, :ShaderLocationIndex
  typedef :int, :ShaderUniformDataType
  typedef :int, :ShaderAttributeDataType
  typedef :int, :PixelFormat
  typedef :int, :TextureFilter
  typedef :int, :TextureWrap
  typedef :int, :CubemapLayout
  typedef :int, :FontType
  typedef :int, :BlendMode
  typedef :int, :Gesture
  typedef :int, :CameraMode
  typedef :int, :CameraProjection
  typedef :int, :NPatchLayout
  callback :TraceLogCallback, [:int, :pointer, :int], :void
  callback :LoadFileDataCallback, [:pointer, :pointer], :pointer
  callback :SaveFileDataCallback, [:pointer, :pointer, :uint], :bool
  callback :LoadFileTextCallback, [:pointer], :pointer
  callback :SaveFileTextCallback, [:pointer, :pointer], :bool
  callback :AudioCallback, [:pointer, :uint], :void

  # Struct

  class Vector2 < FFI::Struct
    layout(
      :x, :float,
      :y, :float,
    )
  end

  class Vector3 < FFI::Struct
    layout(
      :x, :float,
      :y, :float,
      :z, :float,
    )
  end

  class Vector4 < FFI::Struct
    layout(
      :x, :float,
      :y, :float,
      :z, :float,
      :w, :float,
    )
  end

  Quaternion = Vector4

  class Matrix < FFI::Struct
    layout(
      :m0, :float,
      :m4, :float,
      :m8, :float,
      :m12, :float,
      :m1, :float,
      :m5, :float,
      :m9, :float,
      :m13, :float,
      :m2, :float,
      :m6, :float,
      :m10, :float,
      :m14, :float,
      :m3, :float,
      :m7, :float,
      :m11, :float,
      :m15, :float,
    )
  end

  class Color < FFI::Struct
    layout(
      :r, :uchar,
      :g, :uchar,
      :b, :uchar,
      :a, :uchar,
    )
  end

  class Rectangle < FFI::Struct
    layout(
      :x, :float,
      :y, :float,
      :width, :float,
      :height, :float,
    )
  end

  class Image < FFI::Struct
    layout(
      :data, :pointer,
      :width, :int,
      :height, :int,
      :mipmaps, :int,
      :format, :int,
    )
  end

  class Texture < FFI::Struct
    layout(
      :id, :uint,
      :width, :int,
      :height, :int,
      :mipmaps, :int,
      :format, :int,
    )
  end

  Texture2D = Texture
  TextureCubemap = Texture

  class RenderTexture < FFI::Struct
    layout(
      :id, :uint,
      :texture, Texture,
      :depth, Texture,
    )
  end

  RenderTexture2D = RenderTexture

  class NPatchInfo < FFI::Struct
    layout(
      :source, Rectangle,
      :left, :int,
      :top, :int,
      :right, :int,
      :bottom, :int,
      :layout, :int,
    )
  end

  class GlyphInfo < FFI::Struct
    layout(
      :value, :int,
      :offsetX, :int,
      :offsetY, :int,
      :advanceX, :int,
      :image, Image,
    )
  end

  class Font < FFI::Struct
    layout(
      :baseSize, :int,
      :glyphCount, :int,
      :glyphPadding, :int,
      :texture, Texture2D,
      :recs, :pointer,
      :glyphs, :pointer,
    )
  end

  class Camera3D < FFI::Struct
    layout(
      :position, Vector3,
      :target, Vector3,
      :up, Vector3,
      :fovy, :float,
      :projection, :int,
    )
  end

  Camera = Camera3D

  class Camera2D < FFI::Struct
    layout(
      :offset, Vector2,
      :target, Vector2,
      :rotation, :float,
      :zoom, :float,
    )
  end

  class Mesh < FFI::Struct
    layout(
      :vertexCount, :int,
      :triangleCount, :int,
      :vertices, :pointer,
      :texcoords, :pointer,
      :texcoords2, :pointer,
      :normals, :pointer,
      :tangents, :pointer,
      :colors, :pointer,
      :indices, :pointer,
      :animVertices, :pointer,
      :animNormals, :pointer,
      :boneIds, :pointer,
      :boneWeights, :pointer,
      :vaoId, :uint,
      :vboId, :pointer,
    )
  end

  class Shader < FFI::Struct
    layout(
      :id, :uint,
      :locs, :pointer,
    )
  end

  class MaterialMap < FFI::Struct
    layout(
      :texture, Texture2D,
      :color, Color,
      :value, :float,
    )
  end

  class Material < FFI::Struct
    layout(
      :shader, Shader,
      :maps, :pointer,
      :params, [:float, 4],
    )
  end

  class Transform < FFI::Struct
    layout(
      :translation, Vector3,
      :rotation, Quaternion,
      :scale, Vector3,
    )
  end

  class BoneInfo < FFI::Struct
    layout(
      :name, [:char, 32],
      :parent, :int,
    )
  end

  class Model < FFI::Struct
    layout(
      :transform, Matrix,
      :meshCount, :int,
      :materialCount, :int,
      :meshes, :pointer,
      :materials, :pointer,
      :meshMaterial, :pointer,
      :boneCount, :int,
      :bones, :pointer,
      :bindPose, :pointer,
    )
  end

  class ModelAnimation < FFI::Struct
    layout(
      :boneCount, :int,
      :frameCount, :int,
      :bones, :pointer,
      :framePoses, :pointer,
    )
  end

  class Ray < FFI::Struct
    layout(
      :position, Vector3,
      :direction, Vector3,
    )
  end

  class RayCollision < FFI::Struct
    layout(
      :hit, :bool,
      :distance, :float,
      :point, Vector3,
      :normal, Vector3,
    )
  end

  class BoundingBox < FFI::Struct
    layout(
      :min, Vector3,
      :max, Vector3,
    )
  end

  class Wave < FFI::Struct
    layout(
      :frameCount, :uint,
      :sampleRate, :uint,
      :sampleSize, :uint,
      :channels, :uint,
      :data, :pointer,
    )
  end

  class AudioStream < FFI::Struct
    layout(
      :buffer, :pointer,
      :processor, :pointer,
      :sampleRate, :uint,
      :sampleSize, :uint,
      :channels, :uint,
    )
  end

  class Sound < FFI::Struct
    layout(
      :stream, AudioStream,
      :frameCount, :uint,
    )
  end

  class Music < FFI::Struct
    layout(
      :stream, AudioStream,
      :frameCount, :uint,
      :looping, :bool,
      :ctxType, :int,
      :ctxData, :pointer,
    )
  end

  class VrDeviceInfo < FFI::Struct
    layout(
      :hResolution, :int,
      :vResolution, :int,
      :hScreenSize, :float,
      :vScreenSize, :float,
      :vScreenCenter, :float,
      :eyeToScreenDistance, :float,
      :lensSeparationDistance, :float,
      :interpupillaryDistance, :float,
      :lensDistortionValues, [:float, 4],
      :chromaAbCorrection, [:float, 4],
    )
  end

  class VrStereoConfig < FFI::Struct
    layout(
      :projection, [Matrix, 2],
      :viewOffset, [Matrix, 2],
      :leftLensCenter, [:float, 2],
      :rightLensCenter, [:float, 2],
      :leftScreenCenter, [:float, 2],
      :rightScreenCenter, [:float, 2],
      :scale, [:float, 2],
      :scaleIn, [:float, 2],
    )
  end


  # Function

  def self.setup_raylib_symbols()
    symbols = [
      :InitWindow,
      :WindowShouldClose,
      :CloseWindow,
      :IsWindowReady,
      :IsWindowFullscreen,
      :IsWindowHidden,
      :IsWindowMinimized,
      :IsWindowMaximized,
      :IsWindowFocused,
      :IsWindowResized,
      :IsWindowState,
      :SetWindowState,
      :ClearWindowState,
      :ToggleFullscreen,
      :MaximizeWindow,
      :MinimizeWindow,
      :RestoreWindow,
      :SetWindowIcon,
      :SetWindowTitle,
      :SetWindowPosition,
      :SetWindowMonitor,
      :SetWindowMinSize,
      :SetWindowSize,
      :SetWindowOpacity,
      :GetWindowHandle,
      :GetScreenWidth,
      :GetScreenHeight,
      :GetRenderWidth,
      :GetRenderHeight,
      :GetMonitorCount,
      :GetCurrentMonitor,
      :GetMonitorPosition,
      :GetMonitorWidth,
      :GetMonitorHeight,
      :GetMonitorPhysicalWidth,
      :GetMonitorPhysicalHeight,
      :GetMonitorRefreshRate,
      :GetWindowPosition,
      :GetWindowScaleDPI,
      :GetMonitorName,
      :SetClipboardText,
      :GetClipboardText,
      :SwapScreenBuffer,
      :PollInputEvents,
      :WaitTime,
      :ShowCursor,
      :HideCursor,
      :IsCursorHidden,
      :EnableCursor,
      :DisableCursor,
      :IsCursorOnScreen,
      :ClearBackground,
      :BeginDrawing,
      :EndDrawing,
      :BeginMode2D,
      :EndMode2D,
      :BeginMode3D,
      :EndMode3D,
      :BeginTextureMode,
      :EndTextureMode,
      :BeginShaderMode,
      :EndShaderMode,
      :BeginBlendMode,
      :EndBlendMode,
      :BeginScissorMode,
      :EndScissorMode,
      :BeginVrStereoMode,
      :EndVrStereoMode,
      :LoadVrStereoConfig,
      :UnloadVrStereoConfig,
      :LoadShader,
      :LoadShaderFromMemory,
      :GetShaderLocation,
      :GetShaderLocationAttrib,
      :SetShaderValue,
      :SetShaderValueV,
      :SetShaderValueMatrix,
      :SetShaderValueTexture,
      :UnloadShader,
      :GetMouseRay,
      :GetCameraMatrix,
      :GetCameraMatrix2D,
      :GetWorldToScreen,
      :GetWorldToScreenEx,
      :GetWorldToScreen2D,
      :GetScreenToWorld2D,
      :SetTargetFPS,
      :GetFPS,
      :GetFrameTime,
      :GetTime,
      :GetRandomValue,
      :SetRandomSeed,
      :TakeScreenshot,
      :SetConfigFlags,
      :TraceLog,
      :SetTraceLogLevel,
      :MemAlloc,
      :MemRealloc,
      :MemFree,
      :SetTraceLogCallback,
      :SetLoadFileDataCallback,
      :SetSaveFileDataCallback,
      :SetLoadFileTextCallback,
      :SetSaveFileTextCallback,
      :LoadFileData,
      :UnloadFileData,
      :SaveFileData,
      :LoadFileText,
      :UnloadFileText,
      :SaveFileText,
      :FileExists,
      :DirectoryExists,
      :IsFileExtension,
      :GetFileLength,
      :GetFileExtension,
      :GetFileName,
      :GetFileNameWithoutExt,
      :GetDirectoryPath,
      :GetPrevDirectoryPath,
      :GetWorkingDirectory,
      :GetApplicationDirectory,
      :GetDirectoryFiles,
      :ClearDirectoryFiles,
      :ChangeDirectory,
      :IsFileDropped,
      :GetDroppedFiles,
      :ClearDroppedFiles,
      :GetFileModTime,
      :CompressData,
      :DecompressData,
      :EncodeDataBase64,
      :DecodeDataBase64,
      :SaveStorageValue,
      :LoadStorageValue,
      :OpenURL,
      :IsKeyPressed,
      :IsKeyDown,
      :IsKeyReleased,
      :IsKeyUp,
      :SetExitKey,
      :GetKeyPressed,
      :GetCharPressed,
      :IsGamepadAvailable,
      :GetGamepadName,
      :IsGamepadButtonPressed,
      :IsGamepadButtonDown,
      :IsGamepadButtonReleased,
      :IsGamepadButtonUp,
      :GetGamepadButtonPressed,
      :GetGamepadAxisCount,
      :GetGamepadAxisMovement,
      :SetGamepadMappings,
      :IsMouseButtonPressed,
      :IsMouseButtonDown,
      :IsMouseButtonReleased,
      :IsMouseButtonUp,
      :GetMouseX,
      :GetMouseY,
      :GetMousePosition,
      :GetMouseDelta,
      :SetMousePosition,
      :SetMouseOffset,
      :SetMouseScale,
      :GetMouseWheelMove,
      :SetMouseCursor,
      :GetTouchX,
      :GetTouchY,
      :GetTouchPosition,
      :GetTouchPointId,
      :GetTouchPointCount,
      :SetGesturesEnabled,
      :IsGestureDetected,
      :GetGestureDetected,
      :GetGestureHoldDuration,
      :GetGestureDragVector,
      :GetGestureDragAngle,
      :GetGesturePinchVector,
      :GetGesturePinchAngle,
      :SetCameraMode,
      :UpdateCamera,
      :SetCameraPanControl,
      :SetCameraAltControl,
      :SetCameraSmoothZoomControl,
      :SetCameraMoveControls,
      :SetShapesTexture,
      :DrawPixel,
      :DrawPixelV,
      :DrawLine,
      :DrawLineV,
      :DrawLineEx,
      :DrawLineBezier,
      :DrawLineBezierQuad,
      :DrawLineBezierCubic,
      :DrawLineStrip,
      :DrawCircle,
      :DrawCircleSector,
      :DrawCircleSectorLines,
      :DrawCircleGradient,
      :DrawCircleV,
      :DrawCircleLines,
      :DrawEllipse,
      :DrawEllipseLines,
      :DrawRing,
      :DrawRingLines,
      :DrawRectangle,
      :DrawRectangleV,
      :DrawRectangleRec,
      :DrawRectanglePro,
      :DrawRectangleGradientV,
      :DrawRectangleGradientH,
      :DrawRectangleGradientEx,
      :DrawRectangleLines,
      :DrawRectangleLinesEx,
      :DrawRectangleRounded,
      :DrawRectangleRoundedLines,
      :DrawTriangle,
      :DrawTriangleLines,
      :DrawTriangleFan,
      :DrawTriangleStrip,
      :DrawPoly,
      :DrawPolyLines,
      :DrawPolyLinesEx,
      :CheckCollisionRecs,
      :CheckCollisionCircles,
      :CheckCollisionCircleRec,
      :CheckCollisionPointRec,
      :CheckCollisionPointCircle,
      :CheckCollisionPointTriangle,
      :CheckCollisionLines,
      :CheckCollisionPointLine,
      :GetCollisionRec,
      :LoadImage,
      :LoadImageRaw,
      :LoadImageAnim,
      :LoadImageFromMemory,
      :LoadImageFromTexture,
      :LoadImageFromScreen,
      :UnloadImage,
      :ExportImage,
      :ExportImageAsCode,
      :GenImageColor,
      :GenImageGradientV,
      :GenImageGradientH,
      :GenImageGradientRadial,
      :GenImageChecked,
      :GenImageWhiteNoise,
      :GenImageCellular,
      :ImageCopy,
      :ImageFromImage,
      :ImageText,
      :ImageTextEx,
      :ImageFormat,
      :ImageToPOT,
      :ImageCrop,
      :ImageAlphaCrop,
      :ImageAlphaClear,
      :ImageAlphaMask,
      :ImageAlphaPremultiply,
      :ImageResize,
      :ImageResizeNN,
      :ImageResizeCanvas,
      :ImageMipmaps,
      :ImageDither,
      :ImageFlipVertical,
      :ImageFlipHorizontal,
      :ImageRotateCW,
      :ImageRotateCCW,
      :ImageColorTint,
      :ImageColorInvert,
      :ImageColorGrayscale,
      :ImageColorContrast,
      :ImageColorBrightness,
      :ImageColorReplace,
      :LoadImageColors,
      :LoadImagePalette,
      :UnloadImageColors,
      :UnloadImagePalette,
      :GetImageAlphaBorder,
      :GetImageColor,
      :ImageClearBackground,
      :ImageDrawPixel,
      :ImageDrawPixelV,
      :ImageDrawLine,
      :ImageDrawLineV,
      :ImageDrawCircle,
      :ImageDrawCircleV,
      :ImageDrawRectangle,
      :ImageDrawRectangleV,
      :ImageDrawRectangleRec,
      :ImageDrawRectangleLines,
      :ImageDraw,
      :ImageDrawText,
      :ImageDrawTextEx,
      :LoadTexture,
      :LoadTextureFromImage,
      :LoadTextureCubemap,
      :LoadRenderTexture,
      :UnloadTexture,
      :UnloadRenderTexture,
      :UpdateTexture,
      :UpdateTextureRec,
      :GenTextureMipmaps,
      :SetTextureFilter,
      :SetTextureWrap,
      :DrawTexture,
      :DrawTextureV,
      :DrawTextureEx,
      :DrawTextureRec,
      :DrawTextureQuad,
      :DrawTextureTiled,
      :DrawTexturePro,
      :DrawTextureNPatch,
      :DrawTexturePoly,
      :Fade,
      :ColorToInt,
      :ColorNormalize,
      :ColorFromNormalized,
      :ColorToHSV,
      :ColorFromHSV,
      :ColorAlpha,
      :ColorAlphaBlend,
      :GetColor,
      :GetPixelColor,
      :SetPixelColor,
      :GetPixelDataSize,
      :GetFontDefault,
      :LoadFont,
      :LoadFontEx,
      :LoadFontFromImage,
      :LoadFontFromMemory,
      :LoadFontData,
      :GenImageFontAtlas,
      :UnloadFontData,
      :UnloadFont,
      :ExportFontAsCode,
      :DrawFPS,
      :DrawText,
      :DrawTextEx,
      :DrawTextPro,
      :DrawTextCodepoint,
      :DrawTextCodepoints,
      :MeasureText,
      :MeasureTextEx,
      :GetGlyphIndex,
      :GetGlyphInfo,
      :GetGlyphAtlasRec,
      :LoadCodepoints,
      :UnloadCodepoints,
      :GetCodepointCount,
      :GetCodepoint,
      :CodepointToUTF8,
      :TextCodepointsToUTF8,
      :TextCopy,
      :TextIsEqual,
      :TextLength,
      :TextFormat,
      :TextSubtext,
      :TextReplace,
      :TextInsert,
      :TextJoin,
      :TextSplit,
      :TextAppend,
      :TextFindIndex,
      :TextToUpper,
      :TextToLower,
      :TextToPascal,
      :TextToInteger,
      :DrawLine3D,
      :DrawPoint3D,
      :DrawCircle3D,
      :DrawTriangle3D,
      :DrawTriangleStrip3D,
      :DrawCube,
      :DrawCubeV,
      :DrawCubeWires,
      :DrawCubeWiresV,
      :DrawCubeTexture,
      :DrawCubeTextureRec,
      :DrawSphere,
      :DrawSphereEx,
      :DrawSphereWires,
      :DrawCylinder,
      :DrawCylinderEx,
      :DrawCylinderWires,
      :DrawCylinderWiresEx,
      :DrawPlane,
      :DrawRay,
      :DrawGrid,
      :LoadModel,
      :LoadModelFromMesh,
      :UnloadModel,
      :UnloadModelKeepMeshes,
      :GetModelBoundingBox,
      :DrawModel,
      :DrawModelEx,
      :DrawModelWires,
      :DrawModelWiresEx,
      :DrawBoundingBox,
      :DrawBillboard,
      :DrawBillboardRec,
      :DrawBillboardPro,
      :UploadMesh,
      :UpdateMeshBuffer,
      :UnloadMesh,
      :DrawMesh,
      :DrawMeshInstanced,
      :ExportMesh,
      :GetMeshBoundingBox,
      :GenMeshTangents,
      :GenMeshBinormals,
      :GenMeshPoly,
      :GenMeshPlane,
      :GenMeshCube,
      :GenMeshSphere,
      :GenMeshHemiSphere,
      :GenMeshCylinder,
      :GenMeshCone,
      :GenMeshTorus,
      :GenMeshKnot,
      :GenMeshHeightmap,
      :GenMeshCubicmap,
      :LoadMaterials,
      :LoadMaterialDefault,
      :UnloadMaterial,
      :SetMaterialTexture,
      :SetModelMeshMaterial,
      :LoadModelAnimations,
      :UpdateModelAnimation,
      :UnloadModelAnimation,
      :UnloadModelAnimations,
      :IsModelAnimationValid,
      :CheckCollisionSpheres,
      :CheckCollisionBoxes,
      :CheckCollisionBoxSphere,
      :GetRayCollisionSphere,
      :GetRayCollisionBox,
      :GetRayCollisionMesh,
      :GetRayCollisionTriangle,
      :GetRayCollisionQuad,
      :InitAudioDevice,
      :CloseAudioDevice,
      :IsAudioDeviceReady,
      :SetMasterVolume,
      :LoadWave,
      :LoadWaveFromMemory,
      :LoadSound,
      :LoadSoundFromWave,
      :UpdateSound,
      :UnloadWave,
      :UnloadSound,
      :ExportWave,
      :ExportWaveAsCode,
      :PlaySound,
      :StopSound,
      :PauseSound,
      :ResumeSound,
      :PlaySoundMulti,
      :StopSoundMulti,
      :GetSoundsPlaying,
      :IsSoundPlaying,
      :SetSoundVolume,
      :SetSoundPitch,
      :SetSoundPan,
      :WaveCopy,
      :WaveCrop,
      :WaveFormat,
      :LoadWaveSamples,
      :UnloadWaveSamples,
      :LoadMusicStream,
      :LoadMusicStreamFromMemory,
      :UnloadMusicStream,
      :PlayMusicStream,
      :IsMusicStreamPlaying,
      :UpdateMusicStream,
      :StopMusicStream,
      :PauseMusicStream,
      :ResumeMusicStream,
      :SeekMusicStream,
      :SetMusicVolume,
      :SetMusicPitch,
      :SetMusicPan,
      :GetMusicTimeLength,
      :GetMusicTimePlayed,
      :LoadAudioStream,
      :UnloadAudioStream,
      :UpdateAudioStream,
      :IsAudioStreamProcessed,
      :PlayAudioStream,
      :PauseAudioStream,
      :ResumeAudioStream,
      :IsAudioStreamPlaying,
      :StopAudioStream,
      :SetAudioStreamVolume,
      :SetAudioStreamPitch,
      :SetAudioStreamPan,
      :SetAudioStreamBufferSizeDefault,
      :SetAudioStreamCallback,
      :AttachAudioStreamProcessor,
      :DetachAudioStreamProcessor,
    ]
    args = {
      :InitWindow => [:int, :int, :pointer],
      :WindowShouldClose => [],
      :CloseWindow => [],
      :IsWindowReady => [],
      :IsWindowFullscreen => [],
      :IsWindowHidden => [],
      :IsWindowMinimized => [],
      :IsWindowMaximized => [],
      :IsWindowFocused => [],
      :IsWindowResized => [],
      :IsWindowState => [:uint],
      :SetWindowState => [:uint],
      :ClearWindowState => [:uint],
      :ToggleFullscreen => [],
      :MaximizeWindow => [],
      :MinimizeWindow => [],
      :RestoreWindow => [],
      :SetWindowIcon => [Image.by_value],
      :SetWindowTitle => [:pointer],
      :SetWindowPosition => [:int, :int],
      :SetWindowMonitor => [:int],
      :SetWindowMinSize => [:int, :int],
      :SetWindowSize => [:int, :int],
      :SetWindowOpacity => [:float],
      :GetWindowHandle => [],
      :GetScreenWidth => [],
      :GetScreenHeight => [],
      :GetRenderWidth => [],
      :GetRenderHeight => [],
      :GetMonitorCount => [],
      :GetCurrentMonitor => [],
      :GetMonitorPosition => [:int],
      :GetMonitorWidth => [:int],
      :GetMonitorHeight => [:int],
      :GetMonitorPhysicalWidth => [:int],
      :GetMonitorPhysicalHeight => [:int],
      :GetMonitorRefreshRate => [:int],
      :GetWindowPosition => [],
      :GetWindowScaleDPI => [],
      :GetMonitorName => [:int],
      :SetClipboardText => [:pointer],
      :GetClipboardText => [],
      :SwapScreenBuffer => [],
      :PollInputEvents => [],
      :WaitTime => [:float],
      :ShowCursor => [],
      :HideCursor => [],
      :IsCursorHidden => [],
      :EnableCursor => [],
      :DisableCursor => [],
      :IsCursorOnScreen => [],
      :ClearBackground => [Color.by_value],
      :BeginDrawing => [],
      :EndDrawing => [],
      :BeginMode2D => [Camera2D.by_value],
      :EndMode2D => [],
      :BeginMode3D => [Camera3D.by_value],
      :EndMode3D => [],
      :BeginTextureMode => [RenderTexture2D.by_value],
      :EndTextureMode => [],
      :BeginShaderMode => [Shader.by_value],
      :EndShaderMode => [],
      :BeginBlendMode => [:int],
      :EndBlendMode => [],
      :BeginScissorMode => [:int, :int, :int, :int],
      :EndScissorMode => [],
      :BeginVrStereoMode => [VrStereoConfig.by_value],
      :EndVrStereoMode => [],
      :LoadVrStereoConfig => [VrDeviceInfo.by_value],
      :UnloadVrStereoConfig => [VrStereoConfig.by_value],
      :LoadShader => [:pointer, :pointer],
      :LoadShaderFromMemory => [:pointer, :pointer],
      :GetShaderLocation => [Shader.by_value, :pointer],
      :GetShaderLocationAttrib => [Shader.by_value, :pointer],
      :SetShaderValue => [Shader.by_value, :int, :pointer, :int],
      :SetShaderValueV => [Shader.by_value, :int, :pointer, :int, :int],
      :SetShaderValueMatrix => [Shader.by_value, :int, Matrix.by_value],
      :SetShaderValueTexture => [Shader.by_value, :int, Texture2D.by_value],
      :UnloadShader => [Shader.by_value],
      :GetMouseRay => [Vector2.by_value, Camera.by_value],
      :GetCameraMatrix => [Camera.by_value],
      :GetCameraMatrix2D => [Camera2D.by_value],
      :GetWorldToScreen => [Vector3.by_value, Camera.by_value],
      :GetWorldToScreenEx => [Vector3.by_value, Camera.by_value, :int, :int],
      :GetWorldToScreen2D => [Vector2.by_value, Camera2D.by_value],
      :GetScreenToWorld2D => [Vector2.by_value, Camera2D.by_value],
      :SetTargetFPS => [:int],
      :GetFPS => [],
      :GetFrameTime => [],
      :GetTime => [],
      :GetRandomValue => [:int, :int],
      :SetRandomSeed => [:uint],
      :TakeScreenshot => [:pointer],
      :SetConfigFlags => [:uint],
      :TraceLog => [:int, :pointer, :varargs],
      :SetTraceLogLevel => [:int],
      :MemAlloc => [:int],
      :MemRealloc => [:pointer, :int],
      :MemFree => [:pointer],
      :SetTraceLogCallback => [:TraceLogCallback],
      :SetLoadFileDataCallback => [:LoadFileDataCallback],
      :SetSaveFileDataCallback => [:SaveFileDataCallback],
      :SetLoadFileTextCallback => [:LoadFileTextCallback],
      :SetSaveFileTextCallback => [:SaveFileTextCallback],
      :LoadFileData => [:pointer, :pointer],
      :UnloadFileData => [:pointer],
      :SaveFileData => [:pointer, :pointer, :uint],
      :LoadFileText => [:pointer],
      :UnloadFileText => [:pointer],
      :SaveFileText => [:pointer, :pointer],
      :FileExists => [:pointer],
      :DirectoryExists => [:pointer],
      :IsFileExtension => [:pointer, :pointer],
      :GetFileLength => [:pointer],
      :GetFileExtension => [:pointer],
      :GetFileName => [:pointer],
      :GetFileNameWithoutExt => [:pointer],
      :GetDirectoryPath => [:pointer],
      :GetPrevDirectoryPath => [:pointer],
      :GetWorkingDirectory => [],
      :GetApplicationDirectory => [],
      :GetDirectoryFiles => [:pointer, :pointer],
      :ClearDirectoryFiles => [],
      :ChangeDirectory => [:pointer],
      :IsFileDropped => [],
      :GetDroppedFiles => [:pointer],
      :ClearDroppedFiles => [],
      :GetFileModTime => [:pointer],
      :CompressData => [:pointer, :int, :pointer],
      :DecompressData => [:pointer, :int, :pointer],
      :EncodeDataBase64 => [:pointer, :int, :pointer],
      :DecodeDataBase64 => [:pointer, :pointer],
      :SaveStorageValue => [:uint, :int],
      :LoadStorageValue => [:uint],
      :OpenURL => [:pointer],
      :IsKeyPressed => [:int],
      :IsKeyDown => [:int],
      :IsKeyReleased => [:int],
      :IsKeyUp => [:int],
      :SetExitKey => [:int],
      :GetKeyPressed => [],
      :GetCharPressed => [],
      :IsGamepadAvailable => [:int],
      :GetGamepadName => [:int],
      :IsGamepadButtonPressed => [:int, :int],
      :IsGamepadButtonDown => [:int, :int],
      :IsGamepadButtonReleased => [:int, :int],
      :IsGamepadButtonUp => [:int, :int],
      :GetGamepadButtonPressed => [],
      :GetGamepadAxisCount => [:int],
      :GetGamepadAxisMovement => [:int, :int],
      :SetGamepadMappings => [:pointer],
      :IsMouseButtonPressed => [:int],
      :IsMouseButtonDown => [:int],
      :IsMouseButtonReleased => [:int],
      :IsMouseButtonUp => [:int],
      :GetMouseX => [],
      :GetMouseY => [],
      :GetMousePosition => [],
      :GetMouseDelta => [],
      :SetMousePosition => [:int, :int],
      :SetMouseOffset => [:int, :int],
      :SetMouseScale => [:float, :float],
      :GetMouseWheelMove => [],
      :SetMouseCursor => [:int],
      :GetTouchX => [],
      :GetTouchY => [],
      :GetTouchPosition => [:int],
      :GetTouchPointId => [:int],
      :GetTouchPointCount => [],
      :SetGesturesEnabled => [:uint],
      :IsGestureDetected => [:int],
      :GetGestureDetected => [],
      :GetGestureHoldDuration => [],
      :GetGestureDragVector => [],
      :GetGestureDragAngle => [],
      :GetGesturePinchVector => [],
      :GetGesturePinchAngle => [],
      :SetCameraMode => [Camera.by_value, :int],
      :UpdateCamera => [:pointer],
      :SetCameraPanControl => [:int],
      :SetCameraAltControl => [:int],
      :SetCameraSmoothZoomControl => [:int],
      :SetCameraMoveControls => [:int, :int, :int, :int, :int, :int],
      :SetShapesTexture => [Texture2D.by_value, Rectangle.by_value],
      :DrawPixel => [:int, :int, Color.by_value],
      :DrawPixelV => [Vector2.by_value, Color.by_value],
      :DrawLine => [:int, :int, :int, :int, Color.by_value],
      :DrawLineV => [Vector2.by_value, Vector2.by_value, Color.by_value],
      :DrawLineEx => [Vector2.by_value, Vector2.by_value, :float, Color.by_value],
      :DrawLineBezier => [Vector2.by_value, Vector2.by_value, :float, Color.by_value],
      :DrawLineBezierQuad => [Vector2.by_value, Vector2.by_value, Vector2.by_value, :float, Color.by_value],
      :DrawLineBezierCubic => [Vector2.by_value, Vector2.by_value, Vector2.by_value, Vector2.by_value, :float, Color.by_value],
      :DrawLineStrip => [:pointer, :int, Color.by_value],
      :DrawCircle => [:int, :int, :float, Color.by_value],
      :DrawCircleSector => [Vector2.by_value, :float, :float, :float, :int, Color.by_value],
      :DrawCircleSectorLines => [Vector2.by_value, :float, :float, :float, :int, Color.by_value],
      :DrawCircleGradient => [:int, :int, :float, Color.by_value, Color.by_value],
      :DrawCircleV => [Vector2.by_value, :float, Color.by_value],
      :DrawCircleLines => [:int, :int, :float, Color.by_value],
      :DrawEllipse => [:int, :int, :float, :float, Color.by_value],
      :DrawEllipseLines => [:int, :int, :float, :float, Color.by_value],
      :DrawRing => [Vector2.by_value, :float, :float, :float, :float, :int, Color.by_value],
      :DrawRingLines => [Vector2.by_value, :float, :float, :float, :float, :int, Color.by_value],
      :DrawRectangle => [:int, :int, :int, :int, Color.by_value],
      :DrawRectangleV => [Vector2.by_value, Vector2.by_value, Color.by_value],
      :DrawRectangleRec => [Rectangle.by_value, Color.by_value],
      :DrawRectanglePro => [Rectangle.by_value, Vector2.by_value, :float, Color.by_value],
      :DrawRectangleGradientV => [:int, :int, :int, :int, Color.by_value, Color.by_value],
      :DrawRectangleGradientH => [:int, :int, :int, :int, Color.by_value, Color.by_value],
      :DrawRectangleGradientEx => [Rectangle.by_value, Color.by_value, Color.by_value, Color.by_value, Color.by_value],
      :DrawRectangleLines => [:int, :int, :int, :int, Color.by_value],
      :DrawRectangleLinesEx => [Rectangle.by_value, :float, Color.by_value],
      :DrawRectangleRounded => [Rectangle.by_value, :float, :int, Color.by_value],
      :DrawRectangleRoundedLines => [Rectangle.by_value, :float, :int, :float, Color.by_value],
      :DrawTriangle => [Vector2.by_value, Vector2.by_value, Vector2.by_value, Color.by_value],
      :DrawTriangleLines => [Vector2.by_value, Vector2.by_value, Vector2.by_value, Color.by_value],
      :DrawTriangleFan => [:pointer, :int, Color.by_value],
      :DrawTriangleStrip => [:pointer, :int, Color.by_value],
      :DrawPoly => [Vector2.by_value, :int, :float, :float, Color.by_value],
      :DrawPolyLines => [Vector2.by_value, :int, :float, :float, Color.by_value],
      :DrawPolyLinesEx => [Vector2.by_value, :int, :float, :float, :float, Color.by_value],
      :CheckCollisionRecs => [Rectangle.by_value, Rectangle.by_value],
      :CheckCollisionCircles => [Vector2.by_value, :float, Vector2.by_value, :float],
      :CheckCollisionCircleRec => [Vector2.by_value, :float, Rectangle.by_value],
      :CheckCollisionPointRec => [Vector2.by_value, Rectangle.by_value],
      :CheckCollisionPointCircle => [Vector2.by_value, Vector2.by_value, :float],
      :CheckCollisionPointTriangle => [Vector2.by_value, Vector2.by_value, Vector2.by_value, Vector2.by_value],
      :CheckCollisionLines => [Vector2.by_value, Vector2.by_value, Vector2.by_value, Vector2.by_value, :pointer],
      :CheckCollisionPointLine => [Vector2.by_value, Vector2.by_value, Vector2.by_value, :int],
      :GetCollisionRec => [Rectangle.by_value, Rectangle.by_value],
      :LoadImage => [:pointer],
      :LoadImageRaw => [:pointer, :int, :int, :int, :int],
      :LoadImageAnim => [:pointer, :pointer],
      :LoadImageFromMemory => [:pointer, :pointer, :int],
      :LoadImageFromTexture => [Texture2D.by_value],
      :LoadImageFromScreen => [],
      :UnloadImage => [Image.by_value],
      :ExportImage => [Image.by_value, :pointer],
      :ExportImageAsCode => [Image.by_value, :pointer],
      :GenImageColor => [:int, :int, Color.by_value],
      :GenImageGradientV => [:int, :int, Color.by_value, Color.by_value],
      :GenImageGradientH => [:int, :int, Color.by_value, Color.by_value],
      :GenImageGradientRadial => [:int, :int, :float, Color.by_value, Color.by_value],
      :GenImageChecked => [:int, :int, :int, :int, Color.by_value, Color.by_value],
      :GenImageWhiteNoise => [:int, :int, :float],
      :GenImageCellular => [:int, :int, :int],
      :ImageCopy => [Image.by_value],
      :ImageFromImage => [Image.by_value, Rectangle.by_value],
      :ImageText => [:pointer, :int, Color.by_value],
      :ImageTextEx => [Font.by_value, :pointer, :float, :float, Color.by_value],
      :ImageFormat => [:pointer, :int],
      :ImageToPOT => [:pointer, Color.by_value],
      :ImageCrop => [:pointer, Rectangle.by_value],
      :ImageAlphaCrop => [:pointer, :float],
      :ImageAlphaClear => [:pointer, Color.by_value, :float],
      :ImageAlphaMask => [:pointer, Image.by_value],
      :ImageAlphaPremultiply => [:pointer],
      :ImageResize => [:pointer, :int, :int],
      :ImageResizeNN => [:pointer, :int, :int],
      :ImageResizeCanvas => [:pointer, :int, :int, :int, :int, Color.by_value],
      :ImageMipmaps => [:pointer],
      :ImageDither => [:pointer, :int, :int, :int, :int],
      :ImageFlipVertical => [:pointer],
      :ImageFlipHorizontal => [:pointer],
      :ImageRotateCW => [:pointer],
      :ImageRotateCCW => [:pointer],
      :ImageColorTint => [:pointer, Color.by_value],
      :ImageColorInvert => [:pointer],
      :ImageColorGrayscale => [:pointer],
      :ImageColorContrast => [:pointer, :float],
      :ImageColorBrightness => [:pointer, :int],
      :ImageColorReplace => [:pointer, Color.by_value, Color.by_value],
      :LoadImageColors => [Image.by_value],
      :LoadImagePalette => [Image.by_value, :int, :pointer],
      :UnloadImageColors => [:pointer],
      :UnloadImagePalette => [:pointer],
      :GetImageAlphaBorder => [Image.by_value, :float],
      :GetImageColor => [Image.by_value, :int, :int],
      :ImageClearBackground => [:pointer, Color.by_value],
      :ImageDrawPixel => [:pointer, :int, :int, Color.by_value],
      :ImageDrawPixelV => [:pointer, Vector2.by_value, Color.by_value],
      :ImageDrawLine => [:pointer, :int, :int, :int, :int, Color.by_value],
      :ImageDrawLineV => [:pointer, Vector2.by_value, Vector2.by_value, Color.by_value],
      :ImageDrawCircle => [:pointer, :int, :int, :int, Color.by_value],
      :ImageDrawCircleV => [:pointer, Vector2.by_value, :int, Color.by_value],
      :ImageDrawRectangle => [:pointer, :int, :int, :int, :int, Color.by_value],
      :ImageDrawRectangleV => [:pointer, Vector2.by_value, Vector2.by_value, Color.by_value],
      :ImageDrawRectangleRec => [:pointer, Rectangle.by_value, Color.by_value],
      :ImageDrawRectangleLines => [:pointer, Rectangle.by_value, :int, Color.by_value],
      :ImageDraw => [:pointer, Image.by_value, Rectangle.by_value, Rectangle.by_value, Color.by_value],
      :ImageDrawText => [:pointer, :pointer, :int, :int, :int, Color.by_value],
      :ImageDrawTextEx => [:pointer, Font.by_value, :pointer, Vector2.by_value, :float, :float, Color.by_value],
      :LoadTexture => [:pointer],
      :LoadTextureFromImage => [Image.by_value],
      :LoadTextureCubemap => [Image.by_value, :int],
      :LoadRenderTexture => [:int, :int],
      :UnloadTexture => [Texture2D.by_value],
      :UnloadRenderTexture => [RenderTexture2D.by_value],
      :UpdateTexture => [Texture2D.by_value, :pointer],
      :UpdateTextureRec => [Texture2D.by_value, Rectangle.by_value, :pointer],
      :GenTextureMipmaps => [:pointer],
      :SetTextureFilter => [Texture2D.by_value, :int],
      :SetTextureWrap => [Texture2D.by_value, :int],
      :DrawTexture => [Texture2D.by_value, :int, :int, Color.by_value],
      :DrawTextureV => [Texture2D.by_value, Vector2.by_value, Color.by_value],
      :DrawTextureEx => [Texture2D.by_value, Vector2.by_value, :float, :float, Color.by_value],
      :DrawTextureRec => [Texture2D.by_value, Rectangle.by_value, Vector2.by_value, Color.by_value],
      :DrawTextureQuad => [Texture2D.by_value, Vector2.by_value, Vector2.by_value, Rectangle.by_value, Color.by_value],
      :DrawTextureTiled => [Texture2D.by_value, Rectangle.by_value, Rectangle.by_value, Vector2.by_value, :float, :float, Color.by_value],
      :DrawTexturePro => [Texture2D.by_value, Rectangle.by_value, Rectangle.by_value, Vector2.by_value, :float, Color.by_value],
      :DrawTextureNPatch => [Texture2D.by_value, NPatchInfo.by_value, Rectangle.by_value, Vector2.by_value, :float, Color.by_value],
      :DrawTexturePoly => [Texture2D.by_value, Vector2.by_value, :pointer, :pointer, :int, Color.by_value],
      :Fade => [Color.by_value, :float],
      :ColorToInt => [Color.by_value],
      :ColorNormalize => [Color.by_value],
      :ColorFromNormalized => [Vector4.by_value],
      :ColorToHSV => [Color.by_value],
      :ColorFromHSV => [:float, :float, :float],
      :ColorAlpha => [Color.by_value, :float],
      :ColorAlphaBlend => [Color.by_value, Color.by_value, Color.by_value],
      :GetColor => [:uint],
      :GetPixelColor => [:pointer, :int],
      :SetPixelColor => [:pointer, Color.by_value, :int],
      :GetPixelDataSize => [:int, :int, :int],
      :GetFontDefault => [],
      :LoadFont => [:pointer],
      :LoadFontEx => [:pointer, :int, :pointer, :int],
      :LoadFontFromImage => [Image.by_value, Color.by_value, :int],
      :LoadFontFromMemory => [:pointer, :pointer, :int, :int, :pointer, :int],
      :LoadFontData => [:pointer, :int, :int, :pointer, :int, :int],
      :GenImageFontAtlas => [:pointer, :pointer, :int, :int, :int, :int],
      :UnloadFontData => [:pointer, :int],
      :UnloadFont => [Font.by_value],
      :ExportFontAsCode => [Font.by_value, :pointer],
      :DrawFPS => [:int, :int],
      :DrawText => [:pointer, :int, :int, :int, Color.by_value],
      :DrawTextEx => [Font.by_value, :pointer, Vector2.by_value, :float, :float, Color.by_value],
      :DrawTextPro => [Font.by_value, :pointer, Vector2.by_value, Vector2.by_value, :float, :float, :float, Color.by_value],
      :DrawTextCodepoint => [Font.by_value, :int, Vector2.by_value, :float, Color.by_value],
      :DrawTextCodepoints => [Font.by_value, :pointer, :int, Vector2.by_value, :float, :float, Color.by_value],
      :MeasureText => [:pointer, :int],
      :MeasureTextEx => [Font.by_value, :pointer, :float, :float],
      :GetGlyphIndex => [Font.by_value, :int],
      :GetGlyphInfo => [Font.by_value, :int],
      :GetGlyphAtlasRec => [Font.by_value, :int],
      :LoadCodepoints => [:pointer, :pointer],
      :UnloadCodepoints => [:pointer],
      :GetCodepointCount => [:pointer],
      :GetCodepoint => [:pointer, :pointer],
      :CodepointToUTF8 => [:int, :pointer],
      :TextCodepointsToUTF8 => [:pointer, :int],
      :TextCopy => [:pointer, :pointer],
      :TextIsEqual => [:pointer, :pointer],
      :TextLength => [:pointer],
      :TextFormat => [:pointer, :varargs],
      :TextSubtext => [:pointer, :int, :int],
      :TextReplace => [:pointer, :pointer, :pointer],
      :TextInsert => [:pointer, :pointer, :int],
      :TextJoin => [:pointer, :int, :pointer],
      :TextSplit => [:pointer, :char, :pointer],
      :TextAppend => [:pointer, :pointer, :pointer],
      :TextFindIndex => [:pointer, :pointer],
      :TextToUpper => [:pointer],
      :TextToLower => [:pointer],
      :TextToPascal => [:pointer],
      :TextToInteger => [:pointer],
      :DrawLine3D => [Vector3.by_value, Vector3.by_value, Color.by_value],
      :DrawPoint3D => [Vector3.by_value, Color.by_value],
      :DrawCircle3D => [Vector3.by_value, :float, Vector3.by_value, :float, Color.by_value],
      :DrawTriangle3D => [Vector3.by_value, Vector3.by_value, Vector3.by_value, Color.by_value],
      :DrawTriangleStrip3D => [:pointer, :int, Color.by_value],
      :DrawCube => [Vector3.by_value, :float, :float, :float, Color.by_value],
      :DrawCubeV => [Vector3.by_value, Vector3.by_value, Color.by_value],
      :DrawCubeWires => [Vector3.by_value, :float, :float, :float, Color.by_value],
      :DrawCubeWiresV => [Vector3.by_value, Vector3.by_value, Color.by_value],
      :DrawCubeTexture => [Texture2D.by_value, Vector3.by_value, :float, :float, :float, Color.by_value],
      :DrawCubeTextureRec => [Texture2D.by_value, Rectangle.by_value, Vector3.by_value, :float, :float, :float, Color.by_value],
      :DrawSphere => [Vector3.by_value, :float, Color.by_value],
      :DrawSphereEx => [Vector3.by_value, :float, :int, :int, Color.by_value],
      :DrawSphereWires => [Vector3.by_value, :float, :int, :int, Color.by_value],
      :DrawCylinder => [Vector3.by_value, :float, :float, :float, :int, Color.by_value],
      :DrawCylinderEx => [Vector3.by_value, Vector3.by_value, :float, :float, :int, Color.by_value],
      :DrawCylinderWires => [Vector3.by_value, :float, :float, :float, :int, Color.by_value],
      :DrawCylinderWiresEx => [Vector3.by_value, Vector3.by_value, :float, :float, :int, Color.by_value],
      :DrawPlane => [Vector3.by_value, Vector2.by_value, Color.by_value],
      :DrawRay => [Ray.by_value, Color.by_value],
      :DrawGrid => [:int, :float],
      :LoadModel => [:pointer],
      :LoadModelFromMesh => [Mesh.by_value],
      :UnloadModel => [Model.by_value],
      :UnloadModelKeepMeshes => [Model.by_value],
      :GetModelBoundingBox => [Model.by_value],
      :DrawModel => [Model.by_value, Vector3.by_value, :float, Color.by_value],
      :DrawModelEx => [Model.by_value, Vector3.by_value, Vector3.by_value, :float, Vector3.by_value, Color.by_value],
      :DrawModelWires => [Model.by_value, Vector3.by_value, :float, Color.by_value],
      :DrawModelWiresEx => [Model.by_value, Vector3.by_value, Vector3.by_value, :float, Vector3.by_value, Color.by_value],
      :DrawBoundingBox => [BoundingBox.by_value, Color.by_value],
      :DrawBillboard => [Camera.by_value, Texture2D.by_value, Vector3.by_value, :float, Color.by_value],
      :DrawBillboardRec => [Camera.by_value, Texture2D.by_value, Rectangle.by_value, Vector3.by_value, Vector2.by_value, Color.by_value],
      :DrawBillboardPro => [Camera.by_value, Texture2D.by_value, Rectangle.by_value, Vector3.by_value, Vector3.by_value, Vector2.by_value, Vector2.by_value, :float, Color.by_value],
      :UploadMesh => [:pointer, :bool],
      :UpdateMeshBuffer => [Mesh.by_value, :int, :pointer, :int, :int],
      :UnloadMesh => [Mesh.by_value],
      :DrawMesh => [Mesh.by_value, Material.by_value, Matrix.by_value],
      :DrawMeshInstanced => [Mesh.by_value, Material.by_value, :pointer, :int],
      :ExportMesh => [Mesh.by_value, :pointer],
      :GetMeshBoundingBox => [Mesh.by_value],
      :GenMeshTangents => [:pointer],
      :GenMeshBinormals => [:pointer],
      :GenMeshPoly => [:int, :float],
      :GenMeshPlane => [:float, :float, :int, :int],
      :GenMeshCube => [:float, :float, :float],
      :GenMeshSphere => [:float, :int, :int],
      :GenMeshHemiSphere => [:float, :int, :int],
      :GenMeshCylinder => [:float, :float, :int],
      :GenMeshCone => [:float, :float, :int],
      :GenMeshTorus => [:float, :float, :int, :int],
      :GenMeshKnot => [:float, :float, :int, :int],
      :GenMeshHeightmap => [Image.by_value, Vector3.by_value],
      :GenMeshCubicmap => [Image.by_value, Vector3.by_value],
      :LoadMaterials => [:pointer, :pointer],
      :LoadMaterialDefault => [],
      :UnloadMaterial => [Material.by_value],
      :SetMaterialTexture => [:pointer, :int, Texture2D.by_value],
      :SetModelMeshMaterial => [:pointer, :int, :int],
      :LoadModelAnimations => [:pointer, :pointer],
      :UpdateModelAnimation => [Model.by_value, ModelAnimation.by_value, :int],
      :UnloadModelAnimation => [ModelAnimation.by_value],
      :UnloadModelAnimations => [:pointer, :uint],
      :IsModelAnimationValid => [Model.by_value, ModelAnimation.by_value],
      :CheckCollisionSpheres => [Vector3.by_value, :float, Vector3.by_value, :float],
      :CheckCollisionBoxes => [BoundingBox.by_value, BoundingBox.by_value],
      :CheckCollisionBoxSphere => [BoundingBox.by_value, Vector3.by_value, :float],
      :GetRayCollisionSphere => [Ray.by_value, Vector3.by_value, :float],
      :GetRayCollisionBox => [Ray.by_value, BoundingBox.by_value],
      :GetRayCollisionMesh => [Ray.by_value, Mesh.by_value, Matrix.by_value],
      :GetRayCollisionTriangle => [Ray.by_value, Vector3.by_value, Vector3.by_value, Vector3.by_value],
      :GetRayCollisionQuad => [Ray.by_value, Vector3.by_value, Vector3.by_value, Vector3.by_value, Vector3.by_value],
      :InitAudioDevice => [],
      :CloseAudioDevice => [],
      :IsAudioDeviceReady => [],
      :SetMasterVolume => [:float],
      :LoadWave => [:pointer],
      :LoadWaveFromMemory => [:pointer, :pointer, :int],
      :LoadSound => [:pointer],
      :LoadSoundFromWave => [Wave.by_value],
      :UpdateSound => [Sound.by_value, :pointer, :int],
      :UnloadWave => [Wave.by_value],
      :UnloadSound => [Sound.by_value],
      :ExportWave => [Wave.by_value, :pointer],
      :ExportWaveAsCode => [Wave.by_value, :pointer],
      :PlaySound => [Sound.by_value],
      :StopSound => [Sound.by_value],
      :PauseSound => [Sound.by_value],
      :ResumeSound => [Sound.by_value],
      :PlaySoundMulti => [Sound.by_value],
      :StopSoundMulti => [],
      :GetSoundsPlaying => [],
      :IsSoundPlaying => [Sound.by_value],
      :SetSoundVolume => [Sound.by_value, :float],
      :SetSoundPitch => [Sound.by_value, :float],
      :SetSoundPan => [Sound.by_value, :float],
      :WaveCopy => [Wave.by_value],
      :WaveCrop => [:pointer, :int, :int],
      :WaveFormat => [:pointer, :int, :int, :int],
      :LoadWaveSamples => [Wave.by_value],
      :UnloadWaveSamples => [:pointer],
      :LoadMusicStream => [:pointer],
      :LoadMusicStreamFromMemory => [:pointer, :pointer, :int],
      :UnloadMusicStream => [Music.by_value],
      :PlayMusicStream => [Music.by_value],
      :IsMusicStreamPlaying => [Music.by_value],
      :UpdateMusicStream => [Music.by_value],
      :StopMusicStream => [Music.by_value],
      :PauseMusicStream => [Music.by_value],
      :ResumeMusicStream => [Music.by_value],
      :SeekMusicStream => [Music.by_value, :float],
      :SetMusicVolume => [Music.by_value, :float],
      :SetMusicPitch => [Music.by_value, :float],
      :SetMusicPan => [Music.by_value, :float],
      :GetMusicTimeLength => [Music.by_value],
      :GetMusicTimePlayed => [Music.by_value],
      :LoadAudioStream => [:uint, :uint, :uint],
      :UnloadAudioStream => [AudioStream.by_value],
      :UpdateAudioStream => [AudioStream.by_value, :pointer, :int],
      :IsAudioStreamProcessed => [AudioStream.by_value],
      :PlayAudioStream => [AudioStream.by_value],
      :PauseAudioStream => [AudioStream.by_value],
      :ResumeAudioStream => [AudioStream.by_value],
      :IsAudioStreamPlaying => [AudioStream.by_value],
      :StopAudioStream => [AudioStream.by_value],
      :SetAudioStreamVolume => [AudioStream.by_value, :float],
      :SetAudioStreamPitch => [AudioStream.by_value, :float],
      :SetAudioStreamPan => [AudioStream.by_value, :float],
      :SetAudioStreamBufferSizeDefault => [:int],
      :SetAudioStreamCallback => [AudioStream.by_value, :AudioCallback],
      :AttachAudioStreamProcessor => [AudioStream.by_value, :AudioCallback],
      :DetachAudioStreamProcessor => [AudioStream.by_value, :AudioCallback],
    }
    retvals = {
      :InitWindow => :void,
      :WindowShouldClose => :bool,
      :CloseWindow => :void,
      :IsWindowReady => :bool,
      :IsWindowFullscreen => :bool,
      :IsWindowHidden => :bool,
      :IsWindowMinimized => :bool,
      :IsWindowMaximized => :bool,
      :IsWindowFocused => :bool,
      :IsWindowResized => :bool,
      :IsWindowState => :bool,
      :SetWindowState => :void,
      :ClearWindowState => :void,
      :ToggleFullscreen => :void,
      :MaximizeWindow => :void,
      :MinimizeWindow => :void,
      :RestoreWindow => :void,
      :SetWindowIcon => :void,
      :SetWindowTitle => :void,
      :SetWindowPosition => :void,
      :SetWindowMonitor => :void,
      :SetWindowMinSize => :void,
      :SetWindowSize => :void,
      :SetWindowOpacity => :void,
      :GetWindowHandle => :pointer,
      :GetScreenWidth => :int,
      :GetScreenHeight => :int,
      :GetRenderWidth => :int,
      :GetRenderHeight => :int,
      :GetMonitorCount => :int,
      :GetCurrentMonitor => :int,
      :GetMonitorPosition => Vector2.by_value,
      :GetMonitorWidth => :int,
      :GetMonitorHeight => :int,
      :GetMonitorPhysicalWidth => :int,
      :GetMonitorPhysicalHeight => :int,
      :GetMonitorRefreshRate => :int,
      :GetWindowPosition => Vector2.by_value,
      :GetWindowScaleDPI => Vector2.by_value,
      :GetMonitorName => :pointer,
      :SetClipboardText => :void,
      :GetClipboardText => :pointer,
      :SwapScreenBuffer => :void,
      :PollInputEvents => :void,
      :WaitTime => :void,
      :ShowCursor => :void,
      :HideCursor => :void,
      :IsCursorHidden => :bool,
      :EnableCursor => :void,
      :DisableCursor => :void,
      :IsCursorOnScreen => :bool,
      :ClearBackground => :void,
      :BeginDrawing => :void,
      :EndDrawing => :void,
      :BeginMode2D => :void,
      :EndMode2D => :void,
      :BeginMode3D => :void,
      :EndMode3D => :void,
      :BeginTextureMode => :void,
      :EndTextureMode => :void,
      :BeginShaderMode => :void,
      :EndShaderMode => :void,
      :BeginBlendMode => :void,
      :EndBlendMode => :void,
      :BeginScissorMode => :void,
      :EndScissorMode => :void,
      :BeginVrStereoMode => :void,
      :EndVrStereoMode => :void,
      :LoadVrStereoConfig => VrStereoConfig.by_value,
      :UnloadVrStereoConfig => :void,
      :LoadShader => Shader.by_value,
      :LoadShaderFromMemory => Shader.by_value,
      :GetShaderLocation => :int,
      :GetShaderLocationAttrib => :int,
      :SetShaderValue => :void,
      :SetShaderValueV => :void,
      :SetShaderValueMatrix => :void,
      :SetShaderValueTexture => :void,
      :UnloadShader => :void,
      :GetMouseRay => Ray.by_value,
      :GetCameraMatrix => Matrix.by_value,
      :GetCameraMatrix2D => Matrix.by_value,
      :GetWorldToScreen => Vector2.by_value,
      :GetWorldToScreenEx => Vector2.by_value,
      :GetWorldToScreen2D => Vector2.by_value,
      :GetScreenToWorld2D => Vector2.by_value,
      :SetTargetFPS => :void,
      :GetFPS => :int,
      :GetFrameTime => :float,
      :GetTime => :double,
      :GetRandomValue => :int,
      :SetRandomSeed => :void,
      :TakeScreenshot => :void,
      :SetConfigFlags => :void,
      :TraceLog => :void,
      :SetTraceLogLevel => :void,
      :MemAlloc => :pointer,
      :MemRealloc => :pointer,
      :MemFree => :void,
      :SetTraceLogCallback => :void,
      :SetLoadFileDataCallback => :void,
      :SetSaveFileDataCallback => :void,
      :SetLoadFileTextCallback => :void,
      :SetSaveFileTextCallback => :void,
      :LoadFileData => :pointer,
      :UnloadFileData => :void,
      :SaveFileData => :bool,
      :LoadFileText => :pointer,
      :UnloadFileText => :void,
      :SaveFileText => :bool,
      :FileExists => :bool,
      :DirectoryExists => :bool,
      :IsFileExtension => :bool,
      :GetFileLength => :int,
      :GetFileExtension => :pointer,
      :GetFileName => :pointer,
      :GetFileNameWithoutExt => :pointer,
      :GetDirectoryPath => :pointer,
      :GetPrevDirectoryPath => :pointer,
      :GetWorkingDirectory => :pointer,
      :GetApplicationDirectory => :pointer,
      :GetDirectoryFiles => :pointer,
      :ClearDirectoryFiles => :void,
      :ChangeDirectory => :bool,
      :IsFileDropped => :bool,
      :GetDroppedFiles => :pointer,
      :ClearDroppedFiles => :void,
      :GetFileModTime => :long,
      :CompressData => :pointer,
      :DecompressData => :pointer,
      :EncodeDataBase64 => :pointer,
      :DecodeDataBase64 => :pointer,
      :SaveStorageValue => :bool,
      :LoadStorageValue => :int,
      :OpenURL => :void,
      :IsKeyPressed => :bool,
      :IsKeyDown => :bool,
      :IsKeyReleased => :bool,
      :IsKeyUp => :bool,
      :SetExitKey => :void,
      :GetKeyPressed => :int,
      :GetCharPressed => :int,
      :IsGamepadAvailable => :bool,
      :GetGamepadName => :pointer,
      :IsGamepadButtonPressed => :bool,
      :IsGamepadButtonDown => :bool,
      :IsGamepadButtonReleased => :bool,
      :IsGamepadButtonUp => :bool,
      :GetGamepadButtonPressed => :int,
      :GetGamepadAxisCount => :int,
      :GetGamepadAxisMovement => :float,
      :SetGamepadMappings => :int,
      :IsMouseButtonPressed => :bool,
      :IsMouseButtonDown => :bool,
      :IsMouseButtonReleased => :bool,
      :IsMouseButtonUp => :bool,
      :GetMouseX => :int,
      :GetMouseY => :int,
      :GetMousePosition => Vector2.by_value,
      :GetMouseDelta => Vector2.by_value,
      :SetMousePosition => :void,
      :SetMouseOffset => :void,
      :SetMouseScale => :void,
      :GetMouseWheelMove => :float,
      :SetMouseCursor => :void,
      :GetTouchX => :int,
      :GetTouchY => :int,
      :GetTouchPosition => Vector2.by_value,
      :GetTouchPointId => :int,
      :GetTouchPointCount => :int,
      :SetGesturesEnabled => :void,
      :IsGestureDetected => :bool,
      :GetGestureDetected => :int,
      :GetGestureHoldDuration => :float,
      :GetGestureDragVector => Vector2.by_value,
      :GetGestureDragAngle => :float,
      :GetGesturePinchVector => Vector2.by_value,
      :GetGesturePinchAngle => :float,
      :SetCameraMode => :void,
      :UpdateCamera => :void,
      :SetCameraPanControl => :void,
      :SetCameraAltControl => :void,
      :SetCameraSmoothZoomControl => :void,
      :SetCameraMoveControls => :void,
      :SetShapesTexture => :void,
      :DrawPixel => :void,
      :DrawPixelV => :void,
      :DrawLine => :void,
      :DrawLineV => :void,
      :DrawLineEx => :void,
      :DrawLineBezier => :void,
      :DrawLineBezierQuad => :void,
      :DrawLineBezierCubic => :void,
      :DrawLineStrip => :void,
      :DrawCircle => :void,
      :DrawCircleSector => :void,
      :DrawCircleSectorLines => :void,
      :DrawCircleGradient => :void,
      :DrawCircleV => :void,
      :DrawCircleLines => :void,
      :DrawEllipse => :void,
      :DrawEllipseLines => :void,
      :DrawRing => :void,
      :DrawRingLines => :void,
      :DrawRectangle => :void,
      :DrawRectangleV => :void,
      :DrawRectangleRec => :void,
      :DrawRectanglePro => :void,
      :DrawRectangleGradientV => :void,
      :DrawRectangleGradientH => :void,
      :DrawRectangleGradientEx => :void,
      :DrawRectangleLines => :void,
      :DrawRectangleLinesEx => :void,
      :DrawRectangleRounded => :void,
      :DrawRectangleRoundedLines => :void,
      :DrawTriangle => :void,
      :DrawTriangleLines => :void,
      :DrawTriangleFan => :void,
      :DrawTriangleStrip => :void,
      :DrawPoly => :void,
      :DrawPolyLines => :void,
      :DrawPolyLinesEx => :void,
      :CheckCollisionRecs => :bool,
      :CheckCollisionCircles => :bool,
      :CheckCollisionCircleRec => :bool,
      :CheckCollisionPointRec => :bool,
      :CheckCollisionPointCircle => :bool,
      :CheckCollisionPointTriangle => :bool,
      :CheckCollisionLines => :bool,
      :CheckCollisionPointLine => :bool,
      :GetCollisionRec => Rectangle.by_value,
      :LoadImage => Image.by_value,
      :LoadImageRaw => Image.by_value,
      :LoadImageAnim => Image.by_value,
      :LoadImageFromMemory => Image.by_value,
      :LoadImageFromTexture => Image.by_value,
      :LoadImageFromScreen => Image.by_value,
      :UnloadImage => :void,
      :ExportImage => :bool,
      :ExportImageAsCode => :bool,
      :GenImageColor => Image.by_value,
      :GenImageGradientV => Image.by_value,
      :GenImageGradientH => Image.by_value,
      :GenImageGradientRadial => Image.by_value,
      :GenImageChecked => Image.by_value,
      :GenImageWhiteNoise => Image.by_value,
      :GenImageCellular => Image.by_value,
      :ImageCopy => Image.by_value,
      :ImageFromImage => Image.by_value,
      :ImageText => Image.by_value,
      :ImageTextEx => Image.by_value,
      :ImageFormat => :void,
      :ImageToPOT => :void,
      :ImageCrop => :void,
      :ImageAlphaCrop => :void,
      :ImageAlphaClear => :void,
      :ImageAlphaMask => :void,
      :ImageAlphaPremultiply => :void,
      :ImageResize => :void,
      :ImageResizeNN => :void,
      :ImageResizeCanvas => :void,
      :ImageMipmaps => :void,
      :ImageDither => :void,
      :ImageFlipVertical => :void,
      :ImageFlipHorizontal => :void,
      :ImageRotateCW => :void,
      :ImageRotateCCW => :void,
      :ImageColorTint => :void,
      :ImageColorInvert => :void,
      :ImageColorGrayscale => :void,
      :ImageColorContrast => :void,
      :ImageColorBrightness => :void,
      :ImageColorReplace => :void,
      :LoadImageColors => :pointer,
      :LoadImagePalette => :pointer,
      :UnloadImageColors => :void,
      :UnloadImagePalette => :void,
      :GetImageAlphaBorder => Rectangle.by_value,
      :GetImageColor => Color.by_value,
      :ImageClearBackground => :void,
      :ImageDrawPixel => :void,
      :ImageDrawPixelV => :void,
      :ImageDrawLine => :void,
      :ImageDrawLineV => :void,
      :ImageDrawCircle => :void,
      :ImageDrawCircleV => :void,
      :ImageDrawRectangle => :void,
      :ImageDrawRectangleV => :void,
      :ImageDrawRectangleRec => :void,
      :ImageDrawRectangleLines => :void,
      :ImageDraw => :void,
      :ImageDrawText => :void,
      :ImageDrawTextEx => :void,
      :LoadTexture => Texture2D.by_value,
      :LoadTextureFromImage => Texture2D.by_value,
      :LoadTextureCubemap => TextureCubemap.by_value,
      :LoadRenderTexture => RenderTexture2D.by_value,
      :UnloadTexture => :void,
      :UnloadRenderTexture => :void,
      :UpdateTexture => :void,
      :UpdateTextureRec => :void,
      :GenTextureMipmaps => :void,
      :SetTextureFilter => :void,
      :SetTextureWrap => :void,
      :DrawTexture => :void,
      :DrawTextureV => :void,
      :DrawTextureEx => :void,
      :DrawTextureRec => :void,
      :DrawTextureQuad => :void,
      :DrawTextureTiled => :void,
      :DrawTexturePro => :void,
      :DrawTextureNPatch => :void,
      :DrawTexturePoly => :void,
      :Fade => Color.by_value,
      :ColorToInt => :int,
      :ColorNormalize => Vector4.by_value,
      :ColorFromNormalized => Color.by_value,
      :ColorToHSV => Vector3.by_value,
      :ColorFromHSV => Color.by_value,
      :ColorAlpha => Color.by_value,
      :ColorAlphaBlend => Color.by_value,
      :GetColor => Color.by_value,
      :GetPixelColor => Color.by_value,
      :SetPixelColor => :void,
      :GetPixelDataSize => :int,
      :GetFontDefault => Font.by_value,
      :LoadFont => Font.by_value,
      :LoadFontEx => Font.by_value,
      :LoadFontFromImage => Font.by_value,
      :LoadFontFromMemory => Font.by_value,
      :LoadFontData => :pointer,
      :GenImageFontAtlas => Image.by_value,
      :UnloadFontData => :void,
      :UnloadFont => :void,
      :ExportFontAsCode => :bool,
      :DrawFPS => :void,
      :DrawText => :void,
      :DrawTextEx => :void,
      :DrawTextPro => :void,
      :DrawTextCodepoint => :void,
      :DrawTextCodepoints => :void,
      :MeasureText => :int,
      :MeasureTextEx => Vector2.by_value,
      :GetGlyphIndex => :int,
      :GetGlyphInfo => GlyphInfo.by_value,
      :GetGlyphAtlasRec => Rectangle.by_value,
      :LoadCodepoints => :pointer,
      :UnloadCodepoints => :void,
      :GetCodepointCount => :int,
      :GetCodepoint => :int,
      :CodepointToUTF8 => :pointer,
      :TextCodepointsToUTF8 => :pointer,
      :TextCopy => :int,
      :TextIsEqual => :bool,
      :TextLength => :uint,
      :TextFormat => :pointer,
      :TextSubtext => :pointer,
      :TextReplace => :pointer,
      :TextInsert => :pointer,
      :TextJoin => :pointer,
      :TextSplit => :pointer,
      :TextAppend => :void,
      :TextFindIndex => :int,
      :TextToUpper => :pointer,
      :TextToLower => :pointer,
      :TextToPascal => :pointer,
      :TextToInteger => :int,
      :DrawLine3D => :void,
      :DrawPoint3D => :void,
      :DrawCircle3D => :void,
      :DrawTriangle3D => :void,
      :DrawTriangleStrip3D => :void,
      :DrawCube => :void,
      :DrawCubeV => :void,
      :DrawCubeWires => :void,
      :DrawCubeWiresV => :void,
      :DrawCubeTexture => :void,
      :DrawCubeTextureRec => :void,
      :DrawSphere => :void,
      :DrawSphereEx => :void,
      :DrawSphereWires => :void,
      :DrawCylinder => :void,
      :DrawCylinderEx => :void,
      :DrawCylinderWires => :void,
      :DrawCylinderWiresEx => :void,
      :DrawPlane => :void,
      :DrawRay => :void,
      :DrawGrid => :void,
      :LoadModel => Model.by_value,
      :LoadModelFromMesh => Model.by_value,
      :UnloadModel => :void,
      :UnloadModelKeepMeshes => :void,
      :GetModelBoundingBox => BoundingBox.by_value,
      :DrawModel => :void,
      :DrawModelEx => :void,
      :DrawModelWires => :void,
      :DrawModelWiresEx => :void,
      :DrawBoundingBox => :void,
      :DrawBillboard => :void,
      :DrawBillboardRec => :void,
      :DrawBillboardPro => :void,
      :UploadMesh => :void,
      :UpdateMeshBuffer => :void,
      :UnloadMesh => :void,
      :DrawMesh => :void,
      :DrawMeshInstanced => :void,
      :ExportMesh => :bool,
      :GetMeshBoundingBox => BoundingBox.by_value,
      :GenMeshTangents => :void,
      :GenMeshBinormals => :void,
      :GenMeshPoly => Mesh.by_value,
      :GenMeshPlane => Mesh.by_value,
      :GenMeshCube => Mesh.by_value,
      :GenMeshSphere => Mesh.by_value,
      :GenMeshHemiSphere => Mesh.by_value,
      :GenMeshCylinder => Mesh.by_value,
      :GenMeshCone => Mesh.by_value,
      :GenMeshTorus => Mesh.by_value,
      :GenMeshKnot => Mesh.by_value,
      :GenMeshHeightmap => Mesh.by_value,
      :GenMeshCubicmap => Mesh.by_value,
      :LoadMaterials => :pointer,
      :LoadMaterialDefault => Material.by_value,
      :UnloadMaterial => :void,
      :SetMaterialTexture => :void,
      :SetModelMeshMaterial => :void,
      :LoadModelAnimations => :pointer,
      :UpdateModelAnimation => :void,
      :UnloadModelAnimation => :void,
      :UnloadModelAnimations => :void,
      :IsModelAnimationValid => :bool,
      :CheckCollisionSpheres => :bool,
      :CheckCollisionBoxes => :bool,
      :CheckCollisionBoxSphere => :bool,
      :GetRayCollisionSphere => RayCollision.by_value,
      :GetRayCollisionBox => RayCollision.by_value,
      :GetRayCollisionMesh => RayCollision.by_value,
      :GetRayCollisionTriangle => RayCollision.by_value,
      :GetRayCollisionQuad => RayCollision.by_value,
      :InitAudioDevice => :void,
      :CloseAudioDevice => :void,
      :IsAudioDeviceReady => :bool,
      :SetMasterVolume => :void,
      :LoadWave => Wave.by_value,
      :LoadWaveFromMemory => Wave.by_value,
      :LoadSound => Sound.by_value,
      :LoadSoundFromWave => Sound.by_value,
      :UpdateSound => :void,
      :UnloadWave => :void,
      :UnloadSound => :void,
      :ExportWave => :bool,
      :ExportWaveAsCode => :bool,
      :PlaySound => :void,
      :StopSound => :void,
      :PauseSound => :void,
      :ResumeSound => :void,
      :PlaySoundMulti => :void,
      :StopSoundMulti => :void,
      :GetSoundsPlaying => :int,
      :IsSoundPlaying => :bool,
      :SetSoundVolume => :void,
      :SetSoundPitch => :void,
      :SetSoundPan => :void,
      :WaveCopy => Wave.by_value,
      :WaveCrop => :void,
      :WaveFormat => :void,
      :LoadWaveSamples => :pointer,
      :UnloadWaveSamples => :void,
      :LoadMusicStream => Music.by_value,
      :LoadMusicStreamFromMemory => Music.by_value,
      :UnloadMusicStream => :void,
      :PlayMusicStream => :void,
      :IsMusicStreamPlaying => :bool,
      :UpdateMusicStream => :void,
      :StopMusicStream => :void,
      :PauseMusicStream => :void,
      :ResumeMusicStream => :void,
      :SeekMusicStream => :void,
      :SetMusicVolume => :void,
      :SetMusicPitch => :void,
      :SetMusicPan => :void,
      :GetMusicTimeLength => :float,
      :GetMusicTimePlayed => :float,
      :LoadAudioStream => AudioStream.by_value,
      :UnloadAudioStream => :void,
      :UpdateAudioStream => :void,
      :IsAudioStreamProcessed => :bool,
      :PlayAudioStream => :void,
      :PauseAudioStream => :void,
      :ResumeAudioStream => :void,
      :IsAudioStreamPlaying => :bool,
      :StopAudioStream => :void,
      :SetAudioStreamVolume => :void,
      :SetAudioStreamPitch => :void,
      :SetAudioStreamPan => :void,
      :SetAudioStreamBufferSizeDefault => :void,
      :SetAudioStreamCallback => :void,
      :AttachAudioStreamProcessor => :void,
      :DetachAudioStreamProcessor => :void,
    }
    symbols.each do |sym|
      begin
        attach_function sym, args[sym], retvals[sym]
      rescue FFI::NotFoundError => error
        $stderr.puts("[Warning] Failed to import #{sym} (#{error}).")
      end
    end
  end

end

