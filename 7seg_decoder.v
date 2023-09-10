module seven_segment_decoder(num, leds[6:0]);

 input [3:0] num;

 output [6:0] leds;

 assign leds[0] = (num[3] | num[1] | (num[2]&num[0]) | (~num[2]) & (~num[0]));//a
 
 assign leds[1] = ((~num[2]) | (~num[1]) & (~num[0]) | (num[1]&num[0]));//b

 assign leds[2] = (num[2] | (~num[1]) | num[0]);//c

 assign leds[3] = (((~num[2])&(~num[0])) | (num[1] & (~num[0])) | (num[2] & ~(num[1]) & num[0]) | ((~num[2]) & num[1]) | num[3] );//d

 assign leds[4] = (((~num[2])&(~num[0])) | (num[1] & (~num[0])));//e

 assign leds[5] = (num[3] | ((~num[1])&(~num[0])) | (num[2] &(~num[1])) | (num[2] & (~num[0])));//f

 assign leds[6] = (num[3] | (num[2] & (~num[1])) | ((~num[2]) & num[1]) | (num[1]&(~num[0])));//g

endmodule

module seg_tb();
 reg [5:0] temp; reg [3:0] num;reg [3:0] num2;
 wire[6:0] led;//15wire[6:0] led2;

 initial begin
  temp=15;num=temp/10;num2=(temp%10); #100; // num=1 num2=5

  temp=20;num=temp/10;num2=(temp%10); #100; // num=2 num2=0
  
  temp=10;num=temp/10;num2=(temp%10); #100; // num=1 num2=0
  
  temp=6;num=temp/10;num2=(temp%10); #100;  // num=0 num2=6
 end
 seven_segment_decoder test(num, led);
 seven_segment_decoder test2(num2, led2);

endmodule
#