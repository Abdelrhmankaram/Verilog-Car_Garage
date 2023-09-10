module FSM(Open_Button,reset,car_in_out,internal,status);

	input Open_Button, reset, car_in_out;

 	output reg status;//0 -> empty 1 -> full 1-bit
 	
	output reg [5:0] internal;//counter
 
 reg [1:0] stat;//00-> s0 01-> s1 10->s2 11->s3
 parameter s0=0,s1=1,s2=2,s3=3;// for the cases block to indicate which state is on

 
 always @(posedge Open_Button or posedge reset) begin

  if(reset) begin
   stat<=s0;
   internal<=6'b0; //counter
  end  

  else begin 
   case(stat)
     s0:if(car_in_out) begin
                       stat<=s1; internal<=internal+1; status<=0;
		    end
       else stat<=s0;

     s1:if(car_in_out==1 && internal<49) begin
				      stat<=s1; internal<=internal+1; status<=0;
				      end
        else if(car_in_out && internal==49) begin
					     stat<=s3; internal<=50; status<=1;
					     end
        else if(car_in_out==0) begin
			      stat<=s2; internal<=internal-1; status<=0;
			      end

     s2:if(!car_in_out && internal>1) begin
				      stat<=s2; internal<=internal-1;status<=0;
				      end
        else if(!car_in_out && internal==1) begin
					    stat<=s0; internal<=0; status<=0;
					    end
        else if(car_in_out) begin
			    stat<=s1; internal<=internal+1; if(internal==50)begin status<=1;stat<=3; end else status<=0;//full
			    end

     s3:if(car_in_out) begin
		       stat<=s3;internal<=50; status<=1;
		       end
        else if(!car_in_out) begin
			     stat<=s2;internal<=internal-1; status<=0;
			     end

     endcase
  end
 end 
endmodule


module FSM_tb();
	wire btn;reg reset,in;wire[5:0] count;wire st;

FSM s(btn,reset,in,count,st);

initial begin
	reset=1;in=1;#100;//0
	reset=0;in=1;#100;//1
	reset=0;in=1;#100;//2
	reset=0;in=0;#100;//1
	reset=1;in=1;#100;//0
	reset=0;in=1;#100;//1

end

endmodule