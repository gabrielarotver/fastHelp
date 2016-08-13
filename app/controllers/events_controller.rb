class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authorize, except: [:show, :index]

  # GET /events
  # GET /events.json
  def index
    if current_organization.nil?
      if params[:search].present?
        @events = Event.near(params[:search], 10, :order => 'distance') + Event.where("event_name ILIKE ?", "%#{params[:search]}%")

        # ILIKE is a way for insensitive case match

        if @events.empty?
          flash.now[:alert] = "Your search for #{params[:search]} did not return any results. Please try again."
          @events = Event.all
        end
      else
        @events = Event.all
      end
    else
      @events = current_organization.events.all
    end

    respond_to do |format|
      format.html do
        if params[:f] == "calendar"
          render "index"
        else
          render "index_list"
        end
      end
      format.json do
        render "index"
      end
    end

  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = current_organization.events.build(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:event_name, :date, :time, :street_address, :city, :state, :zip_code, :image, :description)
    end

    def authorize
      if current_organization.nil?
        redirect_to login_url, alert: "Not authorized! Please log in."
      else
        if @event && @event.organization != current_organization
          redirect_to root_path, alert: "Not authorized! Only #{@event.organization} has access to this post."
        end
      end
    end
end
