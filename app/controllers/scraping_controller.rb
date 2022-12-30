class ScrapingController < ApplicationController
  def index
    agent = Mechanize.new
    # 取得したいページの取得
    page = agent.get("https://ev-database.org/")
    
    # title
    title_elements = page.search('h2 a')
    @titles = []
    tmp_titles = []
    title_elements.each do |ele|
      @titles.push(ele.inner_text)
    end
    @titles = Kaminari.paginate_array(@titles).page(params[:page]).per(50)
    
    # subtitle
    subtitle_elements = page.search('div .subtitle')
    @subtitles = []
    subtitle_elements.each do |ele|
      @subtitles.push(ele.inner_text)
    end
    
    # towweight
    # towweight_elements = page.search('.towweight')
    # @towweights = []
    # towweight_elements.each do |ele|
    #   @towweights.push(ele.inner_text)
    # end

    # size
    # size_elements = page.search('.size-d')
    # @size = []
    # size_elements.each do |ele|
    #   @size.push(ele.inner_text)
    # end

  end
end
