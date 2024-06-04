class DomainsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]
  skip_before_action :verify_authenticity_token

  def index
    @domain = Domain.new

    if current_user
      @domains = current_user.domains.order(created_at: :desc)
    else
      @domains = []
    end

    response = Domains::GetModelsService.new.call

    if response[:success]
      @models_by_type = {}
      @model_classify_info = {}
      @model_detect_info = {}
      response[:result].each do |domain|
        type = domain[:type]
        models = domain[:models].map { |model| model[:name] }
        @models_by_type[type] = models
        domain[:models].each do |model|
          if type == 'classify'
            @model_classify_info[model[:name]] = model[:info]
          else
            @model_detect_info[model[:name]] = model[:info]
          end
        end
      end
    else
      @models_by_type = {}
      @model_classify_info = {}
      @model_detect_info = {}
    end

    respond_to do |format|
      format.html
      format.turbo_stream
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
