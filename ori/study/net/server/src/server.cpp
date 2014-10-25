/*
 * =====================================================================================
 *
 *       Filename:  server.cpp
 *
 *    Description:  单进程 非阻塞 epoll 
 *
 *        Version:  1.0
 *        Created:  2014年08月20日 11时42分30秒
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  degobert (dh), degobert@163.com
 *        Company:  degobert
 *
 * =====================================================================================
 */
#include "head.h"
#define SERV_PORT 10008
#define MAXCLIENT 5
#define MAXSIZE 1024
char buf[MAXSIZE];
int fd[MAXCLIENT];  // 连接的fd
int conn_amount;  // 当前的连接数
int main(int argc, char* argv[])
{
    signal(SIGPIPE, SIG_IGN);
//    signal(SIGCHLD, SIG_IGN);
    std::cout<<"hello world\n";
    int listen_fd, read_fd, flags;
    struct sockaddr_in listen_addr, client_addr;
    socklen_t len = sizeof(struct sockaddr_in);
    listen_fd = socket(AF_INET, SOCK_STREAM, 0);
    if (listen_fd == -1) {
        perror("socket error");
        return -1;
    }

    if (setsockopt(listen_fd, SOL_SOCKET,SO_REUSEADDR,(char*)&flags, sizeof(flags)) == -1 ) {
        perror("setsockopt error");
        return -1;
    }
    // 设置非阻塞模式
    int flag = fcntl(listen_fd, F_GETFL,0);
    fcntl(listen_fd, F_SETFL, flag|O_NONBLOCK);

    bzero(&listen_addr, sizeof(listen_addr));
    listen_addr.sin_family = AF_INET;
    listen_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    listen_addr.sin_port = htons(SERV_PORT);
    bind(listen_fd, (struct sockaddr *)&listen_addr, len);
    listen(listen_fd, 3);
    struct epoll_event ev, events[20];
    int epfd = epoll_create(256);
    int ev_s = 0;
    ev.data.fd = listen_fd;
    ev.events = EPOLLIN|EPOLLET;
    epoll_ctl(epfd, EPOLL_CTL_ADD, listen_fd, &ev);
    while(1) {
        ev_s = epoll_wait(epfd, events, 20, 500);
        int i = 0;
        for ( i = 0; i < ev_s; i++ ) {
            if (events[i].data.fd == listen_fd) {
                printf("listen event :1 \n");
                read_fd = accept(listen_fd, (struct sockaddr *) &client_addr, &len);
                int flag = fcntl( read_fd, F_GETFL, 0);
                fcntl(read_fd, F_SETFL, flag |O_NONBLOCK);
                ev.data.fd = read_fd;
                ev.events = EPOLLIN|EPOLLET;
                epoll_ctl(epfd, EPOLL_CTL_ADD, read_fd, &ev);
                printf("new accept fd %d\n", read_fd);

            }
            else if (events[i].events &EPOLLIN ) {
                printf("accept event %d\n", i);
                memset(buf, 0, sizeof(buf));
                recv(events[i].data.fd, &buf, 1024,0);
                printf("accept content %s\n", buf);
                
            }
        }
    }
    return 0;
}
