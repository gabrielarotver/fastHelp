class SessionsController < ApplicationController
  def new
  end

  def create
    organization = Organization.find_by_email(params[:email])
    if organization && organization.authenticate(params[:password])
      session[:organization_id] = organization.id
      redirect_to root_url, notice: 'Logged in!'
    else
      render :new
    end
  end

  def destroy
    session[:organization_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end
end
