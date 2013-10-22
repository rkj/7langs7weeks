-module(day2).
-export([find_keyword/2,
         total_price/1,
         items_prices/1,
         tic_tac_toe/1]).

find_keyword([], _) -> [];
find_keyword([{Kw, D}|_], Kw) -> D;
find_keyword([_|T], Kw) -> find_keyword(T, Kw).

items_prices(List) -> [{Item, Q*P } || {Item, Q, P} <- List].

total_price([]) -> 0;
total_price([{_, Q, P}|T]) -> Q * P + total_price(T).

% return {win, x or o} if x or o wins
% true if there is an empty field
% false otherwise
winning([A, A, A]) -> (A == x) or (A == o) andalso {win, A};
winning(Line) -> lists:any(fun(X) -> X == e end, Line).

result([]) -> cat;
result([Line | T]) ->
  case {result(T), winning(Line)} of
    {{win, _}, {win, _}} -> bad;
    {_, R={win, _}} -> R;
    {_, true} -> nowinner;
    {R, false} -> R
  end.

tic_tac_toe([A, B, C,
             D, E, F,
             G, H, J]) ->
  R1 = [A, B, C],
  R2 = [D, E, F],
  R3 = [G, H, J],
  C1 = [A, D, G],
  C2 = [B, E, H],
  C3 = [C, F, J],
  D1 = [A, E, J],
  D2 = [C, E, G],
  All = [R1, R2, R3, C1, C2, C3, D1, D2],
  result(All).
