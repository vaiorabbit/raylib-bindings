# coding: utf-8
require_relative 'util/setup_dll'
require_relative 'util/resource_path'

EMOJI_PER_WIDTH = 8
EMOJI_PER_HEIGHT = 4

$emojiCodepoints = [
  "\xF0\x9F\x8C\x80", "\xF0\x9F\x98\x80", "\xF0\x9F\x98\x82", "\xF0\x9F\xA4\xA3", "\xF0\x9F\x98\x83", "\xF0\x9F\x98\x86", "\xF0\x9F\x98\x89",
  "\xF0\x9F\x98\x8B", "\xF0\x9F\x98\x8E", "\xF0\x9F\x98\x8D", "\xF0\x9F\x98\x98", "\xF0\x9F\x98\x97", "\xF0\x9F\x98\x99", "\xF0\x9F\x98\x9A", "\xF0\x9F\x99\x82",
  "\xF0\x9F\xA4\x97", "\xF0\x9F\xA4\xA9", "\xF0\x9F\xA4\x94", "\xF0\x9F\xA4\xA8", "\xF0\x9F\x98\x90", "\xF0\x9F\x98\x91", "\xF0\x9F\x98\xB6", "\xF0\x9F\x99\x84",
  "\xF0\x9F\x98\x8F", "\xF0\x9F\x98\xA3", "\xF0\x9F\x98\xA5", "\xF0\x9F\x98\xAE", "\xF0\x9F\xA4\x90", "\xF0\x9F\x98\xAF", "\xF0\x9F\x98\xAA", "\xF0\x9F\x98\xAB",
  "\xF0\x9F\x98\xB4", "\xF0\x9F\x98\x8C", "\xF0\x9F\x98\x9B", "\xF0\x9F\x98\x9D", "\xF0\x9F\xA4\xA4", "\xF0\x9F\x98\x92", "\xF0\x9F\x98\x95", "\xF0\x9F\x99\x83",
  "\xF0\x9F\xA4\x91", "\xF0\x9F\x98\xB2", "\xF0\x9F\x99\x81", "\xF0\x9F\x98\x96", "\xF0\x9F\x98\x9E", "\xF0\x9F\x98\x9F", "\xF0\x9F\x98\xA4", "\xF0\x9F\x98\xA2",
  "\xF0\x9F\x98\xAD", "\xF0\x9F\x98\xA6", "\xF0\x9F\x98\xA9", "\xF0\x9F\xA4\xAF", "\xF0\x9F\x98\xAC", "\xF0\x9F\x98\xB0", "\xF0\x9F\x98\xB1", "\xF0\x9F\x98\xB3",
  "\xF0\x9F\xA4\xAA", "\xF0\x9F\x98\xB5", "\xF0\x9F\x98\xA1", "\xF0\x9F\x98\xA0", "\xF0\x9F\xA4\xAC", "\xF0\x9F\x98\xB7", "\xF0\x9F\xA4\x92", "\xF0\x9F\xA4\x95",
  "\xF0\x9F\xA4\xA2", "\xF0\x9F\xA4\xAE", "\xF0\x9F\xA4\xA7", "\xF0\x9F\x98\x87", "\xF0\x9F\xA4\xA0", "\xF0\x9F\xA4\xAB", "\xF0\x9F\xA4\xAD", "\xF0\x9F\xA7\x90",
  "\xF0\x9F\xA4\x93", "\xF0\x9F\x98\x88", "\xF0\x9F\x91\xBF", "\xF0\x9F\x91\xB9", "\xF0\x9F\x91\xBA", "\xF0\x9F\x92\x80", "\xF0\x9F\x91\xBB", "\xF0\x9F\x91\xBD",
  "\xF0\x9F\x91\xBE", "\xF0\x9F\xA4\x96", "\xF0\x9F\x92\xA9", "\xF0\x9F\x98\xBA", "\xF0\x9F\x98\xB8", "\xF0\x9F\x98\xB9", "\xF0\x9F\x98\xBB", "\xF0\x9F\x98\xBD",
  "\xF0\x9F\x99\x80", "\xF0\x9F\x98\xBF", "\xF0\x9F\x8C\xBE", "\xF0\x9F\x8C\xBF", "\xF0\x9F\x8D\x80", "\xF0\x9F\x8D\x83", "\xF0\x9F\x8D\x87", "\xF0\x9F\x8D\x93",
  "\xF0\x9F\xA5\x9D", "\xF0\x9F\x8D\x85", "\xF0\x9F\xA5\xA5", "\xF0\x9F\xA5\x91", "\xF0\x9F\x8D\x86", "\xF0\x9F\xA5\x94", "\xF0\x9F\xA5\x95", "\xF0\x9F\x8C\xBD",
  "\xF0\x9F\x8C\xB6", "\xF0\x9F\xA5\x92", "\xF0\x9F\xA5\xA6", "\xF0\x9F\x8D\x84", "\xF0\x9F\xA5\x9C", "\xF0\x9F\x8C\xB0", "\xF0\x9F\x8D\x9E", "\xF0\x9F\xA5\x90",
  "\xF0\x9F\xA5\x96", "\xF0\x9F\xA5\xA8", "\xF0\x9F\xA5\x9E", "\xF0\x9F\xA7\x80", "\xF0\x9F\x8D\x96", "\xF0\x9F\x8D\x97", "\xF0\x9F\xA5\xA9", "\xF0\x9F\xA5\x93",
  "\xF0\x9F\x8D\x94", "\xF0\x9F\x8D\x9F", "\xF0\x9F\x8D\x95", "\xF0\x9F\x8C\xAD", "\xF0\x9F\xA5\xAA", "\xF0\x9F\x8C\xAE", "\xF0\x9F\x8C\xAF", "\xF0\x9F\xA5\x99",
  "\xF0\x9F\xA5\x9A", "\xF0\x9F\x8D\xB3", "\xF0\x9F\xA5\x98", "\xF0\x9F\x8D\xB2", "\xF0\x9F\xA5\xA3", "\xF0\x9F\xA5\x97", "\xF0\x9F\x8D\xBF", "\xF0\x9F\xA5\xAB",
  "\xF0\x9F\x8D\xB1", "\xF0\x9F\x8D\x98", "\xF0\x9F\x8D\x9D", "\xF0\x9F\x8D\xA0", "\xF0\x9F\x8D\xA2", "\xF0\x9F\x8D\xA5", "\xF0\x9F\x8D\xA1", "\xF0\x9F\xA5\x9F",
  "\xF0\x9F\xA5\xA1", "\xF0\x9F\x8D\xA6", "\xF0\x9F\x8D\xAA", "\xF0\x9F\x8E\x82", "\xF0\x9F\x8D\xB0", "\xF0\x9F\xA5\xA7", "\xF0\x9F\x8D\xAB", "\xF0\x9F\x8D\xAF",
  "\xF0\x9F\x8D\xBC", "\xF0\x9F\xA5\x9B", "\xF0\x9F\x8D\xB5", "\xF0\x9F\x8D\xB6", "\xF0\x9F\x8D\xBE", "\xF0\x9F\x8D\xB7", "\xF0\x9F\x8D\xBB", "\xF0\x9F\xA5\x82",
  "\xF0\x9F\xA5\x83", "\xF0\x9F\xA5\xA4", "\xF0\x9F\xA5\xA2", "\xF0\x9F\x91\x81", "\xF0\x9F\x91\x85", "\xF0\x9F\x91\x84", "\xF0\x9F\x92\x8B", "\xF0\x9F\x92\x98",
  "\xF0\x9F\x92\x93", "\xF0\x9F\x92\x97", "\xF0\x9F\x92\x99", "\xF0\x9F\x92\x9B", "\xF0\x9F\xA7\xA1", "\xF0\x9F\x92\x9C", "\xF0\x9F\x96\xA4", "\xF0\x9F\x92\x9D",
  "\xF0\x9F\x92\x9F", "\xF0\x9F\x92\x8C", "\xF0\x9F\x92\xA4", "\xF0\x9F\x92\xA2", "\xF0\x9F\x92\xA3",
]

