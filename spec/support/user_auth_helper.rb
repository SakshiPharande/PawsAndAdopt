# Handles setting Authorization header for login
def login_user(token = valid_token)
  request.headers["Authorization"] = "Bearer #{token}"
end

# Parses JSON response
def json_response
  JSON.parse(response.body)
end
