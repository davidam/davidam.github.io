#include <stdio.h>

int
main (void)
{
  char c;
  while ((c = getchar()) != EOF) /* no portable */
    {
      printf ("leer c = '%c'\n", c);
    }
  return 0;
}
