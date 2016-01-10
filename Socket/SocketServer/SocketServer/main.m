//
//  main.m
//  SocketServer
//
//  Created by miniu on 15/10/13.
//  Copyright (c) 2015年 muyu. All rights reserved.
//
//  socket tcp server端实现
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
        
        struct sockaddr_in addr;
        memset(&addr, 0, sizeof(addr));
        addr.sin_len = sizeof(addr);
        addr.sin_family = AF_INET;
        addr.sin_port = htons(7788);
        addr.sin_addr.s_addr = INADDR_ANY;
        
        err = bind(fd, (const struct sockaddr *)&addr, sizeof(addr));
        
        err = listen(fd, 100);
        while (true)
        {
            printf("while is true");
            
            int peerFd;
            struct sockaddr_in peerAddr;
            socklen_t peerAddrLen = sizeof(peerAddr);
            peerFd = accept(fd, (struct sockaddr *)&peerAddr, &peerAddrLen);
            if (peerFd != -1) {
                char buf[1024];
                size_t count;
                size_t len = sizeof(buf);
                do
                {
                    count=recv(peerFd, buf, len, 0);
                    NSString * str = [NSString stringWithCString:buf encoding:NSUTF8StringEncoding];
                    NSLog(@"str is %@", str);
                    sleep(1);
                } while (strcmp(buf, "exit")!=0);
            }
            
            close(peerFd);
        }
    }
    return 0;
}
