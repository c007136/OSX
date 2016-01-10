//
//  main.m
//  SocketClient
//
//  Created by miniu on 15/10/13.
//  Copyright (c) 2015年 muyu. All rights reserved.
//
//  socket tcp client端实现
//  http://www.coderyi.com/archives/429
//  http://www.cnblogs.com/skynet/archive/2010/12/12/1903949.html

#import <Foundation/Foundation.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        int err;
        int fd = socket(AF_INET, SOCK_STREAM, 0);
        if (fd == -1) {
            printf("socket is failed");
            close(fd);
            return 0;
        }
        
        struct sockaddr_in addr;
        memset(&addr, 0, sizeof(addr));
        addr.sin_len = sizeof(addr);
        addr.sin_family = AF_INET;
        addr.sin_addr.s_addr = INADDR_ANY;
        
        err = bind(fd, (const struct sockaddr *)&addr, sizeof(addr));
        if (err != 0) {
            printf("bind is failed");
            close(fd);
            return 0;
        }
        
        struct sockaddr_in peerAddr;
        memset(&peerAddr, 0, sizeof(peerAddr));
        peerAddr.sin_len = sizeof(peerAddr);
        peerAddr.sin_family = AF_INET;
        peerAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
        peerAddr.sin_port=htons(7788);
        
        socklen_t peerAddrLen = sizeof(peerAddr);
        err = connect(fd, (const struct sockaddr *)&peerAddr, peerAddrLen);
        if (err != 0) {
            printf("connect is failed");
            close(fd);
            return 0;
        }
        
        struct sockaddr_in addrLog;
        err = getsockname(fd, (struct sockaddr *)&addrLog, &peerAddrLen);
        if (err != 0) {
            printf("getsockname is failed");
            close(fd);
            return 0;
        }
        
        printf("connect success,local address:%s,port:%d",inet_ntoa(addrLog.sin_addr),ntohs(addrLog.sin_port));
        
        char buf[1024];
        do
        {
            printf("input message:");
            scanf("%s",buf);
            send(fd, buf, 1024, 0);
        } while (strcmp(buf, "exit")!=0);
        
        close(fd);
    }
    return 0;
}
