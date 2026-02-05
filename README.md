# PPCP Nutribreads

* Esse projeto foi como construido com Flutter e Supabase.
* Existe algumas consultas e inserão de dados em um segundo DB mysql.
* Toda a interaão com ambos DB são feitas por meio de API.

## Componentes

1. **`cardcabecalho_exec_producao.dart`:**
Componente responsável por criar o cabealho na tela que exibe as ordens todas as ordens de produção.
Parâmetros:

| Paramêtro       | Descrição                                            | Tipo     |
|:---------------:|:----------------------------------------------------:| :------: |
| buttonSuperior  | Titulo do botão superior                             | String   |
| producao        | Titulo do botão superior                             | String   |
| linhaProd       | Linha de produão que irá produzir                    | String   |
| data            | Data de lançamento da ordem                          | String   |
| onTap           | Ações a serem executadas ao clicar no botão Superior | String   |

Exemplo de uso:
````
    CabecalhoExecProducao(
                buttonSuperior: 'Produtos da Ordem',
                producao: 'OP-2026-0147',
                linhaProd: 'Linha 01',
                data: '03/02/2026',
                onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListaPoroducao(),
                    ),
                    );
                },
                ),
````

2. **`cabecalho_list_ordens.dart`**

Componente responsável por criar o cabealho na tela que exibe as ordens todas as ordens de produção.
Parâmetros:

| Paramêtro       | Descrição                                            | Tipo     |
|:---------------:|:----------------------------------------------------:| :------: |
| buttonSuperior  | Titulo do botão superior                             | String   |
| producao        | Titulo do botão superior                             | String   |
| linhaProd       | Linha de produão que irá produzir                    | String   |
| data            | Data de lançamento da ordem                          | String   |
| onTap           | Ações a serem executadas ao clicar no botão Superior | String   |



Exemplo de uso:
````
    CabecalhoListOrdens(
                quantidade_pendente: 30,
                onTap: () {
                    print('Atualizando lista de ordens de produção...');
                },
                ),
````

