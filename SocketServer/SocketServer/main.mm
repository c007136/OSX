#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h> // for close
#include <string>
#include <json/config.h>
#include <json/value.h>
#include <json/writer.h>
#include <iostream>

using std::string;

#define MAXLINE 4096

string &replace_all(string&   str,const   string&   old_value,const   string&   new_value)
{
    while(true)   {
        string::size_type   pos(0);
        if(   (pos=str.find(old_value))!=string::npos   )
            str.replace(pos,old_value.length(),new_value);
        else   break;
    }
    return   str;
}

int main(int argc, char** argv)
{
//    Json::Value json;
//    json["\"name\""] = "\"value\"";
//    //json["小旺机器人"] = "0401你好2";
//    //json["小旺机器人"] = "0401你好3";
//
//    //string s = "{""\"小旺机器人\"" ":" "\"0401你好1\"""}";
//    string s = json.toStyledString();
//    replace_all(s, "\n", "");
//    replace_all(s, "\t", "");
//    replace_all(s, " ", "");
//    std::cout << s << std::endl;
//
//    return 0;
    
    int    listenfd, connfd;
    struct sockaddr_in     servaddr;
    char   buff[4096];
    long   n;
    
    if( (listenfd = socket(AF_INET, SOCK_STREAM, 0)) == -1 ){
        printf("create socket error: %s(errno: %d)\n",strerror(errno),errno);
        exit(0);
    }
    
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
    servaddr.sin_port = htons(6666);
    
    if( bind(listenfd, (struct sockaddr*)&servaddr, sizeof(servaddr)) == -1){
        printf("bind socket error: %s(errno: %d)\n",strerror(errno),errno);
        exit(0);
    }
    
    if( listen(listenfd, 10) == -1){
        printf("listen socket error: %s(errno: %d)\n",strerror(errno),errno);
        exit(0);
    }
    
    printf("======waiting for client's request======\n");
    while(1){
        if( (connfd = accept(listenfd, (struct sockaddr*)NULL, NULL)) == -1){
            printf("accept socket error: %s(errno: %d)",strerror(errno),errno);
            continue;
        }
        
        Json::Value json;
        //json["\"小旺机器人\""] = "\"0401你好1\"";
        json["小旺机器人"] = "0401你好2444";
        
        string s = json.toStyledString();
        replace_all(s, "\n", "");
        replace_all(s, "\t", "");
        replace_all(s, " ", "");
        std::cout << s << std::endl;
        
        long error = send(connfd, s.c_str(), s.length(), 0);
        if (error < 0) {
            printf("send msg error: %s(errno: %d)\n", strerror(errno), errno);
        }
        
        n = recv(connfd, buff, MAXLINE, 0);
        buff[n] = '\0';
        printf("recv msg from n: %ld  client: %s\n", n, buff);
        
        close(connfd);
    }
    
    //close(listenfd);
}
