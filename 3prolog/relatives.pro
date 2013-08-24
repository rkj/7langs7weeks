parent_of(prince_charles, queen_elizabeth_ii).
parent_of(princess_anne, queen_elizabeth_ii).
parent_of(prince_william, prince_charles).
parent_of(peter_phillips, princess_anne).
parent_of(john_f_kennedy, joseph_p_kennedy).
parent_of(ted_kennedy, joseph_p_kennedy).
married_to(queen_elizabeth_ii, prince_philip).
married_to(princess_diana, prince_charles).
died_violently_in_car_crash(princess_diana).

ancestor_of(Child, Parent) :- parent_of(Child, Parent).
ancestor_of(Child, Ancestor) :- parent_of(Child, Parent), ancestor_of(Parent, Ancestor).

sibling(Child1, Child2) :- parent_of(Child1, Parent), parent_of(Child2, Parent), \+(Child1=Child2).
grandparent(Child, Grandparent) :- parent_of(Child, Parent), parent_of(Parent, Grandparent).
cousin(Person1, Person2) :- parent_of(Person1, Parent1), parent_of(Person2, Parent2), sibling(Parent1, Parent2).

related_to_base(P1, P2) :- ancestor_of(P1, P2).
related_to_base(P1, P2) :- married_to(P2, P1).

related_to(P1, P2) :- ancestor_of(P1, Ancestor), ancestor_of(P2, Ancestor), \+(P1=P2).
related_to(P1, P2) :- related_to_base(P1, P2).
related_to(P1, P2) :- related_to_base(P2, P1).
related_to_t(P1, P2) :- related_to(P1, P3), related_to(P2, P3), \+(P1=P3), \+(P2=P3), \+(P1=P2).
