%verifica se uma lista esta vazia
isEmpty([]).

%define condicoes impossiveis para uma meta especifica

%verifica se um bloco esta sendo colocado em uma posicao que ja esta ocupada por outro bloco
impossible(on(Block,at(X1,Y1)),Goals):-
    member(on(Block2,at(X1,Y1)),Goals),
    dif(Block,Block2),
    !.

%verifica se um bloco esta sendo colocado em uma posicao diferente da posicao atual
impossible(on(Block,at(X1,Y1)),Goals):-
    member(on(Block,at(X2,Y2)),Goals),
    dif(at(X1,Y1),at(X2,Y2)),
    !.

%verifica se uma posicao esta marcada como clear mas ja esta ocupada por um bloco
impossible(clear(X1,Y1), Goals):-
    member(on(_, at(X1, Y1)), Goals),
    !.

%verifica se o plano foi satisfeito
plan(State, Goals, []):-
    satisfied(State, Goals).  

%gera um plano de acoes para atingir as metas a partir do estado inicial
plan(State, Goals, Plan):-
    append(PrePlan, [Action], Plan), 
    select(State, Goals, Goal), 
    achieves(Action, Goal), 
    preserves(Action,Goals),   
    regress(Goals, Action, RegressedGoals),
    plan(State, RegressedGoals, PrePlan).


%verifica se todas as metas foram satisfeitas no estado atual
satisfied(_, []). % caso base (sem goals)

%verifica se a primeira meta esta no estado atual e continua verificando as restantes
satisfied(State, [Goal|Goals]):-
    member(Goal, State),   
    satisfied(State, Goals). 

%seleciona uma meta nao resolvida
select(State, Goals, Goal):-    
    delete_all(Goals, State, GoalsNResolvidas), 
    member(Goal, GoalsNResolvidas). 

%verifica se uma acao atinge uma meta
achieves(Action, Goal):-
    adds(Action, Goals),
    member(Goal, Goals).

%verifica se uma acao nao quebra outras metas
preserves(Action , Goals):-
    deletes(Action, Relations),
    naoQuebra(Relations, Goals).

%verifica se uma lista de relacoes nao quebra nenhuma meta
naoQuebra([H|_], Goals):-
    member(H, Goals),
    !,
    fail.

naoQuebra([_|T], Goals):-
    naoQuebra(T, Goals).

naoQuebra([], _).

%regressa as metas baseadas na acao
regress(Goals, Action, RegressedGoals):-
    adds(Action, NewRelations),
    delete_all(Goals, NewRelations, RestGoals),
    deletes(Action,Condition),
    addnew(Condition, RestGoals, RegressedGoals).


%adiciona novos objetivos se nao forem impossiveis
addnew([], L, L).
addnew([Goal | _], Goals, _):-
    impossible(Goal, Goals),
    !,
    fail.

addnew([X|L1], L2, L3):-
    member(X,L2),
    !,
    addnew(L1, L2, L3).

addnew([X|L1], L2, [X|L3]):-
    addnew(L1,L2,L3).

%remove todos os elementos de uma lista que estao em outra lista
delete_all([],_,[]).

delete_all([X|L1], L2, Diff):-
    member(X,L2),
    !,
    delete_all(L1, L2, Diff).

delete_all([X|L1], L2, [X|Diff]):-
    delete_all(L1, L2, Diff).

%inicia o processo de planejamento a partir do estado6 para o estado7
to_plan(L):-
    state6(Inicio),
    state7(Goals),
    plan(Inicio, Goals, L).



