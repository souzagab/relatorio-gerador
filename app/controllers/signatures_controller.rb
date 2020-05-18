class SignaturesController < ApplicationController
  include SignatureTokenConcern
  before_action :authenticate_user!, except: [:sign, :create]
  before_action :validate_token, only: [:sign]
  before_action :authenticate_create, only: [:create]

  skip_forgery_protection

  layout 'signature', only: :sign

  def new
    @signature = Signature.new
  end

  def sign
    @signature = Signature.new
  end

  def create
    user_id = user_signed_in? ? current_user.id : user_id_token

    @signature = Signature.where(id: user_id).first_or_initialize
    @signature.sign = signature_params[:sign]

    respond_to do |format|
      if @signature.save
        format.html #{ redirect_to @signature, notice: 'Signature was successfully created.' }
        format.json { render :nothing, status: :created, location: @signature }
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
end
