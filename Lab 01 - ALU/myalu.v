//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name: Ronny Anariva 
// Email: ranar001@ucr.edu
//      
// Assignment name: Lab 01: Arithmetic and Logic Unit (ALU)
// Lab section: 021
// TA: Yujia Zhai
// 
// I hereby certify that I have not received assistance on this assignment,
// or used code, from ANY outside source other than the instruction team
// (apart from what was provided in the starter file).
//
//=========================================================================

`timescale 1ns / 1ps

//  Constant definitions 

module myalu # ( parameter NUMBITS = 16 ) (
    input wire clk,
    input wire reset ,
    input  wire[NUMBITS-1:0] A,
    input  wire[NUMBITS-1:0] B,
    input wire [2:0]opcode,
    output reg [NUMBITS-1:0] result,
    output reg carryout ,
    output reg overflow ,
    output reg zero  );

// ------------------------------
// Insert your solution below
// ------------------------------ 
   wire A_sign, B_sign; //done to store sign of A & B
   
   assign A_sign = A[NUMBITS-1];
   assign B_sign = B[NUMBITS-1];
 

   always @(posedge clk) begin 
     carryout=0;
     overflow=0;
     zero=0;

     if(reset) begin
        result=0;
     end 
     else begin
         case(opcode)
                3'b000: begin //unassgined addition
                        {carryout, result}= A + B;
                        if(result ==0) begin
                                zero = 1;
                        end
                        else begin
                                zero = 0;
                        end
                end//end 3'b000 case
                3'b001: begin //signed addition 
                        result= A+B;
                        
                        overflow=(~A_sign & ~B_sign & result[NUMBITS-1]) | (A_sign & B_sign & ~result[NUMBITS-1]);
                        //the above means: A>0 & B>0 & result <0  | A<0 & B<0 & result>0
                end//end 3'b001 case
                3'b010: begin //unsigned sub
                        {carryout,result}= A-B;
                        if(B>A) begin
                           carryout=1;
                        end
                        else begin
                           carryout=0;
                        end
                end //end 3'b010 case
                3'b011: begin //signed sub
                        result= A-B;

                        overflow= (~A_sign & B_sign & result[NUMBITS-1]) | (A_sign & ~B_sign & ~result[NUMBITS-1])
                end//end 3'b011 case
                3'b100: begin //bitwise AND
                        result= A & B;  
                end //end 3'b100 case
                3'b101: begin //bitwise OR
                        result = A | B;
                end
                3'b110: begin //bitwise XOR
                        result = A ^ B;
                end//end 3'b110 case
                3'b111: begin //divide A by 2
                        result = A>>1;
                end//end 3'b111 case
        endcase
    end//end else
  end//end always

        
endmodule
