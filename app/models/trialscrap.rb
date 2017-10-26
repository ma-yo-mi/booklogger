class Trialscrap


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
        # binding.pry
            elements.each do |ele|
                if !(ele.get_attribute('href') == "") then
                    set_url = ele.get_attribute('href')
                    database(set_url)
                end        
            end
    end


    def self.database(link)
        p link
        data = []
        agent = Mechanize.new
        current_page = agent.get(link)
        elements = current_page.search('//div[@class="right_box"]')
        # p elements
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
        # binding.pry
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
    
    
    # perdata = {bookname: bookname, price: price, author: author, published_date: published_date, publisher: publisher, image: image, summary: summary, author_data: author_data}
    # data << perdata
    # database = Database.create(bookname: bookname, price: price, author: author, published_date: published_date, publisher: publisher, image: image, summary: summary, author_data: author_data)








#   def self.books
#   Book.all.destroy_all
#   data = []
#   url = 'https://www.kinokuniya.co.jp/disp/CKnRankingPageCList.jsp?dispNo=107002001002&vTp=m'
#   charset = nil
#   html =open(url) do |f|
#     charset =f.charset
#     f.read
#   end
  
#   doc = Nokogiri::HTML.parse(html, nil,charset)
#     doc.xpath('//div[@class="list_area rankingList clearfix pb20"]').each do |node|
#       #ranking
#       ranking = node.css('div[@class="rankingLabel"]').inner_text.gsub(/[^\d]/, "").to_i
#       # title
#       title = node.css('h3').text.gsub(/\r\n/,"").strip!
#       # price
#       price = node.css('span[@class="sale_price mr10"]').text.gsub(/[^\d]/, "").to_i
#       #author
#       author = node.css('p').text.gsub(/\r\n|【著】|/,"").strip!
#       # publish date & publisher
#       p_info = node.css('ul[@class="mb05"]/li').first.inner_text
#         pre_date = p_info.scan(/\w+|[^\s\w]+/)
#         published_date = (pre_date[1] + pre_date[3]).to_i
#         pre_publisher = p_info.scan(/\w+|[^\s\w]+/)
#         publisher = pre_publisher[0].gsub("（","")
#       # #image
#       p_image = node.css('div[@class="listphoto clearfix"]/a img').attr('src').value
#       image = p_image.gsub("..","")
#       book = {ranking: ranking, title: title, price: price, author: author, published_date: published_date, publisher: publisher, image: image}
#       data << book
#       product = Book.create(ranking: ranking, bookname: title, price: price, author: author, published_date: published_date, publisher: publisher, image: image)
#     end
#   end
  
#   def self.database
#   data = []
#   url = 'https://www.kinokuniya.co.jp/disp/CSfDispListPage_001.jsp?qsd=true&ptk=01&gtin=&q=&title=&author-key=&publisher-key=&pubdateStart=201709&pubdateEnd=201709&thn-cod-b=13&ndc-dec-key=&rpp=20&SEARCH.x=55&SEARCH.y=22'
#   charset = nil
#   html =open(url) do |f|
#     charset =f.charset
#     f.read
#   end
  
#   doc = Nokogiri::HTML.parse(html, nil,charset)
#     doc.xpath('//div[@class="list_area clearfix pb10"]').each do |node|
#       bookname = node.css('h3').text.gsub(/\r\n/,"").strip!
#       author = node.css('p').text.gsub(/\r\n|【著】|/,"").strip!
#       price = node.css('span[@class="sale_price"]').text.gsub(/[^\d]/, "").to_i
#       p_info = node.css('ul[@class="mb05"]/li').first.inner_text
#         pre_date = p_info.scan(/\w+|[^\s\w]+/)
#         published_date = (pre_date[1] + pre_date[3]).to_i
#         pre_publisher = p_info.scan(/\w+|[^\s\w]+/)
#         publisher = pre_publisher[0].gsub("（","")
#       p_image = node.css('div[@class="listphoto clearfix"]/a img').attr('src').value
#       image = p_image.slice(0..1)
        
#     book = {bookname: bookname, price: price, author: author, published_date: published_date, publisher: publisher, image: image}
#     Database.create(book)
#       data << book
#     end
#   end
  
#   def self.scrap_info
#      data = []
#     agent = Mechanize.new
#     summary = agent.get("https://www.kinokuniya.co.jp/f/dsg-01-9784167909178").search('p')
#     author_data = agent.get("https://www.kinokuniya.co.jp/f/dsg-01-9784167909178").search('p[4]')
#   end
#     detail = Database.new(summary: summary, author_data: author_data)
#     detail.save
#   end
# end
