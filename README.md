# $k$-Personalized-SRTI
The aim is to find personalized good-enough matchings when there is no stable matching.

The definitions, experimental evaluations, and results are described in the following article, which has been accepted for publication in TPLP 2025:

"Finding Personalized Good-Enough Solutions to Unsatisfiable Stable Roommates Problems"
MÜGE FIDAN and ESRA ERDEM
Accepted for publication in TPLP, 2025.
(A link will be added once the article is published.)


## Motivation
In real-world settings such as dormitory assignments, students often meet others through mutual friends and sometimes build positive relationships through these indirect connections. Inspired by this, we propose a method that extends agents' preference lists by considering the networks of agent’s preferred friends.

In particular, for every agent $x$, our method extends the preference list of $x$ by including every agent $y$ who is not already in $x$’s preference list but “k-connected” to $x$ (i.e., $x$ and $y$ are connected a chain of $k$ PFOAF—preferred friend of a friend—relations).

## Problem Definition
A $k$-Personalized-SRTI instance is defined as $(A,A^-,\prec^{k''})$, where:

-*A*: a finite set of agents

-*A⁻*: a set of unwanted pairs

-*≺ᵏ''*: a collection of $k$-extended preference lists.

## Overview of Files

```k-connected.lp``` This program computes the k-extended preference lists.
#### Input:
- $agent(x)$: defines each agent
- $prefer2(x,y,z)$: agent $x$ prefers $y$ to $z$ based on stated preferences
- $iprefer(x,y,z)$: agent $x$ prefers $y$ to $z$ based on habitual preferences
- $unwanted(x,y)$: agent $y$ is unwanted by agent $x$
#### Constant 
- *k*: the value of $k$
#### Output: 
- $kPrefer(x,y,z)$: agent $x$ prefers $y$ to $z$ by degree $k$

```k-SRTI.lp``` This program computes a $k$-stable matching using the $k$-extended preference lists.

### How to Use
Run the ASP solver as follows:
```clingo k-connected.lp k-SRTI.lp k-input.lp --const k=1```
