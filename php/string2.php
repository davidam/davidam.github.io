<?php
// Mostremos todos los errores
error_reporting(E_ALL);

$genial = 'fant&aacute;stico';

// No funciona, imprime: Esto es { fant&aacute;stico}
echo "Esto es { $genial}";

// Funciona, imprime: Esto es fant&aacute;stico
echo "Esto es {$genial}";
echo "Esto es ${genial}";

// Funciona
echo "Este cuadro tiene {$cuadro->ancho}00 cent&iacute;metros de ancho.";

// Funciona
echo "Esto funciona: {$matriz[4][3]}";

// Esto esta mal por la misma razon por la que $foo[bar] esta mal por
// fuera de una cadena. En otras palabras, aun funciona pero ya que
// PHP busca primero una constante llamada foo, genera un error de
// nivel E_NOTICE (constante indefinida).
echo "Esto esta mal: {$matriz[foo][3]}";

// Funciona. Cuando se usan matrices multi-dimensionales, use siempre
// llaves alrededor de las matrices al interior de cadenas
echo "Esto funciona: {$matriz['foo'][3]}";

// Funciona.
echo "Esto funciona: " . $arr['foo'][3];

echo "Puede incluso escribir {$obj->valores[3]->nombre}";

echo "Este es el valor de la variable llamada $nombre: {${$nombre}}";
?>