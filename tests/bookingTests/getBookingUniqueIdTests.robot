*** Settings ***

Library  RequestsLibrary
Library  Collections
Resource  ../../variables/variables.robot
Resource  ../../resources/bookingResource.robot

*** Test Cases ***
Cenario 1 - Encontrar Booking Pelo Id
    [Tags]  getBookingUniqueId  smoke
    ${response}=    Encontrar Booking Pelo Id   1
    Log To Console   Booking: ${response.json()}
    Should Not Be Empty   ${response.json()}