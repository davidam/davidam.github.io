#if FOO
   int x = 1;
#elsif BAR   /* debería ser #elif */
   int x = 2;
#else     
   int x = 3;
#endif
