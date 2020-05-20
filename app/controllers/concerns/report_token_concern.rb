module ReportTokenConcern
  extend ActiveSupport::Concern

    def validate_token
      return render_unauthorized unless token_valid?
    end

    def render_unauthorized
      redirect_to user_session_path, status: :unauthorized
    end

    def token_valid?
      decoded_token
    end

    def user_id_token
      decoded_token[:user_id]
    end

    def decoded_token
      JsonWebToken.decode report_params[:token]
    end
end
