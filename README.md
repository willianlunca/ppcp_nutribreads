# PPCP Nutribreads

* Esse projeto foi como construido com Flutter e Supabase.
* Existe algumas consultas e inserão de dados em um segundo DB mysql.
* Toda a interaão com ambos DB são feitas por meio de API.

## Componentes

1. **`cardcabecalho_exec_producao.dart`:**
Componente responsável por criar o cabealho na tela de execução de produção.
Parâmetros:

| Paramêtro       | Descrição                                            | Tipo           |
|:--------------- |:---------------------------------------------------- | :------------- |
| buttonSuperior  | Titulo do botão superior                             | String         |
| ordeProducao    | Titulo da ordem de produção                          | String         |
| linhaProd       | Linha de produção que irá produzir                   | String         |
| data            | Data de lançamento da ordem                          | String         |
| onTap           | Ações a serem executadas ao clicar no botão Superior | VoidCallback   |

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

| Paramêtro            | Descrição                                            | Tipo           |
|:-------------------- |:---------------------------------------------------- | :------------  |
| quantidade_pendente  | Quantidade de ordens pendentes                       | int            |
| onTap                | Ações a serem executadas ao clicar no botão Superior | VoidCallback   |



Exemplo de uso:
````
    CabecalhoListOrdens(
                quantidade_pendente: 30,
                onTap: () {
                    print('Atualizando lista de ordens de produção...');
                },
                ),
````

3. **`card_ordem.dart`**

Componente responsável por montar na tela o card que contem uma ordem de produção.
 
| Paramêtro            | Descrição                                            | Tipo           |
|:-------------------- |:---------------------------------------------------- | :------------  |
| descricaoOrdem       | Descrição da ordem                                   | String         |
| prioridade           | Nivel de prioridade da ordem                         | String         |
| linhaProducao        | Local onde será produzido                            | String         |
| data                 | Data de criação da ordem.                            | String         |
| qtdProduzidas        | Quantidade de itens já produzidos da ordem.          | String         |
| onTap                | Ações a serem executadas ao clicar no botão Superior | VoidCallback   |

Exemplo de uso:
````
    CardOrdem(
                        descricaoOrdem: 'OP-2026-0147',
                        prioridade: contador.toString(), // ✅ aqui
                        linhaProducao: 'Linha 02',
                        data: '02/02/2026',
                        qtdItens: 8,
                        qtdProduzidas: 3, // ✅ se quiser mudar também
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
