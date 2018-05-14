//
//  main.cpp
//  GetAndPost
//
//  Created by muyu on 2018/4/9.
//  Copyright © 2018年 muyu. All rights reserved.
//
//  http://blog4jimmy.com/2018/01/319.html

#include <iostream>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <stdlib.h>
#include <string>
#include <cstring>
#include <memory>


#include "HttpGetPostMethod.hpp"

using namespace std;

int main()
{
    //shared_ptr http_request(new HttpGetPostMethod());
    //shared_ptr http_request = make_shared();
    HttpGetPostMethod *http_request = new HttpGetPostMethod();
    
    // 网关升级接口
    int ret  = http_request->HttpGet("apigw.qa.91jkys.com", "/api/index/1.0/validation_appver", "uid=1899888&chr=clt&clientType=1&platform=iOS&appVer=1.0.0");
    if(ret == -1) {
        cout << "Http Socket error!" << endl;
    }
    if(http_request->get_return_status_code() != 200) {
        cout << "Http get status code was: " << http_request->get_return_status_code() << endl;
    }
    string request_return = http_request->get_request_return();
    string main_text = http_request->get_main_text();
    
    cout << "Return Status Code: " << http_request->get_return_status_code() << endl;
    cout << "Request Return: " << endl << request_return << endl;
    //cout << "Main Text: " << endl << main_text << endl;
    
    return 0;
    sleep(5);
    
    ret = http_request->HttpGet("route.showapi.com", "/902-1", "showapi_appid=52875&showapi_sign=59c54e39583740bf9708c645c389c9ec&fundCode=000478&needDetails=1");
    
    if(ret == -1) {
        cout << "Http Socket error!" << endl;
    }
    if(http_request->get_return_status_code() != 200) {
        cout << "Http get status code was: " << http_request->get_return_status_code() << endl;
    }
    request_return = http_request->get_request_return();
    main_text = http_request->get_main_text();
    
    cout << "Return Status Code: " << http_request->get_return_status_code() << endl;
    cout << "Request return: " << endl << request_return << endl;
    cout << "Main Text: " << endl << main_text << endl;
}
