def password_strength(password)
  strength = 0

  strength += 1 if password.match?(/[a-zA-Z]+/)
  strength += 1 if password.length > 8
  strength += 1 if password.match?(/[a-zA-Z]+/) && password.match?(/\d+/)
  strength += 1 if password.match?(/[!#&*^%$£@]/)

  strength
end
