Feature: Actualizacion de productos

  Background:
    * def login = call read('classpath:bdd/auth/loginAuth.feature')
    * def authToken = login.authToken
    * def id = call read('classpath:bdd/product/AgregarProducto.feature')
    * def idProducto = id.idProducto

  Scenario: CP01 - Actualizar Producto
    * def bodyActualizarProducto = read('classpath:resources/Producto/ActualizarProducto.json')
    * print idProducto

    Given url urlBase
    And path '/api/v1/producto/' + idProducto
    And header Content-Type = 'application/json'
    And header Accept = '*/*'
    And header Authorization = 'Bearer ' + authToken
    And request bodyActualizarProducto
    When method put
    Then status 200
    * print response

  Scenario: CP02 - Validar campos de actualizacion de producto
    * def bodyActualizarProducto = read('classpath:resources/Producto/ActualizarProducto.json')
    * print idProducto

    Given url urlBase
    And path '/api/v1/producto/' + idProducto
    And header Content-Type = 'application/json'
    And header Accept = '*/*'
    And header Authorization = 'Bearer ' + authToken
    And request bodyActualizarProducto
    When method put
    Then status 200
    * print response
    * match response.codigo == '#string'
    * match response.id == '#number'
    * match response.nombre == '#string'
    * assert parseInt(response.stock) > 0
