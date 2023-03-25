

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


%Task 1:
is_friend(X, Y) :-
    friend(X, Y).
is_friend(X, Y) :-
    friend(Y, X).



% Task 2:

%task2 part1
%friendList(X, L) :-
    %findall(Y, friend(X, Y), L).

%task2 prt2

member(X, [Y|T]) :- X = Y; member(X, T).
friendList(Person, FriendList) :-
    find_friends(Person, [], FriendList).

 %Define the helper predicate to find all friends of a person
find_friends(Person, Acc, FriendList) :-
    is_friend(Person, Friend),
    \+ member(Friend, Acc),
    find_friends(Person, [Friend|Acc], FriendList).
find_friends(_, FriendList, FriendList).

%Task 3:
friendListCount([],0).

friendListCount([_|T], N):-
    friendListCount(T,NN),
    N is NN+1.
%this task is done when we can pass arguments as name not list
%
% Task 3 part 2:
% friendListCount([],0).
%
% friendListCount([_|T], N):-
% friendListCount(T,NN),
%  N is NN+1.


%Task 4

peopleYouMayKnow(X, Y):-
    is_friend(Z, X),
    is_friend(Z, Y),X\==Y.


%task 5

% check if two lists have at least N common elements
haveNCommonElements(_, _, N) :- N =< 0, !.
haveNCommonElements([], _, _) :- fail.
haveNCommonElements([H|T], L2, N) :-
    (   member(H, L2)
    ->  N1 is N - 1, haveNCommonElements(T, L2, N1)
    ;   haveNCommonElements(T, L2, N)
    ).

% find a friend suggestion for a person
peopleYouMayKnow(Person, N, Suggestion) :-
    friend(Person, Friend1),
    friend(Person, Friend2),
    Friend1 \= Friend2, % make sure they are not the same friend
    friend(Friend1, Suggestion), % potential friend suggestion
    Suggestion \= Person, % make sure they are not already a friend
    Suggestion \= Friend1, % make sure they are not a mutual friend
    Suggestion \= Friend2, % make sure they are not a mutual friend
    findall(MutualFriend, (friend(Friend1, MutualFriend), friend(Friend2, MutualFriend)), MutualFriends),
    haveNCommonElements(MutualFriends, [Suggestion], N).






















%Task 5
% peopleYouMayKnow(Person, N, SuggestedFriend) :-
    %friendList(Person, Friends),
    %findSuggestedFriend(Person, N, Friends, SuggestedFriend).

%findSuggestedFriend(_, _, [], _) :-
 %   fail.
%findSuggestedFriend(Person, N, [Friend|Rest], SuggestedFriend) :-
 %   friendListCount(Friend, Count),
  %  Count >= N,
   % \+ friend(Friend, Person),
    %\+ member(Friend, Rest),
    %SuggestedFriend = Friend.
%findSuggestedFriend(Person, N, [_|Rest], SuggestedFriend) :-
 %   findSuggestedFriend(Person, N, Rest, SuggestedFriend).

%Task 6

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

% Task7
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



factorial(1,1).
factorial(N,Result) :- NewN is N-1,
factorial(NewN,NewResult),
 Result is N * NewResult.
