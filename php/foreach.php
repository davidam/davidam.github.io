<?php
// Crear una matriz simple.
$matriz = array(1, 2, 3, 4, 5);
print_r($matriz);

// Ahora eliminar cada item, pero dejar la matriz misma intacta:
foreach ($matriz as $i => $valor) {
  unset($matriz[$i]);
}
print_r($matriz);

// Agregar un item (note que la nueva clave es 5, en lugar de 0 como
// podria esperarse).
$matriz[] = 6;
print_r($matriz);

// Re-indexar:
$matriz = array_values($matriz);
$matriz[] = 7;
print_r($matriz);
?> 