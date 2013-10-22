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

tic_tac_toe(Board) -> [].
