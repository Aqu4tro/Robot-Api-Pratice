*** Settings ***
Library  RequestsLibrary
Library  Collections
Resource  ../../variables/variables.robot
Resource  ../../resources/pingResources.robot
Suite Teardown  Delete All Sessions

*** Test Cases ***
Validar se a API está no ar
    [Documentation]  Realiza um get para o endpoint /ping e valida se a api está no ar
    [Tags]  ping  smoke
    Check Ping Api