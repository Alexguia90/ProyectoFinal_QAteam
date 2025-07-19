Feature: Listar Productos

  Background:
    * def login = call read('classpath:bdd/auth/loginAuth.feature')
    * def authToken = login.authToken
    * def id = call read('classpath:bdd/product/AgregarProducto.feature')
    * def idProducto = id.idProducto

  Scenario: CP01 - listar un Producto

    Given url urlBase
    And path '/api/v1/producto/' + idProducto
    And header Content-Type = 'application/json'
    And header Accept = '*/*'
    And header Authorization = 'Bearer ' + authToken
    When method get
    Then status 200
    * print response

  Scenario: CP02 - Listar un producto no existente

    * def id = 999999

    Given url urlBase
    And path '/api/v1/producto/' + id
    And header Content-Type = 'application/json'
    And header Accept = '*/*'
    And header Authorization = 'Bearer ' + authToken
    When method get
    Then status 404
    * print response
    * match response.error == 'Producto no encontrado'
