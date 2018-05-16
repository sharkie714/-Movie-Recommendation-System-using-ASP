#include 'category.lp'. 
#include 'movies.lp'.
#include 'hobbies.lp'.


%%%  All constriant rule

:- movie_with(X,family), likes(X,[adult]), person(X).
:- movie_with(X,kids), likes(X,[adult]),person(X).
:- movies_where(X,theatre), not likes(X,[new_released]).
:- movies_with(X,family), likes(X,[romance]), person(X).

%%%% Normal rules

person(0).

watch_with(family).
watch_with(friends).
watch_with(kids).

openness(X,more) :- person(X), not openness(X,less).
openness(X,less) :- person(X), not openness(X,more).

extraversion(X,more) :- person(X), not extraversion(X,less).
extraversion(X,less) :- person(X), not extraversion(X,more).

agreeableness(X,more) :- person(X), not agreeableness(X,less).
agreeableness(X,less) :- perosn(X), not agreeableness(X,more).

neuroticism(X,more) :- person(X), not neuroticism(X,less).
neuroticism(X,less) :- person(X), not neuroticism(X,more).

conscientiousness(X,more) :- person(X), not conscientiousness(X,less).
conscientiousness(X,less) :- person(X), not conscientiousness(X,more).


likes(X,[comedy]) :- person(X), conscientiousness(X,less), openness(X,more) ,neuroticism(X,_),extraversion(X,_), agreeableness(X,_).


likes(X,[horror]) :- person(X), agreeableness(X,less), extraversion(X,less), 
neuroticism(X,more),openness(X,_),conscientiousness(X,_).
likes(X,[action]) :- person(X), openness(X,more), neuroticism(X,less), conscientiousness(X,more), extraversion(X,_),agreeableness(X,_).
likes(X,[romance]) :- person(X), conscientiousness(X,more), neuroticism(X,more),extraversion(X,_),agreeableness(X,_),openness(X,_).
likes(X,[fantasy]) :- person(X), openness(X,more), extraversion(X,less),neuroticism(X,_), agreeableness(X,_),conscientiousness(X,_).
likes(X,[adult]) :- person(X), extraversion(X,more), agreeableness(X,less), conscientiousness(X,less),neuroticism(X,_),openness(X,_).
likes(X,[mystery]) :- person(X), openness(X,more),neuroticism(X,_),extraversion(X,_),agreeableness(X,_),conscientiousness(X,_).
likes(X,[documentory]) :- person(X), openness(X,more),neuroticism(X,_),extraversion(X,_), agreeableness(X,_),conscientiousness(X,_).
likes(X,[anime]) :- person(X), openness(X,more), neuroticism(X,more),extraversion(X,_), agreeableness(X,_),conscientiousness(X,_).
likes(X,[sci_fi]) :- person(X), openness(X,more), neuroticism(X,more),extraversion(X,_), agreeableness(X,_),conscientiousness(X,_).
likes(X,[thriller]) :- person(X), openness(X,more),neuroticism(X,_),extraversion(X,_),   agreeableness(X,_),conscientiousness(X,_).
likes(X,[musical]) :- person(X), openness(X,more), agreeableness(X,more),neuroticism(X,_), extraversion(X,_),conscientiousness(X,_).
likes(X,[music]) :- person(X), openness(X,more), agreeableness(X,more), neneuroticism(X,_), extraversion(X,_), conscientiousness(X,_).
likes(X,[drama]) :- person(X), extraversion(X,more), agreeableness(X,more), neuroticism(X,less), openness(X,_),conscientiousness(X,_).



likes(X,[new_released]) :- person(X), movies_where(X,theatre).





prefer(X,[bollywood]) :- not prefer(X,[hollywood]), not prefer(X,[bollywood,hollywood]),person(X).
prefer(X,[hollywood]) :- not prefer(X,[bollywood]), not prefer(X,[bollywood,hollywood]),person(X).
prefer(X,[bollywood,hollywood]) :- not prefer(X,[hollywood]), not prefer(X,[bollywood]),person(X).

kids(X) :-  not adult(X), not teen(X),person(X).
adult(X) :- not kids(X), not teen(X), person(X).
teen(X) :- not kids(X), not adult(X), person(X).
middle_aged(X) :- not kids(X), not teen(X), not old(X),person(X).
old(X) :- not kids(X), not teen(X), not middle_aged(X),person(X). 

movies_where(X,theatre) :- person(X), not movies_where(X,home).
movies_where(X,home) :- person(X), not movies_where(X,theatre).

inter([ ],_,[ ]).
inter([X|L1],L2,[X|L3]):- member(X, L2), inter(L1, L2, L3).
inter([_|L1],L2,L3):- inter(L1, L2, L3).

age_pref(X, [comedy,animation,family,drama,musical]) :- kids(X). 
age_pref(X, [fantasy,thriller,mystery,animation,short,sci_fi,advanture,comedy]) :- teen(X).
age_pref(X, [sport,adult,advanture,action,comedy,romance,fantasy,mystery,thriller,sci_fi]) :- 
																				middle_aged(X).
age_pref(X,[drama,family,comedy,documentary,history,music,romance]) :- old(X).

movie_with(X,family) :- person(X), not movie_with(X,alone), not movie_with(X,friends).
movie_with(X,alone) :- person(X), not movie_with(X,family), not movie_with(X,friends).
movie_with(X,friends) :- person(X), not movie_with(X,alone), not movie_with(X,family).

pref_with(X,[family,drama,comedy,biography,documentary]) :- movie_with(X,family).
pref_with(X,[advanture,sci_fi,thriller,mystery,action,comedy,sport,crime]) :- movie_with(X,friends). 
pref_with(X,[fantasy,romance,sci_fi,action,horror]) :- movie_with(X,alone). 



region(bollywood) :- prefer(X,[bollywood]).
region(hollywood) :- prefer(X,[hollywood]).
region(_) :- prefer(X,[bollywood,hollywood]).




union([ ], L, L).
union([ X | L1 ], L2, [ X | L3 ]):- not member(X, L2), union(L1, L2, L3).
union([ _ | L1 ], L2, L3):- union(L1, L2, L3).


final(H,[H|T]).  

