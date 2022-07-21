require 'rom'
require 'rom'

class Questions < ROM::Relation[:sql]
  schema(infer: true)

  auto_struct(true)
end
