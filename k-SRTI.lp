%k-SRTI

%Input: finite set of agents -- atoms of the form agent(X)
%         finite set of unwanted pairs -- atoms of the form unwanted(X,Y) 
%        (Incomplete) preferences of agents by degree k -- atoms of the form kPrefer(X,Y,Z).
%        Preferences may contain tie-- tie(X,Y,Z).  
%        kPrefer(X,0,X) is included for every agent X.

%Output: A k-stable matching of roommates -- room size is 2

% Assumptions: 
%  A single agent is matched to herself.
%  Transitivity of preferences is included in the instance description.

% Define: Acceptability -- agent Y is acceptable to X if X prefers Y.
kacceptable(X,Y) :- kPrefer(X,Y,_).
kacceptable(X,Y) :- kPrefer(X,_,Y).


% Generate a matching: For every agent X, find exactly 1 roommate
1{roommate(X,Y): agent(X), kacceptableTo(X,Y)}1 :- agent(Y).
:- roommate(X,Y), not roommate(Y,X), agent(X;Y).

% Remark: The matching is symmetric and injective 

% Define: singles
single(X) :- roommate(X,X), agent(X). 

% Define: agent X prefers agent Y to her roommate X1
like(X,Y) :- roommate(X,X1), kPrefer(X,Y,X1), Y!=X1.

% Define: Tie -- agent X is indifferent between Y and her roommate X1.
%indifferent(X,Y) :- acceptable(X,Y), roommate(X,X1), not prefer(X,X1,Y), not prefer(X,Y,X1), Y!=X1.

% Define: X and Y acceptable to each other
kacceptableTo(X,Y) :- kacceptable(X,Y),kacceptable(Y,X).

% Define: blocking pairs -- a pair (X,Y) is blocking if (i) x and y are acceptable to each other, (ii) (a) single(X) or (b) like(X,Y), and (iii) (a) single(Y) or (b) like(Y,X)

% (i) and (ii)(a) and (iii)(a)
blocking(X,Y) :- kacceptableTo(X,Y), single(X), single(Y), X!=Y, not roommate(X,Y).

% (i) and (ii)(a) and (iii)(b)
blocking(X,Y) :- kacceptableTo(X,Y), single(X), like(Y,X), X!=Y, not roommate(X,Y).

% (i) and (ii)(b) and (iii)(a)
blocking(X,Y) :- kacceptableTo(X,Y), like(X,Y), single(Y), X!=Y, not roommate(X,Y).


% (i) and (ii)(b) and (iii)(b)
blocking(X,Y) :- kacceptableTo(X,Y), like(X,Y), like(Y,X), X!=Y, not roommate(X,Y).


% Test: Eliminate the matchings blocked by a pair (X,Y)

:- blocking(X,Y), X!=Y.

% Display : Show only the matching

#show roommate/2.
