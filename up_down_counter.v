module up_down_counter(
  input clk,
  input reset,
  input in,
  output[5:0] cc
);
reg[5:0]counter;
always @(posedge clk or posedge reset)
begin

  if(reset)
   counter <= 0;

  else begin

   if(counter==50 && in )
    counter <=50;
 
   else if(counter==0 && !in )
    counter <=0;

   else begin

    if(in)
     counter <= counter + 1;

    else 
     counter <= counter - 1;

   end
  end
end

assign cc=counter;

endmodule

module up_down_counter_testbench();
 wire clk; reg reset,in; wire [5:0] counter;
 
 up_down_counter dut(clk, reset,in, counter);

initial begin
  in = 0;reset = 1;#100; //0
  in = 0;reset = 0;#100; //0
  in = 1;reset = 0;#100; //1
  in = 1;reset = 0;#100; //2
  in = 0;reset = 0;#100; //1
  in = 1;reset = 0;#100; //2
end
endmodule
