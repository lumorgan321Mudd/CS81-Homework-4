%% CS 81, Logic and Computability
%% Homework 4, Problem 4
%% Fox, hare, lettuce, man
%% Luke Morgan
%% 10/6/26

%% A configuration comprises a list of two lists in which
%% the first list in the pair consists of the items on the left bank
%% and the second list consists of the items on the right bank.  The
%% man is considered to be an item.  The lists will be kept in sorted
%% order such that man precedes fox precedes hare precedes lettuce.

permutation([], []).
permutation(L, [F | R]) :-
    append(BeforeF, [F | AfterF], L),
    append(BeforeF, AfterF, Other),
    permutation(Other, R).

%% The sorted ordering for a configuration is stipulated here.

precedes(man, fox).
precedes(fox, hare).
precedes(hare, lettuce).

ordered(X, Y) :- precedes(X, Y).
ordered(X, Y) :- 
    precedes(X, Z),
    ordered(Z, Y). 

sorted([]).
sorted([_]).
sorted([First, Second | Rest]) :- 
    ordered(First, Second), sorted([Second | Rest]).

%% A list is safe if it contains the man or is benign.

safe(L) :- member(man, L).

safe(L) :- benign(L).

benign(L) :- 
    not_fox_and_hare(L),
    not_hare_and_lettuce(L).

not_fox_and_hare(L) :- \+ (member(fox, L), member(hare, L)).
not_hare_and_lettuce(L) :- \+ (member(hare, L), member(lettuce, L)).


%% The initial configuration, therefore, is:
%% [ [man, fox, hare, lettuce], [] ]

:- dynamic marked/1.

initial([[man, fox, hare, lettuce], []]).
final([[], [man, fox, hare, lettuce]]).

%% The solve predicate simply retracts all previous marked assertions
%% and calls cross to solve the puzzle.

solve(Configuration, X) :- retractall(marked(X)), cross(Configuration, X).

cross(Configuration, []) :- final(Configuration).

cross(Configuration, ListOfMoves) :-
    ListOfMoves = [Move | RestOfMoves],
    valid(Configuration, Move, NewConfiguration),
    NewConfiguration = [Left, Right],
    sorted(Left),
    sorted(Right),
    \+ marked(NewConfiguration),
    assert(marked(NewConfiguration)),
    cross(NewConfiguration, RestOfMoves).

%% The possible moves must be named:
%% man_goes_right (Man goes from the left bank TO the right bank by himself)
%% man_goes_left (Man goes from the right bank TO the left bank by himself)
%% man_takes_fox_right (Man and fox go from left to right bank)
%% man_takes_fox_left (Man and fox go from right to left bank)
%% man_takes_hare_right (Man and hare go from from left to right bank)
%% man_takes_hare_left (Man and hare go from right to left bank)
%% man_takes_lettuce_right (Man and lettuce go from left to right bank)
%% man_takes_lettuce_left (Man and lettuce from from right to left bank)

%% I suggest writing a separate "valid" predicate for each of the moves above.

%% This predicate is true, for example, if the left and right banks look like
%% [LEFT1, RIGHT1] before the move.  Then, upon making the move man_goes_right
%% the left and right banks look like [LEFT2, RIGHT2]

%% Example done for you:
valid([LEFT1, RIGHT1], man_goes_right, [LEFT2, RIGHT2]) :-
    permutation(LEFT1, [man | LEFT2]),
    permutation([man | RIGHT1], RIGHT2),
    safe(LEFT2),
    safe(RIGHT2).

%% Now you do the rest...
valid([LEFT1, RIGHT1], man_goes_left, [LEFT2, RIGHT2]) :-
    permutation(RIGHT1, [man | RIGHT2]),
    permutation([man | LEFT1], LEFT2),
    safe(LEFT2),
    safe(RIGHT2).

valid([LEFT1, RIGHT1], man_takes_fox_right, [LEFT2, RIGHT2]) :-
    permutation(LEFT1, [man, fox | LEFT2]),
    permutation([man, fox | RIGHT1], RIGHT2),
    safe(LEFT2),
    safe(RIGHT2).

valid([LEFT1, RIGHT1], man_takes_fox_left, [LEFT2, RIGHT2]) :-
    permutation(RIGHT1, [man, fox | RIGHT2]),
    permutation([man, fox | LEFT1], LEFT2),
    safe(LEFT2),
    safe(RIGHT2).

valid([LEFT1, RIGHT1], man_takes_hare_right, [LEFT2, RIGHT2]) :-
    permutation(LEFT1, [man, hare | LEFT2]),
    permutation([man, hare | RIGHT1], RIGHT2),
    safe(LEFT2),
    safe(RIGHT2).

valid([LEFT1, RIGHT1], man_takes_hare_left, [LEFT2, RIGHT2]) :-
    permutation(RIGHT1, [man, hare | RIGHT2]),
    permutation([man, hare | LEFT1], LEFT2),
    safe(LEFT2),
    safe(RIGHT2).

valid([LEFT1, RIGHT1], man_takes_lettuce_right, [LEFT2, RIGHT2]) :-
    permutation(LEFT1, [man, lettuce | LEFT2]),
    permutation([man, lettuce | RIGHT1], RIGHT2),
    safe(LEFT2),
    safe(RIGHT2).

valid([LEFT1, RIGHT1], man_takes_lettuce_left, [LEFT2, RIGHT2]) :-
    permutation(RIGHT1, [man, lettuce | RIGHT2]),
    permutation([man, lettuce | LEFT1], LEFT2),
    safe(LEFT2),
    safe(RIGHT2).