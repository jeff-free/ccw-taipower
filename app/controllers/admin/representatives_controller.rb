class Admin::RepresentativesController < Admin::BaseController
  before_action :set_representative, only: [:show, :edit, :update, :destroy]

  # GET /representatives
  # GET /representatives.json
  def index
    @representatives = Representative.page(params[:page])
  end

  # GET /representatives/1
  # GET /representatives/1.json
  def show
  end

  # GET /representatives/new
  def new
    @representative = Representative.new
  end

  # GET /representatives/1/edit
  def edit
  end

  # POST /representatives
  # POST /representatives.json
  def create
    @representative = Representative.new(representative_params)

    respond_to do |format|
      if @representative.save
        format.html { redirect_to [:admin, @representative], notice: 'Representative was successfully created.' }
        format.json { render :show, status: :created, location: @representative }
      else
        format.html { render :new }
        format.json { render json: @representative.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /representatives/1
  # PATCH/PUT /representatives/1.json
  def update
    respond_to do |format|
      if @representative.update(representative_params)
        format.html { redirect_to [:admin, @representative], notice: 'Representative was successfully updated.' }
        format.json { render :show, status: :ok, location: @representative }
      else
        format.html { render :edit }
        format.json { render json: @representative.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /representatives/1
  # DELETE /representatives/1.json
  def destroy
    @representative.destroy
    respond_to do |format|
      format.html { redirect_to [:admin, :representatives], notice: 'Representative was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    if Representative.import(representative_params[:file])
      redirect_to [:admin, :representatives], notice: '匯入成功'
    else
      @representatives = Representative.order(approved_date: :desc).page(params[:page]).per(50)
      render :index, notice: '匯入失敗，請再次檢查資料'
    end
  end

  private

  def set_representative
    @representative = Representative.find(params[:id])
  end

  def representative_params
    params.fetch(:representative, {})
          .permit(:name, :party, :job_type, :job_title, :file)
  end
end
