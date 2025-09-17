*** Settings ***
Library  RequestsLibrary
Resource  ../variables/variables.robot

*** Variables ***

${AUTH_ENDPOINT}=  /auth

*** Keywords ***
Efetuar Login e Gerar Token
    [Documentation]  Após realizar o post para o endpoint /auth gera um token
    Create Session  auth  ${BASE_URL}
    ${request}=  Create Dictionary  
    ...  username=${USERNAME}  
    ...  password=${PASSWORD}
    
    ${response}=  Post On Session  auth  ${AUTH_ENDPOINT}  json=${request}
    
    Log To Console   Response: ${response.txt}

    Should Be Equal As Integers   ${response.status_code}    200

    ${token}=  Get From Dictionary  ${response.json()}  token
    RETURN  ${token}  