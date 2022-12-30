class ScrapingController < ApplicationController
  def index
    agent = Mechanize.new
    # 取得したいページの取得
    page = agent.get("https://ev-database.org/")
    
    # image
    # image_elements = page.search('h2 a')
    # @images = []
    # image_elements.each do |ele|
    #   @images.push(ele.
    # end
    
    # title
    title_elements = page.search('h2 a')
    @titles = []
    title_elements.each do |ele|
      @titles.push(ele.inner_text)
    end
    
    # subtitle
    subtitle_elements = page.search('div .subtitle')
    @subtitles = []
    subtitle_elements.each do |ele|
      @subtitles.push(ele.inner_text)
    end
    
    # towweight
    towweight_elements = page.search('.towweight')
    @towweights = []
    towweight_elements.each do |ele|
      @towweights.push(ele.inner_text)
    end

    

    
  end
end
