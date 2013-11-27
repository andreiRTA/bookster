class Book < ActiveRecord::Base
	has_many :book_copies
	has_many :collections, through: :book_copies

	def self.find_or_create(book_isbn, params)
		if self.find_by_isbn(book_isbn)
			self.find_by_isbn(book_isbn)
		else
			self.create(params)
		end
	end
end