Message = Struct.new(:text, :language, keyword_init: true)
$messages = [
  Message.new(text: "\x46\x61\x6C\x73\x63\x68\x65\x73\x20\xC3\x9C\x62\x65\x6E\x20\x76\x6F\x6E\x20\x58\x79\x6C\x6F\x70\x68\x6F\x6E\x6D\x75\x73\x69\x6B\x20\x71\x75\xC3\xA4\x6C" "\x74\x20\x6A\x65\x64\x65\x6E\x20\x67\x72\xC3\xB6\xC3\x9F\x65\x72\x65\x6E\x20\x5A\x77\x65\x72\x67", language: "German"),
  Message.new(text: "\x42\x65\x69\xC3\x9F\x20\x6E\x69\x63\x68\x74\x20\x69\x6E\x20\x64\x69\x65\x20\x48\x61\x6E\x64\x2C\x20\x64\x69\x65\x20\x64\x69\x63\x68\x20\x66\xC3\xBC\x74" "\x74\x65\x72\x74\x2E", language: "German"),

  Message.new(text: "\x41\x75\xC3\x9F\x65\x72\x6F\x72\x64\x65\x6E\x74\x6C\x69\x63\x68\x65\x20\xC3\x9C\x62\x65\x6C\x20\x65\x72\x66\x6F\x72\x64\x65\x72\x6E\x20\x61\x75\xC3\x9F" "\x65\x72\x6F\x72\x64\x65\x6E\x74\x6C\x69\x63\x68\x65\x20\x4D\x69\x74\x74\x65\x6C\x2E", language: "German"),
  Message.new(text: "\xD4\xBF\xD6\x80\xD5\xB6\xD5\xA1\xD5\xB4\x20\xD5\xA1\xD5\xBA\xD5\xA1\xD5\xAF\xD5\xAB\x20\xD5\xB8\xD6\x82\xD5\xBF\xD5\xA5\xD5\xAC\x20\xD6\x87\x20\xD5\xAB" "\xD5\xB6\xD5\xAE\xD5\xAB\x20\xD5\xA1\xD5\xB6\xD5\xB0\xD5\xA1\xD5\xB6\xD5\xA3\xD5\xAB\xD5\xBD\xD5\xBF\x20\xD5\xB9\xD5\xA8\xD5\xB6\xD5\xA5\xD6\x80", language: "Armenian"),
  Message.new(text: "\xD4\xB5\xD6\x80\xD5\xA2\x20\xD5\xB8\xD6\x80\x20\xD5\xAF\xD5\xA1\xD6\x81\xD5\xAB\xD5\xB6\xD5\xA8\x20\xD5\xA5\xD5\xAF\xD5\xA1\xD6\x82\x20\xD5\xA1\xD5\xB6\xD5" "\xBF\xD5\xA1\xD5\xBC\x2C\x20\xD5\xAE\xD5\xA1\xD5\xBC\xD5\xA5\xD6\x80\xD5\xA8\x20\xD5\xA1\xD5\xBD\xD5\xA1\xD6\x81\xD5\xAB\xD5\xB6\x2E\x2E\x2E\x20\xC2\xAB\xD4\xBF" "\xD5\xB8\xD5\xBF\xD5\xA8\x20\xD5\xB4\xD5\xA5\xD6\x80\xD5\xB8\xD5\xB6\xD6\x81\xD5\xAB\xD6\x81\x20\xD5\xA7\x3A\xC2\xBB", language: "Armenian"),
  Message.new(text: "\xD4\xB3\xD5\xA1\xD5\xBC\xD5\xA8\xD5\x9D\x20\xD5\xA3\xD5\xA1\xD6\x80\xD5\xB6\xD5\xA1\xD5\xB6\x2C\x20\xD5\xB1\xD5\xAB\xD6\x82\xD5\xB6\xD5\xA8\xD5\x9D\x20\xD5" "\xB1\xD5\xB4\xD5\xBC\xD5\xA1\xD5\xB6", language: "Armenian"),
  Message.new(text: "\x4A\x65\xC5\xBC\x75\x20\x6B\x6C\xC4\x85\x74\x77\x2C\x20\x73\x70\xC5\x82\xC3\xB3\x64\xC5\xBA\x20\x46\x69\x6E\x6F\x6D\x20\x63\x7A\xC4\x99\xC5\x9B\xC4\x87" "\x20\x67\x72\x79\x20\x68\x61\xC5\x84\x62\x21", language: "Polish"),
  Message.new(text: "\x44\x6F\x62\x72\x79\x6D\x69\x20\x63\x68\xC4\x99\x63\x69\x61\x6D\x69\x20\x6A\x65\x73\x74\x20\x70\x69\x65\x6B\xC5\x82\x6F\x20\x77\x79\x62\x72\x75\x6B\x6F" "\x77\x61\x6E\x65\x2E", language: "Polish"),
  Message.new(text: "\xC3\x8E\xC8\x9B\x69\x20\x6D\x75\x6C\xC8\x9B\x75\x6D\x65\x73\x63\x20\x63\xC4\x83\x20\x61\x69\x20\x61\x6C\x65\x73\x20\x72\x61\x79\x6C\x69\x62\x2E\x0A\xC8\x98" "\x69\x20\x73\x70\x65\x72\x20\x73\xC4\x83\x20\x61\x69\x20\x6F\x20\x7A\x69\x20\x62\x75\x6E\xC4\x83\x21", language: "Romanian"),
  Message.new(text: "\xD0\xAD\xD1\x85\x2C\x20\xD1\x87\xD1\x83\xD0\xB6\xD0\xB0\xD0\xBA\x2C\x20\xD0\xBE\xD0\xB1\xD1\x89\xD0\xB8\xD0\xB9\x20\xD1\x81\xD1\x8A\xD1\x91\xD0\xBC\x20" "\xD1\x86\xD0\xB5\xD0\xBD\x20\xD1\x88\xD0\xBB\xD1\x8F\xD0\xBF\x20\x28\xD1\x8E\xD1\x84\xD1\x82\xD1\x8C\x29\x20\xD0\xB2\xD0\xB4\xD1\x80\xD1\x8B\xD0\xB7\xD0\xB3\x21", language: "Russian"),
  Message.new(text: "\xD0\xAF\x20\xD0\xBB\xD1\x8E\xD0\xB1\xD0\xBB\xD1\x8E\x20\x72\x61\x79\x6C\x69\x62\x21", language: "Russian"),
  Message.new(text: "\xD0\x9C\xD0\xBE\xD0\xBB\xD1\x87\xD0\xB8\x2C\x20\xD1\x81\xD0\xBA\xD1\x80\xD1\x8B\xD0\xB2\xD0\xB0\xD0\xB9\xD1\x81\xD1\x8F\x20\xD0\xB8\x20\xD1\x82\xD0\xB0\xD0\xB8" "\x0A\xD0\x98\x20\xD1\x87\xD1\x83\xD0\xB2\xD1\x81\xD1\x82\xD0\xB2\xD0\xB0\x20\xD0\xB8\x20\xD0\xBC\xD0\xB5\xD1\x87\xD1\x82\xD1\x8B\x20\xD1\x81\xD0\xB2\xD0\xBE\xD0\xB8\x20" "\xE2\x80\x93\x0A\xD0\x9F\xD1\x83\xD1\x81\xD0\xBA\xD0\xB0\xD0\xB9\x20\xD0\xB2\x20\xD0\xB4\xD1\x83\xD1\x88\xD0\xB5\xD0\xB2\xD0\xBD\xD0\xBE\xD0\xB9\x20\xD0\xB3\xD0\xBB\xD1" "\x83\xD0\xB1\xD0\xB8\xD0\xBD\xD0\xB5\x0A\xD0\x98\x20\xD0\xB2\xD1\x81\xD1\x85\xD0\xBE\xD0\xB4\xD1\x8F\xD1\x82\x20\xD0\xB8\x20\xD0\xB7\xD0\xB0\xD0\xB9\xD0\xB4\xD1\x83\xD1" "\x82\x20\xD0\xBE\xD0\xBD\xD0\xB5\x0A\xD0\x9A\xD0\xB0\xD0\xBA\x20\xD0\xB7\xD0\xB2\xD0\xB5\xD0\xB7\xD0\xB4\xD1\x8B\x20\xD1\x8F\xD1\x81\xD0\xBD\xD1\x8B\xD0\xB5\x20\xD0\xB2" "\x20\xD0\xBD\xD0\xBE\xD1\x87\xD0\xB8\x2D\x0A\xD0\x9B\xD1\x8E\xD0\xB1\xD1\x83\xD0\xB9\xD1\x81\xD1\x8F\x20\xD0\xB8\xD0\xBC\xD0\xB8\x20\xE2\x80\x93\x20\xD0\xB8\x20\xD0\xBC" "\xD0\xBE\xD0\xBB\xD1\x87\xD0\xB8\x2E", language: "Russian"),
  Message.new(text: "\x56\x6F\x69\x78\x20\x61\x6D\x62\x69\x67\x75\xC3\xAB\x20\x64\xE2\x80\x99\x75\x6E\x20\x63\xC5\x93\x75\x72\x20\x71\x75\x69\x20\x61\x75\x20\x7A\xC3\xA9\x70" "\x68\x79\x72\x20\x70\x72\xC3\xA9\x66\xC3\xA8\x72\x65\x20\x6C\x65\x73\x20\x6A\x61\x74\x74\x65\x73\x20\x64\x65\x20\x6B\x69\x77\x69", language: "French"),
  Message.new(text: "\x42\x65\x6E\x6A\x61\x6D\xC3\xAD\x6E\x20\x70\x69\x64\x69\xC3\xB3\x20\x75\x6E\x61\x20\x62\x65\x62\x69\x64\x61\x20\x64\x65\x20\x6B\x69\x77\x69\x20\x79\x20"  "\x66\x72\x65\x73\x61\x3B\x20\x4E\x6F\xC3\xA9\x2C\x20\x73\x69\x6E\x20\x76\x65\x72\x67\xC3\xBC\x65\x6E\x7A\x61\x2C\x20\x6C\x61\x20\x6D\xC3\xA1\x73\x20\x65\x78" "\x71\x75\x69\x73\x69\x74\x61\x20\x63\x68\x61\x6D\x70\x61\xC3\xB1\x61\x20\x64\x65\x6C\x20\x6D\x65\x6E\xC3\xBA\x2E", language: "Spanish"),
  Message.new(text: "\xCE\xA4\xCE\xB1\xCF\x87\xCE\xAF\xCF\x83\xCF\x84\xCE\xB7\x20\xCE\xB1\xCE\xBB\xCF\x8E\xCF\x80\xCE\xB7\xCE\xBE\x20\xCE\xB2\xCE\xB1\xCF\x86\xCE\xAE\xCF\x82\x20" "\xCF\x88\xCE\xB7\xCE\xBC\xCE\xAD\xCE\xBD\xCE\xB7\x20\xCE\xB3\xCE\xB7\x2C\x20\xCE\xB4\xCF\x81\xCE\xB1\xCF\x83\xCE\xBA\xCE\xB5\xCE\xBB\xCE\xAF\xCE\xB6\xCE\xB5\xCE" "\xB9\x20\xCF\x85\xCF\x80\xCE\xAD\xCF\x81\x20\xCE\xBD\xCF\x89\xCE\xB8\xCF\x81\xCE\xBF\xCF\x8D\x20\xCE\xBA\xCF\x85\xCE\xBD\xCF\x8C\xCF\x82", language: "Greek"),
  Message.new(text: "\xCE\x97\x20\xCE\xBA\xCE\xB1\xCE\xBB\xCF\x8D\xCF\x84\xCE\xB5\xCF\x81\xCE\xB7\x20\xCE\xAC\xCE\xBC\xCF\x85\xCE\xBD\xCE\xB1\x20\xCE\xB5\xCE\xAF\xCE\xBD" "\xCE\xB1\xCE\xB9\x20\xCE\xB7\x20\xCE\xB5\xCF\x80\xCE\xAF\xCE\xB8\xCE\xB5\xCF\x83\xCE\xB7\x2E", language: "Greek"),
  Message.new(text: "\xCE\xA7\xCF\x81\xCF\x8C\xCE\xBD\xCE\xB9\xCE\xB1\x20\xCE\xBA\xCE\xB1\xCE\xB9\x20\xCE\xB6\xCE\xB1\xCE\xBC\xCE\xAC\xCE\xBD\xCE\xB9\xCE\xB1\x21", language: "Greek"),
  Message.new(text: "\xCE\xA0\xCF\x8E\xCF\x82\x20\xCF\x84\xCE\xB1\x20\xCF\x80\xCE\xB1\xCF\x82\x20\xCF\x83\xCE\xAE\xCE\xBC\xCE\xB5\xCF\x81\xCE\xB1\x3B", language: "Greek"),

  Message.new(text: "\xE6\x88\x91\xE8\x83\xBD\xE5\x90\x9E\xE4\xB8\x8B\xE7\x8E\xBB\xE7\x92\x83\xE8\x80\x8C\xE4\xB8\x8D\xE4\xBC\xA4\xE8\xBA\xAB\xE4\xBD\x93\xE3\x80\x82", language: "Chinese"),
  Message.new(text: "\xE4\xBD\xA0\xE5\x90\x83\xE4\xBA\x86\xE5\x90\x97\xEF\xBC\x9F", language: "Chinese"),
  Message.new(text: "\xE4\xB8\x8D\xE4\xBD\x9C\xE4\xB8\x8D\xE6\xAD\xBB\xE3\x80\x82", language: "Chinese"),
  Message.new(text: "\xE6\x9C\x80\xE8\xBF\x91\xE5\xA5\xBD\xE5\x90\x97\xEF\xBC\x9F", language: "Chinese"),
  Message.new(text: "\xE5\xA1\x9E\xE7\xBF\x81\xE5\xA4\xB1\xE9\xA9\xAC\xEF\xBC\x8C\xE7\x84\x89\xE7\x9F\xA5\xE9\x9D\x9E\xE7\xA6\x8F\xE3\x80\x82", language: "Chinese"),
  Message.new(text: "\xE5\x8D\x83\xE5\x86\x9B\xE6\x98\x93\xE5\xBE\x97\x2C\x20\xE4\xB8\x80\xE5\xB0\x86\xE9\x9A\xBE\xE6\xB1\x82", language: "Chinese"),
  Message.new(text: "\xE4\xB8\x87\xE4\xBA\x8B\xE5\xBC\x80\xE5\xA4\xB4\xE9\x9A\xBE\xE3\x80\x82", language: "Chinese"),
  Message.new(text: "\xE9\xA3\x8E\xE6\x97\xA0\xE5\xB8\xB8\xE9\xA1\xBA\xEF\xBC\x8C\xE5\x85\xB5\xE6\x97\xA0\xE5\xB8\xB8\xE8\x83\x9C\xE3\x80\x82", language: "Chinese"),
  Message.new(text: "\xE6\xB4\xBB\xE5\x88\xB0\xE8\x80\x81\xEF\xBC\x8C\xE5\xAD\xA6\xE5\x88\xB0\xE8\x80\x81\xE3\x80\x82", language: "Chinese"),
  Message.new(text: "\xE4\xB8\x80\xE8\xA8\x80\xE6\x97\xA2\xE5\x87\xBA\xEF\xBC\x8C\xE9\xA9\xB7\xE9\xA9\xAC\xE9\x9A\xBE\xE8\xBF\xBD\xE3\x80\x82", language: "Chinese"),
  Message.new(text: "\xE8\xB7\xAF\xE9\x81\xA5\xE7\x9F\xA5\xE9\xA9\xAC\xE5\x8A\x9B\xEF\xBC\x8C\xE6\x97\xA5\xE4\xB9\x85\xE8\xA7\x81\xE4\xBA\xBA\xE5\xBF\x83", language: "Chinese"),
  Message.new(text: "\xE6\x9C\x89\xE7\x90\x86\xE8\xB5\xB0\xE9\x81\x8D\xE5\xA4\xA9\xE4\xB8\x8B\xEF\xBC\x8C\xE6\x97\xA0\xE7\x90\x86\xE5\xAF\xB8\xE6\xAD\xA5\xE9\x9A\xBE\xE8\xA1\x8C\xE3\x80\x82", language: "Chinese"),

  Message.new(text: "\xE7\x8C\xBF\xE3\x82\x82\xE6\x9C\xA8\xE3\x81\x8B\xE3\x82\x89\xE8\x90\xBD\xE3\x81\xA1\xE3\x82\x8B", language: "Japanese"), # "猿も木から落ちる"
  Message.new(text: "\xE4\xBA\x80\xE3\x81\xAE\xE7\x94\xB2\xE3\x82\x88\xE3\x82\x8A\xE5\xB9\xB4\xE3\x81\xAE\xE5\x8A\x9F", language: "Japanese"), # "亀の甲より年の功"
  Message.new(text: "\xE3\x81\x86\xE3\x82\x89\xE3\x82\x84\xE3\x81\xBE\xE3\x81\x97\x20\x20\xE6\x80\x9D\xE3\x81\xB2\xE5\x88\x87\xE3\x82\x8B\xE6\x99\x82\x20\x20\xE7\x8C\xAB\xE3\x81\xAE\xE6\x81\x8B", language: "Japanese"), # "うらやまし  思ひ切る時  猫の恋"
  Message.new(text: "\xE8\x99\x8E\xE7\xA9\xB4\xE3\x81\xAB\xE5\x85\xA5\xE3\x82\x89\xE3\x81\x9A\xE3\x82\x93\xE3\x81\xB0\xE8\x99\x8E\xE5\xAD\x90\xE3\x82\x92\xE5\xBE\x97\xE3\x81\x9A\xE3\x80\x82", language: "Japanese"), # "虎穴に入らずんば虎子を得ず。"
  Message.new(text: "\xE4\xBA\x8C\xE5\x85\x8E\xE3\x82\x92\xE8\xBF\xBD\xE3\x81\x86\xE8\x80\x85\xE3\x81\xAF\xE4\xB8\x80\xE5\x85\x8E\xE3\x82\x92\xE3\x82\x82\xE5\xBE\x97\xE3\x81\x9A\xE3\x80\x82", language: "Japanese"), # "二兎を追う者は一兎をも得ず。"
  Message.new(text: "\xE9\xA6\xAC\xE9\xB9\xBF\xE3\x81\xAF\xE6\xAD\xBB\xE3\x81\xAA\xE3\x81\xAA\xE3\x81\x8D\xE3\x82\x83\xE6\xB2\xBB\xE3\x82\x89\xE3\x81\xAA\xE3\x81\x84\xE3\x80\x82", language: "Japanese"), # "馬鹿は死ななきゃ治らない。"
  Message.new(text: "\xE6\x9E\xAF\xE9\x87\x8E\xE8\xB7\xAF\xE3\x81\xAB\xE3\x80\x80\xE5\xBD\xB1\xE3\x81\x8B\xE3\x81\x95\xE3\x81\xAA\xE3\x82\x8A\xE3\x81\xA6\xE3\x80\x80\xE3\x82\x8F\xE3\x81\x8B\xE3\x82\x8C\xE3\x81\x91\xE3\x82\x8A", language: "Japanese"), # "枯野路に　影かさなりて　わかれけり"
  Message.new(text: "\xE7\xB9\xB0\xE3\x82\x8A\xE8\xBF\x94\xE3\x81\x97\xE9\xBA\xA6\xE3\x81\xAE\xE7\x95\x9D\xE7\xB8\xAB\xE3\x81\xB5\xE8\x83\xA1\xE8\x9D\xB6\xE5\x93\x89", language: "Japanese"), # "繰り返し麦の畝縫ふ胡蝶哉"

  Message.new(text: "\xEC\x95\x84\xEB\x93\x9D\xED\x95\x9C\x20\xEB\xB0\x94\xEB\x8B\xA4\x20\xEC\x9C\x84\xEC\x97\x90\x20\xEA\xB0\x88\xEB\xA7\xA4\xEA\xB8\xB0\x20\xEB\x91\x90\xEC\x97\x87\x20" "\xEB\x82\xA0\xEC\x95\x84\x20\xEB\x8F\x88\xEB\x8B\xA4\x2E\x0A\xEB\x84\x88\xED\x9B\x8C\xEB\x84\x88\xED\x9B\x8C\x20\xEC\x8B\x9C\xEB\xA5\xBC\x20\xEC\x93\xB4\xEB\x8B\xA4\x2E" "\x20\xEB\xAA\xA8\xEB\xA5\xB4\xEB\x8A\x94\x20\xEB\x82\x98\xEB\x9D\xBC\x20\xEA\xB8\x80\xEC\x9E\x90\xEB\x8B\xA4\x2E\x0A\xEB\x84\x90\xEB\x94\xB0\xEB\x9E\x80\x20\xED\x95\x98" "\xEB\x8A\x98\x20\xEB\xB3\xB5\xED\x8C\x90\xEC\x97\x90\x20\xEB\x82\x98\xEB\x8F\x84\x20\xEA\xB0\x99\xEC\x9D\xB4\x20\xEC\x8B\x9C\xEB\xA5\xBC\x20\xEC\x93\xB4\xEB\x8B\xA4\x2E", language: "Korean"),
  Message.new(text: "\xEC\xA0\x9C\x20\xEB\x88\x88\xEC\x97\x90\x20\xEC\x95\x88\xEA\xB2\xBD\xEC\x9D\xB4\xEB\x8B\xA4", language: "Korean"),
  Message.new(text: "\xEA\xBF\xA9\x20\xEB\xA8\xB9\xEA\xB3\xA0\x20\xEC\x95\x8C\x20\xEB\xA8\xB9\xEB\x8A\x94\xEB\x8B\xA4", language: "Korean"),
  Message.new(text: "\xEB\xA1\x9C\xEB\xA7\x88\xEB\x8A\x94\x20\xED\x95\x98\xEB\xA3\xA8\xEC\x95\x84\xEC\xB9\xA8\xEC\x97\x90\x20\xEC\x9D\xB4\xEB\xA3\xA8\xEC\x96\xB4\xEC\xA7\x84\x20\xEA\xB2\x83\xEC\x9D\xB4" "\x20\xEC\x95\x84\xEB\x8B\x88\xEB\x8B\xA4", language: "Korean"),
  Message.new(text: "\xEA\xB3\xA0\xEC\x83\x9D\x20\xEB\x81\x9D\xEC\x97\x90\x20\xEB\x82\x99\xEC\x9D\xB4\x20\xEC\x98\xA8\xEB\x8B\xA4", language: "Korean"),
  Message.new(text: "\xEA\xB0\x9C\xEC\xB2\x9C\xEC\x97\x90\xEC\x84\x9C\x20\xEC\x9A\xA9\x20\xEB\x82\x9C\xEB\x8B\xA4", language: "Korean"),
  Message.new(text: "\xEC\x95\x88\xEB\x85\x95\xED\x95\x98\xEC\x84\xB8\xEC\x9A\x94\x3F", language: "Korean"),
  Message.new(text: "\xEB\xA7\x8C\xEB\x82\x98\xEC\x84\x9C\x20\xEB\xB0\x98\xEA\xB0\x91\xEC\x8A\xB5\xEB\x8B\x88\xEB\x8B\xA4", language: "Korean"),
  Message.new(text: "\xED\x95\x9C\xEA\xB5\xAD\xEB\xA7\x90\x20\xED\x95\x98\xEC\x8B\xA4\x20\xEC\xA4\x84\x20\xEC\x95\x84\xEC\x84\xB8\xEC\x9A\x94\x3F", language: "Korean"),
]

