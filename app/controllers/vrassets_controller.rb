class VrassetsController < ApplicationController
  before_action :set_vrasset, only: %i[ show edit update destroy ]

  # GET /vrassets or /vrassets.json
  def index
    @vrassets = Vrasset.all
  end

  # GET /vrassets/1 or /vrassets/1.json
  def show
  end

  # GET /vrassets/new
  def new
    @vrasset = Vrasset.new
  end

  # GET /vrassets/1/edit
  def edit
  end

  # POST /vrassets or /vrassets.json
  def create
    @vrasset = Vrasset.new(vrasset_params)

    respond_to do |format|
      if @vrasset.save
        format.html { redirect_to vrasset_url(@vrasset), notice: "Vrasset was successfully created." }
        format.json { render :show, status: :created, location: @vrasset }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vrasset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vrassets/1 or /vrassets/1.json
  def update
    respond_to do |format|
      if @vrasset.update(vrasset_params)
        format.html { redirect_to vrasset_url(@vrasset), notice: "Vrasset was successfully updated." }
        format.json { render :show, status: :ok, location: @vrasset }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vrasset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vrassets/1 or /vrassets/1.json
  def destroy
    @vrasset.destroy!

    respond_to do |format|
      format.html { redirect_to vrassets_url, notice: "Vrasset was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vrasset
      @vrasset = Vrasset.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vrasset_params
      params.require(:vrasset).permit(:title, :description)
    end
end
