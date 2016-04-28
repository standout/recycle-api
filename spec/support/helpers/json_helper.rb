module JSONHelper
  def json
    JSON.parse(response.body)
  end
end
