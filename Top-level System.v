module Garage_system(btn,reset,car_in,status,l_num,r_num);

  input btn; // 1:Garage is open , 0:Garage is close

  input reset;// Beginng from zero

  input car_in; // 1:Car gets in Garage , 0:Car gets out  from the Garage

  output wire[6:0] status;//E or F // 0:There are avilable places in the garage and cars can get in , 1:There aren't avilable places in the garage and cars cann't get in.

  output wire [6:0]l_num;// Decoding of The left number from total numbers of cars in garage to 7-segment

  output wire [6:0]r_num;// Decoding of The right number from total numbers of cars in garage to 7-segment
  
  wire [5:0]nums;//Total number of cars in the garage

  wire s;//0 1
  FSM sys(btn,reset,car_in,nums,s);

  wire [3:0]lhs_seg=nums/10;//15=0001
  wire [3:0]rhs_seg=nums%10;

  seven_segment_decoder L(lhs_seg,l_num);
  seven_segment_decoder R(rhs_seg,r_num);
  status_decoder ss(s,status);

endmodule

module Garage_system_tb();
  wire btn;reg reset, car_in;
  wire [6:0] l_num, r_num;wire[6:0] status;

  Garage_system gs(btn, reset, car_in, status, l_num, r_num);

  initial begin                //L             R            status
    reset = 1;car_in = 0;#100; //0111111      0111111       1111001
    //////////////////////////
    reset = 0;car_in = 1;#100; //0111111      0000110       1111001
    //////////////////////////
    reset = 0;car_in = 1;#100; //0111111      1011011       1111001
    //////////////////////////
    reset = 0;car_in = 0;#100;
    //////////////////////////
    reset = 0;car_in = 1;#100;
    //////////////////////////
    //reset = 1;car_in = ;#100;
    //////////////////////////
  end

endmodule
