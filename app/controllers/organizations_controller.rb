class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  before_action :authorize, only: [:edit, :update, :destroy]

  # GET /organizations
  # GET /organizations.json
  def index
    if params[:search].present?
      # search radius and order by distance
      @organizations = Organization.near(params[:search], 10, :order => 'distance') + Organization.where("org_name ILIKE ?", "%#{params[:search]}%")

      # ILIKE is a way for insensitive case match


      if @organizations.empty?
        flash.now[:alert] = "Your search for #{params[:search]} did not return any results. Please try again."
        @organizations = Organization.all
      end
    else
      @organizations = Organization.all
    end
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
    @error_key_names = {"password" => "Password", "org_name" => "Organization Name", "contact_name" => "Contact Name", "contact_number" => "Contact Number","street_address" => "Street Address", "city" => "City", "state" => "State", "zip_code" => "Zip Code", "email" => "Email" }
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    if params["organization"]["org_type"] == "Other"
      params["organization"]["org_type"] = params["org_type_text"]
    end
      @organization = Organization.new(organization_params)

    if params["organization"]["org_type"] == "Shelter" && params[:availability_status] == "Available"
      @organization.availability = true
    else
      @organization.availability = false
    end 

    respond_to do |format|
      if @organization.save
        session[:organization_id] = @organization.id
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { redirect_to new_organization_path, flash: {errors: @organization.errors} }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
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
      params.require(:organization).permit(:org_name, :org_type, :org_type_text, :availability_status, :contact_name, :contact_number, :street_address, :city, :state, :zip_code, :email, :password, :password_confirmation, :image, :description)
    end

    def authorize
      if current_organization.nil?
        redirect_to login_url, alert: "Not authorized! Please log in."
      else
        if @organization != current_organization
          redirect_to login_url, alert: "Not authorized! Log In as #{@organization} to edit the organization's information!"
        end
      end
    end
end
