Feature: TEK Insurance API Post request

  @PostPrimaryAccount
  Scenario: Get Account
    Given url 'https://tek-insurance-api.azurewebsites.net/'
    * def tokenValue = call read('GenerateToken.feature')
    * def token = tokenValue.response.token
    * header Authorization = 'Bearer ' + token
    * path '/api/accounts/add-primary-account'
    * def gen = Java.type('data.DataGenerator')
    * def email = gen.getEmail()
    * def firstName = gen.getFirstName()
    * def lastName = gen.getLastName()
    * def title = gen.getTitle()
    * def gender = gen.getGender()
    * def maritalStatus = gen.getMaritalStatus()
    * def employmentStatus = gen.getEmploymentStatus()
    * def dob = gen.getDateOfBirth()
    * request
      """
      {
      "id": 0,
      "email": "#(email)",
      "firstName": "#(firstName)",
      "lastName": "#(lastName)",
      "title": "#(title)",
      "gender": "#(gender)",
      "maritalStatus": "#(maritalStatus)",
      "employmentStatus": "#(employmentStatus)",
      "dateOfBirth": "#(dob)",
      "new": true
      }
      """
    * method post
    * status 201
    * print response
