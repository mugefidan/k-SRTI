%Input
agent(1..5).
prefer2(1,5,1).
prefer2(2,5,2).
prefer2(3,2,3).
prefer2(4,2,4).
prefer2(5,4,5).

iprefer(1,5,2).
iprefer(3,2,1).
iprefer(3,2,5).
tie(3,1,5).

tie(X,Y,Z) :- tie(X,Z,Y).

% y is stated as unwanted for x
unwanted(2,4).

% value of k
#const k=1.
