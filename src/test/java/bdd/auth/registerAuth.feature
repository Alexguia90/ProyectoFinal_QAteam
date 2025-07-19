Feature: Registro de usuario

  Background:
    * def login = call read('classpath:bdd/auth/loginAuth.feature')
    * print login.authToken
    * def authToken = login.authToken
  
  Scenario: CP01 - Registrar usuario
    * def bodyRegistro = read('classpath:resources/json/registro/registrarUser.json')
    Given url urlBase
    And path '/api/register'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Authorization = 'Bearer'+ authToken
    And request bodyRegistro
    * print bodyRegistro
    When method POST
    Then status 200
    * print response

  Scenario: CP02 - No permitir registrar usuario Existente
    * def bodyRegistro = read('classpath:resources/json/registro/userExistente.json')
    Given url urlBase
    And path '/api/register'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Authorization = 'Bearer'+ authToken
    And request bodyRegistro
    * print bodyRegistro
    When method POST
    * match responseStatus == 500
    * match response.email[0] == 'The email has already been taken.'


