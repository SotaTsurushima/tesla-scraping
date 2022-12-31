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
    size_elements = page.search('.size-d')
    size_elements.each_with_index do |ele, i|
      @tesla_data[i].push(ele.inner_text)
    end

    @tesla_data = Kaminari.paginate_array(@tesla_data).page(params[:page]).per(50)

  end
end
