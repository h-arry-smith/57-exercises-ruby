require_relative '../paint_calculator'

RSpec.describe PaintCalculator do
  it 'calculates area to gallons correctly' do
    expect(PaintCalculator.area_to_gallons(350)).to eq(2)
  end
  
  it 'calculates gallons of paint for a rectangular room' do
    expect(PaintCalculator.rectangular_room(35, 10)).to eq(2)
  end

  it 'calculates gallons of paint for a circular room' do
    expect(PaintCalculator.circular_room(35)).to eq(16)
  end

  it 'calculates gallons of paint for an L shaped room' do
    expect(PaintCalculator.l_shaped_room(35, 10, 25, 20)).to eq(4)
  end
end
