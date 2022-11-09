`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:27:34 07/09/2022 
// Design Name: 
// Module Name:    kb_test 
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
module kb_test
(
	input wire clk, reset, sljedeci,preskok,
	input   wire ps2d, ps2c,	
	input wire start,
   output reg ready, done_tick,
   output wire  f0,f1,f2,f3,f4,f5,f6,f7,
	output  wire tx
);
// signal declaration

reg brojac=0;
reg [15:0] dekadski;
reg [5:0] dekadski_broj;
wire [7:0] key_code,ascii_code;
wire kb_not_empty, kb_buf_empty;
wire sljedeci_out, preskok_out,start_out;

// body
// instantiate keyboard scan code circuit
kb_code kb_code_unit
(.clk(clk), .reset(reset), .ps2d(ps2d), .ps2c(ps2c),
.rd_key_code(kb_not_empty), .key_code(key_code),
.kb_buf_empty(kb_buf_empty));
// instantiate UART
uart uart_unit
(.clk(clk), .reset(reset), .rd_uart(1'b0),
.wr_uart(kb_not_empty), .rx(1'b1), .w_data(ascii_code),
.tx_full(), .rx_empty(), .r_data() , .tx(tx));
// instantiate key-to-ascii code conversion circuit
key2ascii k2a_unit
(.key_code(key_code), .ascii_code(ascii_code));

kb_monitor monitor_unit
(.clk(clk), .reset(reset),
.ps2d(ps2d), .ps2c(ps2c),
.tx(tx));

dekadski dekadski_unit
	(.clk(clk), .reset(reset),
		.key_code_1(dekadski[7:0]),
		.key_code_2(dekadski[15:8]),
		.dekadski_broj(dekadski_broj)
    );
	 
fib fib_unit
(.clk(clk), .reset(reset),.sljedeci(sljedeci_out),.preskok(preskok_out),
	.start(start_out),
   .i(dekadski_broj),
   .ready(ready), .done_tick(done_tick),
   .f0(f0), .f1(f1), .f2(f2), .f3(f3),
	.f4(f4), .f5(f5), .f6(f6), .f7(f7)
); 
dbc sljedeci_debounce(.clk(clk), .signal_i(sljedeci),.signal_o(sljedeci_out));
dbc preskok_debounce(.clk(clk), .signal_i(preskok),.signal_o(preskok_out));
dbc start_debounce(.clk(clk), .signal_i(start),.signal_o(start_out));

always @(posedge clk)
begin
	if(brojac==0)
	begin
		dekadski[7:0]=key_code;
		brojac=brojac+1;
	end
	else
	begin
		dekadski[15:8]=key_code;
		brojac=0;
	end
end
 
assign kb_not_empty = ~kb_buf_empty;
endmodule
