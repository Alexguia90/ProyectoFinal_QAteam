Feature: Login

  Scenario: CP01 - Login exitoso
    Given url urlBase
    And path '/api/login'
    And request { email: 'alex@guia.com', password: 'alex1234' }
    When method post
    Then status 200
    * print response
    * def authToken = response.access_token
    * print authToken

  Scenario: CP02 - Login incorrecto
    Given url urlBase
    And path '/api/login'
    And request { email: 'carlosqateam@gmail.com', password: 'carlos1234' }
    When method post
    * match responseStatus == 401
    * match response.message == 'Datos incorrectos'

  Scenario Outline: CP03 - Login masivo
    Given url urlBase
    And path '/api/login'
    And request { email: '<email>', password: '<password>' }
    When method post
    * print response
    * print response.token
    * match response.user.email == email
    * match responseStatus == <expectedStatus>

    Examples:
      |email|password|expectedStatus|
      |carlosqateam@gmail.com|carlos123|200|
      |Alex@guia.com|alex123|401           |
      |Mire@arango.com|mire123|401         |
      |Pedro@Perez.com|pedro123|401        |




