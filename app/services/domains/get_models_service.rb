class Domains::GetModelsService
  include HTTParty

  base_uri 'http://localhost:2106'

  def call
    response = self.class.get('/api/models')
    handle_response(response)
  end

  private

  def handle_response(response)
    if response.success?
      info = JSON.parse(response.body, symbolize_names: true)
      { success: true, result: info }
    else
      raise 'Error'
    end
  end

end
