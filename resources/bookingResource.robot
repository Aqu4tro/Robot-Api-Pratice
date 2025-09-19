*** Settings ***

Library  RequestsLibrary
Library  Collections
Resource  ../variables/variables.robot

*** Variables ***
${BOOKING_ENDPOINT}=  /booking

*** Keywords ***

Listar Todos os Ids de Bookings na Api 
    [Documentation]  Realiza um get no endpoint /booking e retorna uma lista com todos os ids de bookings 
    

    ${response}=  Get On Session  booking  url=${BOOKING_ENDPOINT}  

    Should Be Equal As Integers  ${response.status_code}  200
    RETURN    ${response}

Listar Todos os Ids de Bookings na Api Filtrados Por Nome
    [Documentation]  Realiza um get no endpoint /booking e retorna uma lista com todos os ids de bookings com o nome do parametro, pra evitar muitos resultados
    [Arguments]  ${nome}  ${lastname}
 
    ${params}=  Create Dictionary  
    ...  firstname=${nome}
    ...  lastname=${lastname}
    ${response}=  Get On Session  booking  url=${BOOKING_ENDPOINT}  params=${params}

    Should Be Equal As Integers  ${response.status_code}  200
    RETURN    ${response}

Encontrar Booking Pelo Id
    [Documentation]  Realiza um get no endpoint /booking/{id} e retorna o booking referente ao id passado no parametro
    [Arguments]  ${id}
  
    ${result}=  Run Keyword And Ignore Error  Get On Session  booking  url=${BOOKING_ENDPOINT}/${id}
    ${status}=  Set Variable  ${result[0]} 
    ${resp}=    Set Variable  ${result[1]}  
    ${response}=  Run Keyword If  '${resp.__class__.__name__}'=='Response'  Set Variable  ${resp}  ELSE  Set Variable  None
    RETURN   ${response}

Criar Novo Booking
    [Documentation]  Realiza um post no endpoint /booking criando um novo booking com os dados passados no parametro
    [Arguments]  ${json_body}

    ${headers}=  Create Dictionary  
    ...  Content-Type=application/json
    ${response}=  Post On Session  booking  url=${BOOKING_ENDPOINT}  json=${json_body}  headers=${headers}  expected_status=any
    
    RETURN    ${response}

Atualizar Booking Pelo Id
    [Documentation]  Realiza um put no endpoint /booking/{id} atualizando o
    [Arguments]  ${id}  ${json_body}  ${token}

    ${headers}=  Create Dictionary
    ...  Content-Type=application/json
    ...  Cookie=token=${token}
    # Authorization=Basic ${token}  # Caso queira usar Basic Auth
    ${response}=  Put On Session  booking  url=${BOOKING_ENDPOINT}/${id}
    ...  json=${json_body}  headers=${headers}  expected_status=any
    RETURN    ${response}

Atualizar Booking Parcialmente Pelo Id
    [Documentation]  Realiza um patch no endpoint /booking/{id} atualizando parcialmente o booking com os dados passados no parametro
    [Arguments]  ${id}  ${json_body}  ${token}

    ${headers}=  Create Dictionary
    ...  Content-Type=application/json
    ...  Cookie=token=${token}
    # Authorization=Basic ${token}  # Caso queira usar Basic Auth
    ${response}=  Patch On Session  booking  url=${BOOKING_ENDPOINT}/${id}
    ...  json=${json_body}  headers=${headers}  expected_status=any
    RETURN    ${response}
Deletar Booking Pelo Id
    [Documentation]  Realiza um delete no endpoint /booking/{id} deletando o booking com o id passado no parametro
    [Arguments]  ${id}  ${token}

    ${headers}=  Create Dictionary
    ...  Cookie=token=${token}
    # Authorization=Basic ${token}  # Caso queira usar Basic Auth
    ${response}=  Delete On Session  booking  url=${BOOKING_ENDPOINT}/${id}  headers=${headers}  expected_status=any
    RETURN    ${response}