class SignaturesController < ApplicationController
  include SignatureTokenConcern
  before_action :authenticate_user!, except: [:sign, :create]
  before_action :validate_token, only: [:sign]
  before_action :authenticate_create, only: [:create]

  skip_forgery_protection

  layout 'signature', only: :sign

  def new
  end

  def sign
  end

  def create
    fetch_signature

    respond_to do |format|
      if @signature.save

        format.html #{ redirect_to reports_path, notice: 'Signature was successfully created.' } if user_signed_in?
        format.json { render :nothing, status: :created }
      else
        format.html #{ render :new }
        format.json { render json: @signature.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    def set_signature
      @signature = Signature.find(params[:id])
    end
    def signature_params
      params.permit(:sign, :token)
    end

    def authenticate_create
      user_signed_in? ? authenticate_user! : validate_token
    end

    def fetch_signature
      user_id = user_signed_in? ? current_user.id : user_id_token
      @signature = Signature.find_or_initialize_by(user_id: user_id)
      @signature.sign = signature_params[:sign]
    end
end
