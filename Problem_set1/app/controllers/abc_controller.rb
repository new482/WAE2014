class AbcController < ApplicationController

  def index
    require 'open-uri'
    require 'rubygems'
    require 'hpricot'

    html = Nokogiri::HTML(open("http://abc.go.com", :proxy => 'http://192.41.170.23:3128').read)
    @moviesList = html.xpath("//section[@id='secondaryContent']//article/div/a")
    @moviesList.each_with_index do |div,i|
      div.css("img").each do |link|
        link.attributes["src"].value = "http://static.east.abc.go.com/service/image/index/id/" + div.xpath("img/@data-properties").text.split("\"")[5] + "/dim/200.64x31.png"
      end
    end
  end
end
