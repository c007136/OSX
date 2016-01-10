//
//  main.m
//  PjTcpClient
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
        addr.sin_addr.s_addr = INADDR_ANY;
        
        err = bind(fd, (const struct sockaddr *)&addr, sizeof(addr));
        if (err != 0) {
            printf("bind is failed\n");
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
            printf("connect is failed\n");
            close(fd);
            return 0;
        }
        
        printf("connect is success\n");
        
        char buf[1024];
        size_t count=recv(fd, buf, sizeof(buf), 0);
        printf("buf is %s\n", buf);
        
        send(fd, "client", 6, 0);
        
        close(fd);
    }
    return 0;
}
