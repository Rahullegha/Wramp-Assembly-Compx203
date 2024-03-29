#include "/courses/compx203/ex2/lib_ex2.h"
//initialize the loop counter
int i=0;
// function to get the start and end value of switches
void count(int start, int end){
    //if start and end is smaller the zero and greater and equal to 10000
    if (start < 0 || start >= 10000 || end < 0 || end >= 10000) {
        //then return back
        return;
    }
    // if end is greater than  and equal start
    if(start <= end){
        // loop counter = start value and go till end value 
        for(i=start; i<=end;i++){
            //call the function to print value
            writessd(i);
            delay();
        }
    }
    else{
        //loop counter = start value and go back till end value
        for (i=start; i>= end; i--) {
            //call the function to print value
            writessd(i);  
            delay();
        }   
    }        
}
