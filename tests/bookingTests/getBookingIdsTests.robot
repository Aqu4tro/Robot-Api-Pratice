*** Settings ***
Library  RequestsLibrary
Library  Collections
Resource  ../../variables/variables.robot
Resource  ../../resources/bookingResource.robot
Suite Setup  Create Session  booking  ${BASE_URL}
Suite Teardown  Delete All Sessions

*** Test Cases ***
Cenario 1 - Listar Todos os Ids de Bookings na Api 
    
    [Tags]  getBookingIds  smoke
    ${response}=   Listar Todos os Ids de Bookings na Api 
    Log To Console   Lista de Ids: ${response.json()}
    Should Not Be Empty   ${response.json()}
Cenario 2 - Listar Todos os Ids de Bookings na Api Filtrados Por Nome

    [Tags]  getBookingIds  smoke
    ${booking_dates}=    Create Dictionary
    ...    checkin=2024-01-01
    ...    checkout=2024-01-02
    ${booking_body}=    Create Dictionary
    ...    firstname=Mary
    ...    lastname=Jackson
    ...    totalprice=111
    ...    depositpaid=true
    ...    bookingdates=${booking_dates}
    ...    additionalneeds=Breakfast
    ${create_response}=    Criar Novo Booking    ${booking_body}
    Should Be Equal As Integers    ${create_response.status_code}    200
    ${response}=   Listar Todos os Ids de Bookings na Api Filtrados Por Nome  Mary  Jackson
    Log To Console   Lista de Ids: ${response.json()}
    Should Not Be Empty   ${response.json()}
Cenario 3 - Listar Todos os Ids de Bookings na Api Filtrados Por Nome e Sobrenome Inexistentes
    
    [Tags]  getBookingIds  regression
    ${response}=   Listar Todos os Ids de Bookings na Api Filtrados Por Nome  NomeInexistente  SobrenomeInexistente
    Log To Console   Lista de Ids: ${response.json()}
    Should Be Empty   ${response.json()}