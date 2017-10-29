%%% basicos.pro --- Ejercicios resueltos avanzados de prolog

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


/*Este fichero ha sido interpretado con swi-prolog (http://www.swi.psy.uva.nl/projects/SWI-Prolog/). Pero cada ejercicio ha sido interpretado de manera individual para evitar utilizar varias veces las mismas variables*/


/**** EJERCICIO 1 ****/

hombre(juan,grande,rubio,joven).
hombre(antonio,mediana,castaño,maduro).
hombre(pepe,mediana,moreno,anciano).
hombre(luis,mediana,moreno,joven).

mujer(maria,pequeña,moreno,joven).
mujer(sara,grande,moreno,joven).
mujer(laura,mediana,pelirrojo,maduro).
mujer(eva,mediana,rubio,anciano).

gustos(juan,clásica,aventuras,tenis).
gustos(antonio,pop,ciencia-ficción,natación).
gustos(pepe,jazz,detectives,yoga).
gustos(luis,jazz,ciencia-ficción,natación).
gustos(maria,jazz,ciencia-ficción,natación).
gustos(sara,pop,aventuras,tenis).
gustos(laura,clásica,detectives,yoga).
gustos(eva,jazz,detectives,natación).

busca(juan,mediana,rubio,joven).
busca(antonio,pequeña,pelirrojo,joven).
busca(pepe,mediana,moreno,maduro).
busca(luis,pequeña,moreno,joven).
busca(maria,mediana,moreno,joven).
busca(sara,grande,castaño,maduro).
busca(laura,grande,moreno,maduro).
busca(eva,mediana,rubio,anciano).

compatible(X,Y) :- gustos(X,A,B,C), gustos(Y,A,B,C), busca(X,O,P,Q), mujer(Y,O,P,Q), X\=Y, compatible(Y,X).
compatible(X,Y) :- gustos(X,A,B,C), gustos(Y,A,B,C), busca(X,O,P,Q), hombre(Y,O,P,Q), X\=Y.

%los compatibles son luis y maria ;-)


/**** EJERCICIO 2 ****/



par(X) :- Y is X mod 2, Y = 0.
impar(Z) :- U is Z mod 2, U\=0.
dividir(X,X,1) :- !.
dividir(X,Y,Z) :- (X mod Y)=0, X1 is X-Y, dividir(X1,Y,R), Z is R+1. 
dividir(X,Y,Z) :- X1 is X-(Y+(X mod Y)), dividir(X1,Y,R), Z is R+1. 





/**** EJERCICIO 3 ****/


substituye(_,_,[],[]).
substituye(X,Y,[X|B],[Y|D]) :- substituye(X,Y,B,D), !.
substituye(X,Y,[A|B],[A|D]) :- substituye(X,Y,B,D).


/**permutación par e impar no puedo resolverlo, debido a que no entiendo qué es lo que deben hacer los predicados para mi permutar una lista es cambiar el orden de unos elementos, si lo que debiera hacer el predicado es verificar si la lista Xs es una permutación de Ys (o al revés) no entiendo por qué debemos plantearnos el que la lista tenga un número par ó impar de elementos. Si lo que se pide es Ys tenga todas las permutaciones posibles Xs, tampoco comprendo para que por qué debemos pensar si tiene un nº par o impar de elementos**/

permutacion([],[]).
permutacion([A|B],[C,D]) :- quitarElem(A,[C|D],ListaSinElem), permutacion(B,ListaSinElem).

/*quitarElem quita un elemento de una lista*/

quitarElem(_,[],[]).
quitarElem(X,[X|B],[A|C]) :- quitarElem(X,B,[A|C]), !.
quitarElem(X,[A|B],[A|C]) :- quitarElem(X,B,C).








