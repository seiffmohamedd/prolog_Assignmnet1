

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

#Task 1:
is_friend(X, Y) :-
    friend(X, Y).
is_friend(X, Y) :-
    friend(Y, X).


# Task 2:
friendList(Person, []) :- \+ friend(Person, _).
friendList(Person, [Friend|Rest]) :-
    friend(Person, Friend),
    friendList(Person, Rest).


# Task 3:
friendListCount(Person, Count) :- friendListCount(Person, 0, Count).

friendListCount(Person, Acc, Count) :-
    friend(Person, Friend),
    NewAcc is Acc + 1,
    friendListCount(Friend, NewAcc, Count).
    
friendListCount(_, Count, Count).

#Task 4:

peopleYouMayKnow(Person, SuggestedFriends) :-
    findall(Friend, suggestFriend(Person, Friend), SuggestedFriends).

suggestFriend(Person, Friend) :-
    friend(Person, X),
    friend(Friend, X),
    not(friend(Person, Friend)),
    Person \= Friend.

peopleYouMayKnow(Person, [SuggestedFriend|Rest]) :-
    suggestFriend(Person, SuggestedFriend),
    not(member(SuggestedFriend, Rest)),
    peopleYouMayKnow(Person, Rest).
peopleYouMayKnow(_, []).


#Task 5
peopleYouMayKnow(Person, N, SuggestedFriend) :-
    friendList(Person, Friends),
    findSuggestedFriend(Person, N, Friends, SuggestedFriend).

findSuggestedFriend(_, _, [], _) :-
    fail.
findSuggestedFriend(Person, N, [Friend|Rest], SuggestedFriend) :-
    friendListCount(Friend, Count),
    Count >= N,
    \+ friend(Friend, Person),
    \+ member(Friend, Rest),
    SuggestedFriend = Friend.
findSuggestedFriend(Person, N, [_|Rest], SuggestedFriend) :-
    findSuggestedFriend(Person, N, Rest, SuggestedFriend).

# Task 6

peopleYouMayKnowList(Person, List) :-
    findPossibleFriends(Person, [], Friends),
    removeDuplicates(Friends, [], List).

findPossibleFriends(Person, Acc, List) :-
    friend(Person, Friend),
    \+ member(Friend, Acc),
    \+ friend(Person, Friend), % to avoid suggestions of existing friends
    findPossibleFriends(Person, [Friend|Acc], List).

findPossibleFriends(_, List, List).

removeDuplicates([], Acc, Acc).
removeDuplicates([H|T], Acc, List) :-
    member(H, Acc),
    removeDuplicates(T, Acc, List).
removeDuplicates([H|T], Acc, List) :-
    \+ member(H, Acc),
    removeDuplicates(T, [H|Acc], List).

# Task7
peopleYouMayKnow_indirect(Person, Friend) :-
    friendOf(Person, F1),
    friendOf(F1, F2),
    \+ friendOf(Person, F2),
    \+ Person = F2,
    friendOf(F2, Friend),
    \+ friendOf(Person, Friend),
    \+ Person = Friend.
    
peopleYouMayKnow_indirect(Person, Friend) :-
    friendOf(Person, F1),
    friendOf(F1, F2),
    \+ friendOf(Person, F2),
    \+ Person = F2,
    peopleYouMayKnow_indirect(F2, Friend),
    \+ friendOf(Person, Friend),
    \+ Person = Friend.



