class DomainsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]
  skip_before_action :verify_authenticity_token

  def index
    @domain = Domain.new

    response = Domains::GetModelsService.new.call
    if response[:success]
      @models_by_type = {}
      response[:result].each do |domain|
        type = domain[:type]
        models = domain[:models].map { |model| model[:name] }
        @models_by_type[type] = models
      end
    else
      @models_by_type = {}
    end
  end

  def create
    @domain = current_user.domains.new(domain_params)
    if @domain.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json { render json: { status: 'success', domain: @domain } }
      end
    else
      respond_to do |format|
        format.html { render :index }
        format.json { render json: { status: 'error', errors: @domain.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    respond_to do |format|
      format.html { render :index }
      format.json { render json: { status: 'error', errors: e.record.errors.full_messages }, status: :unprocessable_entity }
    end
  end

  private

  def domain_params
    params.require(:domain).permit(:name, :model_type, :model_identifier)
  end
end
