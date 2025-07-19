Feature: Productos

  Background:
    * def login = call read('classpath:bdd/auth/loginAuth.feature')
    * def authToken = login.authToken

    @crearProducto
  Scenario: CP01 - Agregar nuevo Producto
    * def bodyProducto = read('classpath:/resources/Producto/NewProducto.json')

    Given url urlBase
    And path '/api/v1/producto'
    And header Content-Type = 'application/json'
    And header Accept = '*/*'
    And header Authorization = 'Bearer ' + authToken
    And request bodyProducto
    When method POST
    Then status 200
    * match response.nombre == bodyProducto.nombre
    * match response.id != null
    * print response.id
    * def idProducto = response.id

  Scenario Outline: : CP02 - Agregar nuevo Producto por CSV
    Given url urlBase
    And path '/api/v1/producto'
    And header Content-Type = 'application/json'
    And header Accept = '*/*'
    And header Authorization = 'Bearer ' + authToken
    And request  { codigo: '#(codigo)',nombre:'#(nombre)',medida:'#(medida)',marca:'#(marca)',categoria:'#(categoria)',precio:'#(precio)',stock:'#(stock)',estado:'#(estado)',descripcion:'#(descripcion)'}
    When method POST
    Then status 200
    * print response
    * print response.id
    Examples:
      |read('classpath:resources/csv/dataProducto.csv')|

  Scenario: CP03 - Validar que no se registre un producto existente
    * def bodyProducto = read('classpath:/resources/Producto/NewProducto.json')

    Given url urlBase
    And path '/api/v1/producto'
    And header Content-Type = 'application/json'
    And header Accept = '*/*'
    And header Authorization = 'Bearer ' + authToken
    And request bodyProducto
    When method POST
    Then status 500
    * print response

  Scenario: CP04 - Validacion de campos de registro de producto
    * def bodyProducto = read('classpath:/resources/Producto/NewProducto.json')

    Given url urlBase
    And path '/api/v1/producto'
    And header Content-Type = 'application/json'
    And header Accept = '*/*'
    And header Authorization = 'Bearer ' + authToken
    And request bodyProducto
    When method POST
    Then status 200

    * print response
    * match response.codigo == '#string'
    * match response.id == '#number'
    * match response.nombre == '#string'
    * assert parseInt(response.stock) > 0



