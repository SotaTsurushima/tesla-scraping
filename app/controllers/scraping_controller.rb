class ScrapingController < ApplicationController
  def index
    agent = Mechanize.new
    # 取得したいページの取得
    page = agent.get("https://ev-database.org/")
    
    # title
    @tesla_data = []
    title_elements = page.search('h2 a')
    title_elements.each do |ele|
      @tesla_data.push([ele.inner_text])
    end
  
    # subtitle
    subtitle_elements = page.search('div .subtitle')
    push_text_with_index(subtitle_elements)
    
    # towweight
    towweight_elements = page.search('.towweight')
    push_text_with_index(towweight_elements)


    # size
    size_elements = page.search("span[@class*='size-']") 
    push_text_with_index(size_elements)


    # number_of_seats
    # number_of_seats_elements = page.search("span[title*='Number of seats']")
    
    # count = 0
    # number_of_seats_elements.each_with_index do |ele|
    #   if ele.inner_text.present?
    #     count += 1
    #     @tesla_data[count].push(ele.inner_text)
    #     binding.pry
    #   end
    #   p count
    # end

    tags_elements = page.search('.left .tag')
    acceleration_elements = page.search('.left .acceleration')
    top_speed_elements = page.search('.left .topspeed')
    driving_distance_elements = page.search('.left .erange_real')
    efficiency_elements = page.search('.left .efficiency')
    fastcharge_elements = page.search('.left .fastcharge_speed_print')
    
    # 加速時間
    push_left_text(tags_elements, "0 - 100")
    push_left_text(acceleration_elements, "sec")
    # 最高速度
    push_left_text(tags_elements, "Top Speed")
    push_left_text(top_speed_elements, "km/h")
    # 走行可能距離
    push_left_text(tags_elements, "Range")
    push_left_text(driving_distance_elements, "km")
    # 燃費？
    push_left_text(tags_elements, "Efficiency")
    push_left_text(efficiency_elements, "Wh/km")
    # 充電速度
    push_left_text(tags_elements, "Fastcharge")
    push_left_text(fastcharge_elements, "km/h")


    # Germany price
    germany_price_elements = page.search('.country_de')
    push_text_with_index(germany_price_elements)
 
    # Netherland price
    netherland_price_elements = page.search('.country_nl')
    push_text_with_index(netherland_price_elements)

    # UK price
    uk_price_elements = page.search('.country_nl')
    push_text_with_index(uk_price_elements)

    @tesla_data = Kaminari.paginate_array(@tesla_data).page(params[:page]).per(50)

  end

  def push_left_text(elements, text)
    count = 0
    
    elements.each do |ele|
      if ele.inner_text.include?(text) 
        @tesla_data[count].push(ele.inner_text)
        count += 1
      end
    end
  end

  def push_text_with_index(elements)
    elements.each_with_index do |ele, i|
      @tesla_data[i].push(ele.inner_text)
    end
  end
end
