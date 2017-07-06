class UsersController < Clearance::UsersController

  def create 
    @user = user_from_params
      if @user.save
        sign_in @user
        redirect_to welcome_path
      else
        @error = @user.errors.full_messages
        # render template: "users/new"
        respond_to do |format|
        format.js
        format.html { render template: "users/new" }
        end
      end
  end

end