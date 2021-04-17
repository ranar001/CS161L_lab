//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name:Ronny Anariva
// Email: ranar001@ucr.edu
// 
// Assignment name: Prelab 01
// Lab section: 021
// TA: Yujia Zhai 
// 
// I hereby certify that I have not received assistance on this assignment,
// or used code, from ANY outside source other than the instruction team
// (apart from what was provided in the starter file).
//
//=========================================================================

`timescale 1ns / 1ps

module myalu_tb;
    parameter NUMBITS = 8;

    // Inputs
    reg clk;
    reg reset;
    reg [NUMBITS-1:0] A;
    reg [NUMBITS-1:0] B;
    reg [2:0] opcode;

    // Outputs
    wire [NUMBITS-1:0] result;
    reg [NUMBITS-1:0] R;
    wire carryout;
    wire overflow;
    wire zero;

    // -------------------------------------------------------
    // Instantiate the Unit Under Test (UUT)
    // -------------------------------------------------------
    myalu #(.NUMBITS(NUMBITS)) uut (
        .clk(clk),
        .reset(reset) ,  
        .A(A), 
        .B(B), 
        .opcode(opcode), 
        .result(result), 
        .carryout(carryout), 
        .overflow(overflow), 
        .zero(zero)
    );

      initial begin 
    
     clk = 0; reset = 1; #50; 
     clk = 1; reset = 1; #50; 
     clk = 0; reset = 0; #50; 
     clk = 1; reset = 0; #50; 
         
     forever begin 
        clk = ~clk; #50; 
     end 
     
    end 
    
    integer totalTests = 0;
    integer failedTests = 0;
    initial begin // Test suite
        // Reset
        @(negedge reset); // Wait for reset to be released (from another initial block)
        @(posedge clk); // Wait for first clock out of reset 
        #10; // Wait 

        // Additional test cases
        // ---------------------------------------------
        // Testing unsigned additions 
        // --------------------------------------------- 
        $write("Test Group 1: Testing unsigned additions ... \n");
        opcode = 3'b000; 
        totalTests = totalTests + 1;
        $write("\tTest Case 1.1: Unsigned Add ... ");
        A = 8'hFF; 
           B = 8'h01;
        R = 8'h00; 
        #100; // Wait 
        if (R != result || zero != 1'b1 || carryout != 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 
        
		// Add more tests here
			$write("Test Case: 1.2: Unsigned Add \n");
			A= 8'h0A; //A= 0000 1010 
			B= 8'h11; //B= 0001 0001
			R= 8'h1B; //R= 0001 1011 
            //10+17=27
			if (R != result || zero != 1'b1 || carryout != 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 
        // ---------------------------------------------
        // Testing unsigned subs 
        // --------------------------------------------- 
        $write("Test Group 2: Testing unsigned subs ...\n");
        opcode = 3'b010; 
		// Add more tests here
			A= 8'hB1; //A= 1011 0001 
			B= 8'h20; //B= 0010 0000
			R= 8'h91; //R= 1001 0001
            //177-32=145 
			if (R != result || zero != 1'b1 || carryout != 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait  
        // ---------------------------------------------
        // Testing signed adds 
        // --------------------------------------------- 
        $write("Test Group 3: Testing signed adds ...\n");
        opcode = 3'b001; 
		// Add more tests here
            //85+(-9)=76
            A=8'h55;//A=0101 0101
            B=8'hF6;//B=1111 0110  -->after using 2s complement 
            R=8'h4C;//R=0100 1100
			if (R != result || zero != 1'b1 || carryout != 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 
        
        // ---------------------------------------------
        // Testing signed subs 
        // --------------------------------------------- 
        $write("Test Group 4: Testing signed subs ...\n");
        opcode = 3'b011; 
		// Add more tests here
        // -10+25=15
			A= 8'hF5; //A= 1111 0101 --> 2s complement 
			B= 8'h19; //B= 0001 1001
			R= 8'h0F; //R= 0000 1111 
			if (R != result || zero != 1'b1 || carryout != 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait  
        // ---------------------------------------------
        // Testing ANDS 
        // --------------------------------------------- 
        $write("Test Group 5: Testing ANDs ...\n");
        opcode = 3'b100; 
		// Add more tests here
			A= 8'hFF; //A= 1111 1111 
			B= 8'h00; //B= 0000 0000
			R= 8'h00; //R= 0000 0000 
			if (R != result || zero != 1'b1 || carryout != 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 
        
        // ----------------------------------------
        // ORs 
        // ---------------------------------------- 
        $write("Test Group 6: Testing ORs ...\n");
        opcode = 3'b101; 
		// Add more tests here
        A= 8'hAA; //1010 1010
        B= 8'hD7; //1101 0111
        R= 8'hFF; //1111 1111
        if (R != result || zero != 1'b1 || carryout != 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10 //wait
        // ----------------------------------------
        // XORs 
        // ---------------------------------------- 
        $write("Test Group 7: Testing XORs ...\n");
        opcode = 3'b110; 
		// Add more tests here
        A= 8'h0F; //A=0000 1111
        B= 8'hF0; //B=1111 0000
        R= 8'hFF; //R=1111 11111
        if (R != result || zero != 1'b1 || carryout != 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10 //wait

        // ----------------------------------------
        // Div 2 
        // ----------------------------------------
        $write("Test Group 8: Testing DIV 2 ...\n");
        opcode = 3'b111; 
		// Add more tests here
        //26/2=13
        A= 8'h1A; //A=0001 1010
        R= 8'h0C; //R=0000 1101 --> shift right by 1 bit
        if (R != result || zero != 1'b1 || carryout != 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10 //wait
        // -------------------------------------------------------
        // End testing
        // -------------------------------------------------------
        $write("\n-------------------------------------------------------");
        $write("\nTesting complete\nPassed %0d / %0d tests", totalTests-failedTests,totalTests);
        $write("\n-------------------------------------------------------");
    end
endmodule
