class ApplicationController < ActionController::API
    def authenticate_request
        header = request.headers['Authorization']
        header = header.split{' '}.last if header
        begin
            decoded = JWT.decode(header, Rails.application.secrets.secret_key_base).first
            @current_user = User.find(decoded['user.id'])
        rescue JWT::ExpiredSignature
            render json: {error: 'Token has expired'}, status: :unauthorized
        rescue JWT::DecodeError
            render json: {errors: 'Unathorized'}, status: :unauthorized
        
        end
    end
end
