#include <assert.h>
#include <string.h>
#include <stdio.h>

char *compress(char *s, char *o) {
  o[0]=0;
  for(char p=*s++,i=1;*s||!sprintf(o+strlen(o),"%d%c",i,p);p=*s,s++)
  if (*s==p) ++i; else { sprintf(o+strlen(o),"%d%c",i,p); i=1; }
  return o;
}

int main() {
  char o[0xff];
  /* disclaimer: string musn't be empty and max. sequence length
  for character should fit in a char type!!! */
  assert(!strcmp(compress("AAABBAAC",o),"3A2B2A1C"));
  assert(!strcmp(compress("ABBAAC",o),"1A2B2A1C"));
  assert(!strcmp(compress("AAABBAACC",o),"3A2B2A2C"));
  assert(!strcmp(compress("ABCDE",o),"1A1B1C1D1E"));

  return 0;
}
