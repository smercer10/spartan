#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>

int main(void)
{
  printf("AF_INET = %d\n", AF_INET);
  printf("SOCK_STREAM = %d\n", SOCK_STREAM);
  printf("INADDR_ANY = %d\n", INADDR_ANY);
  printf("IPPROTO_TCP = %d\n", IPPROTO_TCP);
  printf("TCP_NODELAY = %d\n", TCP_NODELAY);

  return EXIT_SUCCESS;
}
