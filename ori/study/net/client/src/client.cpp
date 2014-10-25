/*
 * =====================================================================================
 *
 *       Filename:  client.cpp
 *
 *    Description:  Test Client
 *
 *        Version:  1.0
 *        Created:  2014年08月20日 14时01分42秒
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  degobert (dh), degobert@163.com
 *        Company:  degobert
 *
 * =====================================================================================
 */
#include "../include/head.h"
int main(int argc, char *argv[])
{

    int send_sk;
    struct sockaddr_in s_addr;
    socklen_t len = sizeof(s_addr);
    std::string SER_IP = "10.33.20.20";
    send_sk = socket(AF_INET, SOCK_STREAM,0);
    if (send_sk == -1) {
        perror("socker error\n");
        return -1;
    }
    bzero(&s_addr, sizeof(s_addr));
    s_addr.sin_family = AF_INET;
    int a = inet_pton(AF_INET, SER_IP.c_str(), &s_addr.sin_addr);
    std::cout<<a<<std::endl;
    s_addr.sin_port = htons(10008);
    if (connect(send_sk, (struct sockaddr *)&s_addr, len) == -1) {
        perror("connect failed");
        return -1;
    }
    std::string pContent = "clinet test";
    write(send_sk, pContent.c_str(),5000);
    close(send_sk);
    return 0;
}
