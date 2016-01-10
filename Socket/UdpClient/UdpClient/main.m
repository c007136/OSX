//
//  main.m
//  UdpClient
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
        addr.sin_addr.s_addr = inet_addr("127.0.0.1");
        addr.sin_port = htons(8899);
        
        err = bind(fd, (const struct sockaddr *)&addr, sizeof(addr));
        
        socklen_t addrLen = sizeof(struct sockaddr_in);
        sendto(fd, "client", 6, 0, (struct sockaddr *)&addr, addrLen);
        
        char recvData[1024];
        recvfrom(fd, recvData, sizeof(recvData), 0, (struct sockaddr *)&addr, &addrLen);
        printf("recvdata is %s\n", recvData);
        
        close(fd);
    }
    return 0;
}
