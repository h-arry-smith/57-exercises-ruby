require_relative '../validation'

class ExampleValidationRule
  include ValidationRule

  def initialize(n)
    @n = n
  end

  def test(data)
    data == @n
  end

  def error_string
    "not equal to #{@n}"
  end
end

class LessThanTen
  include ValidationRule

  def test(data)
    data < 10
  end

  def error_string
    "not less than 10"
  end
end

class BadValidationRule
  include ValidationRule
end

RSpec.describe Validator do
  it 'create a validator with a validation map' do
    map = { key_one: ExampleValidationRule.new(1), key_two: ExampleValidationRule.new(2) }

    validator = Validator.new(map)

    expect(validator.map).to eq(map)
  end

  it 'returns ok with valid data if all validation rules have been met' do
    data = { key_one: 1, key_two: 2 }
    map = { key_one: ExampleValidationRule.new(1), key_two: ExampleValidationRule.new(2) }
    validator = Validator.new(map)

    expect(validator.validate(data)).to eq([:ok, {
      data: data,
      errors: {}
    }])
  end

  it 'returns error status with appropriate errors messages if validation rules not met' do
    data = { key_one: 1, key_two: 3 }
    map = { key_one: ExampleValidationRule.new(1), key_two: ExampleValidationRule.new(2) }
    validator = Validator.new(map)

    expect(validator.validate(data)).to eq([:error, {
      data: { key_one: 1 },
      errors: { key_two: ['not equal to 2']}
    }])
  end

  it 'when there are multiple validation rules and all are satisfied will return ok' do
    data = { key_one: 1 }
    map = { key_one: [ExampleValidationRule.new(1), LessThanTen.new]}
    validator = Validator.new(map)

    expect(validator.validate(data)).to eq([:ok, {
      data: { key_one: 1 },
      errors: {}
    }])
  end
end


RSpec.describe ValidationRule do
  it 'returns true for data that is correct' do
    rule = ExampleValidationRule.new(1)

    expect(rule.validate(1)).to eq([:ok, 1])
  end

  it 'returns an error with its error string if incorrect' do
    rule = ExampleValidationRule.new(1)

    expect(rule.validate(2)).to eq([:error, 'not equal to 1'])
  end

  it 'raises NotImplementedError for methods that need to be implemented' do
    rule = BadValidationRule.new

    expect { rule.validate(2) }.to raise_error(NotImplementedError)
  end
end

RSpec.describe MustBeFilledIn do
  it 'returns true if key is present' do
    rule = MustBeFilledIn.new

    expect(rule.validate('test')).to eq([:ok, 'test'])
  end

  it 'returns false if key is not present' do
    rule = MustBeFilledIn.new

    expect(rule.validate('')).to eq([:error, 'must be filled in'])
    expect(rule.validate(nil)).to eq([:error, 'must be filled in'])
  end
end

RSpec.describe AtLeastNChars do
  it 'returns ok if greater than or equal to n chars' do
    rule = AtLeastNChars.new(4)

    expect(rule.validate('abcd')).to eq([:ok, 'abcd'])
    expect(rule.validate('abcde')).to eq([:ok, 'abcde'])
  end

  it 'returns error if not greater than or equal to n chars' do
    rule = AtLeastNChars.new(4)

    expect(rule.validate('abc')).to eq([:error, 'must be atleast 4 chars'])
  end
end

RSpec.describe EmployeeBadgeFormat do
  it 'returns ok if format of employee badge' do
    rule = EmployeeBadgeFormat.new

    expect(rule.validate('DF-1212')).to eq([:ok, 'DF-1212'])
  end

  it 'returns error if not correct format' do
    rule = EmployeeBadgeFormat.new

    expect(rule.validate('ABC-DEF-123')).to eq([:error, 'incorrect badge format'])
  end
end

RSpec.describe IsANumber do
  it 'returns ok if is a number' do
    rule = IsANumber.new

    expect(rule.validate(12345)).to eq([:ok, 12345])
  end

  it 'returns error if is not a number' do
    rule = IsANumber.new

    expect(rule.validate('12345')).to eq([:error, 'not a number'])
  end
end

RSpec.describe EmployeeValidator do
  it 'returns ok for correctly formatted employee information' do
    data = {
      first_name: 'Harry',
      last_name: 'Smith',
      employee_id: 'HS-1234',
      zip_code: 44345
    }

    expect(EmployeeValidator.validate(data)).to eq([:ok, {
      data: data,
      errors: {}
    }])
  end

  it 'returns every error message if not right' do
    data = {
      first_name: '',
      last_name: '',
      employee_id: '123-456-abc',
      zip_code: 'not-a-zip-code'
    }

    expect(EmployeeValidator.validate(data)).to eq([:error, {
      data: {},
      errors: {
        first_name: ['must be filled in', 'must be atleast 2 chars'],
        last_name: ['must be filled in', 'must be atleast 2 chars'],
        employee_id: ['incorrect badge format'],
        zip_code: ['not a number']
      }
    }])
  end
end
