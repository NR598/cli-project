class Scraper
  def self.first_scrape(user_input)
    @main_url = 'https://www.allstays.com/c/truck-stop-locations.htm'
    html = open(@main_url)
    html_parsed = Nokogiri::HTML(html)
    scrape = html_parsed.css('a[class="mapside button"]')
    scrape.each do |element|
      @state_name = element.children.text
      @state_url = element['href'].insert(0, 'https:')
      if user_input == @state_name
        second_scrape(@state_url, user_input)
        return
      end
    end
    if @state_name != user_input
      CLI.no_state_found(user_input)
    end
  end

  def self.second_scrape(state_url, user_input)
    html = open(@state_url)
    html_parsed = Nokogiri::HTML(html) 
    city_scrape = html_parsed.css('h4')
    name_scrape = html_parsed.css('a[class="full-width button"]')[2..-1]
    address_scrape = html_parsed.xpath('/html/body/div[2]/div/div[1]/text()')[6..-1]
    name_counter = -1
    address_counter = -2
    city_counter = -1
    while city_counter < city_scrape.length - 6
      city_counter += 1
      name_counter += 1
      address_counter += 2
      truckstop_city = city_scrape[city_counter].text
      truckstop_name = name_scrape[name_counter].text
      truckstop_address = address_scrape[address_counter].text
      truckstop = Truckstop.new(truckstop_name, truckstop_city, truckstop_address)
    end
    CLI.user_choice(user_input)
    return
  end
end
