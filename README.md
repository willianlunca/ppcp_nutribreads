# PPCP Nutribreads

* Esse projeto foi como construido com Flutter e Supabase.
* Existe algumas consultas e inserão de dados em um segundo DB mysql.
* Toda a interaão com ambos DB são feitas por meio de API.

## Componentes

**cardcabecalho_exec_producao.dart:**
Componente responsável por criar o cabealho na tela que exibe as ordens todas as ordens de produção.
Parâmetros:
1. buttonSuperior: *`Titulo do botão superior`*
2. producao: *`Titulo da ordem de produção`*
3. linhaProd: *`Linha de produão que irá produzir`*
4. data: *`Data de lançamento da ordem`*
5. onTap: *`Ações a serem executadas ao clicar no botão Superior`*

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

