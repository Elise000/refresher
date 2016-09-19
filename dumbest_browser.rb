require 'net/http'
require 'nokogiri'
require 'uri'

class Browser

  def run!
    puts "Please input the url of the website you want to browse: "
    url = gets.chomp

    page = Page.new(url)
    page.fetch!

    puts "Enter 'title' to view the webpage title"
    puts "Enter 'link' to view the webpage link"


    answer = gets.chomp
      if answer == 'title'
        puts page.title
      elsif answer == 'link' 
        puts page.links
      elsif
        answer == 'exit'
        exit
      end
   
      
    end

end

class Page
  def initialize(url)
    @url = url
    @html = ""
  end

  def fetch!
    parsed_url = URI.parse(@url)
    response = Net::HTTP.get(parsed_url)
    @html = Nokogiri::HTML(response)
  end

  def title
    @html.at_css('title').text
  end

  def links
    links = @html.css('a')
    links.map {|link| link[:href]}
  end

end

Browser.new.run!