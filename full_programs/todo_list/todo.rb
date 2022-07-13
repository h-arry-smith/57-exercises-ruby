require 'sequel'

class TodoDatabase
  attr_reader :db, :todos

  def initialize(path)
    @db = Sequel.sqlite(path)
    @todos = @db[:todos]

    initialize_database unless @db.table_exists?(:todos)
  end

  def all
    @todos.all
  end

  def get(id)
    task = @todos.where(id: id)
    raise TodoNotFound if task.empty?

    task
  end

  def add(task)
    @todos.insert(
      task: task,
      created_at: Time.now,
      complete: false
    )
  end

  def complete(id)
    task = get(id)

    task.update(complete: true)
  end

  def delete(id)
    task = get(id)

    task.delete
  end

  def tidy_up
    @todos.where(complete: true).delete
  end

  private

  def initialize_database
    @db.create_table :todos do
      primary_key :id
      DateTime :created_at
      String :task, text: true
      Boolean :complete
    end
  end
end

class TodoNotFound < StandardError
end
