%% CS 81, Logic and Computability
%% Homework 4, Problem 2
%% Graphs!
%% YOUR NAME HERE
%% DATE HERE

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BASE CASE - STARTER CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%%
path(X, X, _, [X], K) :- K >= 0.

%%%%%%%%%%%%%
%% YOUR TURN!
%%%%%%%%%%%%%
path(X, Y, Graph, [X | Rest], Budget) :- 
    member([X, Next, Cost], Graph),
    NewBudget is Budget - Cost,
    NewBudget >= 0,
    path(Next, Y, Graph, Rest, NewBudget).