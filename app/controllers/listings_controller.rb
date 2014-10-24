class ListingsController < ApplicationController

	def index
		@listings = load_listings
	end

	def show
		load_listing
	end

	def new
		build_listing
	end

	def create
		build_listing
		save_listing or render 'new'
	end

	def edit
		load_listing
		build_listing
	end

	def update
		load_listing
		build_listing
		save_listing or render 'edit'
	end

	def destroy
		load_listing
		@listing.destroy
		redirect_to listings_path
	end	

	def search_results
		@search_results =Listing::AsSearchable.search(params)

		# text_search = Listing.listing_search(params[:search_text])		
		# p search = text_search

		# if params[:start_date] != "" && params[:end_date] != ""
		# 	start_date_search = Listing.where(available_from: params[:start_date])
		# 	end_date_search = Listing.where(available_to: params[:end_date])
		# 	search = text_search & start_date_search & end_date_search
		# end

		# @collection = []
		# search.each do |item|
		#   @collection << Listing.find(item.id)
	 #  end

	 #  @collection
	 	render "listings/searchable/search_results"
	end	

	private

	def load_listings
		@listings ||= listing_scope
	end

	def load_listing
		@listing ||= listing_scope.find(params[:id])
	end	

	def build_listing
		@listing ||= listing_scope.build
		@listing.attributes = listing_params
	end

	def save_listing
		if @listing.save
			redirect_to @listing
		end
	end

	def listing_params
		 listing_params = params[:listing]
		 listing_params ? listing_params.permit(:user_id, :address, :available_to, :available_from) : {}
	end

	def listing_scope 
		Listing.all
	end	
end
