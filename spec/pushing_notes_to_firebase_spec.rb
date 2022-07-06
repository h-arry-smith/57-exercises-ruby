require_relative '../pushing_notes_to_firebase'

TIME_FREEZE = Time.now.to_s
EXAMPLE_DATA = [
  { id: 'testid', text: 'test note 1', date: TIME_FREEZE },
  { id: 'testid-2', text: 'test note 2', date: TIME_FREEZE }
]

RSpec.describe Notes do
  let(:api) { double }

  describe '#new' do
    it 'create an instance with the api dependancy injected' do
      notes = Notes.new(api)

      expect(notes).to have_attributes(api: api)
    end
  end

  describe '#load_notes' do
    it 'calls the api for notes and sets the notes to the returned array' do
      notes = Notes.new(api)

      expect(api).to receive(:get).with('notes').and_return(EXAMPLE_DATA)

      notes.load_notes

      expect(notes.notes).to eq([
        Note.new('testid', 'test note 1', TIME_FREEZE),
        Note.new('testid-2', 'test note 2', TIME_FREEZE)
      ])
    end
  end

  describe '#create_note' do
    it 'calls the api to create a note and adds the note to the notes array' do
      notes = Notes.new(api)
      expected_return = {id: 'test', text: 'test text', date: TIME_FREEZE}

      expect(api).to receive(:add).with('notes', { text: 'test text', date: TIME_FREEZE }).and_return(expected_return)

      notes.create_note('test text', TIME_FREEZE)

      expect(notes.notes).to eq([
        Note.new('test', 'test text', TIME_FREEZE)
      ])
    end
  end

  describe '#get_note' do
    it 'returns the note with the given id' do
      notes = Notes.new(api)
      notes.instance_variable_set(:@notes, [
        Note.new('testid', 'test note 1', TIME_FREEZE),
        Note.new('testid-2', 'test note 2', TIME_FREEZE)
      ])

      expect(notes.get_note('testid')).to eq(Note.new('testid', 'test note 1', TIME_FREEZE))
    end

    it 'returns notes when using a partial id' do
      notes = Notes.new(api)
      notes.instance_variable_set(:@notes, [
        Note.new('JedmOXVeWQcNqr3rHris', 'test note 1', TIME_FREEZE),
        Note.new('ThTAo6nnEoLr4fG2m0ok', 'test note 2', TIME_FREEZE)
      ])

      expect(notes.get_note('ThTAo6')).to eq(Note.new('ThTAo6nnEoLr4fG2m0ok', 'test note 1', TIME_FREEZE))
    end
  end

  describe '#delete_note' do
    it 'given the id of a note it will
 remove it from the notes array and call the api' do
      notes = Notes.new(api)
      notes.instance_variable_set(:@notes, [
        Note.new('testid', 'test note 1', TIME_FREEZE),
        Note.new('testid-2', 'test note 2', TIME_FREEZE)
      ])

      expect(api).to receive(:delete).with('notes', 'testid').and_return(:ok)

      notes.delete_note('testid')

      expect(notes.notes).to eq([Note.new('testid-2', 'test note 2', TIME_FREEZE)])
    end
  end

  describe '#update_note' do
    it 'given an exisiting note, can push those changes to the api' do
      notes = Notes.new(api)
      notes.instance_variable_set(:@notes, [
        Note.new('testid', 'test note 1', TIME_FREEZE),
        Note.new('testid-2', 'test note 2', TIME_FREEZE)
      ])

      expect(api).to receive(:update).with('notes', 'testid', { date: TIME_FREEZE, tags: [], text: "updated text" })

      notes.update_note('testid', text: 'updated text')
    end
  end
end

RSpec.describe Note do
  it 'has the right attributes in the struct' do
    note = Note.new('test-id', 'test-text', TIME_FREEZE)

    expect(note).to have_attributes(
      id: 'test-id',
      text: 'test-text',
      date: TIME_FREEZE
    )
  end

  it 'has an optional tags paramaters' do
    note = Note.new('test-id', 'test-text', TIME_FREEZE, ['one', 'two', 'three'])

    expect(note).to have_attributes(
      id: 'test-id',
      text: 'test-text',
      date: TIME_FREEZE,
      tags: ['one', 'two', 'three']
    )
  end

  it 'two notes are considered equal if their ids are equal' do
    note_one = Note.new('test-test-test', 'test text', TIME_FREEZE)
    note_two = Note.new('test-test-test', 'test text', TIME_FREEZE)

    expect(note_one == note_two).to be true
  end

  describe 'tags' do
    it 'add a single tag to the note' do
      note = Note.new('test-id', 'test-text', TIME_FREEZE)

      note.add_tag('test')

      expect(note.tags).to eq(['test'])
    end

    it 'add multiple tags at once to the note' do
      note = Note.new('test-id', 'test-text', TIME_FREEZE)

      note.add_tag('one', 'two', 'three')

      expect(note.tags).to eq(['one', 'two', 'three'])
    end

    it 'adding a tag twice doesnt produce a duplicate' do
      note = Note.new('test-id', 'test-text', TIME_FREEZE)

      note.add_tag('one', 'two', 'three')
      note.add_tag('one')
      note.add_tag('two', 'three', 'four')

      expect(note.tags).to eq(['one', 'two', 'three', 'four'])
    end

    it 'removes a tag from the list' do
      note = Note.new('test-id', 'test-text', TIME_FREEZE, ['one', 'two', 'three'])

      note.remove_tag('two')

      expect(note.tags).to eq(['one', 'three'])
    end
  end

  it 'fields returns the struct as a hashmap without the id' do
    note = Note.new('test-id', 'test-text', TIME_FREEZE, ['one', 'two', 'three'])
    expected = {
      text: 'test-text',
      date: TIME_FREEZE,
      tags: ['one', 'two', 'three']
    }

    expect(note.fields).to eq(expected)
  end
end
