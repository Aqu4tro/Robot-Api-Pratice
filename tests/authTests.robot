*** Settings ***
Library  ../resources/authResource.robot

*** Test Cases ***
Cenario 1 - Login efetuado e Token Gerado Com Sucesso
    ${token}=  Efetuar Login e Gerar Token
    Log To Console    Token: ${token}
    Should Not Be Empty    ${token}