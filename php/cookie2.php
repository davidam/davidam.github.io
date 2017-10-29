<?php
// Imprime una cookie individual
echo $_COOKIE["CookieDePrueba"];
echo $HTTP_COOKIE_VARS["CookieDePrueba"];

// Otra forma de depurar/probar es ver todas las cookies
print_r($_COOKIE);
?> 