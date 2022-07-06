# Implementation Strategy
# 1. [x] Create firebase database with scheme for basic notes features w/ tags ️
# 2. [ ] Create notes backend object that interacts with FirebaseAPI (mocked out for tests)
#          - [x] set up client with the api
#          - [x] get existing notes from server
#          - [x] create notes
#          - [x] show notes
#          - [x] delete notes
#          - [x] tag notes
# 3. [x] Implement FirebaseAPI object that upholds contract from testing (no tests?)
# 4. [ ] Create CLI front end which interacts with notes backend (mocked out for tests)
#          - [ ] new / show / delete / tag commands
#          - [ ] show [tag]
require 'set'
require 'google/cloud/firestore'

class Notes
  attr_reader :api, :notes

  def initialize(api)
    @api = api
    @notes = []
  end

  def load_notes
    notes = @api.get('notes')

    @notes = notes.map { |note| note_from_data(note) }
  end

  def create_note(text, date)
    note = @api.add('notes', { text: text, date: date })

    new_note = note_from_data(note)
    @notes << new_note
    new_note
  end

  def delete_note(id)
    note = get_note(id)
    result = @api.delete('notes', note.id)

    @notes.reject! { |n| n.id == note.id } if result == :ok
  end

  def get_note(id)
    @notes.find { |note| note.id.start_with?(id) }
  end

  def update_note(id, **fields)
    note = get_note(id)

    fields.each_pair { |key, value| note[key] = value }

    api.update('notes', id, note.fields)
    note
  end

  def add_tags_and_update(id, tags)
    note = get_note(id)

    note.add_tag(*tags)

    update_note(note.id)
  end

  private

  def note_from_data(note)
    Note.new(note[:id], note[:text], note[:date], note[:tags])
  end
end

class Note
  attr_reader :id, :text, :date

  def initialize(id, text, date, tags = [])
    @id = id
    @text = text
    @date = date
    @tags = Set.new

    add_tag(*tags) unless tags.nil?
  end

  def ==(other)
    @id == other.id
  end

  def []=(key, value)
    self.instance_variable_set(:"@#{key}", value)
  end

  def tags
    @tags.to_a
  end

  def add_tag(*tags)
    tags.each { |tag| @tags.add(tag) }
  end

  def remove_tag(tag)
    @tags.delete(tag)
  end

  def fields
    hash = {}

    instance_variables.each { |var| hash[var.to_s.delete('@').to_sym] = instance_variable_get(var) }

    hash[:tags] = @tags.to_a
    hash.delete(:id)
    hash
  end

  def to_s
    "#{@id[0...6]} | #{pretty_date} | #{@text} | #{@tags.join(',')}"
  end

  private

  def pretty_date
    @date.strftime("%d/%m/%y")
  end
end

class FirebaseAPI
  def initialize(project_id, credentials)
    Google::Cloud::Firestore.configure do |config|
      config.project_id = project_id
      config.credentials = credentials
    end

    @client = Google::Cloud::Firestore.new
  end

  def get(col)
    fb_doc = @client.col col

    fb_doc.get.map { |item| {**item.fields, id: item.document_id} }
  end

  def add(col, fields)
    fb_doc = @client.col col

    new_doc = fb_doc.add(fields)

    {id: new_doc.document_id, **fields}
  end

  def delete(col, id)
    @client.doc("#{col}/#{id}").delete
    :ok
  end

  def update(col, id, fields)
    @client.doc("#{col}/#{id}").set(fields, merge: true)
  end
end
