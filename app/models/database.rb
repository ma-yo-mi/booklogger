class Database < ActiveRecord::Base
  class << self
    def search(search)
      rel = Database.all
      if search.present?
        rel = rel.where("bookname LIKE ? OR author LIKE? OR publisher LIKE?", "%#{search}%", "%#{search}%")
      end
      rel
    end
  end
end
