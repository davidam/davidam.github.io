%%% avanzados.pro --- Ejercicios resueltos avanzados de prolog

%% Copyright (C) 2005  David Arroyo Menendez

%% Author: David Arroyo Menendez (http://www.davidam.com)
%% Maintainer: David Arroyo Menendez (http://www.davidam.com)
%% Keywords: extensions

%% This file is free software; you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation% either version 2, or (at your option)
%% any later version.

%% This file is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY% without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.

%% You should have received a copy of the GNU General Public License
%% along with GNU Emacs% see the file COPYING.  If not, write to
%% the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
%% Boston, MA 02111-1307, USA.


% 4.1

% desconozco el valor del predicado cuts, así es que solo hará una versión del ejercicio.

d(X,X,1) :- !.
d(C,X,0) :- atomic(C).
d(~U,X,~A) :- d(U,X,A).
d(U+V,X,A+B) :- d(U,X,A),d(V,X,B).
d(U-V,X,A-B) :- d(U,X,A),d(V,X,B).
d(C*U,X,C*A) :- atomic(C), C \= X, d(U,X,A), !.
d(U*V,X,B*U+A*V) :- d(U,X,A), d(V,X,B).
d(U/V,X,A) :- d(U*V^(~1),X,A).
d(U^C,X,C*U^(C-1)*W) :- atomic(C), C \= X, d(U,X,W),!.
d(U^V,X,A) :- d(exp(V * log(U)),X,A).
d(log(U),X,A^(~1)) :- d(U,X,A).
d(exp(U),X,exp(U) * A) :- d(U,X,A).


% 4.2

% Lo primero que hay que pensar es cómo representar los valores de cada carta.
% Diremos que es una estructura carta con dos valores, en uno se representa el valor numérico o figura y en el otro si es de corazones, picas, rombos, o tréboles.
% Una jugada es una lista de cartas.

% En una jugada no importa el orden en que se tengan las cartas. Para expresar esto necesito de un predicado permutacion.


permutacion(L,[H|T]) :-
	append(V,[H|U],L),
	append(V,U,W),
	permutacion(W,T).
permutacion([],[]).

jugada(X) :- jugada(Y), permutacion(X,Y).

jugada-posicion(jugada([carta(A,_),carta(A,_),carta(A,_),carta(A,_), carta(A,_)]),1) :- !. 
jugada-posicion(jugada([carta(A,_),carta(A,_),carta(A,_),carta(A,_),carta(_,_)]),2) :- !.
jugada-posicion(jugada([carta(B,A),carta(C,A),carta(D,A),carta(E,A)]),3) :- (B<C), (C<D), (D<E). 
jugada-posicion(jugada([carta(B,A),carta(C,A),carta(D,A),carta(E,A)]),3) :- permutacion([carta(B,A),carta(C,A),carta(D,A),carta(E,A)],Y), jugada-posicion(Z,3), miembro(Z,Y). /*para que esto funcione bien en permutacion(X,Y) Y debe ser la lista que contiene todas las permutaciones de X.*/
jugada-posicion(jugada([carta(A,_),carta(B,_),carta(C,_),carta(D,_),carta(E,_)]),4) :- (A<B), (B<C), (C<D), (D<E).
jugada-posicion(jugada([carta(A,_),carta(A,_),carta(A,_),carta(B,_),carta(B,_)]),5).
jugada-posicion(jugada([carta(_,A),carta(_,A),carta(_,A),carta(_,A), carta(_,A)]),6). 
jugada-posicion(jugada([carta(A,_),carta(A,_),carta(A,_),carta(_,_), carta(_,_)]),7). 
jugada-posicion(jugada([carta(A,_),carta(A,_),carta(B,_),carta(B,_), carta(_,_)]),8).
jugada-posicion(jugada([carta(_,_),carta(_,_),carta(_,_),carta(A,_), carta(A,_)]),9).  
jugada-posicion(jugada([carta(_,_),carta(_,_),carta(_,_),carta(_,_), carta(_,_)]),10).  

mejor-jugada(X,Y,Z,Mejor) :- 
	jugada-posicion(X,A), 
	jugada-posicion(Y,B),
	jugada-posicion(Z,C),
	Mejor >= A,
	Mejor >= B,
	Mejor >= C.


% 4.3

camino(X,X,T).
camino(X,Y,T) :- (arco(X,Z) ; arco(Z,X)), not(miembro(Z,T)), camino(Z,Y,[Z|T]).

miembro(X,[X|_]).
miembro(X,[_|Y]) :- miembro(X,Y).


