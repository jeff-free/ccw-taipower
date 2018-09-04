class Admin::ExpendituresController < Admin::BaseController
  before_action :set_expenditure, only: [:show, :edit, :update, :destroy]

  # GET /admin/expenditures
  # GET /admin/expenditures.json
  def index
    @xpenditures = Expenditure.all
  end

  # GET /admin/expenditures/1
  # GET /admin/expenditures/1.json
  def show
  end

  # GET /admin/expenditures/new
  def new
    @expenditure = Expenditure.new
  end

  # GET /admin/expenditures/1/edit
  def edit
  end

  # POST /admin/expenditures
  # POST /admin/expenditures.json
  def create
    @expenditure = Expenditure.new(expenditure_params)

    respond_to do |format|
      if @expenditure.save
        format.html { redirect_to [:admin, @expenditure], notice: 'Expenditure was successfully created.' }
        format.json { render :show, status: :created, location: @expenditure }
      else
        format.html { render :new }
        format.json { render json: @expenditure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/expenditures/1
  # PATCH/PUT /admin/expenditures/1.json
  def update
    respond_to do |format|
      if @expenditure.update(expenditure_params)
        format.html { redirect_to [:admin, @expenditure], notice: 'Expenditure was successfully updated.' }
        format.json { render :show, status: :ok, location: @expenditure }
      else
        format.html { render :edit }
        format.json { render json: @expenditure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/expenditures/1
  # DELETE /admin/expenditures/1.json
  def destroy
    @expenditure.destroy
    respond_to do |format|
      format.html { redirect_to admin_expenditures_url, notice: 'Expenditure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    respond_to do |format|
      if Expenditure.import(expenditure_params[:file])
        format.html { redirect_to [:admin, :expenditures], notice: '匯入成功' }
      end
    end
  end

  private
  def set_expenditure
    @expenditure = Expenditure.find(params[:id])
  end

  def expenditure_params
    params.fetch(:expenditure, {}).permit(:file)
  end
end
