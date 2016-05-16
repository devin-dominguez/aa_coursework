class ModelBase

  def self.find_by_id(id)
    class_str = self.we_are_silly
    info = QuestionsDatabase.instance.execute(<<-SQL, id: id)
      SELECT
        *
      FROM
        #{class_str}
      WHERE
        id = :id
    SQL

    raise "#{class_str} not found" if info.empty?
    self.new(info[0])
  end

  def self.all
    class_str = self.we_are_silly
    objects = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        #{class_str}
    SQL
    objects.map { |object_info| self.new(object_info) }
  end

  def self.create(options)
    new_object = self.new(options)
    new_object.save
    new_user
  end

  def self.we_are_silly
    class_str = (self == User) ? self.to_s + 's' : self.to_s
    class_str.downcase
  end

  def self.where(options)
    objects = self.all
    good_objects = []
    objects.each do |object|
      good_objects << object if object.instance_variables.any? do |param|
        (options[param.to_s[1..-1]] || options[param.to_s[1..-1].to_sym]) == object.instance_variable_get(param)
      end
    end

    good_objects
  end

end
