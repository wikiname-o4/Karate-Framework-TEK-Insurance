@TEKInsuranceCompleteTest
Feature: Tek Insurance API Test Feature File

  Background: 
    Given url 'https://tek-insurance-api.azurewebsites.net/'
    * path '/api/token'
    * request { "username": "supervisor", "password": "tek_supervisor" }
    * method post
    * def token = response.token
    * status 200
    * header Authorization = 'Bearer ' + token

  @GetAllAccounts
  Scenario: Get All Accounts
    * path '/api/accounts/get-all-accounts'
    * method get
    * status 200
    * print response

  @AddPrimaryAccount
  Scenario: Add Primary Account
    * path '/api/accounts/add-primary-account'
    * def gen = Java.type('data.DataGenerator')
    * def email = gen.getEmail()
    * def firstName = gen.getFirstName()
    * def lastName = gen.getLastName()
    * def dob = gen.getDateOfBirth()
    * request
      """
      {
      "id": 0,
      "email": "#(email)",
      "firstName": "#(firstName)",
      "lastName": "#(lastName)",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "SINGLE",
      "employmentStatus": "The Book",
      "dateOfBirth": "#(dob)",
      "new": true
      }
      """
    * method post
    * status 201
    * print response
    * karate.write(response, 'createdAccount.json')


  @GetMyAccountInformation
  Scenario: Get My Test Account
    * path '/api/accounts/get-account'
    * def accountInfo = read('file:./target/createdAccount.json')
    * param primaryPersonId = accountInfo.id
    * method get
    * status 200
    * print response
    
    
  @AddPhoneNumber
  Scenario: Add Account Phone
    * path '/api/accounts/add-account-phone'
    * def accountInfo = read('file:./target/createdAccount.json')
    * param primaryPersonId = accountInfo.id
    * def generator = Java.type('data.DataGenerator')
    * def phoneNumber = generator.getPhoneNumber()
    * def phoneExtension = generator.getPhoneExtension()
    * request
      """
      {
        "id": 0,
        "phoneNumber": "#(phoneNumber)",
        "phoneExtension": "#(phoneExtension)",
        "phoneTime": "Morning",
        "phoneType": "Cell"
      }
      """
    * method post
    * status 201
    * print response

  @AddAccountCar
  Scenario: Add Account Car
    * path '/api/accounts/add-account-car'
    * def accountInfo = read('file:./target/createdAccount.json')
    * param primaryPersonId = accountInfo.id
    * request
      """
      {
      "id": 0,
      "make": "Mercedes",
      "model": "G63 AMG",
      "year": "2023",
      "licensePlate": "TheBook"
      }
      """
    * method post
    * status 201
    * print response

  @AddAccountAddress
  Scenario: Add Account Address
    * path '/api/accounts/add-account-address'
    * def accountInfo = read('file:./target/createdAccount.json')
    * param primaryPersonId = accountInfo.id
    * def gen = Java.type('data.DataGenerator')
    * def streetAddress = gen.getStreetAddress()
    * def city = gen.getCity()
    * def state = gen.getState()
    * def postalCode = gen.getPostalCode()
    * def countryCode = gen.getCountryCode()
    * request
      """
      {
      "id": 0,
      "addressType": "Apartment",
      "addressLine1": "#(streetAddress)",
      "city": "#(city)",
      "state": "#(state)",
      "postalCode": "#(postalCode)",
      "countryCode": "#(countryCode)",
      "current": true
      }
      """
    * method post
    * status 201
    * print response

  @UpdatePhoneNumber
  Scenario: UpdatePhoneNumber
    * path '/api/accounts/get-account'
    * def createdAccountInfo = read('file:./target/createdAccount.json')
    * param primaryPersonId = createdAccountInfo.id
    * method get
    * def accountInfo = response
    * print response
    * def phoneId = response.primaryPersonPhones[0].id
    * header Authorization = 'Bearer ' + token
    * path '/api/accounts/update-account-phone'
    * param primaryPersonId = createdAccountInfo.id
    * def gen = Java.type('data.DataGenerator')
    * def phoneNumber = gen.getPhoneNumber()
    * def phoneExtension = gen.getPhoneExtension()
    * request
      """
      {
        "id": "#(phoneId)",
        "phoneNumber": "#(phoneNumber)",
        "phoneExtension": "#(phoneExtension)",
        "phoneTime": "Evening",
        "phoneType": "Home"
      }
      """
    * method put
    * status 200
    * print response

  @UpdateCar
  Scenario: Update Car Information
    * path '/api/accounts/get-account'
    * def createdAccountInfo = read('file:./target/createdAccount.json')
    * param primaryPersonId = createdAccountInfo.id
    * method get
    * def accountInfo = response
    * print response
    * def carId = response.primaryPersonCars[0].id
    * header Authorization = 'Bearer ' + token
    * path '/api/accounts/update-account-car'
    * param primaryPersonId = createdAccountInfo.id
    * request
      """
      {
      "id": "#(carId)",
      "make": "Volkswagen",
      "model": "Golf",
      "year": "2021",
      "licensePlate": "BooBoo"
      }
      """
    * method put
    * status 200
    * print response

  @UpdateAccountAddress
  Scenario: Update Account Address
    * path '/api/accounts/get-account'
    * def createdAccountInfo = read('file:./target/createdAccount.json')
    * param primaryPersonId = createdAccountInfo.id
    * method get
    * def accountInfo = response
    * print response
    * def addressId = response.primaryPersonMailingAddresses[0].id
    * header Authorization = 'Bearer ' + token
    * path '/api/accounts/update-account-address'
    * param primaryPersonId = createdAccountInfo.id
    * def gen = Java.type('data.DataGenerator')
    * def streetAddress = gen.getStreetAddress()
    * def city = gen.getCity()
    * def state = gen.getState()
    * def postalCode = gen.getPostalCode()
    * def countryCode = gen.getCountryCode()
    * request
      """
      {
      "id": "#(addressId)",
      "addressType": "Apartment",
      "addressLine1": "#(streetAddress)",
      "city": "#(city)",
      "state": "#(state)",
      "postalCode": "#(postalCode)",
      "countryCode": "#(countryCode)",
      "current": true
      }
      """
    * method put
    * status 200
    * print response

  @DeleteAccount
  Scenario: Delete Created Account
    * path '/api/accounts/delete-account'
    * def accountInfo = read('file:./target/createdAccount.json')
    * param primaryPersonId = accountInfo.id
    * method delete
    * status 200
    * print response
