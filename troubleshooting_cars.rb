class DecisionTree
  attr_reader :yes, :no, :question

  def initialize(question, yes, no)
    @question = question
    @yes = yes
    @no = no
  end

  def self.create(structure)
    yes = create_tree_or_answer(structure[1])
    no = create_tree_or_answer(structure[2])

    new(structure[0], yes, no)
  end

  def self.create_tree_or_answer(struct)
    if struct.is_a? Array
      create(struct)
    else
      Answer.new(struct)
    end
  end
end

Answer = Struct.new(:string) do
end

CAR_TREE = DecisionTree.create [
  'Is the car silent when you turn the key?',
  [
    'Are the battery terminals corroded?',
    'Clean terminals and try starting again.',
    'Replace cables and try again.'
  ],
  [
    'Does the car make a clicking noise?',
    'Replace the battery.',
    [
      'Does the car crank up but fail to start?',
      'Check spark plug connections.',
      [
        'Does the engine start and then die?',
        [
          'Does your car have fuel injection?',
          'Get it in for a service.',
          'Check to ensure the choke is opening and closing.'
        ],
        nil
      ]
    ]
  ]
]
