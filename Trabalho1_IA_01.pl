%definição de blocos e locais
block(a).
block(b).
block(c).
block(d).

place(0).
place(1).
place(2).
place(3).
place(4).
place(5).

%propriedade dos blocos
height(a,1).
height(b,1).
height(c,1).
height(d,1).

lenght(a,1).
lenght(b,1).
lenght(c,2).
lenght(d,3).

%estados iniciais e finais
final([clear(0,0), clear(1,0), clear(2,0), on(d,at(3,0)), clear(3,1), on(a, at(4,1)), on(b, at(5,1)), on(c,at(4,2)), clear(4,3), clear(5,3)]).
state([on(c,at(0,0)), clear(0,1), clear(1,1), clear(2,0), on(a,at(3,0)), on(d, at(3,1)), clear(4,0), on(b,at(5,0)), clear(3,2), clear(4,2), clear(5,2)]).
state0([on(c, at(0,0)), on(d, at(3,1)), on(a,at(3,0)), on(b, at(5,0)), clear(0,1), clear(1,1), clear(2,0), clear(3,2), clear(4,2), clear(5,2), clear(4,0)]).
state7([on(a, at(0,1)), on(b,at(1,1)), on(c,at(0,0)), on(d, at(3,0)), clear(0,2), clear(1,2), clear(2,0), clear(3,1), clear(4,1), clear(5,1)]).
state6([on(a, at(0,1)), on(b,at(1,1)), on(c,at(0,0)), on(d, at(2,0)), clear(0,2), clear(1,2), clear(5,0), clear(3,1), clear(4,1), clear(2,1)]).
state4([on(a, at(0,1)), on(b,at(5,0)), on(c,at(0,0)), on(d, at(2,0)), clear(0,2), clear(1,1), clear(5,1), clear(3,1), clear(4,1), clear(2,1)]).
state3([on(a, at(5,1)), on(b,at(5,0)), on(c,at(0,0)), on(d, at(2,0)), clear(0,1), clear(1,1), clear(5,2), clear(3,1), clear(4,1), clear(2,1)]).

%predicado clearinterval
clearInterval(X1, X2, _, []) :- X1 > X2, !. 

clearInterval(X1, X2, Y, [clear(X1, Y) | L]) :-
    place(X1),
    Xn is X1 + 1,
    clearInterval(Xn, X2, Y, L).

%predicado can
can(move(Block,at(Xf, Yf), at(Xt, Yt)),L):-
    block(Block),                                                      
    lenght(Block, 1),                                                  
    height(Block, BlockHeight),
    place(Xf),                                                         
    place(Yf),
    place(Xt),
    place(Yt),
    dif(at(Xf, Yf), at(Xt, Yt)),                                       
    Y1 is Yf + BlockHeight,                                            
    place(Y1),                                                          
    addnew([on(Block, at(Xf, Yf)),clear(Xt, Yt)], [clear(Xf, Y1)], L). 

can(move(Block,at(Xf, Yf), at(Xt, Yt)),[on(Block, at(Xf, Yf))|L]):-
    block(Block),                                                       
    lenght(Block, 2),                                                      
    height(Block, BlockHeight),
    place(Xf),                
    place(Yf),
    place(Xt),
    place(Yt),
    dif(at(Xf, Yf), at(Xt, Yt)),
    X3 is Xf + 1,
    X4 is Xt + 1,
    place(X3), place(X4),
    H is Yf + BlockHeight,
    place(H),
    clearInterval(Xf, X3, H, L1),                                      
    clearInterval(Xt, X4, Yt, L2),                                     
    append(L1, L2, L4),
    XEnd is Xt + 1,
    place(XEnd),
    addnew([clear(Xt, Yt), clear(XEnd, Yt)], L4, L).                   

