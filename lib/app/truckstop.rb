class Truckstop
  attr_accessor :name, :city, :address

  @@all = []

  def initialize(name, city, address)
    @name = name
    @address = address
    @city = city
    @@all << self
  end

  def self.all
    @@all
  end

  def self.print_all_truckstops
    counter = 0
    while counter < @@all.length - 1
      counter += 1
      puts @@all[counter].name
      puts @@all[counter].address
      puts @@all[counter].city
      puts ''
    end
  end

  def self.clear_truckstop_list
    @@all = []
    system 'clear'
    CLI.enter_state
  end

  def self.search_by(user_input)
    counter = -1
    # binding.pry
    while counter <= @@all.length - 2
      counter += 1
      if user_input == @@all[counter].city 
        puts @@all[counter].name
        puts @@all[counter].address
        puts ''
      end
    end
    CLI.search_by_city
  end
end
