//
//  main.c
//  SQLite
//
//  Created by muyu on 2018/5/25.
//  Copyright © 2018年 muyu. All rights reserved.
//

#include <stdio.h>
#include <sqlite3.h>
#include <string.h>
#include "util.h"

// 函数声明
int openFunctionDemo(void);

int mprintfFunctionDemo(void);

int execFunctionDemo(void);

int getTableFunctionDemo(void);

int prepareFunctionDemo(void);

int prepareFunctionDemo1(void);

int queryParameterDemo(void);

int authorizerFunctionDemo(void);

int customFunctionDemo(void);

int aggregateFunctionDemo(void);

int collationRuleDemo(void);

int busyHandleDemo(void);


int main(int argc, const char * argv[])
{
    return busyHandleDemo();
    
//    return collationRuleDemo();
//
//    return aggregateFunctionDemo();
//
//    return customFunctionDemo();
//
//    return authorizerFunctionDemo();
//
//    return prepareFunctionDemo1();
//
//    return prepareFunctionDemo();
//
//    return getTableFunctionDemo();
//
//    return execFunctionDemo();
//
//    return mprintfFunctionDemo();
//
//    return openFunctionDemo();
}

int openFunctionDemo(void)
{
    char *file = "database.sqlite3";
    sqlite3 *pDB = NULL;
    int rc = 0;
    
    //sqlite3_initialize();  // 用于嵌入式编程，正常情况不需要使用

    /*
     * sqlite3_open_v2函数
     * sqlite3_open的加强版
     *
     * flag相关
     *
     * SQLITE_OPEN_CREATE: 不存在则创建
     * SQLITE_OPEN_NOMUTEX: 打开方式为multi-thread
     * SQLITE_OPEN_FULLMUTEX: 打开方式为serialized
     * SQLITE_OPEN_SHAREDCACHE: the database connection to be eligible to use shared cache mode
     * SQLITE_OPEN_PRIVATECACHE: the databse connection not to be eligibel to use share cache mode
     *
     * vfs: 允许应用程序命名一个虚拟文件系统（Virtual File System）模块
     * VFS是SQLite libarary和底层存储系统（如某个文件系统）之间的一个抽象层
     * 通常传递一个NULL指针，以使默认的VFS模块
     */
    rc = sqlite3_open_v2(file, &pDB, SQLITE_OPEN_READWRITE|SQLITE_OPEN_CREATE, NULL);
    if (rc != SQLITE_OK) {
        sqlite3_close(pDB);
        return -1;
    }
    
    sqlite3_close(pDB);
    //sqlite3_shutdown();  // 用于嵌入式编程
    printf("success");
    
    return 0;
}

int mprintfFunctionDemo(void)
{
    // 会将单引号he's变成加倍后变成he''s
    // 如何验证？？
    char *before1 = "Hey, at least %q no pig-man";
    char *after1 = sqlite3_mprintf(before1, "he’s");
    printf("%s\n", after1);
    
    // %Q 用单引号包围所产生的字符串
    char *before2 = "Hey, at least %Q no pig-man";
    char *after2 = sqlite3_mprintf(before2, "he’s");
    printf("%s\n", after2);
    
    // 空指针的情况，括号包围
    char *before3 = "Hey, at least %q no pig-man";
    char *param3 = NULL;
    char *after3 = sqlite3_mprintf(before3, param3);
    printf("%s\n", after3);
    
    // 空指针的情况，就是NULL
    char *before4 = "Hey, at least %Q no pig-man";
    char *param4 = NULL;
    char *after4 = sqlite3_mprintf(before4, param4);
    printf("%s\n", after4);
    
    return 0;
}

int execCallback(void *data, int nclos, char ** values, char **headers);

int execFunctionDemo(void)
{
    sqlite3 *db;
    int rc;
    char *sql;
    char *zErr;
    
    rc = sqlite3_open_v2("execDemo.db", &db, SQLITE_OPEN_READWRITE|SQLITE_OPEN_CREATE, NULL);
    if (rc) {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
        return -1;
    }
    
//    // create table
//    sql = "create table episodes (id int, name text)";
//    rc = sqlite3_exec(db, sql, NULL, NULL, &zErr);
//    if (rc != SQLITE_OK) {
//        if (zErr != NULL) {
//            fprintf(stderr, "SQL error: %s\n", zErr);
//            sqlite3_free(zErr);
//        }
//    }
    
    // insert + select
    const char *data = "Callback function called";
    sql = "insert into episodes (id, name) values (11, 'Mack');" \
          "select * from episodes;";
    // exec函数支持批量操作
    rc = sqlite3_exec(db, sql, execCallback, (void *)data, &zErr);
    if (rc != SQLITE_OK) {
        if (zErr != NULL) {
            fprintf(stderr, "SQL error: %s\n", zErr);
            sqlite3_free(zErr);
        }
    }
    
    sqlite3_close(db);
    
    return 0;
}

