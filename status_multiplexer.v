module status_decoder(
       input status,
       output reg [6:0] status_word
       );
 always @( * )
 case(status)                   // gfedcba
        1'b0:assign status_word=7'b1111001;//displays E on the third seven segement to indicate that the garage has slots for cars
        1'b1:assign status_word=7'b1110001;//displays F in the third seven segement to indicate that the garage is full
 endcase

endmodule

module multiplexer_tb();

 wire in;
 wire [6:0] out;
 status_decoder g(in,out);
 
endmodule
//1