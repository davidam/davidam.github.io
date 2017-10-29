#include <stdio.h>  

int
main (void)
{
  double x = strtod ("123", NULL);
  printf ("El valor es %f\n", x);
  return 0;
}
