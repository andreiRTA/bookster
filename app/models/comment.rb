class Comment < ActiveRecord::Base
	belongs_to :collection

	validates :collection_id, presence: true
	validates :comment,				presence: true
end
