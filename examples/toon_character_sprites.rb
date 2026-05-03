require_relative 'util/setup_dll'
require 'rexml/document'

if __FILE__ == $PROGRAM_NAME
  CharacterSheet = Struct.new(:name, :texture, :animations, :animation_names)

  CHARACTER_NAMES = [
    'FemaleAdventurer',
    'FemalePerson',
    'MaleAdventurer',
    'MalePerson',
    'Robot',
    'Zombie'
  ].freeze

  SCREEN_WIDTH = 1000
  SCREEN_HEIGHT = 700
  TARGET_FPS = 60
  ANIMATION_FPS = 8

  def sheet_basename(character_name)
    normalized = character_name[0].downcase + character_name[1..]
    "character_#{normalized}_sheetHD"
  end

  def parse_animations_from_xml(xml_path)
    xml = REXML::Document.new(File.read(xml_path))
    animations = {}

    xml.elements.each('TextureAtlas/SubTexture') do |sub_texture|
      name = sub_texture.attributes['name']
      base_animation_name = name.sub(/\d+\z/, '')

      rect = Rectangle.create(
        sub_texture.attributes['x'].to_f,
        sub_texture.attributes['y'].to_f,
        sub_texture.attributes['width'].to_f,
        sub_texture.attributes['height'].to_f
      )

      animations[base_animation_name] ||= []
      animations[base_animation_name] << rect
    end

    animations
  end

  def clamp_index(index, max_count)
    return 0 if max_count <= 0
    return 0 if index < 0
    return max_count - 1 if index >= max_count

    index
  end

  def pick_animation_index(animation_names, preferred_name)
    idx = animation_names.index(preferred_name)
    idx.nil? ? 0 : idx
  end

  InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, 'Yet Another Ruby-raylib bindings - toon character sprites')
  SetTargetFPS(TARGET_FPS)

  atlas_root = File.expand_path('sprite/kenney_toon-characters', __dir__)

  characters = []
  load_errors = []

  CHARACTER_NAMES.each do |character_name|
    basename = sheet_basename(character_name)
    sheet_dir = File.join(atlas_root, character_name)
    image_path = File.join(sheet_dir, "#{basename}.png")
    xml_path = File.join(sheet_dir, "#{basename}.xml")

    unless File.exist?(image_path)
      load_errors << "Missing sprite sheet: #{image_path}"
      next
    end

    unless File.exist?(xml_path)
      load_errors << "Missing xml atlas: #{xml_path}"
      next
    end

    begin
      animations = parse_animations_from_xml(xml_path)
      if animations.empty?
        load_errors << "No SubTexture entries found in: #{xml_path}"
        next
      end

      texture = LoadTexture(image_path)
      characters << CharacterSheet.new(character_name, texture, animations, animations.keys)
    rescue StandardError => e
      load_errors << "Failed to load #{character_name}: #{e.message}"
    end
  end

  if characters.empty?
    until WindowShouldClose()
      BeginDrawing()
        ClearBackground(RAYWHITE)
        DrawText('No character data could be loaded.', 30, 40, 28, MAROON)
        DrawText('Press ESC or close the window.', 30, 80, 20, DARKGRAY)

        y = 130
        load_errors.each do |error_message|
          DrawText(error_message, 30, y, 18, RED)
          y += 24
        end
      EndDrawing()
    end

    CloseWindow()
    exit
  end

  character_list_active = 0
  character_list_scroll = 0

  current_character = characters[character_list_active]
  animation_list_active = pick_animation_index(current_character.animation_names, 'idle')
  animation_list_scroll = 0

  character_options = characters.map(&:name).join(';')
  animation_options = current_character.animation_names.join(';')

  sprite_scale = 1.0

  current_frame = 0
  frame_counter = 0

  until WindowShouldClose()
    previous_character_active = character_list_active
    previous_animation_active = animation_list_active

    current_character = characters[character_list_active]
    animation_names = current_character.animation_names

    animation_list_active = clamp_index(animation_list_active, animation_names.length)

    current_animation_name = animation_names[animation_list_active]
    frames = current_character.animations[current_animation_name]

    frame_counter += 1
    if frames.length > 1 && frame_counter >= (TARGET_FPS / ANIMATION_FPS)
      frame_counter = 0
      current_frame = (current_frame + 1) % frames.length
    elsif frames.length <= 1
      current_frame = 0
      frame_counter = 0
    end

    BeginDrawing()
      ClearBackground(RAYWHITE)

      # Left panel - Character list (3 rows visible)
      DrawText('Character', 10, 8, 10, DARKGRAY)
      character_list_scroll, character_list_active, result = RGuiListView(
        Rectangle.create(10, 28, 250, 90),
        character_options,
        character_list_scroll,
        character_list_active
      )
      character_list_active = clamp_index(character_list_active, characters.length)

      if character_list_active != previous_character_active
        new_char = characters[character_list_active]
        animation_options = new_char.animation_names.join(';')
        animation_list_active = pick_animation_index(new_char.animation_names, current_animation_name)
        animation_list_scroll = 0
        current_frame = 0
        frame_counter = 0
      end

      # Left panel - Animation list (5 rows visible, scrollable)
      DrawText('Animation', 10, 128, 10, DARKGRAY)
      animation_list_scroll, animation_list_active, result = RGuiListView(
        Rectangle.create(10, 148, 250, 145),
        animation_options,
        animation_list_scroll,
        animation_list_active
      )
      animation_list_active = clamp_index(animation_list_active, characters[character_list_active].animation_names.length)

      if animation_list_active != previous_animation_active
        current_frame = 0
        frame_counter = 0
      end

      # Scale slider
      sprite_scale, result = RGuiSlider(
        Rectangle.create(10, 315, 250, 20),
        'Scale',
        TextFormat('%1.2fx', :float, sprite_scale),
        sprite_scale,
        0.5,
        2.0
      )

      # Derive current state after GUI updates
      current_character = characters[character_list_active]
      animation_names = current_character.animation_names
      animation_list_active = clamp_index(animation_list_active, animation_names.length)
      current_animation_name = animation_names[animation_list_active]
      frames = current_character.animations[current_animation_name]
      current_frame = clamp_index(current_frame, frames.length)

      # Status text - positioned below the left panel controls
      DrawText("Character: #{current_character.name}", 10, 348, 10, BLACK)
      DrawText("Animation: #{current_animation_name}", 10, 372, 10, BLACK)
      DrawText("Frame: #{current_frame + 1}/#{frames.length}", 10, 396, 10, DARKGRAY)

      # Sprite - centered in right area to avoid left panel overlap
      source_rect = frames[current_frame]
      scaled_w = source_rect.width * sprite_scale
      scaled_h = source_rect.height * sprite_scale
      dest_rect = Rectangle.create(640.0, 380.0, scaled_w, scaled_h)
      origin = Vector2.create(scaled_w / 2.0, scaled_h / 2.0)

      DrawTexturePro(current_character.texture, source_rect, dest_rect, origin, 0.0, WHITE)

      DrawText('Animation frames are parsed from XML SubTexture entries.', 10, SCREEN_HEIGHT - 25, 10, GRAY)
      DrawFPS(SCREEN_WIDTH - 90, 10)
    EndDrawing()
  end

  characters.each do |character|
    UnloadTexture(character.texture)
  end

  CloseWindow()
end