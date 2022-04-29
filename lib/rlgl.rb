# Yet another raylib wrapper for Ruby
#
# * https://github.com/vaiorabbit/raylib-bindings
#
# [NOTICE] This is an automatically generated file.

require 'ffi'

module Raylib
  extend FFI::Library
  # Define/Macro

  RLGL_VERSION = "4.0"
  RL_DEFAULT_BATCH_BUFFER_ELEMENTS = 8192
  RL_DEFAULT_BATCH_BUFFERS = 1
  RL_DEFAULT_BATCH_DRAWCALLS = 256
  RL_DEFAULT_BATCH_MAX_TEXTURE_UNITS = 4
  RL_MAX_MATRIX_STACK_SIZE = 32
  RL_MAX_SHADER_LOCATIONS = 32
  RL_CULL_DISTANCE_NEAR = 0.01
  RL_CULL_DISTANCE_FAR = 1000.0
  RL_TEXTURE_WRAP_S = 0x2802
  RL_TEXTURE_WRAP_T = 0x2803
  RL_TEXTURE_MAG_FILTER = 0x2800
  RL_TEXTURE_MIN_FILTER = 0x2801
  RL_TEXTURE_FILTER_NEAREST = 0x2600
  RL_TEXTURE_FILTER_LINEAR = 0x2601
  RL_TEXTURE_FILTER_MIP_NEAREST = 0x2700
  RL_TEXTURE_FILTER_NEAREST_MIP_LINEAR = 0x2702
  RL_TEXTURE_FILTER_LINEAR_MIP_NEAREST = 0x2701
  RL_TEXTURE_FILTER_MIP_LINEAR = 0x2703
  RL_TEXTURE_FILTER_ANISOTROPIC = 0x3000
  RL_TEXTURE_WRAP_REPEAT = 0x2901
  RL_TEXTURE_WRAP_CLAMP = 0x812F
  RL_TEXTURE_WRAP_MIRROR_REPEAT = 0x8370
  RL_TEXTURE_WRAP_MIRROR_CLAMP = 0x8742
  RL_MODELVIEW = 0x1700
  RL_PROJECTION = 0x1701
  RL_TEXTURE = 0x1702
  RL_LINES = 0x0001
  RL_TRIANGLES = 0x0004
  RL_QUADS = 0x0007
  RL_UNSIGNED_BYTE = 0x1401
  RL_FLOAT = 0x1406
  RL_STREAM_DRAW = 0x88E0
  RL_STREAM_READ = 0x88E1
  RL_STREAM_COPY = 0x88E2
  RL_STATIC_DRAW = 0x88E4
  RL_STATIC_READ = 0x88E5
  RL_STATIC_COPY = 0x88E6
  RL_DYNAMIC_DRAW = 0x88E8
  RL_DYNAMIC_READ = 0x88E9
  RL_DYNAMIC_COPY = 0x88EA
  RL_FRAGMENT_SHADER = 0x8B30
  RL_VERTEX_SHADER = 0x8B31
  RL_COMPUTE_SHADER = 0x91B9

  # Enum

  OPENGL_11 = 1
  OPENGL_21 = 2
  OPENGL_33 = 3
  OPENGL_43 = 4
  OPENGL_ES_20 = 5
  RL_ATTACHMENT_COLOR_CHANNEL0 = 0
  RL_ATTACHMENT_COLOR_CHANNEL1 = 1
  RL_ATTACHMENT_COLOR_CHANNEL2 = 2
  RL_ATTACHMENT_COLOR_CHANNEL3 = 3
  RL_ATTACHMENT_COLOR_CHANNEL4 = 4
  RL_ATTACHMENT_COLOR_CHANNEL5 = 5
  RL_ATTACHMENT_COLOR_CHANNEL6 = 6
  RL_ATTACHMENT_COLOR_CHANNEL7 = 7
  RL_ATTACHMENT_DEPTH = 100
  RL_ATTACHMENT_STENCIL = 200
  RL_ATTACHMENT_CUBEMAP_POSITIVE_X = 0
  RL_ATTACHMENT_CUBEMAP_NEGATIVE_X = 1
  RL_ATTACHMENT_CUBEMAP_POSITIVE_Y = 2
  RL_ATTACHMENT_CUBEMAP_NEGATIVE_Y = 3
  RL_ATTACHMENT_CUBEMAP_POSITIVE_Z = 4
  RL_ATTACHMENT_CUBEMAP_NEGATIVE_Z = 5
  RL_ATTACHMENT_TEXTURE2D = 100
  RL_ATTACHMENT_RENDERBUFFER = 200
  RL_LOG_ALL = 0
  RL_LOG_TRACE = 1
  RL_LOG_DEBUG = 2
  RL_LOG_INFO = 3
  RL_LOG_WARNING = 4
  RL_LOG_ERROR = 5
  RL_LOG_FATAL = 6
  RL_LOG_NONE = 7
  RL_PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1
  RL_PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA = 2
  RL_PIXELFORMAT_UNCOMPRESSED_R5G6B5 = 3
  RL_PIXELFORMAT_UNCOMPRESSED_R8G8B8 = 4
  RL_PIXELFORMAT_UNCOMPRESSED_R5G5B5A1 = 5
  RL_PIXELFORMAT_UNCOMPRESSED_R4G4B4A4 = 6
  RL_PIXELFORMAT_UNCOMPRESSED_R8G8B8A8 = 7
  RL_PIXELFORMAT_UNCOMPRESSED_R32 = 8
  RL_PIXELFORMAT_UNCOMPRESSED_R32G32B32 = 9
  RL_PIXELFORMAT_UNCOMPRESSED_R32G32B32A32 = 10
  RL_PIXELFORMAT_COMPRESSED_DXT1_RGB = 11
  RL_PIXELFORMAT_COMPRESSED_DXT1_RGBA = 12
  RL_PIXELFORMAT_COMPRESSED_DXT3_RGBA = 13
  RL_PIXELFORMAT_COMPRESSED_DXT5_RGBA = 14
  RL_PIXELFORMAT_COMPRESSED_ETC1_RGB = 15
  RL_PIXELFORMAT_COMPRESSED_ETC2_RGB = 16
  RL_PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA = 17
  RL_PIXELFORMAT_COMPRESSED_PVRT_RGB = 18
  RL_PIXELFORMAT_COMPRESSED_PVRT_RGBA = 19
  RL_PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA = 20
  RL_PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA = 21
  RL_TEXTURE_FILTER_POINT = 0
  RL_TEXTURE_FILTER_BILINEAR = 1
  RL_TEXTURE_FILTER_TRILINEAR = 2
  RL_TEXTURE_FILTER_ANISOTROPIC_4X = 3
  RL_TEXTURE_FILTER_ANISOTROPIC_8X = 4
  RL_TEXTURE_FILTER_ANISOTROPIC_16X = 5
  RL_BLEND_ALPHA = 0
  RL_BLEND_ADDITIVE = 1
  RL_BLEND_MULTIPLIED = 2
  RL_BLEND_ADD_COLORS = 3
  RL_BLEND_SUBTRACT_COLORS = 4
  RL_BLEND_ALPHA_PREMUL = 5
  RL_BLEND_CUSTOM = 6
  RL_SHADER_LOC_VERTEX_POSITION = 0
  RL_SHADER_LOC_VERTEX_TEXCOORD01 = 1
  RL_SHADER_LOC_VERTEX_TEXCOORD02 = 2
  RL_SHADER_LOC_VERTEX_NORMAL = 3
  RL_SHADER_LOC_VERTEX_TANGENT = 4
  RL_SHADER_LOC_VERTEX_COLOR = 5
  RL_SHADER_LOC_MATRIX_MVP = 6
  RL_SHADER_LOC_MATRIX_VIEW = 7
  RL_SHADER_LOC_MATRIX_PROJECTION = 8
  RL_SHADER_LOC_MATRIX_MODEL = 9
  RL_SHADER_LOC_MATRIX_NORMAL = 10
  RL_SHADER_LOC_VECTOR_VIEW = 11
  RL_SHADER_LOC_COLOR_DIFFUSE = 12
  RL_SHADER_LOC_COLOR_SPECULAR = 13
  RL_SHADER_LOC_COLOR_AMBIENT = 14
  RL_SHADER_LOC_MAP_ALBEDO = 15
  RL_SHADER_LOC_MAP_METALNESS = 16
  RL_SHADER_LOC_MAP_NORMAL = 17
  RL_SHADER_LOC_MAP_ROUGHNESS = 18
  RL_SHADER_LOC_MAP_OCCLUSION = 19
  RL_SHADER_LOC_MAP_EMISSION = 20
  RL_SHADER_LOC_MAP_HEIGHT = 21
  RL_SHADER_LOC_MAP_CUBEMAP = 22
  RL_SHADER_LOC_MAP_IRRADIANCE = 23
  RL_SHADER_LOC_MAP_PREFILTER = 24
  RL_SHADER_LOC_MAP_BRDF = 25
  RL_SHADER_UNIFORM_FLOAT = 0
  RL_SHADER_UNIFORM_VEC2 = 1
  RL_SHADER_UNIFORM_VEC3 = 2
  RL_SHADER_UNIFORM_VEC4 = 3
  RL_SHADER_UNIFORM_INT = 4
  RL_SHADER_UNIFORM_IVEC2 = 5
  RL_SHADER_UNIFORM_IVEC3 = 6
  RL_SHADER_UNIFORM_IVEC4 = 7
  RL_SHADER_UNIFORM_SAMPLER2D = 8
  RL_SHADER_ATTRIB_FLOAT = 0
  RL_SHADER_ATTRIB_VEC2 = 1
  RL_SHADER_ATTRIB_VEC3 = 2
  RL_SHADER_ATTRIB_VEC4 = 3

  # Typedef

  typedef :int, :rlGlVersion
  typedef :int, :rlFramebufferAttachType
  typedef :int, :rlFramebufferAttachTextureType
  typedef :int, :rlTraceLogLevel
  typedef :int, :rlPixelFormat
  typedef :int, :rlTextureFilter
  typedef :int, :rlBlendMode
  typedef :int, :rlShaderLocationIndex
  typedef :int, :rlShaderUniformDataType
  typedef :int, :rlShaderAttributeDataType

  # Struct

  class RlVertexBuffer < FFI::Struct
    layout(
      :elementCount, :int,
      :vertices, :pointer,
      :texcoords, :pointer,
      :colors, :pointer,
      :indices, :pointer,
      :vaoId, :uint,
      :vboId, [:uint, 4],
    )
  end

  class RlDrawCall < FFI::Struct
    layout(
      :mode, :int,
      :vertexCount, :int,
      :vertexAlignment, :int,
      :textureId, :uint,
    )
  end

  class RlRenderBatch < FFI::Struct
    layout(
      :bufferCount, :int,
      :currentBuffer, :int,
      :vertexBuffer, :pointer,
      :draws, :pointer,
      :drawCounter, :int,
      :currentDepth, :float,
    )
  end


  # Function

  def self.setup_rlgl_symbols()
    symbols = [
      :rlMatrixMode,
      :rlPushMatrix,
      :rlPopMatrix,
      :rlLoadIdentity,
      :rlTranslatef,
      :rlRotatef,
      :rlScalef,
      :rlMultMatrixf,
      :rlFrustum,
      :rlOrtho,
      :rlViewport,
      :rlBegin,
      :rlEnd,
      :rlVertex2i,
      :rlVertex2f,
      :rlVertex3f,
      :rlTexCoord2f,
      :rlNormal3f,
      :rlColor4ub,
      :rlColor3f,
      :rlColor4f,
      :rlEnableVertexArray,
      :rlDisableVertexArray,
      :rlEnableVertexBuffer,
      :rlDisableVertexBuffer,
      :rlEnableVertexBufferElement,
      :rlDisableVertexBufferElement,
      :rlEnableVertexAttribute,
      :rlDisableVertexAttribute,
      :rlActiveTextureSlot,
      :rlEnableTexture,
      :rlDisableTexture,
      :rlEnableTextureCubemap,
      :rlDisableTextureCubemap,
      :rlTextureParameters,
      :rlEnableShader,
      :rlDisableShader,
      :rlEnableFramebuffer,
      :rlDisableFramebuffer,
      :rlActiveDrawBuffers,
      :rlEnableColorBlend,
      :rlDisableColorBlend,
      :rlEnableDepthTest,
      :rlDisableDepthTest,
      :rlEnableDepthMask,
      :rlDisableDepthMask,
      :rlEnableBackfaceCulling,
      :rlDisableBackfaceCulling,
      :rlEnableScissorTest,
      :rlDisableScissorTest,
      :rlScissor,
      :rlEnableWireMode,
      :rlDisableWireMode,
      :rlSetLineWidth,
      :rlGetLineWidth,
      :rlEnableSmoothLines,
      :rlDisableSmoothLines,
      :rlEnableStereoRender,
      :rlDisableStereoRender,
      :rlIsStereoRenderEnabled,
      :rlClearColor,
      :rlClearScreenBuffers,
      :rlCheckErrors,
      :rlSetBlendMode,
      :rlSetBlendFactors,
      :rlglInit,
      :rlglClose,
      :rlLoadExtensions,
      :rlGetVersion,
      :rlSetFramebufferWidth,
      :rlGetFramebufferWidth,
      :rlSetFramebufferHeight,
      :rlGetFramebufferHeight,
      :rlGetTextureIdDefault,
      :rlGetShaderIdDefault,
      :rlGetShaderLocsDefault,
      :rlLoadRenderBatch,
      :rlUnloadRenderBatch,
      :rlDrawRenderBatch,
      :rlSetRenderBatchActive,
      :rlDrawRenderBatchActive,
      :rlCheckRenderBatchLimit,
      :rlSetTexture,
      :rlLoadVertexArray,
      :rlLoadVertexBuffer,
      :rlLoadVertexBufferElement,
      :rlUpdateVertexBuffer,
      :rlUpdateVertexBufferElements,
      :rlUnloadVertexArray,
      :rlUnloadVertexBuffer,
      :rlSetVertexAttribute,
      :rlSetVertexAttributeDivisor,
      :rlSetVertexAttributeDefault,
      :rlDrawVertexArray,
      :rlDrawVertexArrayElements,
      :rlDrawVertexArrayInstanced,
      :rlDrawVertexArrayElementsInstanced,
      :rlLoadTexture,
      :rlLoadTextureDepth,
      :rlLoadTextureCubemap,
      :rlUpdateTexture,
      :rlGetGlTextureFormats,
      :rlGetPixelFormatName,
      :rlUnloadTexture,
      :rlGenTextureMipmaps,
      :rlReadTexturePixels,
      :rlReadScreenPixels,
      :rlLoadFramebuffer,
      :rlFramebufferAttach,
      :rlFramebufferComplete,
      :rlUnloadFramebuffer,
      :rlLoadShaderCode,
      :rlCompileShader,
      :rlLoadShaderProgram,
      :rlUnloadShaderProgram,
      :rlGetLocationUniform,
      :rlGetLocationAttrib,
      :rlSetUniform,
      :rlSetUniformMatrix,
      :rlSetUniformSampler,
      :rlSetShader,
      :rlLoadComputeShaderProgram,
      :rlComputeShaderDispatch,
      :rlLoadShaderBuffer,
      :rlUnloadShaderBuffer,
      :rlUpdateShaderBufferElements,
      :rlGetShaderBufferSize,
      :rlReadShaderBufferElements,
      :rlBindShaderBuffer,
      :rlCopyBuffersElements,
      :rlBindImageTexture,
      :rlGetMatrixModelview,
      :rlGetMatrixProjection,
      :rlGetMatrixTransform,
      :rlGetMatrixProjectionStereo,
      :rlGetMatrixViewOffsetStereo,
      :rlSetMatrixProjection,
      :rlSetMatrixModelview,
      :rlSetMatrixProjectionStereo,
      :rlSetMatrixViewOffsetStereo,
      :rlLoadDrawCube,
      :rlLoadDrawQuad,
    ]
    args = {
      :rlMatrixMode => [:int],
      :rlPushMatrix => [],
      :rlPopMatrix => [],
      :rlLoadIdentity => [],
      :rlTranslatef => [:float, :float, :float],
      :rlRotatef => [:float, :float, :float, :float],
      :rlScalef => [:float, :float, :float],
      :rlMultMatrixf => [:pointer],
      :rlFrustum => [:double, :double, :double, :double, :double, :double],
      :rlOrtho => [:double, :double, :double, :double, :double, :double],
      :rlViewport => [:int, :int, :int, :int],
      :rlBegin => [:int],
      :rlEnd => [],
      :rlVertex2i => [:int, :int],
      :rlVertex2f => [:float, :float],
      :rlVertex3f => [:float, :float, :float],
      :rlTexCoord2f => [:float, :float],
      :rlNormal3f => [:float, :float, :float],
      :rlColor4ub => [:uchar, :uchar, :uchar, :uchar],
      :rlColor3f => [:float, :float, :float],
      :rlColor4f => [:float, :float, :float, :float],
      :rlEnableVertexArray => [:uint],
      :rlDisableVertexArray => [],
      :rlEnableVertexBuffer => [:uint],
      :rlDisableVertexBuffer => [],
      :rlEnableVertexBufferElement => [:uint],
      :rlDisableVertexBufferElement => [],
      :rlEnableVertexAttribute => [:uint],
      :rlDisableVertexAttribute => [:uint],
      :rlActiveTextureSlot => [:int],
      :rlEnableTexture => [:uint],
      :rlDisableTexture => [],
      :rlEnableTextureCubemap => [:uint],
      :rlDisableTextureCubemap => [],
      :rlTextureParameters => [:uint, :int, :int],
      :rlEnableShader => [:uint],
      :rlDisableShader => [],
      :rlEnableFramebuffer => [:uint],
      :rlDisableFramebuffer => [],
      :rlActiveDrawBuffers => [:int],
      :rlEnableColorBlend => [],
      :rlDisableColorBlend => [],
      :rlEnableDepthTest => [],
      :rlDisableDepthTest => [],
      :rlEnableDepthMask => [],
      :rlDisableDepthMask => [],
      :rlEnableBackfaceCulling => [],
      :rlDisableBackfaceCulling => [],
      :rlEnableScissorTest => [],
      :rlDisableScissorTest => [],
      :rlScissor => [:int, :int, :int, :int],
      :rlEnableWireMode => [],
      :rlDisableWireMode => [],
      :rlSetLineWidth => [:float],
      :rlGetLineWidth => [],
      :rlEnableSmoothLines => [],
      :rlDisableSmoothLines => [],
      :rlEnableStereoRender => [],
      :rlDisableStereoRender => [],
      :rlIsStereoRenderEnabled => [],
      :rlClearColor => [:uchar, :uchar, :uchar, :uchar],
      :rlClearScreenBuffers => [],
      :rlCheckErrors => [],
      :rlSetBlendMode => [:int],
      :rlSetBlendFactors => [:int, :int, :int],
      :rlglInit => [:int, :int],
      :rlglClose => [],
      :rlLoadExtensions => [:pointer],
      :rlGetVersion => [],
      :rlSetFramebufferWidth => [:int],
      :rlGetFramebufferWidth => [],
      :rlSetFramebufferHeight => [:int],
      :rlGetFramebufferHeight => [],
      :rlGetTextureIdDefault => [],
      :rlGetShaderIdDefault => [],
      :rlGetShaderLocsDefault => [],
      :rlLoadRenderBatch => [:int, :int],
      :rlUnloadRenderBatch => [RlRenderBatch.by_value],
      :rlDrawRenderBatch => [:pointer],
      :rlSetRenderBatchActive => [:pointer],
      :rlDrawRenderBatchActive => [],
      :rlCheckRenderBatchLimit => [:int],
      :rlSetTexture => [:uint],
      :rlLoadVertexArray => [],
      :rlLoadVertexBuffer => [:pointer, :int, :bool],
      :rlLoadVertexBufferElement => [:pointer, :int, :bool],
      :rlUpdateVertexBuffer => [:uint, :pointer, :int, :int],
      :rlUpdateVertexBufferElements => [:uint, :pointer, :int, :int],
      :rlUnloadVertexArray => [:uint],
      :rlUnloadVertexBuffer => [:uint],
      :rlSetVertexAttribute => [:uint, :int, :int, :bool, :int, :pointer],
      :rlSetVertexAttributeDivisor => [:uint, :int],
      :rlSetVertexAttributeDefault => [:int, :pointer, :int, :int],
      :rlDrawVertexArray => [:int, :int],
      :rlDrawVertexArrayElements => [:int, :int, :pointer],
      :rlDrawVertexArrayInstanced => [:int, :int, :int],
      :rlDrawVertexArrayElementsInstanced => [:int, :int, :pointer, :int],
      :rlLoadTexture => [:pointer, :int, :int, :int, :int],
      :rlLoadTextureDepth => [:int, :int, :bool],
      :rlLoadTextureCubemap => [:pointer, :int, :int],
      :rlUpdateTexture => [:uint, :int, :int, :int, :int, :int, :pointer],
      :rlGetGlTextureFormats => [:int, :pointer, :pointer, :pointer],
      :rlGetPixelFormatName => [:uint],
      :rlUnloadTexture => [:uint],
      :rlGenTextureMipmaps => [:uint, :int, :int, :int, :pointer],
      :rlReadTexturePixels => [:uint, :int, :int, :int],
      :rlReadScreenPixels => [:int, :int],
      :rlLoadFramebuffer => [:int, :int],
      :rlFramebufferAttach => [:uint, :uint, :int, :int, :int],
      :rlFramebufferComplete => [:uint],
      :rlUnloadFramebuffer => [:uint],
      :rlLoadShaderCode => [:pointer, :pointer],
      :rlCompileShader => [:pointer, :int],
      :rlLoadShaderProgram => [:uint, :uint],
      :rlUnloadShaderProgram => [:uint],
      :rlGetLocationUniform => [:uint, :pointer],
      :rlGetLocationAttrib => [:uint, :pointer],
      :rlSetUniform => [:int, :pointer, :int, :int],
      :rlSetUniformMatrix => [:int, Matrix.by_value],
      :rlSetUniformSampler => [:int, :uint],
      :rlSetShader => [:uint, :pointer],
      :rlLoadComputeShaderProgram => [:uint],
      :rlComputeShaderDispatch => [:uint, :uint, :uint],
      :rlLoadShaderBuffer => [:ulong_long, :pointer, :int],
      :rlUnloadShaderBuffer => [:uint],
      :rlUpdateShaderBufferElements => [:uint, :pointer, :ulong_long, :ulong_long],
      :rlGetShaderBufferSize => [:uint],
      :rlReadShaderBufferElements => [:uint, :pointer, :ulong_long, :ulong_long],
      :rlBindShaderBuffer => [:uint, :uint],
      :rlCopyBuffersElements => [:uint, :uint, :ulong_long, :ulong_long, :ulong_long],
      :rlBindImageTexture => [:uint, :uint, :uint, :int],
      :rlGetMatrixModelview => [],
      :rlGetMatrixProjection => [],
      :rlGetMatrixTransform => [],
      :rlGetMatrixProjectionStereo => [:int],
      :rlGetMatrixViewOffsetStereo => [:int],
      :rlSetMatrixProjection => [Matrix.by_value],
      :rlSetMatrixModelview => [Matrix.by_value],
      :rlSetMatrixProjectionStereo => [Matrix.by_value, Matrix.by_value],
      :rlSetMatrixViewOffsetStereo => [Matrix.by_value, Matrix.by_value],
      :rlLoadDrawCube => [],
      :rlLoadDrawQuad => [],
    }
    retvals = {
      :rlMatrixMode => :void,
      :rlPushMatrix => :void,
      :rlPopMatrix => :void,
      :rlLoadIdentity => :void,
      :rlTranslatef => :void,
      :rlRotatef => :void,
      :rlScalef => :void,
      :rlMultMatrixf => :void,
      :rlFrustum => :void,
      :rlOrtho => :void,
      :rlViewport => :void,
      :rlBegin => :void,
      :rlEnd => :void,
      :rlVertex2i => :void,
      :rlVertex2f => :void,
      :rlVertex3f => :void,
      :rlTexCoord2f => :void,
      :rlNormal3f => :void,
      :rlColor4ub => :void,
      :rlColor3f => :void,
      :rlColor4f => :void,
      :rlEnableVertexArray => :bool,
      :rlDisableVertexArray => :void,
      :rlEnableVertexBuffer => :void,
      :rlDisableVertexBuffer => :void,
      :rlEnableVertexBufferElement => :void,
      :rlDisableVertexBufferElement => :void,
      :rlEnableVertexAttribute => :void,
      :rlDisableVertexAttribute => :void,
      :rlActiveTextureSlot => :void,
      :rlEnableTexture => :void,
      :rlDisableTexture => :void,
      :rlEnableTextureCubemap => :void,
      :rlDisableTextureCubemap => :void,
      :rlTextureParameters => :void,
      :rlEnableShader => :void,
      :rlDisableShader => :void,
      :rlEnableFramebuffer => :void,
      :rlDisableFramebuffer => :void,
      :rlActiveDrawBuffers => :void,
      :rlEnableColorBlend => :void,
      :rlDisableColorBlend => :void,
      :rlEnableDepthTest => :void,
      :rlDisableDepthTest => :void,
      :rlEnableDepthMask => :void,
      :rlDisableDepthMask => :void,
      :rlEnableBackfaceCulling => :void,
      :rlDisableBackfaceCulling => :void,
      :rlEnableScissorTest => :void,
      :rlDisableScissorTest => :void,
      :rlScissor => :void,
      :rlEnableWireMode => :void,
      :rlDisableWireMode => :void,
      :rlSetLineWidth => :void,
      :rlGetLineWidth => :float,
      :rlEnableSmoothLines => :void,
      :rlDisableSmoothLines => :void,
      :rlEnableStereoRender => :void,
      :rlDisableStereoRender => :void,
      :rlIsStereoRenderEnabled => :bool,
      :rlClearColor => :void,
      :rlClearScreenBuffers => :void,
      :rlCheckErrors => :void,
      :rlSetBlendMode => :void,
      :rlSetBlendFactors => :void,
      :rlglInit => :void,
      :rlglClose => :void,
      :rlLoadExtensions => :void,
      :rlGetVersion => :int,
      :rlSetFramebufferWidth => :void,
      :rlGetFramebufferWidth => :int,
      :rlSetFramebufferHeight => :void,
      :rlGetFramebufferHeight => :int,
      :rlGetTextureIdDefault => :uint,
      :rlGetShaderIdDefault => :uint,
      :rlGetShaderLocsDefault => :pointer,
      :rlLoadRenderBatch => RlRenderBatch.by_value,
      :rlUnloadRenderBatch => :void,
      :rlDrawRenderBatch => :void,
      :rlSetRenderBatchActive => :void,
      :rlDrawRenderBatchActive => :void,
      :rlCheckRenderBatchLimit => :bool,
      :rlSetTexture => :void,
      :rlLoadVertexArray => :uint,
      :rlLoadVertexBuffer => :uint,
      :rlLoadVertexBufferElement => :uint,
      :rlUpdateVertexBuffer => :void,
      :rlUpdateVertexBufferElements => :void,
      :rlUnloadVertexArray => :void,
      :rlUnloadVertexBuffer => :void,
      :rlSetVertexAttribute => :void,
      :rlSetVertexAttributeDivisor => :void,
      :rlSetVertexAttributeDefault => :void,
      :rlDrawVertexArray => :void,
      :rlDrawVertexArrayElements => :void,
      :rlDrawVertexArrayInstanced => :void,
      :rlDrawVertexArrayElementsInstanced => :void,
      :rlLoadTexture => :uint,
      :rlLoadTextureDepth => :uint,
      :rlLoadTextureCubemap => :uint,
      :rlUpdateTexture => :void,
      :rlGetGlTextureFormats => :void,
      :rlGetPixelFormatName => :pointer,
      :rlUnloadTexture => :void,
      :rlGenTextureMipmaps => :void,
      :rlReadTexturePixels => :pointer,
      :rlReadScreenPixels => :pointer,
      :rlLoadFramebuffer => :uint,
      :rlFramebufferAttach => :void,
      :rlFramebufferComplete => :bool,
      :rlUnloadFramebuffer => :void,
      :rlLoadShaderCode => :uint,
      :rlCompileShader => :uint,
      :rlLoadShaderProgram => :uint,
      :rlUnloadShaderProgram => :void,
      :rlGetLocationUniform => :int,
      :rlGetLocationAttrib => :int,
      :rlSetUniform => :void,
      :rlSetUniformMatrix => :void,
      :rlSetUniformSampler => :void,
      :rlSetShader => :void,
      :rlLoadComputeShaderProgram => :uint,
      :rlComputeShaderDispatch => :void,
      :rlLoadShaderBuffer => :uint,
      :rlUnloadShaderBuffer => :void,
      :rlUpdateShaderBufferElements => :void,
      :rlGetShaderBufferSize => :ulong_long,
      :rlReadShaderBufferElements => :void,
      :rlBindShaderBuffer => :void,
      :rlCopyBuffersElements => :void,
      :rlBindImageTexture => :void,
      :rlGetMatrixModelview => Matrix.by_value,
      :rlGetMatrixProjection => Matrix.by_value,
      :rlGetMatrixTransform => Matrix.by_value,
      :rlGetMatrixProjectionStereo => Matrix.by_value,
      :rlGetMatrixViewOffsetStereo => Matrix.by_value,
      :rlSetMatrixProjection => :void,
      :rlSetMatrixModelview => :void,
      :rlSetMatrixProjectionStereo => :void,
      :rlSetMatrixViewOffsetStereo => :void,
      :rlLoadDrawCube => :void,
      :rlLoadDrawQuad => :void,
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

