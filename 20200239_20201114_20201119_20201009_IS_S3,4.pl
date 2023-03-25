% consult('C:/Users/Lenovo/Desktop/assig/prolog_Assignmnet1/data.pl').
% use_module('C://Users//Lenovo//Desktop//assig//prolog_Assignmnet1//data.pl').

:-include('data.pl').

%____________________________________TASK 1_______________________________________


is_friend(X, Y) :-
    friend(X, Y).
is_friend(X, Y) :-
    friend(Y, X).


%____________________________________TASK 2_______________________________________


 member(X, [Y|T]) :- X = Y; member(X, T).

friendList(Person, FriendList) :-
    find_friends(Person, [], FriendList).

find_friends(Person, List, FriendList) :-
    is_friend(Person, Friend),
    \+ member(Friend, List),
    find_friends(Person, [Friend|List], FriendList).
find_friends(_, FriendList, FriendList).


%____________________________________TASK 3_______________________________________


friendListCount(Person, N):-
    friendList(Person,List),
    counthelper(List,0,N).


counthelper([],Count,Count).


counthelper([_|T],N,Count):-
    N1 is N+1,
    counthelper(T,N1,Count).


%____________________________________TASK 4_______________________________________



peopleYouMayKnow(X, Y):-
    is_friend(Z, X),
    is_friend(Z, Y),X\==Y.


% ____________________________________TASK 5______________________________________

peopleYouMayKnow(X, Num, Y):-
	people_counter(X,Y,Z),
	Num =:= Z.

theCounter([],_,0).


theCounter([X1|T],X,Z):-
	X1\=X,
	theCounter(T,X,Z).

theCounter([X|T],X,Y):-
	theCounter(T,X,Z), Y is Z +1.


peopleList(X, L):-
	findall(Y, peopleYouMayKnow(X, Y), L).

people_counter(X,Y,Z):-
	peopleList(X, L),
	count_all_people(L,Y,Z).

count_all_people(L,X,Y):-
	member(X,L),
	theCounter(L,X,Y).





