require 'rubygems'
require 'commander'
require_relative 'todo'

TODO = TodoDatabase.new('todo.db')

class MyApplication
  include Commander::Methods

  def run
    program :name, 'Todo List'
    program :version, '1.0.0'
    program :description, 'Simple todo list backed with SQLite'

    command :add do |c|
      c.syntax = 'todo add <task>'
      c.description = 'Adds a new task'
      c.action do |args, options|
        TODO.add(args.join(' '))
        say "Added new task succesfully."
      end
    end

    command :del do |c|
      c.syntax = 'todo del <id>'
      c.description = 'Deletes a task by ID'
      c.action do |args, options|
        id = args[0].to_i
        begin
          TODO.delete(id)
          say "Task {#{id}} deleted!"
        rescue TodoNotFound
          say "Task with this ID {#{id}} not found"
        end
      end
    end

    command :list do |c|
      c.syntax = 'todo list'
      c.description = 'Show all tasks in the database'
      c.action do |args, options|
        TODO.all.each { |task| say "#{task[:id]} [#{task[:complete] ? 'x' : ' '}] #{task[:task]}" }
      end
    end

    command :done do |c|
      c.syntax = 'todo done <id>'
      c.description = 'Mark a task as complete'
      c.action do |args, options|
        id = args[0].to_i
        begin
          TODO.complete(id)
          say "Well done!"
        rescue TodoNotFound
          say "Task with this ID {#{id}} not found"
        end
      end
    end

    command :tidy do |c|
      c.syntax = 'todo tidy'
      c.description = 'Remove all the complete tasks from the task list'
      c.action do |args, options|
        TODO.tidy_up
        say "Tidied up the todo list."
      end
    end

    run!
  end
end

MyApplication.new.run if $0 == __FILE__
