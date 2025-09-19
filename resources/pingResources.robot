*** Settings ***
Library  RequestsLibrary
Library  Collections
Resource  ../variables/variables.robot

*** Variables ***
${PING_ENDPOINT}=  /ping

*** Keywords ***
Check Ping Api
    [Documentation]  Realiza um get para o endpoint /ping e valida se a api está no ar
    Create Session  ping  ${BASE_URL}
    ${response}=  Get On Session  ping  ${PING_ENDPOINT}

    Log To Console   Response retornado: ${response}

    Should Be Equal As Integers   ${response.status_code}    201