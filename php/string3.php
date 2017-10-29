<?php
// Obtener el primer caracter de una cadena
$cadena = 'Esta es una prueba.';
$primer = $cadena{0};

// Obtener el tercer caracter de una cadena
$tercer = $cadena{2};

// Obtener el ultimo caracter de una cadena.
$cadena = 'Esta es tambien una prueba.';
$ultimo = $cadena{strlen($cadena)-1};

// Modificar el ultimo caracter de una cadena
$cadena = 'Observe el mar';
$cadena{strlen($cadena)-1} = 'l';
echo "primer: $primer, tercer: $tercer y ultimo: $ultimo\n <br />";
//$foo = "Hola";
echo "\$foo==$foo; tipo es " . gettype ($foo) . "<br />\n";
?> 