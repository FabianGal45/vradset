class AdvertisementsController < ApplicationController
  include ApplicationHelper # Calls upone the application_helper.rb file where simple methods have been declared and can be reused here for simplicity.
  before_action :authenticate_user!, except: [:index, :get_image] #only display and show advertisements to users who are not logged in or request a random image
  before_action :set_advertisement, only: %i[ show edit update destroy ]
  before_action :verify_permission, only: [:show, :new, :edit, :create, :update, :destroy]

  # Class variable array of adcertisements with attached files(images) from the database that are in a random order.
  # A class variable is used to keep the state upon each request. Otherwise on each request the variable will reset.
  @@image_queue = Advertisement.with_attached_file.order('RANDOM()').to_a

  # GET /advertisements or /advertisements.json
  def index
    # Only display the advertisements corresponding to the user that created them when logged in.
    if user_advertiser?
      @advertisements = current_user.advertisements
    else
      # If the no user is signed in then all advertisements will be displayed. However they cannot be edited.
      @advertisements = Advertisement.all
    end
  end

  # GET /get_image - Used to request an image from Unreal Engine
  def get_image
    # If the image queue is empty then refill the queue
    @@image_queue = Advertisement.with_attached_file.order('RANDOM()').to_a if @@image_queue.empty?

    # Removes the first image from the queue whilst holding the first in the advertisement variable
    # https://www.geeksforgeeks.org/ruby-queue-shift-function/
    advertisement = @@image_queue.shift

    # if there is a file attached, redirect to the blob with said file.
    # https://stackoverflow.com/questions/50424251/how-can-i-get-url-of-my-attachment-stored-in-active-storage-in-my-rails-controll
    if advertisement&.file&.attached?
      redirect_to rails_blob_url(advertisement.file, disposition: "attachment", only_path: true)
    else
      head :not_found # else display not found message
    end
  end


  # GET /advertisements/1 or /advertisements/1.json
  def show
    # limit so only the owner of the user can view the advertisement when searching for /advertisements/1
    @advertisement = Advertisement.find(params[:id])
    if user_advertiser? && current_user != @advertisement.user
      redirect_to advertisements_path, alert: 'You are not authorized to view this advertisement.'
    end
  end

  # GET /advertisements/new
  def new
    @advertisement = Advertisement.new
  end

  # GET /advertisements/1/edit
  def edit
  end

  # POST /advertisements or /advertisements.json
  def create
    # each new advertisement will be associated to the user that is currently signed up and able to create it.
    @advertisement = current_user.advertisements.build(advertisement_params)

    respond_to do |format|
      if @advertisement.save
        format.html { redirect_to advertisement_url(@advertisement), notice: "Advertisement was successfully created." }
        format.json { render :show, status: :created, location: @advertisement }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @advertisement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /advertisements/1 or /advertisements/1.json
  def update
    respond_to do |format|
      if @advertisement.update(advertisement_params)
        format.html { redirect_to advertisement_url(@advertisement), notice: "Advertisement was successfully updated." }
        format.json { render :show, status: :ok, location: @advertisement }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @advertisement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advertisements/1 or /advertisements/1.json
  def destroy
    @advertisement.destroy!

    respond_to do |format|
      format.html { redirect_to advertisements_url, notice: "Advertisement was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advertisement
      @advertisement = Advertisement.find(params[:id])
    end

    # Check if the user is an advertiser or admin
    def verify_permission
      unless user_advertiser_or_admin?
        redirect_to advertisements_path, alert: "You are not authorized to perform this action."
      end
    end

    # Only allow a list of trusted parameters through.
    def advertisement_params
      params.require(:advertisement).permit(:title, :description, :url, :file, :check_asai_all, :check_asai_children)
    end
end
