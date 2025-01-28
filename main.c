#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdlib.h>


#define PORT 6000


struct Custom {
    unsigned short int sin_family;
    uint16_t sin_port;
    uint32_t s_addr;
    unsigned char data[8];
};



void teste(int fd, struct Custom *c, int size) {
    printf("sin_family -> %d\n", c->sin_family);
    printf("sin_port -> %d\n", c->sin_port);
    printf("s_addr -> %d\n", c->s_addr);
    printf("data -> %s\n", c->data);

    printf("fd -> %d\n", fd);
    printf("sizeof -> %d\n", size);

}

// int main() {
//     int server_fd;

//     struct Custom server_addr;
//     // printf("Calculo aleatorio: %ld\n", sizeof (struct sockaddr) - __SOCKADDR_COMMON_SIZE - sizeof (in_port_t) - sizeof (struct in_addr));
//     // printf("Valor original: %ld\nValor custom: %ld\n",sizeof(struct sockaddr_in), sizeof(struct Custom));
//     // exit(1);

//     if((server_fd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
//         return -1;
//     }

//     server_addr.sin_family = AF_INET;
//     server_addr.s_addr = INADDR_ANY;
//     server_addr.sin_port = htons(PORT);

//     // server_addr.sin_family = AF_INET;
//     // server_addr.sin_addr.s_addr = INADDR_ANY;
//     // server_addr.sin_port = htons(PORT);

//     printf("socket size: %ld\n", sizeof(server_addr));
//     exit(1);

//     if(bind(server_fd, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
//         return -1;
//     }

//     if(listen(server_fd, 10) < 0) {
//         return -1;
//     }

//     printf("Server listening on http://localhost:%d\n", PORT);

//     while(1) {
//         struct sockaddr_in client_addr;
//         socklen_t client_addr_len = sizeof(client_addr);
//         int *client_fd = malloc(sizeof(int));

//         if((*client_fd = accept(server_fd, (struct sockaddr *)&client_addr, &client_addr_len)) < 0) {
//             return -1;
//         }

//         printf("A client has connected\n");
//     }

// }