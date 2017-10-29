
<html>
<body>
<?php
// echo $_POST['numero'];
// var_dump($_POST);

function factorial($x) {
  if ($x > 0) {
    return factorial($x - 1) * $x;
  } else {
    return 1;
  }
}

  echo factorial($_POST['numero']);


?>

<p>Escribe un n&uacute;mero y te damos el factorial:
<form action="factorial.php" method=post>
<input type=text name=numero></input>
<input type=submit>
</form>
</body>
</html>