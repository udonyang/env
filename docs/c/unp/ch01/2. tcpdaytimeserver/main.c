#include "unp.h"
#include <time.h>

int main(int argc, char **argv) {
  int listenfd, connfd;
  struct sockaddr_in servaddr;
  char buff[MAXLINE];
  time_t ticks;

  listenfd = Socket(AF_INET, SOCK_STREAM, 0);

  bzero(&servaddr, sizeof(servaddr));
  servaddr.sin_family = AF_INET;
  servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
  servaddr.sin_port = htonl(INADDR_ANY);

  Bind(listenfd, (SA*)&servaddr, sizeof(servaddr));

  Listen(listenfd, LISTENQ);

  for ( ; ; ) {
    connfd = Accept(listenfd, (SA*)NULL, NULL);
    ticks = time(NULL);
    snprintf(buff, sizeof(buff), "%.24s\r\n", ctime(&ticks));
    char *i;
    for (i = buff; *i; i++) Write(connfd, i, 1);
//     Write(connfd, buff, strlen(buff));
    Close(connfd);
  }
  return 0;
}
