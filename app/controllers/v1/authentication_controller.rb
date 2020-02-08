class V1::AuthenticationController < ApplicationController
    skip_before_action :authenticate_request

    def authenticate
        command = AuthenticateUser.call(params[:username], params[:password])

        if command.success?
            render json: { id: User.find_by_username(params[:username]).id, token: command.result }
        else
            render status: :unauthorized
        end
    end
end
