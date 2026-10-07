%% CS 81, Logic and Computability
%% Homework 4, Problem 1
%% More Trees!
%% Luke Morgan
%% 10/6/26

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BASE CASE - STARTER CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%%
insert(E, [], [E, [], []]).

%%%%%%%%%%%%%
%% YOUR TURN!
%%%%%%%%%%%%%
insert(E, [Root, Left, Right], [Root, NewLeft, Right]) :- E < Root, insert(E, Left, NewLeft).
insert(E, [Root, Left, Right], [Root, Left, NewRight]) :- E > Root, insert(E, Right, NewRight).