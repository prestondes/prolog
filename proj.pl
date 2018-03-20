subVerify(_,[]) :- !,fail.
subVerify(A,[H|T]) :- A == H ; subVerify(A,T).
subset([],_) :- !,true.
subset([H|T],Y) :- subVerify(H,Y) -> subset(T,Y).

unionVerify(_,[]) :- true.
unionVerify(A,[H|T]) :- A == H -> fail ; unionVerify(A,T) -> true.
reversalU(B,[],U) :- U = B.
reversalU(B,[H|T],U) :- reversalU([H|B],T,U).
unionBin([],B,C,U) :- reversalU(B,C,U),!,true.
unionBin([H|T],B,C,U) :- unionVerify(H,B) -> unionBin(T,B,[H|C],U) ; unionBin(T,B,C,U).
union([],B,U) :- !,U = B.
union([H|T],B,U) :- unionVerify(H,B) -> unionBin(T,B,[H],U),!,true ;  union(T,B,U).

finalCheck([],_,_) :- true.
finalCheck(_,[],_) :- fail.
finalCheck([F|B],[H|T],S) :- F == H -> finalCheck(B,S,S) ; finalCheck([F|B],T,S). 
intersectionVerify(_,[]) :- fail.
intersectionVerify(A,[H|T]) :- A == H -> true ; intersectionVerify(A,T).
reversal(A,[H|T],I) :- intersectionVerify(H,T) -> reversal([H|A],T,I),true ; intersection(A,[],I),!.
intersection(A,[],I) :- !,I = A. 
intersection([],[H|T],I) :- intersectionVerify(H,T) -> reversal([H],T,I),! ; !,I = []. 
intersection([H|T],B,I) :- (intersectionVerify(H,B) -> finalCheck(T,B,B) -> intersection(T,[H|B],I) ; intersection(T,B,I)) ; intersection(T,[H|B],I).

differenceVerify(_,[]) :- true.
differenceVerify(A,[H|T]) :- A == H -> fail ; differenceVerify(A,T).
reversalD([],C,D) :- difference(C,[],D),!,true.
reversalD([H|T],C,D) :- reversalD(T,[H|C],D).
eliminate([],_,[H|T],D) :- reversalD(T,[H],D),!,true.
eliminate([H|T],B,C,D) :- differenceVerify(H,B) -> eliminate(T,B,[H|C],D) ; eliminate(T,B,C,D).
difference(C,[],D) :- !,D = C.
difference([],_,D) :- !,D = [].
difference([H|T],B,D) :- differenceVerify(H,B) -> eliminate(T,B,[H],D),!,true ; difference(T,B,D).

elimVerify(_,[]) :- true.
elimVerify(A,[H|T]) :- A == H -> fail ; elimVerify(A,T).
reversalE(A,[],R) :- !,R = A.
reversalE(A,[H|T],R) :- reversalE([H|A],T,R).
removalE([],[H|T],R) :- reversalE([H],T,R),true,!.
removalE([H|T],B,R) :- elimVerify(H,B) -> removalE(T,[H|B],R) ; removalE(T,B,R).
elimdup([],R) :- !, R = [].
elimdup([H|T],R) :- removalE(T,[H],R),true,!.






