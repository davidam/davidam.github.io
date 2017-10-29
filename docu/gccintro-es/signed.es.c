#include <stdio.h>

int 
main (void)
{
  char c = 255;
  if (c > 128) {
    printf ("el carácter es sin signo (c = %d)\n", c);

  } else {
    printf ("el carácter es con signo (c = %d)\n", c);
  }
  return 0;
}
