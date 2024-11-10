#include <unistd.h>
#include <limits.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
int main(int argc,char **argv){
    char *command[argc+11];
    char *path = (char *)malloc(4096);
    path[0]='\0';
    realpath("/proc/self/exe",path);
    for(size_t i=strlen(path)-1;i>=0;i--){
        if(path[i]=='/'){
            path[i]='\0';
            break;
        }
    }
    char file[4096]={'\0'};
    sprintf(file,"%s/file-static",path);
    command[0]=file;
    command[1]="--magic-file";
    char magic[4096]={'\0'};
    sprintf(magic,"%s/magic.mgc",path);
    command[2]=magic;
    for(int i=1;i<argc;i++){
        command[i+2]=argv[i];
    }
    command[argc+2] = NULL;
    free(path);
    execv(command[0],command);
}