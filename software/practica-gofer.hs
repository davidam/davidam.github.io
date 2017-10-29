-- Esta práctica ha sido interpretada con tkgofer
-- Copyright © 2003, David Arroyo Menéndez
-- El contenido listado aquí abajo es software libre. Puede ser utilizado, modificado y distribuído libremente bajo los términos de la GNU General Public License (http://www.gnu.org/copyleft/gpl.html). 



--####-EJERCICIO 1-####--

{-- Escribir, en una sola linea y sin funciones auxiliares, una definición recursiva de la lista infinita de números de fibonacci. Recuérdese que los números de fibonacci se definen así: 
  fib(0) = fib(1) = 1, fib(n) = fib(n - 1) + fib(n - 2) para n >=  2 
  ¿Cual es el coste de calcular fib(n) utilizando esa lista? ¿Cual sería el coste de aplicar directamente la definición?--}

--Fibonacci en una línea
lista =[1,1]
fib = 1:1:[fib!!(n-1) + fib!!(n-2)|n<-[2..]]

--Esta lista es de coste O(k), debido a que hace uso de la evaluación perezosa y para generar un nuevo elemento de la lista haces uso de lo ya calculado.

--Aplicar la definición de Fibonacci

fib2 n | n==0      = 1     
       | n==1      = 1      
       | otherwise = fib2 (n-1) + fib2 (n-2)

--La definición de la lista de números de Fibonacci sería...

fib3 = map fib2 [0..]

--Con esta lista para calcular un nuevo elemento de la lista es necesario calcular todos los números de Fibonacci por lo que el coste se dispara.

--####-EJERCICIO 2-####--

-- 2. Dado el tipo:
-- data Fichero = Texto [Char] | Carpeta [Fichero]
-- escribir un programa que, dado un elemento de tipo Fichero, calcule recur-
-- sivamente:
-- * el número de textos que contiene
-- * el número acumulado de caracteres sobre todo los textos
-- * el número de directorios
-- * el texto mas largo
-- * dada una cadena de caracteres, el resultado de eliminar todos los textos
-- idénticos a esa cadena de caracteres del fichero.


data Fichero = Texto [Char] | Carpeta [Fichero]

fich1 = Texto "Arbol"
fich2 = Carpeta [Texto "campo", Texto "pajaro", Carpeta [Texto "lagoness"]]
fich3 = Carpeta [Texto "campoamor", Texto "pajaro", Texto "pajarito"]

--Aquí viene la función número de textos

ndt (Texto x) = 1
ndt (Carpeta []) = 0
ndt (Carpeta (x:xs)) = (ndt x) + ndt (Carpeta xs)

--Aquí viene la función número de caracteres

ndc (Texto x) = length x
ndc (Carpeta []) = 0
ndc (Carpeta (x:xs)) = (ndc x) + ndc (Carpeta xs)


--Aquí viene la función número de directorios

ndd (Texto x) = 0
ndd (Carpeta []) = 1
ndd (Carpeta (x:xs)) = (ndd x) + ndd (Carpeta xs)

--Aquí viene la función texto más largo

maslargo x y | (length x) >= (length y) = x
maslargo x y | (length x) < (length y) = y

tml (Texto x) = x 
tml (Carpeta []) = ""
tml (Carpeta (xs:xss)) = maslargo (tml xs) (tml (Carpeta xss))

--Aquí viene la función dada una cadena de caracteres, el resultado de eliminar todos los textos idénticos a esa cadena de caracteres del fichero.

bf (Texto x) y | x == y = (Carpeta [])
	       | x /= y = (Texto x)
bf (Carpeta []) y = (Carpeta [])
--bf (Carpeta (x:xs)) y = (concatfich (bf x y) (bf (Carpeta xs) y))
bf (Carpeta (x:xs)) y = concatfich (bf x y) (bf (Carpeta xs) y)

concatfich :: Fichero -> Fichero -> Fichero
concatfich (Texto x) (Texto y) = (Carpeta [Texto x, Texto y])
concatfich (Texto x) (Carpeta []) = (Carpeta [Texto x])
concatfich (Texto x) (Carpeta (y:ys)) = Carpeta ((Texto x):y:ys)
concatfich (Carpeta []) (Texto y) = (Carpeta [Texto y])
concatfich (Carpeta []) (Carpeta []) = (Carpeta [])
concatfich (Carpeta []) (Carpeta (y:ys)) = (Carpeta (y:ys))
concatfich (Carpeta x) (Texto y) = Carpeta ((Texto y):x)
concatfich (Carpeta x) (Carpeta []) = Carpeta x
--concatfich (Carpeta x) (Carpeta (y:ys)) = (Carpeta (x:y:ys))
concatfich (Carpeta (x:xs)) (Texto y) = Carpeta ((Texto y):x:xs)
concatfich (Carpeta (x:xs)) (Carpeta []) = Carpeta (x:xs)
--concatfich (Carpeta (x:xs)) (Carpeta (y:ys)) = (((Carpeta x) `concatfich` (Carpeta y)) `concatfich` (Carpeta xs)) `concatfich` (Carpeta ys)



--####-EJERCICIO 3-####--

-- 3. La criba de Erastótenes es un método para encontrar números primos,
-- eliminando los no primos de los números enteros de 2 en adelante. El proceso
-- sigue los siguientes pasos:
-- Dada una lista (inicialmente 2,3,4..) tomar el primer elemento como el si-
-- guiente primo, y eliminar de la lista todos sus múltiplos. Repetir el proceso
-- usando la lista resultante.
-- Definir la lista infinita de todos los primos usando la criba de Erastótenes.

nmultiplo x y =  not((y `rem` x) == 0)
criba []=[]
criba (x:xs) = x:(criba (filter (nmultiplo x) xs))

listaprimos = criba ([2..])

--####-EJERCICIO 4-####--

-- 4. Me salto el planteamiento del juego por claridad.
--Se pide programar:

-- 1. Una función que, dada una situación del juego, identifique las alternativas
-- posibles, es decir, las regiones del tablero que pueden seleccionarse para
-- ser eliminadas en ese momento. El argumento de esta función será de tipo
-- Tablero, y este tipo debe definirse mediante data (ver ejercicio 2) para
-- representar una situación cualquiera de juego. El resultado de la función
-- será de tipo lista de Region, donde Region debe ser también definido mediante
--  data para identificar una región cualquiera del tablero. Discutir
-- implementaciones alternativas de estos tipos de datos.

-- Discusión de las implementaciones de estos tipos de datos:

--*** VISIÓN GENERAL ***


--La resolución de la función solitario coincide directamente con el esquema algorítmico de vuelta atrás visto en Programación III. Este esquema escrito de una manera funcional sería el siguiente:

-- vuelta_atras ensayo 
--     | valido ensayo = [ensayo]
--     | otherwise = concat (map explora (compleciones ensayo))
-- 		  where explora e | condiciones_poda e = vuelta_atras e
-- 				  | otherwise = []

-- La función valido coincidirá con que el tablero es vacío y hemos resuelto la partida.

-- La función compleciones son las posibles opciones que puedes realizar en cada momento de la partida (tableros a los que puedes acceder dependiendo de la región que borres).

-- Las condiciones de poda son situaciones como que se quede un valor aislado en el tablero (esto nos llevaría a fracasar).

-- Ir refinando estas funciones es lo que nos hará hallar la solución del juego. En concreto, compleciones requiere calcular las regiones del tablero que pueden seleccionarse en cada momento (punto 1 de este ejercicio) y para cada region hallar el tablero resultante de eliminarla (punto 2 de este ejercicio). 

-- *** ESTRUCTURAS DE DATOS ***

-- Un tablero es una estructura bidimensional con números, un elemento del tablero puede quedar determinado de varias maneras: 

-- 1) Una lista de listas de enteros. Donde la primera lista sería las abcsisas y las segunda las ordenadas (o viceversa) y el entero el valor que toma el tablero en ese punto. En este caso el conjunto de regiones también sería una lista de listas, en el que los elementos que no son región quedarían marcados de alguna manera (por ejemplo con un cero).

