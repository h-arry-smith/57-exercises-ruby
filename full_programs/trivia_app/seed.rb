require 'rom'
require_relative 'question_repo'

rom = ROM.container(:sql, 'sqlite://questions.db') do |conf|
  require_relative 'questions'

  conf.register_relation(Questions)
end

QR = QuestionRepo.new(rom)

def seed
  # Easy
  QR.create(
    question: 'What is my favourite animal?',
    answer: 'Dog',
    wrong_answer_one: 'Cat',
    wrong_answer_two: 'Moose',
    category: 'Personal',
    difficulty: 1
  )
  QR.create(
    question: 'Which football team is the best?',
    answer: 'Liverpool',
    wrong_answer_one: 'Manchester',
    wrong_answer_two: 'Arsenal',
    category: 'Sports',
    difficulty: 1
  )
  QR.create(
    question: 'Which animal makes milk we mostly drink?',
    answer: 'Cow',
    wrong_answer_one: 'Giraffe',
    wrong_answer_two: 'Pigeon',
    category: 'Farming',
    difficulty: 1
  )
  QR.create(
    question: 'What is a cocktail made from sugar, whiskey, and angostura bitters?',
    answer: 'Old Fashioned',
    wrong_answer_one: 'Negroni',
    wrong_answer_two: 'Woo Woo',
    category: 'Food and Drinks',
    difficulty: 1
  )
  QR.create(
    question: 'What is kombucha made from?',
    answer: 'Tea',
    wrong_answer_one: 'Meat',
    wrong_answer_two: 'Leaves',
    category: 'Sports',
    difficulty: 1
  )
  QR.create(
    question: 'What noise does a duck make?',
    answer: 'Quack',
    wrong_answer_one: 'Moo',
    wrong_answer_two: 'Woof',
    category: 'Farming',
    difficulty: 1
  )

  # Intermediate
  QR.create(
    question: 'What city is the biggest?',
    answer: 'London',
    wrong_answer_one: 'Salisbury',
    wrong_answer_two: 'York',
    category: 'Britain',
    difficulty: 2
  )
  QR.create(
    question: 'What is the fifth letter of the alphabet?',
    answer: 'E',
    wrong_answer_one: 'Z',
    wrong_answer_two: 'H',
    category: 'Spelling',
    difficulty: 2
  )
  QR.create(
    question: 'How many burgers are in a big mac?',
    answer: 'One',
    wrong_answer_one: 'Two',
    wrong_answer_two: 'You cant count them',
    category: 'Food',
    difficulty: 2
  )
  QR.create(
    question: 'What is the purpose of bacon in a bacon sandwich?',
    answer: 'The filling',
    wrong_answer_one: 'The bread',
    wrong_answer_two: 'The sauce',
    category: 'Food',
    difficulty: 2
  )

  # Hard
  QR.create(
    question: 'Whats eight plus nine plus ten minus 4?',
    answer: 'Twenty Three',
    wrong_answer_one: 'Nineteen',
    wrong_answer_two: 'Thirty eight',
    category: 'Mathematic',
    difficulty: 3
  )
  QR.create(
    question: 'Whats the second best thing to put in tea?',
    answer: 'Sugar',
    wrong_answer_one: 'Biscuits',
    wrong_answer_two: 'A Straw',
    category: 'British',
    difficulty: 3
  )
end
