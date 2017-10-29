
<html>
<body>
<?php

function fibonacci($x) {
  if (($x == 0) || ($x == 1)) {
    return 1;
  } else {
    return fibonacci($x - 1) + fibonacci($x - 2);
  }
}

echo fibonacci($_POST['numero']);

?>

<p>Escribe un n&uacute;mero y te damos el fibonacci:
<form action="fibonacci.php" method=post>
<input type=text name=numero></input>
<input type=submit>
</form>
</body>
</html>