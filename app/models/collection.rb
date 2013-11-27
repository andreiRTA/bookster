class Collection < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	has_many :book_copies
	has_many :books, through: :book_copies

	validates :user_id, presence: true

	def self.add_to_collection(user, book)
		self.create(user_id: user.id) unless user.collection
		user.reload
		user.collection.book_copies.create(book_id: book.id) unless self.already_in_collection?(user, book)
	end

	def self.already_in_collection?(user, book)
		!!user.collection.books.find_by_isbn(book.isbn)
	end
end
