Feature: TEK Insurance API Get Service

  @GetPrimaryAccount
  Scenario: Get Account
    Given url 'https://tek-insurance-api.azurewebsites.net/'
    * def tokenValue = call read('GenerateToken.feature')
    * def token = tokenValue.response.token
    * header Authorization = 'Bearer ' + token
    * path '/api/accounts/get-primary-account'
    * param primaryPersonId = 5516
    * method get
    * print response
    * status 200
    * def responseID = response.id
    * match reponseID == 5516