int execCallback(void *data, int nclos, char ** values, char **headers)
{
    int i;
    fprintf(stderr, "%s: ", (const char *)data);
    for (i = 0; i < nclos; i++) {
        fprintf(stderr, "%s=%s ", headers[i], values[i]);
    }
    
    fprintf(stderr, "\n");
    return 0;
}

int getTableFunctionDemo(void)
{
    sqlite3 *db;
    int rc;
    char *sql;
    char *zErr;
    char **result;
    int nrows = 0;
    int ncols = 0;
    
    rc = sqlite3_open_v2("execDemo.db", &db, SQLITE_OPEN_READWRITE|SQLITE_OPEN_CREATE, NULL);
    if (rc) {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
        return -1;
    }
    
    sql = "select * from episodes;";
    rc = sqlite3_get_table(db, sql, &result, &nrows, &ncols, &zErr);
    if (rc) {
        fprintf(stderr, "Can't get table: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
        return -1;
    }
    
    for(int i=0; i < nrows+1; i++) { // 比总列数多1
        for(int j=0; j < ncols; j++) {
            fprintf(stdout, "%s ", result[i*ncols + j]);
        }
    }
    
    /* Free memory */
    sqlite3_free_table(result);
    
    return 0;
}

int prepareFunctionDemo(void)
{
    int rc;
    int i;
    int ncols;
    sqlite3 *db;
    sqlite3_stmt *stmt;
    const char *sql;
    const char *tail;
    
    rc = sqlite3_open("foods.db", &db);
    if (rc) {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
        return -1;
    }
    
    // 不带tail的用法
//    sql = "select * from episodes;";
//    rc = sqlite3_prepare_v2(db, sql, (int)strlen(sql), &stmt, &tail);
//    if (rc != SQLITE_OK) {
//        fprintf(stderr, "SQL error: %s\n", sqlite3_errmsg(db));
//        return -1;
//    }
    
    // tail的用法
    sql = "select * from episodes; select * from foods;";
    while (sqlite3_complete(sql)) {
        rc = sqlite3_prepare_v2(db, sql, (int)strlen(sql), &stmt, &tail);
        if (rc != SQLITE_OK) {
            fprintf(stderr, "SQL error: %s\n", sqlite3_errmsg(db));
            return -1;
        }
        
        rc = sqlite3_step(stmt);
        ncols = sqlite3_column_count(stmt);
        while (rc == SQLITE_ROW) {
            for (i = 0; i < ncols; i++) {
                fprintf(stderr, "'%s' ", sqlite3_column_text(stmt, i));
            }
            fprintf(stderr, "\n");
            rc = sqlite3_step(stmt);
        }
        
        fprintf(stderr, "------------------------\n");
        sqlite3_finalize(stmt);
        sql = tail;
    }
    
    sqlite3_close(db);
    
    return 0;
}

int prepareFunctionDemo1(void)
{
    int rc;
    int i;
    int ncols;
    int id;
    int cid;
    const unsigned char *name;
    char *sql;
    sqlite3 *db;
    sqlite3_stmt *stmt;
    
    rc = sqlite3_open("foods.db", &db);
    if (rc) {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
        return -1;
    }
    
    sql = "select * from episodes;";
    rc = sqlite3_prepare_v2(db, sql, (int)strlen(sql), &stmt, NULL);
    if (rc != SQLITE_OK) {
        fprintf(stderr, "SQL error: %s\n", sqlite3_errmsg(db));
        return -1;
    }
    
    rc = sqlite3_step(stmt);
    ncols = sqlite3_column_count(stmt);
    
    for (i = 0; i < ncols; i++) {
        fprintf(stdout, "Column: name = %s, storage class = %i, declared = %s\n",
                sqlite3_column_name(stmt, i),
                sqlite3_column_type(stmt, i),
                sqlite3_column_decltype(stmt, i));
    }
    
    fprintf(stdout, "\n");
    
    while (rc == SQLITE_ROW) {
        id = sqlite3_column_int(stmt, 0);
        cid = sqlite3_column_int(stmt, 1);
        name = sqlite3_column_text(stmt, 2);
        if(name != NULL){
            fprintf(stderr, "Row:  id=%i, cid=%i, name='%s'\n", id,cid,name);
        } else {
            /* Field is NULL */
            fprintf(stderr, "Row:  id=%i, cid=%i, name=NULL\n", id,cid);
        }
        rc = sqlite3_step(stmt);
    }
    
    return 0;
}

int test_positional_params(sqlite3 *db)
{
    sqlite3_stmt *stmt;
    const char *sql = "insert into food (id, cid, name) values (?, ?, 'muyu');";
    int rc = sqlite3_prepare(db, sql, (int)strlen(sql), &stmt, NULL);
    if (rc != SQLITE_OK) {
        fprintf(stderr, "Error: %s\n", sqlite3_errmsg(db));
    }
    
    sqlite3_bind_int(stmt, 1, 10);
    sqlite3_bind_int(stmt, 2, 20);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    
    return SQLITE_OK;
}

int test_numbered_params(sqlite3 *db)
{
    sqlite3_stmt *stmt;
    char *name = "MuYu";
    const char *sql = "insert into food (id, cid, name) values (?100, ?100, ?101);";
    int rc = sqlite3_prepare(db, sql, (int)strlen(sql), &stmt, NULL);
    if (rc != SQLITE_OK) {
        fprintf(stderr, "Error: %s\n", sqlite3_errmsg(db));
    }
    
    sqlite3_bind_int(stmt, 100, 10);
    sqlite3_bind_text(stmt, 101, name, (int)strlen(name), SQLITE_TRANSIENT);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    
    return SQLITE_OK;
}

void cleanup_fn(void* data)
{
    fprintf(stderr, "Cleanup function called for: %s\n", data);
}

int test_named_params(sqlite3 *db)
{
    sqlite3_stmt *stmt;
    char *name = "Muyu";
    const char *sql = "insert into food (id, cid, name) values (:cosmo,:cosmo,:newman);";
    int rc = sqlite3_prepare(db, sql, (int)strlen(sql), &stmt, NULL);
    if (rc != SQLITE_OK) {
        fprintf(stderr, "Error: %s\n", sqlite3_errmsg(db));
    }
    
    int index = sqlite3_bind_parameter_index(stmt, ":cosmo");
    rc = sqlite3_bind_int(stmt, index, 10);
    if (rc != SQLITE_OK) {
        fprintf(stderr, "Error: %s\n", sqlite3_errmsg(db));
    }
    index = sqlite3_bind_parameter_index(stmt, ":newman");
    rc = sqlite3_bind_text(stmt, index, name, (int)strlen(name), cleanup_fn);
    if (rc != SQLITE_OK) {
        fprintf(stderr, "Error: %s\n", sqlite3_errmsg(db));
    }
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    
    return SQLITE_OK;
}

int queryParameterDemo(void)
{
    int rc;
    sqlite3 *db;
    
    rc = sqlite3_open("test.db", &db);
    
    if (rc) {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
        return -1;
    }
    
    execute(db, "drop table food");
    execute(db, "create table food (id int, cid int, name text);");
    
    fprintf(stdout, "Test Positional Parameters\n");
    execute(db, "delete from food;");
    
    // Positional Parameters
    if (test_positional_params(db) != SQLITE_OK) {
        goto end;
    }
    print_sql_result(db, "select * from food");
    fprintf(stdout, "\n");
    
    // Numbered Parameters
    fprintf(stdout, "Test Numbered Parameters\n");
    execute(db, "delete from food");
    if(test_numbered_params(db) != SQLITE_OK) {
        goto end;
    }
    print_sql_result(db, "select * from food");
    fprintf(stdout, "\n");
    
    // Named Parameters
    fprintf(stdout, "Test Named Parameters\n");
    execute(db, "delete from food");
    if(test_named_params(db) != SQLITE_OK) {
        goto end;
    }
    print_sql_result(db, "select * from food");
    
end:
    sqlite3_close(db);
    
    return 0;
}

int auth(void *x, int type, const char *a, const char *b, const char *c, const char *d)
{
    const char *operation = a;
    printf("    %s", event_description(type));
    
    if ((a != NULL) && (type == SQLITE_TRANSACTION)) {
        printf(": %s Transaction", operation);
    }
    
    switch(type) {
        case SQLITE_CREATE_INDEX:
        case SQLITE_CREATE_TABLE:
        case SQLITE_CREATE_TRIGGER:
        case SQLITE_CREATE_VIEW:
        case SQLITE_DROP_INDEX:
        case SQLITE_DROP_TABLE:
        case SQLITE_DROP_TRIGGER:
        case SQLITE_DROP_VIEW:
        {
            printf(": Schema modified");
        }
    }
    
    if(type == SQLITE_READ) {
        
        printf(": Read of %s.%s ", a, b);
        
        /* Block attempts to read column z */
        if(strcmp(b,"z")==0) {
            printf("-> DENIED\n");
            return SQLITE_IGNORE;
        }
    }
    
    if(type == SQLITE_INSERT) {
        printf(": Insert records into %s ", a);
    }
    
    if(type == SQLITE_UPDATE) {
        printf(": Update of %s.%s ", a, b);
        
        /* Block updates of column x */
        if(strcmp(b,"x")==0) {
            printf("-> DENIED\n");
            return SQLITE_IGNORE;
        }
    }
    
    if(type == SQLITE_DELETE) {
        printf(": Delete from %s ", a);
    }
    
    if(type == SQLITE_ATTACH) {
        printf(": %s", a);
    }
    
    if(type == SQLITE_DETACH) {
        printf("-> %s", a);
    }
    
    printf("\n");
    
    return SQLITE_OK;
}

int authorizerFunctionDemo(void)
{
    sqlite3 *db, *db2;
    char *zErr;
    int rc;
    
    rc = sqlite3_open("test.db", &db);
    
    if (rc) {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
        return -1;
    }
    
    sqlite3_set_authorizer(db, auth, NULL);
    
    printf("program : Starting transaction\n");
    sqlite3_exec(db, "BEGIN", NULL, NULL, &zErr);
    
    printf("program : Aborting transaction\n");
    sqlite3_exec(db, "ROLLBACK", NULL, NULL, &zErr);
    
    printf("program : Creating table\n");
    sqlite3_exec(db, "create table foo(x int, y int, z int)", NULL, NULL, &zErr);

    printf("program : Inserting record\n");
    sqlite3_exec(db, "insert into foo values (1,2,3)", NULL, NULL, &zErr);

    printf("program : Selecting record (value for z should be NULL)\n");
    print_sql_result(db, "select * from foo");

    printf("program : Updating record (update of x should be denied)\n");
    sqlite3_exec(db, "update foo set x=4, y=5, z=6", NULL, NULL, &zErr);

    printf("program : Selecting record (notice x was not updated)\n");
    print_sql_result(db, "select * from foo");

    printf("program : Deleting record\n");
    sqlite3_exec(db, "delete from foo", NULL, NULL, &zErr);

    printf("program : Dropping table\n");
    sqlite3_exec(db, "drop table foo", NULL, NULL, &zErr);

    rc = sqlite3_open("test2.db", &db2);

    if(rc) {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db2));
        sqlite3_close(db2);
        return -1;
    }

    /* Drop table foo2 in test2 if exists */
    sqlite3_exec(db2, "drop table foo2", NULL, NULL, &zErr);
    sqlite3_exec(db2, "create table foo2(x int, y int, z int)", NULL, NULL, &zErr);

    /* Attach database test2.db to test.db */
    // 还有这种用法
    printf("program : Attaching database test2.db\n");
    sqlite3_exec(db, "attach 'test2.db' as test2", NULL, NULL, &zErr);

    /* Select record from test2.db foo2 in test.db */
    printf("program : Selecting record from attached database test2.db\n");
    sqlite3_exec(db, "select * from foo2", NULL, NULL, &zErr);

    printf("program : Detaching table\n");
    sqlite3_exec(db, "detach test2", NULL, NULL, &zErr);

    sqlite3_close(db);
    sqlite3_close(db2);
    
    return 0;
}

