#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>

int main(void)
{
  printf("AF_INET = %d\n", AF_INET);
  printf("SOCK_STREAM = %d\n", SOCK_STREAM);

  return EXIT_SUCCESS;
}