*** Settings ***
Resource  /home/aqu4tro/Desktop/Robot-Api-Pratice/resources/authResource.robot
Suite Teardown  Delete All Sessions

*** Test Cases ***
Cenario 1 - Login efetuado e Token Gerado Com Sucesso
    ${token}=   Efetuar Login e Gerar Token
    Log To Console    Token: ${token}
    Should Not Be Empty    ${token}

Cenario 2 - Login com Credenciais Inválidas
    ${payload}=  Create Dictionary  
    ...  username=fakeuser  
    ...  password=fakepassword
    ${response}=  POST On Session  auth  ${AUTH_ENDPOINT}  json=${payload}
    Log To Console    Erro ao Logar: ${response.json()}
    Dictionary Should Contain Value    ${response.json()}    Bad credentials