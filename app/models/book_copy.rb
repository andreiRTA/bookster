class BookCopy < ActiveRecord::Base
	belongs_to :collection
	belongs_to :book

	validates :collection_id, presence: true
	validates :book_id, 			presence: true
end
