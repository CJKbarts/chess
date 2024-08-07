module Serializable
  @@serializer = JSON

  def serialize
    obj = {}
    instance_variables.each do |var|
      obj[var] = instance_variable_get(var)
    end

    @@serializer.dump(obj)
  end

  def unserialize(string)
    obj = @@serializer.load(string)
    obj.each_key { |var| instance_variable_set(var, obj[var]) }
    self
  end
end
