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

peopleYouMayKnow(X, N, Y):-
	people_counter(X,Y,Z),
	N =:= Z.


counter([],_,0).
counter([X|T],X,Y):-
	counter(T,X,Z), Y is Z +1.
counter([X1|T],X,Z):-
	X1\=X,
	counter(T,X,Z).

count_all_people(L,X,Y):-
	member(X,L),
	counter(L,X,Y).

people_counter(X,Y,Z):-
	peopleList(X, L),
	count_all_people(L,Y,Z).

peopleList(X, L):-
	findall(Y, peopleYouMayKnow(X, Y), L).





