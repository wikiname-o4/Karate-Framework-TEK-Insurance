Feature: TEK Insurance API Get Service

  @GetPrimaryAccount
  Scenario: Get Account
    Given url 'https://tek-insurance-api.azurewebsites.net/'
    * def tokenValue = call read('GenerateToken.feature')
    * def token = tokenValue.response.token
    * header Authorization = 'Bearer ' + token
    * path '/api/accounts/get-primary-account'
    * def ppIdValue = call read('PostAccount.feature')
    * param primaryPersonId = ppIdValue.response.id
    * method get
    * print response
    * status 200
    * def responseID = response.id
    * match responseID == ppIdValue.response.id
