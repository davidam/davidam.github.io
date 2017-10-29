
<?php
var_dump(01090); // 010 octal = 8 decimal

$numero_grande =  2147483647;
var_dump($numero_grande);
// salida: int(2147483647)

$numero_grande =  2147483648;
var_dump($numero_grande);
// salida: float(2147483648)

// esto no ocurre con los enteros indicados como hexadecimales:
var_dump( 0x100000000 );
// salida: int(2147483647)

$millon = 1000000;
$numero_grande =  50000 * $millon;
var_dump($numero_grande);
// salida: float(50000000000)
?> 
