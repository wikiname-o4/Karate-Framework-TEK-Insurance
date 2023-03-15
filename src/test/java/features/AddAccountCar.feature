Feature: TEK Insurance API Add Car

Background:

    Given url 'https://tek-insurance-api.azurewebsites.net/'
    * def tokenValue = callonce read('GenerateToken.feature')
    * def token = tokenValue.response.token
    * header Authorization = 'Bearer ' + token
    * path '/api/accounts/add-account-car'
    * def ppIdValue = callonce read('PostAccount.feature')

    
    
  @AddAccountCar1
  Scenario: Add Car Service Test
    * param primaryPersonId = ppIdValue.response.id
    * def gen = Java.type('data.DataGenerator')
    * def carMake = gen.getCarMake()
    * def carModel = gen.getCarModel()
    * def carLicensePlate = gen.getCarLicensePlate()
    * request
      """
      {
      "id": 0,
      "make": "#(carMake)",
      "model": "#(carModel)",
      "year": "2023",
      "licensePlate": "#(carLicensePlate)"
      }
      """
    * method post
    * status 201
    * print response
    
    
  @AddAccountCar1
  Scenario: Add Car Service Test
    * param primaryPersonId = ppIdValue.response.id
    * def gen = Java.type('data.DataGenerator')
    * def carMake = gen.getCarMake()
    * def carModel = gen.getCarModel()
    * def carLicensePlate = gen.getCarLicensePlate()
    * request
      """
      {
      "id": 0,
      "make": "#(carMake)",
      "model": "#(carModel)",
      "year": "2023",
      "licensePlate": "#(carLicensePlate)"
      }
      """
    * method post
    * status 201
    * print response