Emoji = Struct.new(:index, :message, :color, keyword_init: true)
$emoji = []

$hovered = -1
$selected = -1

# Fills the emoji array with random emoji (only those emojis present in fontEmoji)
def RandomizeEmoji()
  $emoji.clear
  $hovered = -1
  $selected = -1
  start = GetRandomValue(45, 360)
  (EMOJI_PER_WIDTH*EMOJI_PER_HEIGHT).times do |i|
    # index: 0-179 emoji codepoints (from emoji char array)
    # color: Generate a random color for this emoji
    # message: Set a random message for this emoji
    $emoji << Emoji.new(index: GetRandomValue(0, 179),
                        color: Fade(ColorFromHSV(((start*(i + 1))%360).to_f, 0.6, 0.85), 0.8),
                        message: GetRandomValue(0, $messages.length - 1))
  end
end

# Draw text using font inside rectangle limits
def DrawTextBoxed(font, text, rec, fontSize, spacing, wordWrap, tint)
  DrawTextBoxedSelectable(font, text, rec, fontSize, spacing, wordWrap, tint, 0, 0, WHITE, WHITE)
end

# Draw text using font inside rectangle limits with support for text selection
MEASURE_STATE = 0
DRAW_STATE = 1

def DrawTextBoxedSelectable(font, text, rec, fontSize, spacing, wordWrap, tint, selectStart, selectLength, selectTint, selectBackTint)

  textOffsetY = 0 # Offset between lines (on line break '\n')
  textOffsetX = 0 # Offset X to next character to draw

  scaleFactor = fontSize / font.baseSize.to_f # Character rectangle scaling factor

  # Word/character wrapping mechanism variables
  state = wordWrap ? MEASURE_STATE : DRAW_STATE

  startLine = -1 # Index where to begin drawing (where a line begins)
  endLine = -1   # Index where to stop drawing (where a line ends)
  lastk = -1     # Holds last value of the character position

  idx = -1
  k = -1
  while idx < text.length
    idx += 1
    break if idx >= text.length
    k += 1
    char = text.chars[idx]

    # Get glyph index in font
    index = char != nil ? GetGlyphIndex(font, char.ord) : 0

    # NOTE: Normally we exit the decoding sequence as soon as a bad byte is found (and return 0x3f)
    # but we need to draw all of the bad bytes using the '?' symbol moving one byte
    glyphWidth = 0
    if char != "\n"
      glyphInfo = GlyphInfo.new(font.glyphs + index * GlyphInfo.size)
      glyphWidth = 0
      if glyphInfo.advanceX == 0
        rect = Rectangle.new(font.recs + index * Rectangle.size)
        glyphWidth = rect.width*scaleFactor
      else
        glyphWidth = glyphInfo.advanceX*scaleFactor
      end
      glyphWidth = glyphWidth + spacing if idx + 1 < text.length
    end

    # NOTE: When wordWrap is ON we first measure how much of the text we can draw before going outside of the rec container
    # We store this info in startLine and endLine, then we change states, draw the text between those two variables
    # and change states again and again recursively until the end of the text (or until we get outside of the container).
    # When wordWrap is OFF we don't need the measure state so we go to the drawing state immediately
    # and begin drawing on the next line before we can get outside the container.
    if state == MEASURE_STATE
      # TODO: There are multiple types of spaces in UNICODE, maybe it's a good idea to add support for more
      # Ref: http://jkorpela.fi/chars/spaces.html
      endLine = idx if char == " " || char == "\t" || char == "\n"
      if (textOffsetX + glyphWidth) > rec.width
        endLine = (endLine < 1) ? idx : endLine
        endLine -= 1 if idx == endLine
        endLine = (idx - 1) if (startLine + 1) == endLine
        state = DRAW_STATE
      elsif (idx + 1) == text.length
        endLine = idx
        state = DRAW_STATE
      elsif char == "\n"
        state = DRAW_STATE
      end

      if state == DRAW_STATE
        textOffsetX = 0
        idx = startLine
        glyphWidth = 0
        # Save character position when we switch states
        tmp = lastk
        lastk = k - 1
        k = tmp
      end
    else
      if char == "\n"
        if !wordWrap
          textOffsetY += (font.baseSize + font.baseSize/2)*scaleFactor
          textOffsetX = 0
        end
      else
        if !wordWrap && ((textOffsetX + glyphWidth) > rec.width)
          textOffsetY += (font.baseSize + font.baseSize/2)*scaleFactor
          textOffsetX = 0
        end

        # When text overflows rectangle height limit, just stop drawing
        break if (textOffsetY + font.baseSize*scaleFactor) > rec.height

        # Draw selection background
        isGlyphSelected = false
        if (selectStart >= 0) && (k >= selectStart) && (k < (selectStart + selectLength))
          r = Rectangle.new
          r.x = rec.x + textOffsetX - 1
          r.y = rec.y + textOffsetY
          r.width = glyphWidth
          r.height = font.baseSize.to_f * scaleFactor
          DrawRectangleRec(r, selectBackTint)
          isGlyphSelected = true
        end
        # Draw current character glyph
        if (char != " ") && (char != "\t")
          v = Vector2.new
          v.x = rec.x + textOffsetX
          v.y = rec.y + textOffsetY
          DrawTextCodepoint(font, char.ord, v, fontSize, isGlyphSelected ? selectTint : tint)
        end
      end

      if wordWrap && (idx == endLine)
        textOffsetY += (font.baseSize + font.baseSize/2)*scaleFactor
        textOffsetX = 0
        startLine = endLine
        endLine = -1
        glyphWidth = 0
        selectStart += lastk - k
        k = lastk
        state = MEASURE_STATE
      end
    end

    textOffsetX += glyphWidth

  end
