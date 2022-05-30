require_relative '../troubleshooting_cars.rb'

RSpec.describe DecisionTree do
  it 'has a yes branch, no branch and a question' do
    tree = DecisionTree.new('test question?', 1, 2)

    expect(tree.yes).to eq(1)
    expect(tree.no).to eq(2)
    expect(tree.question).to eq('test question?')
  end

  describe 'constructing decision tree from data structure' do
    it 'handles a decision with two answers' do
      structure = ['question one?', 'answer one', 'answer two']

      tree = DecisionTree.create(structure)

      expect(tree.question).to eq('question one?')
      expect(tree.yes.string).to eq('answer one')
      expect(tree.no.string).to eq('answer two')
    end

    it 'handles a structure with multiple questions' do
      structure = [
        'question one?',
        [
          'question two?',
          'answer one',
          'answer two'
        ],
        'answer three'
      ]

      tree = DecisionTree.create(structure)

      expect(tree.yes.question).to eq('question two?')
      expect(tree.yes.no.string).to eq('answer two')
    end

    it 'handles a complex nested tree' do
      structure = [
        'question one?',
        [
          'question two?',
          [
            'question three?',
            'answer one',
            'answer two'
          ],
          [
            'question four?',
            'answer three',
            'answer four'
          ]
        ],
        [
          'question five?',
          'answer five',
          'answer six'
        ]
      ]

      tree = DecisionTree.create(structure)

      expect(tree.yes.no.yes.string).to eq('answer three')
    end
  end
end

RSpec.describe Answer do
  it 'has an answer string' do
    answer = Answer.new('test answer')

    expect(answer.string).to eq('test answer')
  end
end

RSpec.describe 'checking the car' do
  it 'clean the terminals' do
    expect(CAR_TREE.yes.yes.string).to eq('Clean terminals and try starting again.')
  end

  it 'replace cables' do
    expect(CAR_TREE.yes.no.string).to eq('Replace cables and try again.')
  end

  it 'replace the battery' do
    expect(CAR_TREE.no.yes.string).to eq('Replace the battery.')
  end

  it 'check spark plugs' do
    expect(CAR_TREE.no.no.yes.string).to eq('Check spark plug connections.')
  end

  it 'choke' do
    expect(CAR_TREE.no.no.no.yes.no.string).to eq('Check to ensure the choke is opening and closing.')
  end

  it 'service' do
    expect(CAR_TREE.no.no.no.yes.yes.string).to eq('Get it in for a service.')
  end
end
