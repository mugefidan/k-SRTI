%k-SRTI
%k-connectedness
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% acceptability
accept(X,Y) :- prefer2(X,Y,_).
accept(X,Y) :- prefer2(X,_,Y).

inferred(X,Y) :- iprefer(X,Y,_), not prefer2(X,Y,_).
inferred(X,Y) :- iprefer(X,_,Y).

%%% unwanted agents
not_accept(X,Y) :- 1{unwanted(X,Y); unwanted(Y,X)}, agent(X), agent(Y), X!=Y.

%% u states v as an acceptable or not_acceptable, OR,  v states u as an acceptable or not_acceptable
know(X,Y) :- 1{accept(X,Y);accept(Y,X);not_accept(X,Y)}, agent(X), agent(Y), X!=Y.

%k-acceptability graph: G=(V,E), each vertex -> agent and uv in E if uv knows & acceptable pairs
edge(X,Y) :- know(X,Y), not not_accept(X,Y), agent(X), agent(Y), X!=Y.

%% Students u and v are k-connected pairs if there is path from u to v with length k
connected(X,Y,1) :- edge(X,Y), agent(X), agent(Y), X!=Y, k>0.
connected(X,Y,K+1) :- connected(X,Z,K), edge(Z,Y), agent(Y), X!=Y,K<k.

%break ties in preference list
iprefer(X,Y,Z) :- tie(X,Y,Z), connected(X,Y,K), not connected(X,Z,K).

%% k-extended prefence list
% acceptable with degree k
may_accept(X,Y,K) :- not accept(X,Y), not unwanted(X,Y), not inferred(X,Y), connected(X,Y,K). 

% extending preference list
ePrefer(X,Y,Z) :- prefer2(X,Y,Z).
ePrefer(X,Y,Z) :- iprefer(X,Y,Z).
ePrefer(X,Y,Z) :- prefer2(X,_,Y), iprefer(X,Z,_), X!=Y. 
ePrefer(X,Z,X) :- iprefer(X,_,Z), not prefer2(X,Z,_).

% extending preferences by degree k
prefer(X,Z,X,K):- may_accept(X,Z,K), X!=Z, K<k+1.
prefer(X,Y,Z,K):- ePrefer(X,Y,_), may_accept(X,Z,K), X!=Y.
prefer(X,Y,Z,K1) :- prefer(X,Y,_,K), not ePrefer(X,Z,_), may_accept(X,Y,K), may_accept(X,Z,K1), not may_accept(X,Z,K), K<K1, X!=Y, Y!=Z.
prefer(X,Y,Z,K1) :- prefer(X,_,Y,K), not ePrefer(X,Z,_), may_accept(X,Y,K), may_accept(X,Z,K1), not may_accept(X,Z,K), K<K1, X!=Y, Y!=Z.

% define k-extended preference list
kPrefer(X,Y,Z) :- ePrefer(X,Y,Z), X!=Y.
kPrefer(X,Y,Z) :- prefer(X,Y,Z,K), X!=Y, K<k+1.

