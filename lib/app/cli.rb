class CLI
  def self.run
    system 'clear'
    puts 'Welcome to the Truck Stop Locator CLI Program'.center(100)
    puts '============================================================='.center(100)
    puts ''
    CLI.enter_state
  end

  def self.enter_state
    puts 'Enter the current US state or Canadian province you are currently located in.'
    puts 'Please make sure to capitalize state/province.'
    @user_input = gets.chomp
    if @user_input == 'Hawaii'
      puts ''
      puts 'Only mainland states and provinces available.'
      puts ''
      CLI.enter_state
    elsif @user_input.length.positive?
      Scraper.first_scrape(@user_input)
    else
      puts 'No text entered.'
      puts ''
      CLI.enter_state
    end
  end

  def self.no_state_found(user_input)
    puts ''
    puts "'#{user_input}' not found."
    puts ''
    CLI.enter_state
    return
  end

  def self.no_city_found(user_input)
    puts ''
    puts "'#{user_input}' not found."
    puts ''
    CLI.enter_state
    return
  end

  def self.exit
    system 'clear'
    return
  end

  def self.user_choice(user_input)
    system 'clear'
    puts "Truckstops located in #{user_input}.".center(100)
    puts '===================================='.center(100)
    puts 'What would you like to do?'
    puts ''
    puts '1. View list of all truck stops in selected state.'
    puts '2. Search by city.'
    puts '3. select a new state.'
    puts '4. Exit program.'
    @user_input = gets.chomp
    if @user_input == '1'
      CLI.view_all_truckstops(user_input)
      return
    elsif @user_input == '2'
      CLI.search_by_city
      return
    elsif @user_input == '3'
      Truckstop.clear_truckstop_list
      return
    elsif @user_input == '4'
      CLI.exit
      return
    else
      CLI.user_choice(user_input)
      return
    end
  end

  def self.view_all_truckstops(user_input)
    system 'clear'
    puts "Truckstops located in #{user_input}.".center(100)
    puts '===================================='.center(100)
    puts ''
    Truckstop.print_all_truckstops
    puts 'Enter "1" to re-enter state.'
    puts 'Enter "2" to go back.'
    @user_input = gets.chomp
    if @user_input == '1'
      Truckstop.clear_truckstop_list
      return
    elsif @user_input == '2'
      CLI.user_choice(user_input)
      return
    else
      CLI.view_all_truckstops(user_input)
      return
    end
  end

  def self.search_by_city
    puts ''
    puts 'Enter name of city or enter "1" to select a new state/province.'
    puts ''
    @user_input = gets.chomp
    if @user_input.length.positive? && @user_input != '1'
      system 'clear'
      puts "Truck stops located in #{@user_input}.".center(100)
      puts '======================================='.center(100)
      puts ''
      Truckstop.search_by(@user_input)
      return
    elsif @user_input.length.positive? && @user_input == '1'
      system 'clear'
      Truckstop.clear_truckstop_list
      return
    else
      puts 'No text entered.'
      puts ''
      CLI.search_by_city
      return
    end
  end
end
