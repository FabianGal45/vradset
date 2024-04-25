class AdvertisementsController < ApplicationController
  include ApplicationHelper # Calls upone the application_helper.rb file where simple methods have been declared and can be reused here for simplicity.
  before_action :authenticate_user!, except: [:index ] #only display and show advertisements to users who are not logged in
  before_action :set_advertisement, only: %i[ show edit update destroy ]
  before_action :verify_permission, only: [:show, :edit, :update, :destroy]

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

  # Checks used to ensure the user has the role advertiser
  def check_advertiser_role
    unless current_user.advertiser?
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advertisement
      @advertisement = Advertisement.find(params[:id])
    end

    def verify_permission
      unless current_user && (current_user.advertiser? || current_user.admin?)
        redirect_to advertisements_path, alert: "You are not authorized to perform this action."
      end
    end


    # Only allow a list of trusted parameters through.
    def advertisement_params
      params.require(:advertisement).permit(:title, :description, :url, :file)
    end
end
