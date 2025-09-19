*** Settings ***

Library  RequestsLibrary
Library  Collections
Resource  ../../variables/variables.robot
Resource  ../../resources/bookingResource.robot
Suite Setup  Create Session  booking  ${BASE_URL}
Suite Teardown  Delete All Sessions

*** Test Cases ***
Cenario 1 - Encontrar Booking Pelo Id
    [Tags]  getBookingUniqueId  smoke
    ${response}=    Encontrar Booking Pelo Id   1
    Should Be Equal As Integers  ${response.status_code}  200
    Log To Console   Booking: ${response.json()}
    Should Not Be Empty   ${response.json()}
Cenario 2 - Encontrar Booking Pelo Id Inexistente
    [Tags]  getBookingUniqueId  regression
    ${response}=  Encontrar Booking Pelo Id  -5
    ${status_code}=  Run Keyword If  '${response}'=='None'  Set Variable  404  ELSE  Set Variable  ${response.status_code}
    Log To Console  Status code: ${status_code} Erro ao buscar booking inexistente
    Should Be Equal As Integers  ${status_code}  404