end

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450
  SetConfigFlags(FLAG_MSAA_4X_HINT | FLAG_VSYNC_HINT)
  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - unicode")

  fontDefault = LoadFont(RAYLIB_TEXT_PATH + "resources/dejavu.fnt")
  fontAsian = LoadFont(RAYLIB_TEXT_PATH + "resources/noto_cjk.fnt")
  fontEmoji = LoadFont(RAYLIB_TEXT_PATH + "resources/symbola.fnt")

  hoveredPos = Vector2.create(0.0, 0.0)
  selectedPos = Vector2.create(0.0, 0.0)

  SetTargetFPS(60)

  # Set a random set of emojis when starting up
  RandomizeEmoji()

  until WindowShouldClose()
    # Add a new set of emojis when SPACE is pressed
    RandomizeEmoji() if IsKeyPressed(KEY_SPACE)

    # Set the selected emoji and copy its text to clipboard
    if IsMouseButtonPressed(MOUSE_BUTTON_LEFT) && ($hovered != -1) && ($hovered != $selected)
      $selected = $hovered
      selectedPos.set(hoveredPos.x, hoveredPos.y)
      SetClipboardText($messages[$emoji[$selected].message].text)
    end

    mouse = GetMousePosition()
    pos = Vector2.create(28.8, 10.0)
    $hovered = -1

    BeginDrawing()
    ClearBackground(RAYWHITE)

    # Draw random emojis in the background
    $emoji.each_with_index do |em, i|
      txt = $emojiCodepoints[em.index]
      emojiRect = Rectangle.new
      emojiRect.x = pos.x
      emojiRect.y = pos.y
      emojiRect.width = fontEmoji.baseSize
      emojiRect.height = fontEmoji.baseSize
      if !CheckCollisionPointRec(mouse, emojiRect)
        DrawTextEx(fontEmoji, txt, pos, fontEmoji.baseSize.to_f, 1.0, $selected == i ? em.color : Fade(LIGHTGRAY, 0.4))
      else
        DrawTextEx(fontEmoji, txt, pos, fontEmoji.baseSize.to_f, 1.0, em.color)
        $hovered = i
        hoveredPos.set(pos.x, pos.y)
      end

      if (i != 0) && (i%EMOJI_PER_WIDTH == 0)
        pos.y += (fontEmoji.baseSize + 24.25)
        pos.x = 28.8
      else
        pos.x += (fontEmoji.baseSize + 28.8)
      end
    end

    # Draw the message when a emoji is selected
    if $selected != -1
      message = $emoji[$selected].message
      horizontalPadding = 20
      verticalPadding = 30

      font = fontDefault
      # Set correct font for asian languages
      font = fontAsian if TextIsEqual($messages[message].language, "Chinese") || TextIsEqual($messages[message].language, "Korean") || TextIsEqual($messages[message].language, "Japanese")

      # Calculate size for the message box (approximate the height and width)
      sz = MeasureTextEx(font, $messages[message].text, font.baseSize, 1.0)
      if sz.x > 300
        sz.y *= sz.x / 300
        sz.x = 300
      elsif sz.x < 160
        sz.x = 160
      end

      msgRect = Rectangle.new
      msgRect.x = selectedPos.x - 38.8
      msgRect.y = selectedPos.y
      msgRect.width = 2 * horizontalPadding + sz.x
      msgRect.height = 2 * verticalPadding + sz.y

      msgRect.y -= msgRect.height

      # Coordinates for the chat bubble triangle
      a = Vector2.create(selectedPos.x, msgRect.y + msgRect.height)
      b = Vector2.create(a.x + 8, a.y + 10)
      c = Vector2.create(a.x + 10, a.y)

      # Don't go outside the screen
      msgRect.x += 28 if msgRect.x < 10
      if msgRect.y < 10
        msgRect.y = selectedPos.y + 84
        a.y = msgRect.y
        c.y = a.y
        b.y = a.y - 10
        # Swap values so we can actually render the triangle :(
        a, b = b, a
      end
      if msgRect.x + msgRect.width > screenWidth
        msgRect.x -= (msgRect.x + msgRect.width) - screenWidth + 10
      end

      # Draw chat bubble
      DrawRectangleRec(msgRect, $emoji[$selected].color)
      DrawTriangle(a, b, c, $emoji[$selected].color)

      # Draw the main text message
      textRect = Rectangle.new
      textRect.x = msgRect.x + horizontalPadding/2
      textRect.y = msgRect.y + verticalPadding/2
      textRect.width = msgRect.width - horizontalPadding
      textRect.height = msgRect.height
      wordWrap = true
      DrawTextBoxed(font, $messages[message].text, textRect, font.baseSize.to_f, 1.0, wordWrap, WHITE)

      # Draw the info text below the main message
      # int size = (int)strlen(messages[message].text);
      # int length = GetCodepointCount(messages[message].text);
      info = TextFormat("%s %u characters %i bytes", :string, $messages[message].language, :uint, $messages[message].text.length, :int, $messages[message].text.bytesize)
      sz = MeasureTextEx(GetFontDefault(), info, 10, 1.0)
      pos = Vector2.create(textRect.x + textRect.width - sz.x,  msgRect.y + msgRect.height - sz.y - 2)
      DrawText(info, pos.x, pos.y, 10, RAYWHITE)
    end

    # Draw the info text
    DrawText("These emojis have something to tell you, click each to find out!", (screenWidth - 650)/2, screenHeight - 40, 20, GRAY)
    DrawText("Each emoji is a unicode character from a font, not a texture... Press [SPACEBAR] to refresh", (screenWidth - 484)/2, screenHeight - 16, 10, GRAY)
    EndDrawing()
  end

  UnloadFont(fontDefault)
  UnloadFont(fontAsian)
  UnloadFont(fontEmoji)
  CloseWindow()
end
