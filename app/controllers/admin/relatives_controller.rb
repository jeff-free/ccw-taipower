class Admin::RelativesController < Admin::BaseController
  before_action :set_relative, only: [:show, :edit, :update, :destroy]

  # GET /relatives
  # GET /relatives.json
  def index
    @relatives = Relative.includes(:organization, :representative)
                         .group_by { |relative| relative.representative }
  end

  # GET /relatives/1
  # GET /relatives/1.json
  def show
  end

  # GET /relatives/new
  def new
    @relative = Relative.new
  end

  # GET /relatives/1/edit
  def edit
  end

  # POST /relatives
  # POST /relatives.json
  def create
    @relative = Relative.new(relative_params)

    respond_to do |format|
      if @relative.save
        format.html { redirect_to [:admin, @relative], notice: 'Relative was successfully created.' }
        format.json { render :show, status: :created, location: @relative }
      else
        format.html { render :new }
        format.json { render json: @relative.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /relatives/1
  # PATCH/PUT /relatives/1.json
  def update
    respond_to do |format|
      if @relative.update(relative_params)
        format.html { redirect_to [:admin, @relative], notice: 'Relative was successfully updated.' }
        format.json { render :show, status: :ok, location: @relative }
      else
        format.html { render :edit }
        format.json { render json: @relative.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /relatives/1
  # DELETE /relatives/1.json
  def destroy
    @relative.destroy
    respond_to do |format|
      format.html { redirect_to [:admin, :relatives], notice: 'Relative was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    if RelativeBuilder.import(relative_params[:file])
      redirect_to [:admin, :relatives], notice: '匯入成功'
    else
      @relatives = Relative.order(approved_date: :desc).page(params[:page]).per(50)
      render :index, notice: '匯入失敗，請再次檢查資料'
    end
  end

  private
  def set_relative
    @relative = Relative.find(params[:id])
  end

  def relative_params
    params.fetch(:relative, {})
          .permit(:name, :title, :representative_id, :kinship_type,
                  :kinship_name, :mismatch, :file)
  end
end
