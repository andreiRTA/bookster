class BooksController < ApplicationController
	before_action :signed_in_user

	def index
	end

	def new
		@search = params[:search]
		@books = GoogleBooks.search(@search, {:count => 10})
	end

	def create
		user = User.find(current_user.id)
		book = Book.find_or_create(params[:book][:isbn], book_params)
		book_copy = Collection.add_to_collection(user, book)
		if book_copy && book_copy.save
			redirect_to user
		else
			flash[:warning] = "That book is already in your collection. Please search for another one of your favourites!"
			redirect_to search_for_book_path
		end
	end

	private

		def book_params
			params.require(:book).permit(:title, :author, :description, :image, :isbn)
		end
end
