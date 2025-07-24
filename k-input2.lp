%Input
agent(1..6).
prefer2(1,2,1).
prefer2(3,2,4).
prefer2(4,3,4).
prefer2(5,3,5).
prefer2(6,1,6).

iprefer(1,2,4).
iprefer(2,6,5).
iprefer(4,3,2).
iprefer(5,3,1).
iprefer(6,1,3).

tie(X,Y,Z) :- tie(X,Z,Y).

% y is stated as unwanted for x
unwanted(3,5).

% value of k
#const k=1.
