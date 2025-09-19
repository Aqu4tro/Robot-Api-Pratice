*** Settings ***
Library  RequestsLibrary
Library  Collections
Resource  ../../variables/variables.robot
Resource  ../../resources/bookingResource.robot
Resource    ../../resources/authResource.robot


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