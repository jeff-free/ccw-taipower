class Admin::OrganizationsController < Admin::BaseController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization.page(params[:page]).per(50)
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
        Expenditure.where(organization_name: @organization.name)
                   .update_all(organization_id: @organization.id)
        format.html { redirect_to [:admin, @organization], notice: 'Organization was successfully created.' }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        Expenditure.where(organization_name: @organization.name)
                   .update_all(organization_id: @organization.id)
        format.html { redirect_to [:admin, @organization], notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  def import
    if Organization.import(organization_params[:file])
      redirect_to [:admin, :organizations], notice: '匯入成功'
    else
      @organizations = Organization.page(params[:page]).per(200)
      render :index, notice: '匯入失敗'
    end
  end

  def import_by_api
    if Organization.import_from_api
      redirect_to [:admin, :organizations], notice: '匯入成功'
    else
      @organizations = Organization.page(params[:page]).per(200)
      render :index, notice: '匯入失敗'
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to admin_organizations_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.fetch(:organization, {}).permit(:name, :owner_name, :file)
    end
end
