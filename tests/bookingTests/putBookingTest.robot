*** Settings ***
Library  RequestsLibrary
Library  Collections
Resource  ../../variables/variables.robot
Resource  ../../resources/bookingResource.robot
Resource    ../../resources/authResource.robot
Suite Setup  Create Session  booking  ${BASE_URL}
Suite Teardown  Delete All Sessions

*** Test Cases ***
Cenario 1 - Alterar Booking Com Sucesso
    [Documentation]  Atualizar um booking existente com dados válidos e um token de autenticação válido.
    [Tags]  putBooking  positivo
    # Booking já deve existir, no caso use um booking criado anteriormente ou crie um novo booking aqui.
    ${criar_booking_body}=  Create Dictionary  
    ...  firstname=John
    ...  lastname=Doe
    ...  totalprice=150
    ...  depositpaid=True
    ...  bookingdates=${EMPTY}
    ...  additionalneeds=Breakfast
    ${booking_dates}=  Create Dictionary  checkin=2023-10-01  checkout=2023-10-10
    Set To Dictionary  ${criar_booking_body}  bookingdates=${booking_dates}
    ${BOOKING}=  Criar Novo Booking   ${criar_booking_body}
    ${token}=  Efetuar Login e Gerar Token 
    # Atualizar o booking criado anteriormente.
    ${booking_dates}=  Create Dictionary  checkin=2023-11-01  checkout=2023-11-15
    ${atualizar_booking_body}=  Create Dictionary  
    ...  firstname=Jane
    ...  lastname=Doe
    ...  totalprice=251
    ...  depositpaid=False
    ...  bookingdates=${booking_dates}
    ...  additionalneeds=Late Checkout
    ${atualizar_response}=   Atualizar Booking Pelo Id  ${BOOKING.json()['bookingid']}  ${atualizar_booking_body}  ${token}
    
    Should Be Equal As Integers  ${atualizar_response.status_code}  200
    ${updated_firstname}=  Get From Dictionary  ${atualizar_response.json()}  firstname
    Should Be Equal As Strings  ${updated_firstname}  Jane
    ${updated_totalprice}=  Get From Dictionary  ${atualizar_response.json()}  totalprice
    Should Be Equal As Integers  ${updated_totalprice}  251
    Log To Console   Booking Atualizado: ${atualizar_response.json()}

Cenario 2 - Tentar Alterar Booking Sem Token de Autenticação
    [Documentation]  Tentar atualizar um booking existente sem fornecer um token de autenticação.
    [Tags]  putBooking  negativo
    # Booking já deve existir, no caso use um booking criado anteriormente ou crie um novo
    ${criar_booking_body}=  Create Dictionary
    ...  firstname=John
    ...  lastname=Doe
    ...  totalprice=150
    ...  depositpaid=True
    ...  bookingdates=${EMPTY}
    ...  additionalneeds=Breakfast
    ${booking_dates}=  Create Dictionary  
    ...  checkin=2023-10-01
    ...  checkout=2023-10-10
    Set To Dictionary  ${criar_booking_body}  bookingdates=${booking_dates}
    ${BOOKING}=  Criar Novo Booking   ${criar_booking_body}
    # Tentar atualizar o booking criado anteriormente sem token.
    ${booking_dates}=  Create Dictionary  
    ...  checkin=2023-11-01
    ...  checkout=2023-11-15
    ${atualizar_booking_body}=  Create Dictionary
    ...  firstname=Jane
    ...  lastname=Doe
    ...  totalprice=251
    ...  depositpaid=False
    ...  bookingdates=${booking_dates}
    ...  additionalneeds=Late Checkout
    ${atualizar_response}=   Atualizar Booking Pelo Id  ${BOOKING.json()['bookingid']}  ${atualizar_booking_body}  token inválido
    Should Be Equal As Integers  ${atualizar_response.status_code}  403
    Log To Console   Erro ao tentar alterar booking sem token: ${atualizar_response}

Cenario 3 - Tentar Alterar Booking com ID Inexistente
    [Documentation]  Tentar atualizar um booking com um ID que não existe.
    [Tags]  putBooking  negativo
    ${token}=  Efetuar Login e Gerar Token
    ${booking_dates}=  Create Dictionary
    ...  checkin=2023-11-01
    ...  checkout=2023-11-15
    ${atualizar_booking_body}=  Create Dictionary
    ...  firstname=Jane
    ...  lastname=Doe
    ...  totalprice=251
    ...  depositpaid=False
    ...  bookingdates=${booking_dates}
    ...  additionalneeds=Late Checkout
    ${invalid_id}=  Set Variable  -5  # ID que provavelmente não existe
    ${atualizar_response}=   Atualizar Booking Pelo Id  ${invalid_id}  ${atualizar_booking_body}  ${token}
    Should Be Equal As Integers  ${atualizar_response.status_code}  405
    Log To Console   Erro ao tentar alterar booking com ID inexistente: ${atualizar_response}