Feature: Token Generator Feature for TEK Insurance API

  @generateToken
  Scenario: Generate Token
    Given url 'https://tek-insurance-api.azurewebsites.net/'
    * path '/api/token'
    * request { "username": "supervisor", "password": "tek_supervisor" }
    * method post
    * print response.token
    * print response.fullName
    * status 200
    * assert response.fullName == 'Supervisor'
