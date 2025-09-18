*** Settings ***
Library  RequestsLibrary
Library  Collections
Resource  ../../variables/variables.robot
Resource  ../../resources/bookingResource.robot

*** Test Cases ***
Cenario 1 - Listar Todos os Ids de Bookings na Api 
    
    [Tags]  getBookingIds  smoke
    ${response}=   Listar Todos os Ids de Bookings na Api 
    Log To Console   Lista de Ids: ${response.json()}
    Should Not Be Empty   ${response.json()}
Cenario 2 - Listar Todos os Ids de Bookings na Api Filtrados Por Nome
    
    [Tags]  getBookingIds  smoke
    ${response}=   Listar Todos os Ids de Bookings na Api Filtrados Por Nome  Sally  Brown
    Log To Console   Lista de Ids: ${response.json()}
    Should Not Be Empty   ${response.json()}
Cenario 3 - Listar Todos os Ids de Bookings na Api Filtrados Por Nome e Sobrenome Inexistentes
    
    [Tags]  getBookingIds  regression
    ${response}=   Listar Todos os Ids de Bookings na Api Filtrados Por Nome  NomeInexistente  SobrenomeInexistente
    Log To Console   Lista de Ids: ${response.json()}
    Should Be Empty   ${response.json()}