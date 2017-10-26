class Scraping
  
  require 'open-uri'
  require 'nokogiri'
  require 'mechanize'

    def self.book_urls
        agent = Mechanize.new
        links = []
        for num in 1..10 do
        url = "https://www.kinokuniya.co.jp/f/dsd---?p=#{num}&rpp=20&ptk=01&qsd=true&author-key=%E6%B1%A0%E4%BA%95%E6%88%B8%E3%80%80%E6%BD%A4"     
         links << url
        end
        
        set_url = []
        select_url = links[0]
        p select_url
        agent = Mechanize.new
        current_page = agent.get(select_url)
        elements = current_page.search('.listphoto a')
        p elements
            elements.each do |ele|
                if !(ele.get_attribute('href') == "") then
                    set_url = ele.get_attribute('href')
                    database(set_url)
                end        
            end
    end

    def self.database(link)
        p link
        agent = Mechanize.new
        current_page = agent.get(link)
        elements = current_page.search('//div[@class="right_box"]')
        
        elements.each do |node|
            p @bookname = node.css('h3').text
            p_author = node.css('li a').text
            p @author = p_author.gsub(/\r\n|【著】.*$|/,"")
            p @price = node.xpath('//span[@class="sale_price"]').text.gsub(/[^\d]/, "").to_i
            p_info = node.css('li').text.split[3]
            pre_publisher = p_info.scan(/\w+|[^\s\w]+/)
            @publisher = pre_publisher[0].gsub("（","")
            @published_date = (pre_publisher[1] + pre_publisher[3]).to_i
            p_image = node.xpath('//div[@class="left_box"]/p/a/img').attribute('src').value
            @image = p_image.gsub("..","")
            @summary = node.xpath('//div[@class="career_box"]/p').text
            @author_data = node.xpath('//div[@class="career_box"]/p[2]').text
        end
        
        record = Database.where(bookname: @bookname).first_or_initialize
        record.author = @author
        record.price = @price
        record.publisher = @publisher
        record.published_date = @published_date
        record.summary = @summary
        record.author_data = @author_data
        record.save
    end
end