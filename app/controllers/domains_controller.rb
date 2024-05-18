class DomainsController < ApplicationController
  before_action :authenticate_user!

  def index
    @domains = current_user.domains
  end

  def new
    @domain = Domain.new
  end

  def create
    @domain = current_user.domains.new(domain_params)
    if @domain.save
      redirect_to domains_path
    else
      render :new
    end
  rescue ActiveRecord::RecordInvalid => e
    flash[:alert] = e.record.errors.full_messages.join(', ')
    render :new
  end


  private

  def domain_params
    params.require(:domain).permit(:name, :user_id, :model_type, :model_name)
  end
end