-- 2) con una tupla de tres elementos, donde el primer elemento es el valor y las otras dos son las coordenadas. Una lista de tuplas sería nuestro tablero o nuestra region.

-- En ambos casos, el coste de acceder a un elemento cualquiera en el caso peor va a ser de n*m, que son los elementos del tablero. En mi caso, he elegido la segunda opción.


--###--SOLUCIÓN DEL PUNTO 1 DEL EJERCICIO 4--###--


data Tablero = Tablero [(Int,Int,Int)]
data Region = Region [(Int,Int,Int)]


--dos elementos de la tupla son las coordenadas y el otro es el valor

--estos son algunas constantes útiles para hacer pruebas con las funciones 

t1 = Tablero [(1,1,1),(1,1,2),(2,1,3),(3,2,1),(1,2,2),(3,2,3),(3,3,1),(3,3,2),(3,3,3),(2,4,1),(2,4,2),(2,4,3)]

t2 = Tablero [(1,1,1), (3,1,2), (3,1,3), (1,1,4), (3,2,1), (2,2,2), (3,2,3), (1,2,4), (2,3,1), (2,3,2), (3,3,3), (1,3,4)]

t3 = Tablero [(1,1,1), (3,1,2), (1,1,4), (3,2,1), (2,2,2), (1,2,4), (2,3,1), (2,3,2), (1,3,4)]


