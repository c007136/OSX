//
//  main.m
//  UdpServer
//
//  Created by miniu on 15/10/15.
//  Copyright © 2015年 muyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<errno.h>
#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
#import <arpa/inet.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        int fd;
        int err;
        
        fd = socket(AF_INET, SOCK_DGRAM, 0);
        
        struct sockaddr_in addr;
        memset(&addr, 0, sizeof(addr));
        addr.sin_family = AF_INET;
        addr.sin_addr.s_addr = htonl(INADDR_ANY);
        addr.sin_port = htons(8899);
        
        err = bind(fd, (const struct sockaddr *)&addr, sizeof(addr));
        
        while (true)
        {
            char recvData[1024];
            memset(recvData, 0, sizeof(recvData));
            socklen_t addrLen = sizeof(struct sockaddr_in);
            ssize_t len = recvfrom(fd, recvData, sizeof(recvData), 0, (struct sockaddr *)&addr, &addrLen);
            
            printf("addr is %s and port is %d recvdata is %s\n", inet_ntoa(addr.sin_addr), ntohs(addr.sin_port), recvData);
            
            sendto(fd, recvData, sizeof(recvData), 0, (struct sockaddr *)&addr, addrLen);
        }
    }
    return 0;
}
