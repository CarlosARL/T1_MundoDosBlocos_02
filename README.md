# T1_MundoDosBlocos_02

## Descrição
Este repositório contém arquivos para o projeto "Mundo dos Blocos", desenvolvido no âmbito do curso de Inteligência Artificial na Universidade Federal do Amazonas. O projeto envolve scripts em Prolog que implementam um planejador de blocos, determinando a sequência de movimentos para reorganizar blocos de um estado inicial para um estado final desejado.

## Arquivos
- `Trabalho1_IA_01.pl`: Script Prolog para a Tarefa 1.
- `Trabalho1_IA_02.pl`: Script Prolog para a Tarefa 2.
- `Respostas_Mundo_dos_Blocos.pdf`: Documento contendo respostas e explicações detalhadas sobre o funcionamento do planejador e as soluções para os problemas propostos.

## Estrutura dos Scripts Prolog

### Definição de Blocos e Locais
- `block(X)`: Define os blocos `a`, `b`, `c` e `d`.
- `place(X)`: Define os locais numerados de 0 a 5, representando as posições possíveis para os blocos.

### Propriedades dos Blocos
- `height(Block, Height)`: Define a altura de cada bloco como 1.
- `length(Block, Length)`: Define o comprimento de cada bloco, variando de 1 a 3.

### Estados
- `final(List)`: Define o estado final desejado, listando as posições dos blocos e as posições livres.
- `state(List)`: Define o estado inicial dos blocos.
- `state0`, `state3`, `state4`, `state6`, `state7`: Definem estados intermediários para testes.

### Predicados Auxiliares
- `clearInterval(X1, X2, Y, List)`: Gera uma lista de posições livres (representadas por `clear(X,Y)`) em um intervalo de X1 a X2, na altura Y.

### Regras de Movimento (Predicado `can`)
O predicado `can(move(Block, From, To), List)` verifica se um movimento é possível, considerando:
- Se o bloco existe e suas dimensões.
- Se as posições inicial e final são válidas.
- Se a posição final está livre.
- Se o movimento respeita as regras de estabilidade.

Existem quatro versões do predicado `can`, cada uma lidando com um comprimento de bloco específico.

### Efeitos dos Movimentos (Predicados `adds` e `deletes`)
- `adds(Move, List)`: Define as novas relações adicionadas após um movimento.
- `deletes(Move, List)`: Define as relações removidas após um movimento.

### Observações
- O código assume que um bloco só pode ser movido se estiver no topo de uma pilha.
- A estabilidade é verificada garantindo que os blocos sejam suportados adequadamente nas laterais.
- O código não implementa a lógica completa do planejador, faltando predicados como `plan`, `satisfied`, `select`, `achieves`, `preserves` e `regress`, necessários para gerar o plano de movimento.

## Funcionalidades Principais
- **Representação de Estados**: Estados representados por listas de termos Prolog.
- **Ações**: Definição de ações para mover blocos, considerando restrições de movimento.
- **Planejamento**: A função `plan/3` implementa a lógica principal de planejamento.
- **Satisfied/2**: Verifica se um estado satisfaz todas as metas especificadas.
- **Select/3**: Seleciona uma meta que ainda não foi alcançada.
- **Achieves/2**: Verifica se uma ação específica contribui para atingir uma meta.
- **Preserves/2**: Garante que uma ação não invalida metas já alcançadas.
- **Regress/3**: Determina as submetas necessárias para alcançar um objetivo.

## Exemplo de Uso
A função `to_plan/1` demonstra como usar o planejador para encontrar uma sequência de ações que leve o sistema do estado `state6` para o estado `state7`.

## Instalação
Para executar os scripts Prolog, você precisa ter um interpretador Prolog instalado. Recomendamos usar o [SWI-Prolog](https://www.swi-prolog.org/).

1. Baixe e instale o SWI-Prolog a partir [deste link](https://www.swi-prolog.org/Download.html).
2. Clone este repositório:
    ```bash
    git clone https://github.com/CarlosARL/T1_MundoDosBlocos_02.git
    cd T1_MundoDosBlocos_02
    ```

## Uso
Para executar um script Prolog, abra um terminal e use o seguinte comando:
```bash
swipl -s Trabalho1_IA_01.pl