r1 = Region [(1,1,1),(1,1,2),(1,2,2)]
r2 = Region [(1,1,1),(1,2,1),(1,3,1)]

rr1 = [Region [(1,1,1),(1,1,2),(1,2,2)], Region [(1,1,1),(1,2,1),(1,3,1)]]
rr2 = [Region [(1,1,1),(1,1,2),(1,2,2)], Region [(3,3,3),(3,3,2),(3,2,2)]]

t = [(1,1,2),(2,1,3),(3,2,1),(1,2,2),(3,2,3),(3,3,1),(3,3,2),(3,3,3),(2,4,1),(2,4,2),(2,4,3)]

tt = [(3,2,1), (3,2,3), (3,3,1), (3,3,2), (3,3,3), (2,4,1), (2,4,2), (2,4,3)]

ttt = [(1,1,1), (3,1,2), (3,1,3), (3,1,3), (1,1,4), (3,2,1), (2,2,2), (3,2,3), (1,2,4), (2,3,1), (2,3,2), (3,3,3), (1,3,4)]

rProb = Region (todosAdyacente t [(1,2,2)])
tProb = Tablero (todosMenosAdyacente (1,2,2) t)

-- Esta es la función principal se llama haciendo alternat (alternativas (t1)) u otro tablero que nos inventáramos.

alternat :: [Region] -> [Region]
alternat [] = []
alternat ((Region xs):xxs)
	     | length (xs) == 1 = alternat xxs
	     | otherwise = (Region xs):(alternat xxs)

alternativas :: Tablero -> [Region]
alternativas (Tablero []) = []
alternativas (Tablero [(x,y,z)]) = [Region [(x,y,z)]]
alternativas (Tablero ((x,y,z):xs)) = (Region (todosAdyacente ((x,y,z):xs) [(x,y,z)])):(alternativas (Tablero (todosMenosAdyacente (x,y,z) ((x,y,z):xs))))

todosMenosAdyacente :: (Int,Int,Int) -> [(Int,Int,Int)] -> [(Int,Int,Int)] 
-- -- -- -- -- -- -- -- -- tupla -- -- lista completa -- lista con los elementos adyacentes a la tupla borrados
todosMenosAdyacente (a,b,c) ((x,y,z):xs) = borraLista (todosAdyacente ((x,y,z):xs) [(x,y,z)]) ((x,y,z):xs)


borraLista :: [(Int,Int,Int)] -> [(Int,Int,Int)] -> [(Int,Int,Int)] 
-- -- -- --  lista-completa --- lista-adyacente -- lista-solucion, en la que los elemntos de lista adyacente se han borrado de la lista complet
borraLista [] [] = []
borraLista ((x,y,z):xs) [] = []
borraLista [] ((a,b,c):ys) = ((a,b,c):ys)
borraLista [(x,y,z)] ((a,b,c):ys) = dropOfList (igualTupla (x,y,z)) ((a,b,c):ys)
borraLista ((x,y,z):xs) ((a,b,c):ys) = borraLista (xs) (dropOfList (igualTupla (x,y,z)) ((a,b,c):ys))


dropOfList p [] = []
dropOfList p (x:xs) 
	 | p x = dropOfList p xs
	 | otherwise = x:(dropOfList p xs)

todosAdyacente :: [(Int,Int,Int)] -> [(Int,Int,Int)] -> [(Int,Int,Int)]
--todosAdyacente listatotal   lista q van siendo adyacentes  lista con todos adyacente de la lista total
todosAdyacente [] [] = []
todosAdyacente ((x,y,z):xs) [] = todosAdyacente (xs) [(x,y,z)]
todosAdyacente [] ((a,b,c):ys) = ((a,b,c):ys) 
todosAdyacente ((x,y,z):xs) [(a,b,c)]
      | esadyacente (x,y,z) (a,b,c) = todosAdyacente (xs) [(x,y,z),(a,b,c)]
      | otherwise = todosAdyacente (xs) [(a,b,c)]
