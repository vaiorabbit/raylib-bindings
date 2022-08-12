# Yet another raylib wrapper for Ruby
#
# * https://github.com/vaiorabbit/raylib-bindings
#
# [NOTICE] This is an automatically generated file.

require 'ffi'

module Raylib
  extend FFI::Library
  # Define/Macro

  PHYSAC_MAX_BODIES = 64
  PHYSAC_MAX_MANIFOLDS = 4096
  PHYSAC_MAX_VERTICES = 24
  PHYSAC_DEFAULT_CIRCLE_VERTICES = 24
  PHYSAC_COLLISION_ITERATIONS = 100
  PHYSAC_PENETRATION_ALLOWANCE = 0.05
  PHYSAC_PENETRATION_CORRECTION = 0.4
  PHYSAC_PI = 3.14159265358979323846

  # Enum

  PHYSICS_CIRCLE = 0
  PHYSICS_POLYGON = 1

  # Typedef

  typedef :int, :PhysicsShapeType
  typedef :pointer, :PhysicsBody
  typedef :pointer, :PhysicsManifold

  # Struct

  class Matrix2x2 < FFI::Struct
    layout(
      :m00, :float,
      :m01, :float,
      :m10, :float,
      :m11, :float,
    )
  end

  class PhysicsVertexData < FFI::Struct
    layout(
      :vertexCount, :uint,
      :positions, [Vector2, 24],
      :normals, [Vector2, 24],
    )
  end

  class PhysicsShape < FFI::Struct
    layout(
      :type, :int,
      :body, :pointer,
      :vertexData, PhysicsVertexData,
      :radius, :float,
      :transform, Matrix2x2,
    )
  end

  class PhysicsBodyData < FFI::Struct
    layout(
      :id, :uint,
      :enabled, :bool,
      :position, Vector2,
      :velocity, Vector2,
      :force, Vector2,
      :angularVelocity, :float,
      :torque, :float,
      :orient, :float,
      :inertia, :float,
      :inverseInertia, :float,
      :mass, :float,
      :inverseMass, :float,
      :staticFriction, :float,
      :dynamicFriction, :float,
      :restitution, :float,
      :useGravity, :bool,
      :isGrounded, :bool,
      :freezeOrient, :bool,
      :shape, PhysicsShape,
    )
  end

  class PhysicsManifoldData < FFI::Struct
    layout(
      :id, :uint,
      :bodyA, :pointer,
      :bodyB, :pointer,
      :penetration, :float,
      :normal, Vector2,
      :contacts, [Vector2, 2],
      :contactsCount, :uint,
      :restitution, :float,
      :dynamicFriction, :float,
      :staticFriction, :float,
    )
  end


  # Function

  def self.setup_physac_symbols()
    symbols = [
      :InitPhysics,
      :UpdatePhysics,
      :ResetPhysics,
      :ClosePhysics,
      :SetPhysicsTimeStep,
      :SetPhysicsGravity,
      :CreatePhysicsBodyCircle,
      :CreatePhysicsBodyRectangle,
      :CreatePhysicsBodyPolygon,
      :DestroyPhysicsBody,
      :PhysicsAddForce,
      :PhysicsAddTorque,
      :PhysicsShatter,
      :SetPhysicsBodyRotation,
      :GetPhysicsBody,
      :GetPhysicsBodiesCount,
      :GetPhysicsShapeType,
      :GetPhysicsShapeVerticesCount,
      :GetPhysicsShapeVertex,
    ]
    args = {
      :InitPhysics => [],
      :UpdatePhysics => [],
      :ResetPhysics => [],
      :ClosePhysics => [],
      :SetPhysicsTimeStep => [:double],
      :SetPhysicsGravity => [:float, :float],
      :CreatePhysicsBodyCircle => [Vector2.by_value, :float, :float],
      :CreatePhysicsBodyRectangle => [Vector2.by_value, :float, :float, :float],
      :CreatePhysicsBodyPolygon => [Vector2.by_value, :float, :int, :float],
      :DestroyPhysicsBody => [:pointer],
      :PhysicsAddForce => [:pointer, Vector2.by_value],
      :PhysicsAddTorque => [:pointer, :float],
      :PhysicsShatter => [:pointer, Vector2.by_value, :float],
      :SetPhysicsBodyRotation => [:pointer, :float],
      :GetPhysicsBody => [:int],
      :GetPhysicsBodiesCount => [],
      :GetPhysicsShapeType => [:int],
      :GetPhysicsShapeVerticesCount => [:int],
      :GetPhysicsShapeVertex => [:pointer, :int],
    }
    retvals = {
      :InitPhysics => :void,
      :UpdatePhysics => :void,
      :ResetPhysics => :void,
      :ClosePhysics => :void,
      :SetPhysicsTimeStep => :void,
      :SetPhysicsGravity => :void,
      :CreatePhysicsBodyCircle => :pointer,
      :CreatePhysicsBodyRectangle => :pointer,
      :CreatePhysicsBodyPolygon => :pointer,
      :DestroyPhysicsBody => :void,
      :PhysicsAddForce => :void,
      :PhysicsAddTorque => :void,
      :PhysicsShatter => :void,
      :SetPhysicsBodyRotation => :void,
      :GetPhysicsBody => :pointer,
      :GetPhysicsBodiesCount => :int,
      :GetPhysicsShapeType => :int,
      :GetPhysicsShapeVerticesCount => :int,
      :GetPhysicsShapeVertex => Vector2.by_value,
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

