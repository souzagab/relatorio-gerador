class SignaturesController < ApplicationController

  def new
    @signature = Signature.new
  end

  def create
    @signature = Signature.new(signature_params)

    respond_to do |format|
      if @signature.save
        format.html { redirect_to @signature, notice: 'Signature was successfully created.' }
        format.json { render :show, status: :created, location: @signature }
      else
        format.html { render :new }
        format.json { render json: @signature.errors, status: :unprocessable_entity }
      end
    end
  end


  def method_name
    # Relatório cria/encontra subscriber e gera assinatura 
    # envia link com query (token) com a assinatura ID/UID
    # token -> subscriber_email  signature.uuid 
    # if params[:token]
    #token = params[:token]
    #decoded = JwtService .decode token
    #@signature = Signature.find_by(uuid: decoded.uuid)

  end

  private
    def set_signature
      @signature = Signature.find(params[:id])
    end

    def signature_params
      params.fetch(:signature, {})
    end
end
