#ifndef MYLIB_H
#define MYLIB_H

typedef struct Account {
    long id;
    int type;
    double balance;
} Account;



void hello_init(void);
void say_hello(void);
int square(int x);
char *greeting(char *name);
Account create_account(long id, int type, double balance);
void hello_terminate(void);

#endif