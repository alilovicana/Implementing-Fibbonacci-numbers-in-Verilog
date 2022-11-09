`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:19:14 07/06/2022 
// Design Name: 
// Module Name:    key2ascii 
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
module key2ascii (

input   wire [7:0] key_code , 

output   reg [7:0] ascii_code); 

always @* 

case (key_code) 

8'h45: ascii_code = 8'h30;

8'h16: ascii_code= 8'h31;

8'h1e: ascii_code = 8'h32;

8'h26: ascii_code = 8'h33;

8'h25: ascii_code = 8'h34;

8'h2e: ascii_code = 8'h35;

8'h36: ascii_code = 8'h36;

8'h3d: ascii_code = 8'h37;

8'h3e: ascii_code = 8'h38;

8'h46: ascii_code = 8'h39;

8'h5a: ascii_code = 8'h0d; // (enter, cr) 

default: ascii_code = 8'h2a; // * 

endcase 

endmodule