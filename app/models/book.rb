class Book < ActiveRecord::Base
  class << self
    def search(query)
      rel = order("number")
      if query.present?
        rel = rel.where("bookname LIKE ? OR author LIKE? OR publisher LIKE?", "%#{query}%", "%#{query}%")
      end
      rel
    end
  end
end
