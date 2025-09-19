*** Settings ***
Library  RequestsLibrary
Library  Collections
Resource  ../../variables/variables.robot
Resource  ../../resources/bookingResource.robot
Resource    ../../resources/authResource.robot


*** Test Cases ***
Cenario 1 - Alterar Booking Parcialmente(PATCH) Com Sucesso
    [Documentation]  Atualizar parcialmente um booking existente com dados válidos e um token de autenticação válido.
    [Tags]  patchBooking  positivo
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
    # Atualizar parcialmente o booking criado anteriormente.
    ${atualizar_booking_body}=  Create Dictionary  
    ...  firstname=Jane
    ...  totalprice=251
    ${atualizar_response}=    Atualizar Booking Parcialmente Pelo Id   ${BOOKING.json()['bookingid']}  ${atualizar_booking_body}  ${token}
    
    Should Be Equal As Integers  ${atualizar_response.status_code}  200
    ${updated_firstname}=  Get From Dictionary  ${atualizar_response.json()}  firstname
    Should Be Equal As Strings  ${updated_firstname}  Jane
    ${updated_totalprice}=  Get From Dictionary  ${atualizar_response.json()}  totalprice
    Should Be Equal As Integers  ${updated_totalprice}  251
    Log To Console   Booking Parcialmente Atualizado: ${atualizar_response.json()}

Cenario 2 - Tentar Alterar Booking Parcialmente(PATCH) Sem Token de Autenticação
    [Documentation]  Tentar atualizar parcialmente um booking existente sem fornecer um token de autenticação
    [Tags]  patchBooking  negativo
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
    # Tentar atualizar parcialmente o booking criado anteriormente sem token.
    ${atualizar_booking_body}=  Create Dictionary
    ...  firstname=Jane
    ...  totalprice=251
    ${atualizar_response}=   Atualizar Booking Parcialmente Pelo Id  ${BOOKING.json()['bookingid']}  ${atualizar_booking_body}  token inválido
    Should Be Equal As Integers  ${atualizar_response.status_code}  403
    Log To Console   Resposta ao tentar atualizar parcialmente sem token: ${atualizar_response}
