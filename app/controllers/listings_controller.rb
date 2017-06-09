class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :update, :edit, :destroy]
  before_action :require_login
  before_action :non_user_only, only: [:index]
  before_action :authorize_check, only: [:update, :destroy, :edit]

  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all.order('created_at DESC').paginate(:page => params[:page]).per_page(20)
  end

  def search
    @listings = Listing.search(params[:term], fields: ["country", "state", "city", "zipcode", "address", "description"], misspellings: {below: 5}).paginate(:page => params[:page]).per_page(20)
    if @listings.blank?
      redirect_to root_path, flash:{danger: "no successful search result"}
    else
      render :search
    end
  end

  def mylisting
    @listings = current_user.listings
    render 'index'
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @reservation = @listing.reservations.new
    @errors = @reservation.errors.full_messages

  end

  # GET /listings/new
  def new
    @listing = Listing.new
    @image = @listing.images.build
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = current_user.listings.new(listing_params)

    respond_to do |format|
      if @listing.save
        if params[:images]
          params[:images].each do |image|
            @listing.images.create(image: image)
          end
        end

        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        if params[:images]
          @listing.images.destroy_all
          params[:images].each do |image|
            @listing.images.create(image: image)
          end
        end

        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    def authorize_check
      unless @listing.user == current_user || current_user.moderator? || current_user.superadmin?
        redirect_to root_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:place_type, :property_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :address, :price_per_night, :description, images_attributes: [:image, :listing_id])
    end

    def non_user_only
      redirect_to sign_in_path if current_user.user?
    end
end