todosAdyacente [(x,y,z)] ((a,b,c):ys) 
      | or (map (esadyacente (x,y,z)) ((a,b,c):ys)) && not (elemLista (x,y,z) ((a,b,c):ys)) = todosAdyacente [] ((x,y,z):(a,b,c):ys)
      | otherwise = todosAdyacente [] ((a,b,c):ys)
todosAdyacente ((x,y,z):xs) ((a,b,c):ys) 
      | or (map (esadyacente (x,y,z)) ((a,b,c):ys)) && not (elemLista (x,y,z) ((a,b,c):ys)) = todosAdyacente xs ((x,y,z):(a,b,c):ys)
      | otherwise = todosAdyacente xs ((a,b,c):ys)

igualTupla :: (Int, Int, Int) -> (Int, Int, Int) -> Bool
igualTupla (x,y,z) (a,b,c) | (x == a) &&  (y == b) && (z == c)= True
		      | otherwise = False

elemLista :: (Int,Int,Int) -> [(Int,Int,Int)] -> Bool
-- --nos dice si una tupla está en una lista de tuplas
elemLista e xs = or (map (igualTupla e) xs)

adyacentes :: (Int,Int,Int) -> [(Int,Int,Int)] -> [[(Int,Int,Int)]]
adyacentes (x,y,z) [] = []
adyacentes (x,y,z) ((a,b,c):xs) = ((x,y,z):(filter (esadyacente (x,y,z)) ((a,b,c):xs))):(adyacentes (a,b,c) (filter (noesadyacente (x,y,z)) xs))

esadyacente :: (Int,Int,Int) -> (Int,Int,Int) -> Bool
esadyacente (c1,x1,y1) (c2,x2,y2)
	|(c1==c2) && (x1==x2) && (abs(y1-y2)==1) = True
	|(c1==c2) && (y1==y2) && (abs(x1-x2)==1) = True
	|otherwise = False

noesadyacente :: (Int,Int,Int) -> (Int,Int,Int) -> Bool
noesadyacente (c1,x1,y1) (c2,x2,y2)
	|(c1==c2) && (x1==x2) && (abs(y1-y2)==1) = False
	|(c1==c2) && (y1==y2) && (abs(x1-x2)==1) = False
	|otherwise = True



--###--SOLUCIÓN DEL PUNTO 2 DEL EJERCICIO 4--###--

--El programa falla debido a un mal funcionamiento de la función recorre, pero no sé exactamente qué le pasa :-/

eliminaRegion :: Region -> Tablero -> Tablero
eliminaRegion (Region []) (Tablero []) = Tablero []
eliminaRegion (Region ((x,y,z):xs)) (Tablero ((a,b,c):ys)) = arreglaTablero (quitarRegion (Region ((x,y,z):xs)) (Tablero ((a,b,c):ys)))

-- le das una región y un tablero y devuelve un tablero sin esa region
quitarRegion :: Region -> Tablero -> Tablero
quitarRegion (Region []) (Tablero []) = Tablero []
quitarRegion (Region []) (Tablero [(a,b,c)]) = Tablero [(a,b,c)]
-- quitarRegion (Region []) (Tablero ((a,b,c):ys)) = Tablero ((a,b,c):ys)
-- quitarRegion (Region [(x,y,z)]) (Tablero [(a,b,c)])
-- 	     | igualTupla (x,y,z) (a,b,c) = Tablero []
--              | otherwise = Tablero [(a,b,c)]				       quitarRegion (Region ((x,y,z):xs)) (Tablero ((a,b,c):ys)) = Tablero (borraLista ((x,y,z):xs) ((a,b,c):ys))

arreglaTablero :: Tablero -> Tablero
arreglaTablero (Tablero []) = Tablero []
arreglaTablero (Tablero [(x,y,z)]) = Tablero [(x,1,1)]
--arreglaTablero (Tablero (xs:(x,y,z))) = bajarElemento (quitaFila (quitaColumna (Tablero (xs:(x,y,z)))))

