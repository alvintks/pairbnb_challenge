class SessionsController < Clearance::SessionsController

  def new
  end

  def create
    @user = authenticate(params)

    sign_in(@user) do |status|
      if status.success?
        redirect_to welcome_path
      else
        # flash.now.notice = status.failure_message
        @error = status.failure_message
        respond_to do |format|
        format.js
        format.html { render template: "sessions/new" }
        end
      end
    end
  end

 def create_from_omniauth
    auth_hash = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) ||  Authentication.create_with_omniauth(auth_hash)

    # if: previously already logged in with OAuth
    if authentication.user
      user = authentication.user
      authentication.update_token(auth_hash)
      @next = root_url
      @notice = "Signed in!"
    # else: user logs in with OAuth for the first time
    else
      user = User.create_with_auth_and_hash(authentication, auth_hash)
      # you are expected to have a path that leads to a page for editing user details
      @next = edit_user_path(user)
      @notice = "User created. Please confirm or edit details"
    end
    sign_in(user)
    redirect_to "/"
  end

  # def redirect_signed_in_users
  #   if signed_in?
  #     redirect_to "/welcome"
  #   end
  # end

end 