void hello_newman(sqlite3_context *ctx, int nargs, sqlite3_value **values)
{
    char *data = (char *)sqlite3_user_data(ctx);
    fprintf(stdout, "Data is %s.\n", data);
    
    const char *msg;
    msg = sqlite3_mprintf("Hello %s", sqlite3_value_text(values[0]));
    
    sqlite3_result_text(ctx, msg, (int)strlen(msg), sqlite3_free);
}

int customFunctionDemo(void)
{
    sqlite3 *db;
    
    int rc = sqlite3_open("test.db", &db);
    if (rc) {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
        return -1;
    }
    
    sqlite3_create_function(db, "hello_newman", 1, SQLITE_UTF8, "Muyu", hello_newman, NULL, NULL);
    
    fprintf(stdout, "Calling with one argument.\n");
    print_sql_result(db, "select hello_newman('Jerry');");
    
    fprintf(stdout, "\nCalling with two argument.\n");
    print_sql_result(db, "select hello_newman('Jerry', 'Elaine');");

    fprintf(stdout, "\nCalling with no argument.\n");
    print_sql_result(db, "select hello_newman();");
    
    sqlite3_close(db);
    
    return 0;
}

typedef struct SAggCtx SAggCtx;
struct SAggCtx {
    int chrCnt;
    char *result;
};

