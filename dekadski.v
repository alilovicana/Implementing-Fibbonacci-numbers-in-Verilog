`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:16:10 07/09/2022 
// Design Name: 
// Module Name:    dekadski 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module dekadski(
		input   wire clk, reset,
		input wire [7:0] key_code_1,
		input wire [7:0] key_code_2,
		output [5:0] dekadski_broj
    );
	 reg prvi_broj;
	 reg drugi_broj;
	 
	 always @* 
		begin
		case (key_code_1) 

			8'b00010110: prvi_broj = 1'd1;

			8'b00011110: prvi_broj=  1'd2;

			8'b00100110: prvi_broj = 1'd3;

			8'b00100101: prvi_broj = 1'd4;

			8'b00101110: prvi_broj = 1'd5;

			8'b00110110: prvi_broj= 1'd6;

			8'b00111101: prvi_broj = 1'd7;

			8'b00111110: prvi_broj = 1'd8;

			8'b01000110: prvi_broj = 1'd9;

			//8'b01000101: ascii_code = 1'd0;

			//8'h5a: ascii_code = 8'h0d; // (enter, cr) 

		default: prvi_broj = 1'd0;  

		endcase 
		end
		always @* 
		begin
		case (key_code_2) 

			8'b00010110: drugi_broj = 1'd1;

			8'b00011110: drugi_broj=  1'd2;

			8'b00100110: drugi_broj = 1'd3;

			8'b00100101: drugi_broj = 1'd4;

			8'b00101110: drugi_broj = 1'd5;

			8'b00110110: drugi_broj = 1'd6;

			8'b00111101: drugi_broj = 1'd7;

			8'b00111110: drugi_broj = 1'd8;

			8'b01000110: drugi_broj = 1'd9;

			//8'b01000101: ascii_code = 1'd0;

			//8'h5a: ascii_code = 8'h0d; // (enter, cr) 

		default: drugi_broj = 1'd0;  

		endcase
		end		
	 
	assign dekadski_broj=prvi_broj*10+drugi_broj;

endmodule

