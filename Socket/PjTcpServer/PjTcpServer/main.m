//
//  main.m
//  PjTcpServer
//
//  Created by miniu on 15/10/15.
//  Copyright © 2015年 muyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        int err;
        int fd = socket(AF_INET, SOCK_STREAM, 0);
        if (fd == -1) {
            printf("socket is failed\n");
            close(fd);
            return 0;
        }
        
        struct sockaddr_in addr;
        memset(&addr, 0, sizeof(addr));
        addr.sin_len = sizeof(addr);
        addr.sin_family = AF_INET;
        addr.sin_port = htons(7788);
        addr.sin_addr.s_addr = INADDR_ANY;
        
        err = bind(fd, (const struct sockaddr *)&addr, sizeof(addr));
        if (err != 0) {
            printf("bind is failed\n");
            close(fd);
            return 0;
        }
        
        err = listen(fd, 100);
        if (err != 0) {
            printf("listen is failed\n");
            close(fd);
            return 0;
        }
        
        while (true)
        {
            int peerFd;
            struct sockaddr_in peerAddr;
            socklen_t peerAddrLen = sizeof(peerAddr);
            peerFd = accept(fd, (struct sockaddr *)&peerAddr, &peerAddrLen);
            if (peerFd == -1) {
                printf("listen is failed\n");
                close(peerFd);
                close(fd);
                return 0;
            }
            
            printf("connect success,local address:%s,port:%d\n",inet_ntoa(peerAddr.sin_addr),ntohs(peerAddr.sin_port));
            
            
            
            send(peerFd, "server", 6, 0);
            
            char buf[1024];
            size_t count = recv(peerFd, buf, sizeof(buf), 0);
            printf("buf is %s\n", buf);
            
            close(peerFd);
        }
        
        
        close(fd);
        
    }
    return 0;
}
