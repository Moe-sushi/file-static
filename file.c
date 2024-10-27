#include <unistd.h>
#include <limits.h>
#include <stdlib.h>
#include <string.h>
int main(int argc,char **argv){
    char *command[argc+11];
    command[0]="file-static";
    command[1]="--magic-file";
    char path[4096]={'\0'};
    realpath("/proc/self/exe",path);
    for(size_t i=strlen(path)-1;i>=0;i--){
        if(path[i]=='/'){
            path[i]='\0';
            break;
        }
    }
    strcat(path,"/magic.mgc");
    command[2]=path;
    for(int i=1;i<argc;i++){
        command[i+2]=argv[i];
    }
    command[argc+2] = NULL;
    execvp(command[0],command);
}