void str_agg_step(sqlite3_context *ctx, int nclos, sqlite3_value **value)
{
    SAggCtx *p = sqlite3_aggregate_context(ctx, sizeof(SAggCtx));
    static const char delim [] = ", ";
    const char *txt = (const char *)sqlite3_value_text(value[0]);
    int len = (int)strlen(txt);
    
    if (!p->result) {
        p->result = sqlite3_malloc(len+1);
        memcpy(p->result, txt, len);
        p->chrCnt = len;
    } else {
        const int delimLen = sizeof(delim)-1;
        p->result = sqlite3_realloc(p->result, p->chrCnt+len+delimLen+2);
        memcpy(p->result+p->chrCnt, delim, delimLen);
        p->chrCnt += delimLen;
        memcpy(p->result+p->chrCnt, txt, len+1);
        p->chrCnt += len;
    }
}

void str_agg_finalize(sqlite3_context *ctx)
{
    SAggCtx *p = (SAggCtx *)sqlite3_aggregate_context(ctx, sizeof(SAggCtx));
    
    if (p && p->result) {
        sqlite3_result_text(ctx, p->result, p->chrCnt, sqlite3_free);
    }
}

// season相同的row，拼接之name
int aggregateFunctionDemo(void)
{
    sqlite3 *db;
    int rc = sqlite3_open("foods.db", &db);
    if (rc) {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
        return -1;
    }
    
    fprintf(stdout, "Registering aggregate function.\n");
    
    sqlite3_create_function(db, "str_agg", 1, SQLITE_UTF8, NULL, NULL, str_agg_step, str_agg_finalize);
    
    fprintf(stdout, "Running query: \n");
    char *sql = "select season, str_agg(name) from episodes group by season";
    print_sql_result(db, sql);
    
    sqlite3_close(db);
    
    return 0;
}

