friend(ahmed, samy).
friend(ahmed, fouad).
friend(samy, mohammed).
friend(samy, said).
friend(samy, omar).
friend(samy, abdullah).
friend(fouad, abdullah).
friend(abdullah, khaled).
friend(abdullah, ibrahim).
friend(abdullah, omar).
friend(mostafa, marwan).
friend(marwan, hassan).
friend(hassan, ali).

friend(hend, aisha).
friend(hend, mariam).
friend(hend, khadija).
friend(huda, mariam).
friend(huda, aisha).
friend(huda, lamia).
friend(mariam, hagar).
friend(mariam, zainab).
friend(aisha, zainab).
friend(lamia, zainab).
friend(zainab, rokaya).
friend(zainab, eman).
friend(eman, laila).


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


