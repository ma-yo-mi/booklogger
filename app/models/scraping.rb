class Scraping

  require 'open-uri'
  require 'nokogiri'
  require 'mechanize'


  def self.books
    data = []
  url = 'https://www.kinokuniya.co.jp/disp/CKnRankingPageCList.jsp?dispNo=107002001002&vTp=m'
  charset = nil
  html =open(url) do |f|
    charset =f.charset
    f.read
  end
  doc = Nokogiri::HTML.parse(html, nil,charset)
    doc.xpath('//div[@class="list_area rankingList clearfix pb20"]').each do |node|
      #ranking
      ranking = node.css('div[@class="rankingLabel"]').inner_text.gsub(/[^\d]/, "").to_i
      # title
      title = node.css('h3').text.gsub(/\r\n/,"").strip!
      # price
      price = node.css('span[@class="sale_price mr10"]').text.gsub(/[^\d]/, "").to_i
      # #author
      author = node.css('p').text.gsub(/\r\n|【著】|/,"").strip!
      # # publish date & publisher
      p_info = node.css('ul[@class="mb05"]/li').first.inner_text
        pre_date = p_info.scan(/\w+|[^\s\w]+/)
        published_date = (pre_date[1] + pre_date[3]).to_i
        pre_publisher = p_info.scan(/\w+|[^\s\w]+/)
        publisher = pre_publisher[0].gsub("（","")
      # #image
      image = node.css('div[@class="listphoto clearfix"]/a img').attr('src').value

    book = {ranking: ranking, title: title, price: price, author: author, published_date: published_date, publisher: publisher, image: image}
    data << book


    product = Book.create(ranking: ranking, bookname: title, price: price, author: author, published_date: published_date, publisher: publisher, image: image)
    end
  end


  def self.database
    links = []
    agent = Mechanize.new
    next_url = ""
    while true
      current_page = agent.get("https://www.kinokuniya.co.jp/disp/CSfDispListPage_001.jsp?qsd=true&ptk=01&gtin=&q=&title=&author-key=&publisher-key=&pubdateStart=201709&pubdateEnd=&thn-cod-b=13&ndc-dec-key=&rpp=100&SEARCH.x=51&SEARCH.y=26" + next_url)
      elements = current_page.search('.heightLine-2 a')
      elements.each do |ele|
        links << ele.get_attribute('href')
      end

     next_link = current_page.at('.newColor a')
     break unless next_link
     next_url = next_link.get_attribute('href')
   end
   # links.each do |link|
    get_image('https://www.kinokuniya.co.jp/' + link)
  end
end

  def self.get_image
    agent = Mechanize.new
    page = agent.get("https://www.kinokuniya.co.jp/disp/CSfDispListPage_001.jsp?qsd=true&ptk=01&gtin=&q=&title=&author-key=&publisher-key=&pubdateStart=201709&pubdateEnd=&thn-cod-b=13&ndc-dec-key=&rpp=100&SEARCH.x=51&SEARCH.y=26")
    bookname = page.at('.heightLine-2 a')
    image = page.at('.list_area clearfix img')[:src] if page.at('.list_area clearfix img')
    binding.pry
    database = Database.where(bookname: bookname).first_or_initialize
    database.image = image
    database.save
  end
end