can(move(Block,at(Xf, Yf), at(Xt, Yt)),[on(Block, at(Xf, Yf))|L]):-
    block(Block),           % Verificando se um bloco
    lenght(Block, BlockLength),
    dif(BlockLength,1),
    dif(BlockLength,2),
    height(Block, BlockHeight),
    place(Xf),                                                         
    place(Yf),
    place(Xt),
    place(Yt),
    dif(at(Xf, Yf), at(Xt, Yt)),
    X3 is BlockLength + Xf - 1,
    X4 is BlockLength + Xt - 1,
    place(X3), place(X4),
    Par is mod(BlockLength,2),                                          
    dif(Par,0),
    H is Yf + BlockHeight,
    place(H),
    clearInterval(Xf, X3, Yf, L0),
    clearInterval(Xf, X3, H, L1),                                       
    clearInterval(Xt, X4, Yt, L2),                                      
    append(L1,L2,L3),
    Mid is BlockLength // 2,
    XMid is Xt + Mid,
    place(XMid),
    addnew([clear(XMid,Yt)], L3, L4),                                   
    delete_all(L4, L0, L).

can(move(Block,at(Xf, Yf), at(Xt, Yt)),[on(Block, at(Xf, Yf))|L]):-
    block(Block),           % Verificando se � um bloco
    lenght(Block, BlockLength),
    dif(BlockLength,1),
    dif(BlockLength,2),
    height(Block, BlockHeight),
    place(Xf),                 %  Verificando os locais
    place(Yf),
    place(Xt),
    place(Yt),
    dif(at(Xf, Yf), at(Xt, Yt)),
    X3 is BlockLength + Xf - 1,
    X4 is BlockLength + Xt - 1,
    place(X3), place(X4),
    H is Yf + BlockHeight,
    place(H),
    clearInterval(Xf, X3, Yf, L0),
    clearInterval(Xf, X3, H, L1),                                      
    clearInterval(Xt, X4, Yt, L2),                                     
    append(L1,L2,L3),
    XEnd is Xt + BlockLength - 1,
    place(XEnd),
    addnew([clear(Xt, Yt) ,clear(XEnd, Yt)], L3, L4),                  
    delete_all(L4, L0, L).
    
%adds e deletes
adds(move(Block,at(Xf, Yf), at(Xt, Yt)),[on(Block,at(Xt, Yt))|L]):-
    block(Block),
    place(Xf),
    place(Yf),
    place(Xt),
    place(Yt),
    dif(at(Xf, Yf), at(Xt, Yt)),
    lenght(Block, BlockLength),
    height(Block, BlockHeight),
    X1 is Xt + BlockLength - 1,
    X2 is Xf + BlockLength - 1,
    Y1 is Yt + BlockHeight,
    Y2 is Yf + BlockHeight,
    place(X1), place(X2),
    place(Y1), place(Y2),
    clearInterval(Xf, X2, Y2, L5),
    clearInterval(Xt, X1, Y1, L1),                                     
    XEnd is Xf + BlockLength - 1,
    place(XEnd),
    clearInterval(Xf, XEnd, Yf, L2),
    clearInterval(Xt, X1, Yt, L3),
    append(L1, L2, L4),
    delete_all(L4, L3, L6),
    delete_all(L6, L5, L).


deletes(move(Block,at(Xf, Yf), at(Xt, Yt)),[on(Block,at(Xf, Yf))|L]):-
    block(Block),
    place(Xf),
    place(Yf),
    place(Xt),
    place(Yt),
    dif(at(Xf, Yf), at(Xt, Yt)),
    lenght(Block, BlockLength),
    height(Block, BlockHeight),
    X1 is BlockLength + Xf - 1,
    Y1 is Yf + BlockHeight,
    place(X1),
    place(Y1),
    X2 is BlockLength + Xt - 1,
    Y2 is BlockHeight + Yt,
    place(X2),
    place(Y2),
    clearInterval(Xt, X2, Y2, L5),
    clearInterval(Xf, X1, Y1, L1),                                     
    XEnd is Xt + BlockLength - 1,
    Y3 is Yt,
    place(XEnd),
    place(Y3),
    clearInterval(Xt, XEnd, Y3, L2),                                   
    clearInterval(Xf, X1, Yf, L3),
    append(L1,L2,L4),
    delete_all(L4, L3, L6), 
    delete_all(L6, L5, L).
