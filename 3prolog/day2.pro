
count(C, [_|T]) :- count(TC, T), C is TC + 1.
count(0, []).

concatenate([], L, L).
%concatenate([H|L1], L2, L3) :- concatenate(L1, [H|L2], L3).
concatenate([H|L1], L2, [H|L3]) :- concatenate(L1, L2, L3).
%concatenate(L1, [H|L2], L3) :- concatenate(L1, L2, [H|L3]).

fib(0, []).
fib(1, [1]).
fib(2, [1, 1]).
%fib(3, [2, 1, 1]).
%fib(4, [3, 2, 1, 1]).
%fix(N, [A + B, A, B|T]) :- fib(N-1, [A, B|T]).
fix(N, [S, A, B|T]) :- N1 is N - 1, S is A + B, fib(N1, [A, B|T]).
%fix(N-1, [A, B|T]) :- fib(N, [A + B, A, B|T]).

fib2(0, A, _, A).
fib2(N, A, B, Res) :- N1 is N-1, S is A + B, fib2(N1, B, S, Res).
%fib2(N, A, B, Res) :- fib2(N-1, B, A+B, Res).
fib2(N, Res) :- fib2(N, 0, 1, Res).

rev([], []).
rev([A], [A]).
%rev([A, B], [B, A]).
%rev([A, B, C], [C, B, A]).
%1, 2, 3, 4
%4, 3, 2, 1
%rev([H|[T|[L]]], [L|[R|[H]]]) :- T = R.
%rev([H|[T|[L]]], [L|[R|[H]]]) :- rev(T, R).
%rev([H|T], R) :- last(R, H), concatenate(X, H, R), rev(T, X). 
%rev([H|T], [L|R]) :- last(R, H), last(T, L).
rev([H|T], [L|R]) :- last(R, H), last(T, L), concatenate(X, [H], [L|R]), rev(T, X). 

smallest([L], L).
smallest([H|T], L) :- smallest(T, L), H > L. 
smallest([H|T], H) :- smallest(T, L), H =< L. 

my_sort([A], [A]).
my_sort(L, [H|S]) :- smallest(L, H), concatenate(A, [H|B], L), concatenate(A, B, X), my_sort(X, S).

pivot(_, [], [], []).
%pivot(A, [H|L], [H|S], G) :- pivot(A, L, S, G), H < A. 
%pivot(A, [H|L], S, [H|G]) :- pivot(A, L, S, G), H >= A. 
pivot(A, [H|L], [H|S], G) :- H < A, pivot(A, L, S, G). 
pivot(A, [H|L], S, [H|G]) :- H >= A, pivot(A, L, S, G). 
qsort([], []).
qsort([H|L], R) :-
  pivot(H, L, S, G),
  qsort(S, SS),
  qsort(G, GS),
  concatenate(SS, [H|GS], R).

% http://ktiml.mff.cuni.cz/~bartak/prolog/sorting.html
pivoting(H,[],[],[]).
pivoting(H,[X|T],[X|L],G):-X=<H,pivoting(H,T,L,G).
pivoting(H,[X|T],L,[X|G]):-X>H,pivoting(H,T,L,G).

quick_sort(List,Sorted):-q_sort(List,[],Sorted).
q_sort([],Acc,Acc).
q_sort([H|T],Acc,Sorted):-
  pivoting(H,T,L1,L2),
  q_sort(L1,Acc,Sorted1),q_sort(L2,[H|Sorted1],Sorted).

% quick_sort([12, 58, 16, 17, 95, 42, 74, 98, 18, 87, 13, 64, 40, 7, 85, 80, 100, 91, 86, 48, 92, 6, 67], R).
% [12, 58, 16, 17, 95, 42, 74, 98, 18, 87, 13, 64, 40, 7, 85, 80, 100, 91, 86, 48, 92, 6, 67, 68, 65, 30, 75, 46, 41, 50, 36, 35, 88, 59, 60, 84, 78, 39, 82, 57, 66, 15, 71, 97, 44, 73, 20, 62, 4, 26, 83, 70, 5, 56, 38, 43, 89, 34, 53, 33, 9, 93, 37, 69, 49, 23, 81, 32, 94, 61, 21, 63, 3, 54, 76, 47, 31, 52, 29, 77, 19, 25, 2, 10, 14, 51, 72, 22, 11, 99, 24, 28, 79, 90, 55, 1, 45, 27, 96, 8]

