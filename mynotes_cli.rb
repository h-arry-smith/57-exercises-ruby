#!/usr/bin/env ruby
require 'gli'
require_relative 'pushing_notes_to_firebase'

PROJECT_ID = 'mynotes-79a91'
CREDENTIALS = 'secrets/mynotes.json'

class App
  extend GLI::App

  pre do 
    $api = FirebaseAPI.new(PROJECT_ID, CREDENTIALS)
    $notes = Notes.new($api)
    $notes.load_notes
  end

  command :show do |c|
    c.action do 
      $notes.notes.each { |note| puts note }
    end
  end

  command :new do |c|
    c.action do |_global_options, _options, args|
      text = args.first

      puts $notes.create_note(text, Time.now)
    end
  end

  command :delete do |c|
    c.action do |_global_options, _options, args|
      id = args.first

      $notes.delete_note(id)

      puts "Removed Note #{id}"
    end
  end

  command :tag do |c|
    c.action do |_global_options, _options, args|
      id = args.first

      puts $notes.add_tags_and_update(id, args[1..])
    end
  end
end

exit App.run(ARGV)
