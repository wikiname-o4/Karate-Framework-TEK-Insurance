@TEKRetailAPICompleteTest
Feature: TEK Retail API Test Feature File

  Scenario: test
    Given url 'https://tek-retail-api.azurewebsites.net/'
    * path '/auth/login'
    * request { "email": "mytest21@gmail.com","password": "Test@12345"}
    * method post
    * status 200
    * print response
    
