Feature: TEK Insurance API Post request

  @PostPrimaryAccount
  Scenario: Get Account
    Given url 'https://tek-insurance-api.azurewebsites.net/'
    * def tokenValue = call read('GenerateToken.feature')
    * def token = tokenValue.response.token
    * header Authorization = 'Bearer ' + token
      * path '/api/accounts/add-primary-account'