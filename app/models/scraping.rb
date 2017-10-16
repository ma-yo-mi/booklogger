class Scraping

  require 'open-uri'
  require 'nokogiri'


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

end

