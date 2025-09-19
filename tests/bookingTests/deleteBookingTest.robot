*** Settings ***
Library  RequestsLibrary
Library  Collections
Resource  ../../variables/variables.robot
Resource  ../../resources/bookingResource.robot
Resource    ../../resources/authResource.robot
Suite Setup  Create Session  booking  ${BASE_URL}
Suite Teardown  Delete All Sessions

*** Test Cases ***
Cenario 1 - Deletar Booking Com Sucesso
    [Documentation]  Deletar um booking existente com um token de autenticação válido.
    [Tags]  deleteBooking  positivo
    # Booking já deve existir, no caso use um booking criado anteriormente ou crie um novo
    ${booking_dates}=  Create Dictionary  checkin=2023-10-01  checkout=2023-10-10
    ${BookingBody}=  Create Dictionary  
    ...  firstname=John
    ...  lastname=Doe
    ...  totalprice=150
    ...  depositpaid=True
    ...  bookingdates=${booking_dates}
    ...  additionalneeds=Breakfast
    
    ${BookingId}=  Criar Novo Booking   ${BookingBody}  
    ${token}=  Efetuar Login e Gerar Token 
    
    ${response}=  Deletar Booking Pelo Id  ${BookingId.json()['bookingid']}  ${token}
    Should Be Equal As Integers  ${response.status_code}  201
    Log To Console   Booking Deletado com sucesso: ${response}

Cenario 2 - Tentar Deletar Booking Sem Token de Autenticação
    [Documentation]  Tentar deletar um booking existente sem fornecer um token de autenticação.
    [Tags]  deleteBooking  negativo
    # Booking já deve existir, no caso use um booking criado anteriormente ou crie um novo
    ${booking_dates}=  Create Dictionary  checkin=2023-10-01  checkout=2023-10-10
    ${BookingBody}=  Create Dictionary  
    ...  firstname=John
    ...  lastname=Doe
    ...  totalprice=150
    ...  depositpaid=True
    ...  bookingdates=${booking_dates}
    ...  additionalneeds=Breakfast
    ${BookingId}=  Criar Novo Booking   ${BookingBody}  
    # Tentar deletar o booking criado anteriormente sem token.
    ${response}=  Deletar Booking Pelo Id  ${BookingId.json()['bookingid']}  token inválido
    Should Be Equal As Integers  ${response.status_code}  403
    Log To Console   Resposta ao tentar deletar sem token: ${response}

Cenario 3 - Tentar Deletar Booking Inexistente
    [Documentation]  Tentar deletar um booking que não existe.
    [Tags]  deleteBooking  negativo
    ${token}=  Efetuar Login e Gerar Token 
    ${response}=  Deletar Booking Pelo Id  -5  ${token}  # Usando um ID que provavelmente não existe
    Should Be Equal As Integers  ${response.status_code}  405
    Log To Console   Resposta ao tentar deletar booking inexistente: ${response}