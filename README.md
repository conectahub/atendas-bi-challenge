# Desafio Técnico - Analista de Dados Pleno (BI)

Bem-vindo ao repositório do Desafio Técnico de BI da **Atendas CPaaS**! Este desafio foi estruturado para avaliar suas habilidades em extração de dados usando **SQL**, modelagem e visualização de dados utilizando o **Apache Superset**, e sua visão de negócios voltada a métricas de CPaaS e Customer Service.

---

## 1. Estrutura do Projeto

Este repositório contém os insumos necessários para você subir o ambiente de teste localmente:

*   `docker-compose.yml`: Orquestração dos serviços do banco de dados e do BI.
*   `superset_init.sh`: Script automático de inicialização do Apache Superset.
*   `db_init/01_init.sql`: Dump de dados fictícios que popula o banco automaticamente na primeira execução.
*   `escopo_tarefas.md`: O escopo detalhado de todas as tarefas e análises que você deve realizar.
*   `scripts/generate_data.py`: Script Python utilizado para gerar o dump de dados (apenas para referência, não é necessário executá-lo).

---

## 2. Pré-requisitos

Antes de iniciar, certifique-se de que você possui instalado na sua máquina:
*   [Docker](https://docs.docker.com/get-docker/)
*   [Docker Compose](https://docs.docker.com/compose/install/)

---

## 3. Como Inicializar o Ambiente

Para subir os serviços, abra o terminal na pasta raiz deste projeto e execute o comando:

```bash
docker compose up -d
```

Este comando irá baixar as imagens oficiais, iniciar o banco de dados PostgreSQL, carregar o dump de dados e realizar a configuração inicial do Apache Superset (criando o usuário administrador).

> [!NOTE]
> A inicialização do Superset pode levar de **1 a 2 minutos** no primeiro boot devido à execução das migrações internas. Você pode acompanhar o progresso com o comando:
> ```bash
> docker compose logs -f superset
> ```
> A inicialização estará concluída quando os logs mostrarem mensagens de inicialização do servidor web (Gunicorn).

---

## 4. Credenciais de Acesso

### Apache Superset (BI Tool)
*   **URL:** [http://localhost:8088](http://localhost:8088)
*   **Usuário:** `admin`
*   **Senha:** `admin`

### Banco de Dados PostgreSQL (Conexão externa)
Se você quiser se conectar ao banco de dados utilizando um cliente SQL externo (como DBeaver, pgAdmin ou VSCode Database Client) a partir da sua máquina host:
*   **Host:** `localhost`
*   **Porta:** `5432`
*   **Banco de Dados:** `atendas_bi`
*   **Usuário:** `postgres`
*   **Senha:** `atendas_secure_pass`

---

## 5. Como Conectar o PostgreSQL no Apache Superset

Para realizar suas consultas e construir os dashboards, você precisa conectar o banco no Superset. Siga estes passos simples:

1.  Acesse o Apache Superset em [http://localhost:8088](http://localhost:8088) e faça login.
2.  No menu superior direito, clique em **Settings (ícone de engrenagem) ⚙️** > **Database Connections**.
3.  Clique no botão **+ Database** no canto superior direito.
4.  Na janela que se abre, selecione **PostgreSQL** na lista suspensa.
5.  No campo **SQLAlchemy URI**, insira a string de conexão abaixo:
    ```text
    postgresql://postgres:atendas_secure_pass@db:5432/atendas_bi
    ```
    > [!IMPORTANT]
    > Note que o host na string acima é **`db`** e não `localhost`. Isso ocorre porque o Apache Superset está rodando dentro de um container Docker e se comunicará com o PostgreSQL através da rede interna do Docker Compose, onde o serviço do banco de dados chama-se `db`.
6.  Clique em **Test Connection**. Se estiver tudo correto, você verá uma mensagem de sucesso.
7.  Clique em **Connect** (ou **Save**) para concluir.

Pronto! Agora você tem acesso completo às tabelas `companies`, `channels`, `messages_sent` e `support_tickets` no ambiente do Superset para criar suas análises no **SQL Lab** e estruturar seus gráficos.

---

## 6. Próximos Passos
Abra o arquivo [escopo_tarefas.md](escopo_tarefas.md) para entender os requisitos do teste, as perguntas de SQL que precisam ser respondidas e os painéis que deverão ser desenhados. 

Boa sorte no desafio!
