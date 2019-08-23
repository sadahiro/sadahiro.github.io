/*

to compile:

  g++ -o ./trackingRequester ./trackingRequester.cpp


to set environment:

  export TRACKER_DEFAULT_HOST=  For security, I can not disclose this on web.
                                 Please contact us if you need this.
 
  export TRACKER_DEFAULT_PIPE=${HOME}/.tracker.pipe


to run:

  Make sure hiBall_client daemon is running, and them issue:

  ./trackingRequester

to quit:

  cntl_c

*/

#include <sys/time.h>
#include <ctype.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <iostream.h>
#include <string.h>
#include <fcntl.h>

int main (){
  
  //  using namespace std;
  
  char FIFO_NAME[1000];
  int fd;
  char* pipe_name= getenv("TRACKER_DEFAULT_PIPE");
  strcpy(FIFO_NAME, pipe_name);
  cout << "named-pipe: " << FIFO_NAME << endl;
  fd = open(FIFO_NAME, O_RDONLY);
  printf("trackd is connected to feeder--\n");
  
  int num;
  const int PACKET_SIZE=11;
  float s[PACKET_SIZE];
  
  while(1){
    num = read(fd, s, PACKET_SIZE*sizeof(float));
    if (sizeof(float)*PACKET_SIZE != num)
      perror("Elements number from server to trackd does not match...\n");
    if(1>num){
      cerr << "hiBall_client side terminated: exiting...." << endl;
      exit(1);
    }
    printf("Tracker: %1.0f\n pos                  rot                      buttons\n %5.3f %5.3f %5.3f   %5.3f %5.3f %5.3f   0:%1.0f 1:%1.0f 2:%1.0f 3:%1.0f\n",
	   s[0], s[1], s[2], s[3], s[4], s[5], s[6], s[7], s[8], s[9], s[10]);
  }
  
  return 0;
}

