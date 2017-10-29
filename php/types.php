<?php
$bool = TRUE;  // un valor booleano
$str  = "foo";  // una cadena
$int  = 12;    // un entero

// echo gettype($bool); // imprime "boolean"
// echo gettype($str);  // imprime "string"

// Si este valor es un entere, incrementarlo en cuatro
if (is_int($int)) {
  $int += 4;
  echo "$int";
}

// Si $bool es una cadena, imprimirla
// (no imprime nada)
if (is_string($bool)) {
  echo "Cadena: $bool";
}
?>