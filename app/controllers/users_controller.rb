class UsersController < Clearance::UsersController
before_action :set_user, only: [:show, :edit, :update, :destroy]
before_action :require_login, only: [:show, :edit, :update, :destroy, :index]
before_action :superadmin_only, only: [:index]
    def new
        @user = User.new  # = user_from_params
        # render template: "users/new"
    end

    def create
        @user = User.new(user_params)
        if @user.save
            sign_in @user
            redirect_back_or url_after_create
        else
            render template: "users/new"
        end
    end

    def index
      @users = User.all
    end

    def edit
    end

    def show
      # unless current_user.superadmin
        # redirect_to root_path
      # end
    end

    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /listings/1
    # DELETE /listings/1.json
    def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully deleted.' }
        format.json { head :no_content }
      end
    end

    private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :age, :country, :gender, :email, :password, :avatar)
    end

    def superadmin_only
      redirect_to sign_in_path unless current_user.superadmin?
    end

end
