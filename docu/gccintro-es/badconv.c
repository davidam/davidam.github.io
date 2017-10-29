#include <stdio.h>  

int
main (void)
{
  double x = strtod ("123", NULL);
  printf ("Value is %f\n", x);
  return 0;
}
