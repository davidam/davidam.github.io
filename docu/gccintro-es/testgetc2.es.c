#include <stdio.h>

int
main (void)
{
  int i;
  while ((i = getchar()) != EOF)
    {
      unsigned char c = i;
      printf ("leer c = '%c'\n", c);
    }
  return 0;
}