quitaColumna :: Tablero -> [Int] -> Tablero
-- para cada elemento de noEstaC hay que borrar columna
quitaColumna (Tablero []) [] = Tablero []
quitaColumna (Tablero [(x,y,z)]) [] = Tablero [(x,y,z)]
quitaColumna (Tablero ((x,y,z):xs)) [] = Tablero ((x,y,z):xs)
quitaColumna (Tablero ((x,y,z):xs)) [a] = Tablero (borrarColumna ((x,y,z):xs) a)
quitaColumna (Tablero ((x,y,z):xs)) (a:ys) = junta2Tablero (quitaColumna (Tablero ((x,y,z):xs)) [a]) (quitaColumna (Tablero ((x,y,z):xs)) (map (dec) ys))
		    
dec :: Int -> Int
dec x = x - 1

borrarColumna :: [(Int,Int,Int)] -> Int ->  [(Int,Int,Int)]
borrarColumna [] x = []
borrarColumna  ((a,b,c):ys) x  
 	       | (c > x)  = [(a,b,c-1)] ++ borrarColumna (ys) x
 	       | otherwise = [(a,b,c)] ++ borrarColumna (ys) x

quitaFila :: Tablero -> [Int] -> Tablero
-- para cada elemento de noEstaF hay que borrar fila
quitaFila (Tablero []) [] = Tablero []
quitaFila (Tablero [(x,y,z)]) [] = Tablero [(x,y,z)]
quitaFila (Tablero ((x,y,z):xs)) [] = Tablero ((x,y,z):xs)
quitaFila (Tablero ((x,y,z):xs)) [a] = Tablero (borrarFila ((x,y,z):xs) a)
quitaFila (Tablero ((x,y,z):xs)) (a:ys) = junta2Tablero (quitaFila (Tablero ((x,y,z):xs)) [a]) (quitaFila (Tablero ((x,y,z):xs)) (map (dec) ys))


junta2Tablero :: Tablero -> Tablero -> Tablero
junta2Tablero (Tablero []) (Tablero []) = Tablero []
junta2Tablero (Tablero xs) (Tablero []) = Tablero xs
junta2Tablero (Tablero []) (Tablero ys) = Tablero ys
junta2Tablero (Tablero ((x,y,z):xs)) (Tablero [(a,b,c)]) 
	     | igualTupla (x,y,z) (a,b,c) = Tablero ((x,y,z):xs)
	     | otherwise = Tablero ((x,y,z):(a,b,c):xs)
junta2Tablero (Tablero [(x,y,z)]) (Tablero ((a,b,c):ys))
	     | igualTupla (x,y,z) (a,b,c) = Tablero ((x,y,z):ys)
	     | otherwise = Tablero ((a,b,c):(x,y,z):ys)
junta2Tablero (Tablero ((x,y,z):xs)) (Tablero ((a,b,c):ys))
	     | elemLista (x,y,z) ((a,b,c):ys) = junta2Tablero (Tablero xs) (Tablero ((a,b,c):ys))
             | otherwise = junta2Tablero (Tablero xs) (Tablero ((x,y,z):(a,b,c):ys))


bajarElemento :: Tablero -> Tablero
bajarElemento (Tablero []) = Tablero []
bajarElemento (Tablero [(x,y,z)]) = Tablero [(x,1,1)]
bajarElemento (Tablero ((x,y,z):xs)) = recorre (Tablero ((x,y,z):xs)) 1 1


recorre :: Tablero -> Int -> Int -> Tablero
recorre (Tablero []) a b = Tablero []
recorre (Tablero ((x,y,z):xs)) a b 
 	 | (mayorY ((x,y,z):xs) 0) <  a = (recorre (Tablero xs) 1 (b+1))
 	 | compruebaElemento ((x,y,z):xs) a b = junta2Tablero (Tablero [(x,y,z)]) (recorre (Tablero xs) (a+1) b)
 	 | otherwise = recorre (Tablero (rebaja xs a b)) a b
	
rebaja :: [(Int,Int,Int)] -> Int -> Int -> [(Int,Int,Int)]
--para todos los elementos de la lista mirar los que estando en la columna b son mayores que a y rebajarles la fila 
rebaja [] a b = []
rebaja ((x,y,z):xs) a b 
       | (z == b) && (y > a) = [(x,y-1,z)] ++ (rebaja (xs) a b)
       | otherwise = [(x,y,z)] ++ (rebaja xs a b)


