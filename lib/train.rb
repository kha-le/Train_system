class Train
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    all_trains = DB.exec("SELECT * FROM trains;")
    trains_list = []
    all_trains.each() do |train|
      name = train.fetch('name')
      id = train.fetch('id').to_i()
      trains_list.push(Train.new({:name => name, :id => id}))
    end
  trains_list
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end


  define_singleton_method(:find) do |identification|
    found_train = nil
    Train.all().each() do |train|
      if train.id() == identification
        found_train = train
      end
    end
    found_train
  end

  define_method(:==) do |another_train|
    self.name().==(another_train.name())
  end
end
