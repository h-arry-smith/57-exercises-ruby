require_relative '../rectangular_room'

RSpec.describe Room do
  it 'can create a room with feet dimensions' do
    room = Room.new(15, 20)

    expect(room.width).to eq(15)
    expect(room.height).to eq(20)
  end

  it 'rejects non numerics values' do
    expect { Room.new('a', 100) }.to raise_exception(ArgumentError)
    expect { Room.new(100, 'a') }.to raise_exception(ArgumentError)
  end

  context 'when using feet' do
    it 'calculates the square footage of a room' do
      room = Room.new(15, 20)

      expect(room.square_footage).to eq(300)
    end

    it 'calculates the square meterage of a room' do
      room = Room.new(15, 20)

      expect(room.square_meterage).to eq(27.871)
    end
  end

  context 'when using meters' do
    it 'calculates the square footage of a room' do
      room = Room.new(5, 10, :m)

      expect(room.square_footage).to eq(538.196)
    end

    it 'calculates the square meterage of a room' do
      room = Room.new(5, 10, :m)

      expect(room.square_meterage).to eq(50)
    end
  end
end