compruebaElemento :: [(Int,Int,Int)] -> Int -> Int -> Bool
-- Dice si existe el elemento en la lista
compruebaElemento [] a b = False
compruebaElemento [(x,y,z)] a b
		 | (y == a) && (z ==b)  = True
		 | otherwise = False
compruebaElemento ((x,y,z):xs) a b
		 | (y == a) && (z ==b) = True
		 | otherwise = False || compruebaElemento xs a b


compruebaColumna :: [(Int,Int,Int)] -> Int -> Bool
-- Dice si existe esa columna en la lista
compruebaColumna [] a = False
compruebaColumna [(x,y,z)] a 
		 | (z == a) = True
		 | otherwise = False
compruebaColumna ((x,y,z):xs) a 
		 | z == a = True
		 | otherwise = True && compruebaColumna xs a

noEstaC :: [(Int,Int,Int)] -> [Int] -> [Int]
-- Devuelve la lista de columnas que no están
noEstaC [] [] = []
noEstaC ((a,b,c):ys) [x] 
	| compruebaColumna ((a,b,c):ys) x = []
        | otherwise = [x]
noEstaC ((a,b,c):ys) (x:xs) 
	| compruebaColumna ((a,b,c):ys) x = noEstaC ((a,b,c):ys) xs
        | otherwise = [x] ++ noEstaC ((a,b,c):ys) xs

mayorZ :: [(Int,Int,Int)] -> Int -> Int
-- Encuentra el elemento que está en la columna mayor, se llama a la función con mayorZ lista 0
mayorZ [] a = a
mayorZ [(x,y,z)] a 
       | a > z = a
       | otherwise = z
mayorZ ((x,y,z):xs) a 
       | a > z = mayorZ xs a
       | otherwise = mayorZ xs z

compruebaFila :: [(Int,Int,Int)] -> Int -> Bool
-- Dice si existe esa columna en la lista
compruebaFila [] a = False
compruebaFila [(x,y,z)] a 
		 | (y == a) = True
		 | otherwise = False
compruebaFila ((x,y,z):xs) a 
		 | y == a = True
		 | otherwise = True && compruebaFila xs a


noEstaF :: [(Int,Int,Int)] -> [Int] -> [Int]
-- Devuelve la lista de columnas que no están
noEstaF [] [] = []
noEstaF ((a,b,c):ys) [x] 
	| compruebaFila ((a,b,c):ys) x = []
        | otherwise = [x]
noEstaF ((a,b,c):ys) (x:xs) 
	| compruebaFila ((a,b,c):ys) x = noEstaF ((a,b,c):ys) xs
        | otherwise = [x] ++ noEstaF ((a,b,c):ys) xs

mayorY :: [(Int,Int,Int)] -> Int -> Int
mayorY [] a = a
mayorY [(x,y,z)] a 
       | a > y = a
       | otherwise = y
mayorY ((x,y,z):xs) a 
       | a > y = mayorY xs a
       | otherwise = mayorY xs y

borrarFila :: [(Int,Int,Int)] -> Int ->  [(Int,Int,Int)]
borrarFila [] x = []
borrarFila  ((a,b,c):ys) x  
 	       | (c > x)  = [(a,b,c-1)] ++ borrarFila (ys) x
 	       | otherwise = [(a,b,c)] ++ borrarFila (ys) x



-------######### SOLUCIÓN DEL PUNTO 3 DEL EJERCICIO 4 #########----------

-- data ListatableroOchar = Listatablero [Tablero] | Ochar String

-- solitario :: Tablero -> ListatableroOchar  
-- solitario (Tablero []) = OChar "No hay solución"
-- solitario (Tablero (x:xs)) = Listatablero (x:xs)

-- vueltaAtras Tablero [] = []
-- vueltaAtras Tablero xs
--        | valido (Tablero xs) = [Tablero]
--        | otherwise = concat (map explora (compleciones (alternat (Tablero xs))))
--  		  where explora e | condiciones_poda e = vuelta_atras e
--  				  | otherwise = []
-- valido :: Tablero -> Bool
-- valido Tablero [] = True
-- valido Tablero xs = False

-- compleciones :: [Region] -> Tablero -> [Tablero]
-- compleciones [] [] = []
-- compleciones [] Tablero xs = [(Tablero xs)]
-- compleciones Region xs Tablero xs = 

-- condiciones_poda :: Tablero -> Bool
-- condiciones_poda Tablero [] = False






