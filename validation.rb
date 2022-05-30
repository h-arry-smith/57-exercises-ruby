class Validator
  attr_reader :map

  def initialize(map)
    @map = map
  end

  def validate(data)
    status = :ok
    validated_map = {
      data: {},
      errors: {},
    }

    data.each_pair do |key, value|
      validators = @map[key]

      if validators.is_a? Array
        (valid, data) = validate_all(value, validators)
      else
        (valid, data) = validators.validate(value)
      end

      if valid == :ok
        validated_map[:data][key] = data
      else
        data = [data] if !data.is_a? Array

        validated_map[:errors][key] = data
        status = :error
      end
    end

    [status, validated_map]
  end

  private

  def validate_all(value, validators)
    errors = []

    validators.each do |rule|
      (valid, data) = rule.validate(value)

      if valid == :error
        errors << data
      end
    end

    if errors.empty?
      [:ok, value]
    else
      [:error, errors]
    end
  end
end

module ValidationRule
  def validate(data)
    if test(data)
      [:ok, data]
    else
      [:error, error_string]
    end
  end

  def test(_data)
    raise NotImplementedError
  end

  def error_string
    raise NotImplementedError
  end
end

class MustBeFilledIn
  include ValidationRule

  def test(data)
    return false if data.nil?

    !data.empty?
  end

  def error_string
    'must be filled in'
  end
end

class AtLeastNChars
  include ValidationRule

  def initialize(n)
    @n = n
    super()
  end

  def test(data)
    data.length >= @n
  end

  def error_string
    "must be atleast #{@n} chars"
  end
end

class EmployeeBadgeFormat
  include ValidationRule

  def test(data)
    data.match?(/[A-Z][A-Z]-\d{4}/)
  end

  def error_string
    'incorrect badge format'
  end
end

class IsANumber
  include ValidationRule

  def test(data)
    data.is_a? Numeric
  end

  def error_string
    'not a number'
  end
end

EmployeeValidator = Validator.new({
  first_name: [MustBeFilledIn.new(), AtLeastNChars.new(2)],
  last_name: [MustBeFilledIn.new(), AtLeastNChars.new(2)],
  employee_id: [EmployeeBadgeFormat.new],
  zip_code: [IsANumber.new]
})
