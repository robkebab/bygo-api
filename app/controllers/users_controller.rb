class UsersController < ApplicationController
    before_action :find_user, only: [:update, :destroy]
    
    def index
        users = User.all
        
        render json: users
    end

    def create
        user = User.new(user_params)
        
        if user.save
            render json: user
        else
            render json: {"error": "could not sign you up"}
        end
    end

    def update
        if @user.update(user_params)
            render json: @user
        else
            render json: {"error": "could not udpate your profile"}
        end
    end

    def destroy
        if @user.destroy
            render json: {"message": "your account has been deleted"}
        else
            render json: {"error": "could not delete your account"}
        end
    end

        private

        def find_user
            @user = User.find(params[:id])
        end

        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end
end
