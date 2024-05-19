class Domains::CheckDotnetService
  include HTTParty

  base_uri 'http://localhost:2106'

  def initialize(domain)
    @domain = domain
  end

  def call
    response = self.class.post('/api/check',
                               body: request_body.to_json,
                               headers: { 'Content-Type' => 'application/json' })
    handle_response(response)
  end

  private

  def request_body
    {
      type: @domain.model_type,
      model: @domain.model_identifier,
      domain: @domain.name
    }
  end

  def handle_response(response)
    if response.success?
      result = JSON.parse(response.body, symbolize_names: true)
      { success: true, result: result[:result] }
    else
      raise 'Error'
    end
  end
end
