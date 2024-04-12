class AdvertisementsController < ApplicationController
  before_action :authenticate_user!, except: [:index ] #only display and show advertisements to users who are not logged in
  before_action :set_advertisement, only: %i[ show edit update destroy ]
  before_action :check_user_permission, only: [:show, :edit, :update, :destroy]

  # GET /advertisements or /advertisements.json
  def index
    @advertisements = Advertisement.all
  end

  # GET /advertisements/1 or /advertisements/1.json
  def show
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
    @advertisement = Advertisement.new(advertisement_params)

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

    def check_user_permission
      unless current_user && (current_user.advertiser? || current_user.admin?)
        redirect_to advertisements_path, alert: "You are not authorized to perform this action."
      end
    end


    # Only allow a list of trusted parameters through.
    def advertisement_params
      params.require(:advertisement).permit(:title, :description, :url, :file)
    end
end