int length_first_collation(void *data, int l1, const void *s1, int l2, const void *s2)
{
    int result = 0;
    int opinion = 0;
    const char *ss1 = (const char *)s1;
    const char *ss2 = (const char *)s2;
    
    if (l1 == l2) result = 0;
    if (l1 < l2) result = 1;
    if (l1 > l2) result = 2;
    
    switch (result) {
        case 1:
            opinion = result;
            break;
        case 2:
            opinion = -result;
        default:
            opinion = strcmp(ss1, ss2);
            break;
    }
    
    return opinion;
}

// 跟预想中的排序规则不一致
int collationRuleDemo(void)
{
    sqlite3 *db;
    char *sql;
    
    int rc = sqlite3_open("foods.db", &db);
    if (rc) {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
        return -1;
    }
    
    fprintf(stdout, "Registering length_first function.\n");
    sqlite3_create_collation(db, "Length_First", SQLITE_UTF8, NULL, length_first_collation);
    
    fprintf(stdout, "Select records using default collation: \n");
    sql = "select name from foods order by name limit 20";
    print_sql_result(db, sql);
    
    fprintf(stdout, "\nSelect records using length_first collation: \n");
    sql = "select name from foods order by name collate Length_First limit 20";
    print_sql_result(db, sql);
    
    sqlite3_close(db);
    
    return 0;
}

int callback(void* data, int ncols, char** values, char** headers)
{
    int i;
    fprintf(stderr, "%s: ", (const char*)data);
    for(i=0; i < ncols; i++) {
        fprintf(stderr, "%s=%s ", headers[i], values[i]);
    }
    
    fprintf(stderr, "\n");
    return 0;
}

// 重看书的时候，来看这个demo
int busyHandleDemo(void)
{
    sqlite3 *db;
    char *sql;
    char *zErr;
    
    int rc = sqlite3_open("test.db", &db);
    if (rc) {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
        return -1;
    }
    
    // 60s
    sqlite3_busy_timeout(db, 60000);
    
    char *data = "Callback function called";
    sql = "insert into episodes (name, cid) values ('Muyu', 1); select * from episodes;";
    
    rc = sqlite3_exec(db, sql, callback, data, &zErr);
    if (rc != SQLITE_OK) {
        if (zErr != NULL) {
            fprintf(stderr, "SQL Error : %s\n", zErr);
            sqlite3_free(zErr);
        }
    }
    
    sqlite3_close(db);
    
    return 0;
}
