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
    subtitle_elements.each_with_index do |ele, i|
      @tesla_data[i].push(ele.inner_text)
    end
    
    # towweight
    towweight_elements = page.search('.towweight')
    towweight_elements.each_with_index do |ele, i|
      @tesla_data[i].push(ele.inner_text)
    end

    # size
    # 取れてないやつあるっぽいので保留
    size_elements = page.search("span[@class*='size-']") 
    size_elements.each_with_index do |ele, i|
      @tesla_data[i].push(ele.inner_text)
    end

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

    # tags_elements = page.search('.left span')
    # 加速時間
    # tags_elements.each_with_index do |ele, i|
    #   if ele.inner_text.include?("0 - 100") 
    #     @tesla_data[i].push(ele.inner_text)
      
    #     binding.pry
        
    #   end
    # end

    # Germany price
    germany_price_elements = page.search('.country_de')
    germany_price_elements.each_with_index do |ele, i|
      @tesla_data[i].push(ele.inner_text)
    end
    # Netherland price
    netherland_price_elements = page.search('.country_nl')
    netherland_price_elements.each_with_index do |ele, i|
      @tesla_data[i].push(ele.inner_text)
    end
    # UK price
    uk_price_elements = page.search('.country_nl')
    uk_price_elements.each_with_index do |ele, i|
      @tesla_data[i].push(ele.inner_text)
    end

    @tesla_data = Kaminari.paginate_array(@tesla_data).page(params[:page]).per(50)

  end
end
