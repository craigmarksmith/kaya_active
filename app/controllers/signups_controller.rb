class SignupsController < ApplicationController

  def create
    signup = Signup.new(signup_params)

    if signup.valid?
      signup.save
    end

    respond_to do |format|
      format.js { render :json => {message:'Success'} }
      format.html { redirect_to request.referer }
    end
  end

  def signup_params
    params.require(:signup).permit(:email_address)
  end

end