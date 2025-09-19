# Robot-Api-Pratice

Projeto de prática de automação de testes com Robot Framework para APIs públicas, incluindo operações GET, POST, PUT e DELETE, com foco em autenticação e manipulação de respostas.


## Tutorial de Uso

### 1. Criar e ativar o ambiente virtual

```bash
python3 -m venv .venv
source .venv/bin/activate  # Linux/macOS
# .venv\Scripts\activate   # Windows
```

### 2. Instalar as dependências

```bash
pip install -r requirements.txt
```

### 3. Executar os testes

```bash
robot tests/
```

### 4. Desativar o ambiente virtual

```bash
deactivate
```

## Estrutura do Projeto

```
Robot-Api-Pratice/
├── tests/
│   ├── authTests/
│   │   └── authTests.robot
│   ├── bookingTests/
│   │   ├── deleteBookingTest.robot
│   │   ├── getBookingIdsTests.robot
|   |   ├── getBookingUniqueIdTests.robot
|   |   ├── patchBookingTest.robot
|   |   ├── postBookingCreateTest.robot
│   │   └── putBookingTest.robot
│   └── pingTests/
│       └── pingTest.robot
├── resources/
│   ├── authResource.robot
│   ├── bookingResource.robot
│   └── pingResource.robot
├── variables/
│   └── variables.robot
├── requirements.txt
└── README.md
```

## API utilizada

Este projeto utiliza a [Restful Booker API](https://restful-booker.herokuapp.com/), uma API pública para testes de automação.

### Rotas e verbos abrangidos

- **Autenticação**
    - `POST /auth` — Geração de token de autenticação

- **Booking**
    - `GET /booking` — Listar todos os IDs de reservas
    - `GET /booking/{id}` — Buscar detalhes de uma reserva específica
    - `POST /booking` — Criar uma nova reserva
    - `PUT /booking/{id}` — Atualizar uma reserva existente
    - `PATCH /booking/{id}` — Atualizar parcialmente uma reserva
    - `DELETE /booking/{id}` — Excluir uma reserva

- **Ping**
    - `GET /ping` — Verificar disponibilidade da API

