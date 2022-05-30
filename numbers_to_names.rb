class MonthMap
  attr_accessor :default

  def add(language, map)
    instance_variable_set("@#{language}", map.dup.prepend(nil))
    singleton_class.instance_eval { attr_reader language }
  end

  def [](month)
    raise NoDefaultSetError if @default.nil?

    instance_variable_get("@#{default}")[month]
  end
end

class NoDefaultSetError < StandardError
end
