adj(mississippi, tennessee).
adj(mississippi, alabama).
adj(alabama, tennessee).
adj(alabama, mississippi).
adj(alabama, georgia).
adj(alabama, florida).
adj(georgia, florida).
adj(georgia, tennessee).

same_color(S1, S2, [[S, C]|Assignment]) :-
  S1 == S, member([S2, C], Assignment).

invalid(Assignment) :-
  adj(A, B),
  same_color(A, B, Assignment).

all_assigned([S|States], Colors, [[S, C]|Assignment]) :-
  member(C, Colors),
  all_assigned(States, Colors, Assignment).
all_assigned([], _, []).

coloring(States, Colors, Assignment) :-
  all_assigned(States, Colors, Assignment),
  \+(invalid(Assignment))
  .

