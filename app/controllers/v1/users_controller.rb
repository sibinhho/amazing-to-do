class V1::UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [:create]

    def create
        @user = User.new(user_params)
        @user.save
        render json: @user, status: :created
    end

    def show
        if params[:id].to_i == @current_user.id.to_i
            render json: @current_user.tasks.paginate(page: params[:page]), status: :ok
        else
            render status: :unauthorized
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
