`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:40:39 07/09/2022 
// Design Name: 
// Module Name:    fib 
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
`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////

// Company: 

// Engineer: 

// 

// Create Date:    12:02:03 05/12/2022 

// Design Name: 

// Module Name:    fibonacci 

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

 module fib

(

   input wire clk, reset,sljedeci,preskok,

	input wire start,

   input wire [5:0] i,

   output reg ready, done_tick,

   output reg [7:0] f0,f1,f2,f3,f4,f5,f6,f7

); 

// symbolic state declaration

 localparam [1:0]

   idle = 2'b00,

   op =2'b01,

   done = 2'b10;

// signal declaration

  reg [1:0] state_reg , state_next;

  reg [63:0] t0_reg, t0_next, t1_reg, t1_next;

  reg [6:0] n_reg , n_next;

  reg [31:0] brojac_reg,brojac_next;  

  reg [3:0] brojac_izlaz;
  reg [7:0] reg1, reg2, reg3, reg4,reg5;


// bod,

// FSMD state & data registers

 always @(posedge clk , posedge reset )

   if (reset)

     begin

         state_reg<=idle;

         t0_reg <= 0;

         t1_reg <= 0;

			brojac_reg<=0;

         n_reg <= 0;

     end

   else

     begin

         state_reg <= state_next ;

         t0_reg <= t0_next;

         t1_reg <= t1_next;

			brojac_reg=brojac_next;

         n_reg <= n_next;

     end

	 
	 always @(posedge clk , posedge sljedeci)

	  begin

      if (sljedeci)

		begin

		
			state_reg <= state_next ;

         t0_reg <= t0_next;

         t1_reg <= t1_next;

			brojac_reg=brojac_next;

         n_reg <= n_next;

     end

     end

	  

	  always @(posedge clk , posedge preskok)

	  begin

      if (preskok)

		begin		

			state_reg <= state_next ;

         t0_reg <= t0_next;

         t1_reg <= t1_next;

			brojac_reg=brojac_next;

         n_reg <= n_next;

     end

     end

	 

// FSMD next-state logic

 always @(*)

    begin

         state_next = state_reg;

         ready = 1'b0;

			brojac_next=brojac_reg;

         done_tick = 1'b0;

         t0_next = t0_reg;

         t1_next = t1_reg;

         n_next = n_reg;

			

   case (state_reg)

  idle:

    begin

        ready = 1'b1;

   if (start)

		begin

			t0_next = 0;

			t1_next = 20'd1;

			brojac_next=0;

			n_next = i;

			state_next = op;

    end

	 if(preskok)

	 begin

	 t0_next = t0_reg;

			t1_next = t1_reg;

			brojac_next=0;

			n_next = i+1;

			state_next = op;

	 end
	 
	  if(sljedeci)

	 begin

			t0_next = t0_reg;

			t1_next = t1_reg;

			n_next = 2;

			state_next = op;
			
			brojac_next=0;
	 end
	 
  end
 

  op :

	if (n_reg==0)

		begin

			t1_next = 0;

			state_next = done;

		end

	else if (n_reg==1)

			state_next = done;

	else

		begin

			t1_next = t1_reg + t0_reg;

			t0_next = t1_reg;

			n_next = n_reg-1;

		end



	done :

		begin

			if(brojac_reg<1000000000)

			begin

			done_tick=1'b1;

			brojac_next=brojac_reg+1;

			state_next=done;

			end

			else

			begin

			state_next=idle;

			end

		end		

		default : state_next = idle ;

	endcase

 end

// output 

//assign f = t1_reg;
always @(posedge clk)
begin
if(done_tick==1)
	begin
	case(t1_reg)
		0: 
			begin
				reg1=8'b00000000;
				brojac_izlaz=1;
			end
		1: begin
				reg1=8'b00000001;
				brojac_izlaz=1;
			end
		2: begin
				reg1=8'b00000010;
				brojac_izlaz=1;
			end
		3: begin 
				reg1=8'b00000011;
				brojac_izlaz=1;
			end
		5: begin
				reg1=8'b00000101;
				brojac_izlaz=1;
			end
		8: 
			begin
				reg1=8'b00001000;
				brojac_izlaz=1;
			end
		13: begin
				reg1=8'b00001101;
				brojac_izlaz=1;
			end
		21: begin 
				reg1=8'b00010101;
				brojac_izlaz=1;
			end
		34: begin
				reg1=8'b00100010;
				brojac_izlaz=1;
			end
		55: begin
				reg1=8'b00110111;
				brojac_izlaz=1;
				end
		89: begin
				reg1=8'b01011001;
				brojac_izlaz=1;
			end
		144: begin
				reg1=8'b10010000;
				brojac_izlaz=1;
			end
		233: begin
				reg1=8'b11101001;
				brojac_izlaz=1;
				end
		377: begin
					reg1=8'b01111001;
					reg2=8'b00000001;
					brojac_izlaz=2;
				end
		610: begin
					reg1=8'b01100010;
					reg2=8'b00000010;
					brojac_izlaz=2;
				end
		987: begin
				reg1=8'b11011011;
				reg2=8'b00000011;
				brojac_izlaz=2;
				end
		1597: begin
				reg1=8'b00111101;
				reg2=8'b00000110;
				brojac_izlaz=2;
				end
		2584: begin
				reg1=8'b00011000;
				reg2=8'b00001010;
				brojac_izlaz=2;
				end
		4181: begin
				reg1=8'b01010101;
				reg2=8'b00010000;
				brojac_izlaz=2;
				end
		6765: begin
				reg1=8'b01101101;
				reg2=8'b00011010;
				brojac_izlaz=2;
				end
		10946: begin
				reg1=8'b11000010;
				reg2=8'b00101010;
				brojac_izlaz=2;
				end
		17711: begin
					reg1=8'b00101111;
					reg2=8'b01000101;
					brojac_izlaz=2;
				end
		28657: begin
					reg1=8'b11110001;
					reg2=8'b01101111;
					brojac_izlaz=2;
					end
		46368: begin
					reg1=8'b00100000;
					reg2=8'b10110101;
					brojac_izlaz=2;
					end
		75025: begin
					reg1=8'b00010001;
					reg2=8'b00100101;
					reg3=8'b00000001;
					brojac_izlaz=3;
					end
		121393: begin
					reg1=8'b00110001;
					reg2=8'b11011010;
					reg3=8'b00000001;
					brojac_izlaz=3;
					end
		196418: begin
					reg1=8'b01000010;
					reg2=8'b11111111;
					reg3=8'b00000010;
					brojac_izlaz=3;
					end
		317811: begin
					reg1=8'b01110011;
					reg2=8'b11011001;
					reg3=8'b00000100;
					brojac_izlaz=3;
					end
		514229:  begin
					reg1=8'b10110101;
					reg2=8'b11011000;
					reg3=8'b00000111;
					brojac_izlaz=3;
					end
		832040: begin
					reg1=8'b00101000;
					reg2=8'b10110010;
					reg3=8'b00001100;
					brojac_izlaz=3;
					end
		1346269: begin
					reg1=8'b11011101;
					reg2=8'b10001010;
					reg3=8'b00010100;
					brojac_izlaz=3;
					end
		2178309: begin
					reg1=8'b00000101;
					reg2=8'b00111101;
					reg3=8'b00100001;
					brojac_izlaz=3;
					end
		3524578: begin
					reg1=8'b11100010;
					reg2=8'b11000111;
					reg3=8'b00110101;
					brojac_izlaz=3;
					end
		5702887: begin
					reg1=8'b11100111;
					reg2=8'b00000100;
					reg3=8'b01010111;
					brojac_izlaz=3;
					end
		9227465: begin
					reg1=8'b11001001;
					reg2=8'b11001100;
					reg3=8'b10001100;
					brojac_izlaz=3;
					end
		14930352: begin
					reg1=8'b10110000;
					reg2=8'b11010001;
					reg3=8'b11100011;
					brojac_izlaz=3;
					end
		24157817: begin
					reg1=8'b01111001;
					reg2=8'b10011110;
					reg3=8'b01110000;
					reg4=8'b00000001;
					brojac_izlaz=4;
					end
		39088169: begin
					reg1=8'b00101001;
					reg2=8'b01110000;
					reg3=8'b01010100;
					reg4=8'b00000010;
					brojac_izlaz=4;
					end
		63245986: begin
					reg1=8'b10100010;
					reg2=8'b00001110;
					reg3=8'b11000101;
					reg4=8'b00000011;
					brojac_izlaz=4;
					end
		102334155: begin
					reg1=8'b11001011;
					reg2=8'b01111110;
					reg3=8'b00011001;
					reg4=8'b00000110;
					brojac_izlaz=4;
					end
		165580141: begin
					reg1=8'b01101101;
					reg2=8'b10001101;
					reg3=8'b11011110;
					reg4=8'b00001001;
					brojac_izlaz=4;
					end
		267914296: begin
					reg1=8'b00111000;
					reg2=8'b00001100;
					reg3=8'b11111000;
					reg4=8'b00001111;
					brojac_izlaz=4;
					end
		433494437: begin
					reg1=8'b10100101;
					reg2=8'b10011001;
					reg3=8'b11010110;
					reg4=8'b00011010;
					brojac_izlaz=4;
					end
		701408733: begin
					reg1=8'b11011101;
					reg2=8'b10100101;
					reg3=8'b11001110;
					reg4=8'b00101001;
					brojac_izlaz=4;
					end
		1134903170: begin
					reg1=8'b10000010;
					reg2=8'b00111111;
					reg3=8'b10100101;
					reg4=8'b01000011;
					brojac_izlaz=4;
					end
		1836311903: begin
					reg1=8'b01011111;
					reg2=8'b11100101;
					reg3=8'b01110011;
					reg4=8'b01101101;
					brojac_izlaz=4;
					end
		2971215073: begin
					reg1=8'b11100001;
					reg2=8'b00100100;
					reg3=8'b00011001;
					reg4=8'b10110001;
					brojac_izlaz=4;
					end
		4807526976: begin
					reg1=8'b01000000;
					reg2=8'b00001010;
					reg3=8'b10001101;
					reg4=8'b00011110;
					reg5=8'b00000001;
					brojac_izlaz=5;
					end
		7778742049: begin
					reg1=8'b00100001;
					reg2=8'b00101111;
					reg3=8'b10100110;
					reg4=8'b11001111;
					reg5=8'b00000001;
					brojac_izlaz=5;
					end
		12586269025: begin
					reg1=8'b01100001;
					reg2=8'b00111001;
					reg3=8'b00011001;
					reg4=8'b01110101;
					reg5=8'b00000001;
					brojac_izlaz=5;
					end
		20365011074: begin
					reg1=8'b10000010;
					reg2=8'b01101000;
					reg3=8'b11011001;
					reg4=8'b10111101;
					reg5=8'b00000100;
					brojac_izlaz=5;
					end
		32951280099: begin
					reg1=8'b11100011;
					reg2=8'b10100001;
					reg3=8'b00001100;
					reg4=8'b10101100;
					reg5=8'b00000111;
					brojac_izlaz=5;
					end
		53316291173: begin
					reg1=8'b01100101;
					reg2=8'b00001010;
					reg3=8'b11100110;
					reg4=8'b01101001;
					reg5=8'b00011000;
					brojac_izlaz=5;
					end
		 86267571272:begin
					reg1=8'b01001000;
					reg2=8'b10101100;
					reg3=8'b11110010;
					reg4=8'b00010101;
					reg5=8'b00010100;
					brojac_izlaz=5;
					end
		 139583862445:begin
					reg1=8'b10101101;
					reg2=8'b10110110;
					reg3=8'b11011000;
					reg4=8'b01111111;
					reg5=8'b00100000;
					brojac_izlaz=5;
					end
		225851433717: begin
					reg1=8'b11110101;
					reg2=8'b01100010;
					reg3=8'b11001011;
					reg4=8'b01001011;
					reg5=8'b01101001;
					brojac_izlaz=5;
					end
		365435296162: begin
					reg1=8'b10100010;
					reg2=8'b00011001;
					reg3=8'b10100100;
					reg4=8'b00010101;
					reg5=8'b01010101;
					brojac_izlaz=5;
					end
		591286729879: begin
					reg1=8'b10010111;
					reg2=8'b01111100;
					reg3=8'b01101111;
					reg4=8'b10101011;
					reg5=8'b10001001;
					brojac_izlaz=5;
					end
		956722026041: begin
					reg1=8'b00111001;
					reg2=8'b10010110;
					reg3=8'b00010011;
					reg4=8'b11000001;
					reg5=8'b11011110;
					brojac_izlaz=5;
					end
			endcase
		end
end
always @(posedge clk)
	begin
		case(brojac_izlaz)
				1:begin
						f0<=reg1[0];
						f1<=reg1[1];
						f2<=reg1[2];
						f3<=reg1[3];
						f4<=reg1[4];
						f5<=reg1[5];
						f6<=reg1[6];
						f7<=reg1[7];
					end
				2: begin
						f0<=reg2[0];
						f1<=reg2[1];
						f2<=reg2[2];
						f3<=reg2[3];
						f4<=reg2[4];
						f5<=reg2[5];
						f6<=reg2[6];
						f7<=reg2[7];
						brojac_izlaz<=brojac_izlaz-1;
					end
				3: begin
						f0<=reg3[0];
						f1<=reg3[1];
						f2<=reg3[2];
						f3<=reg3[3];
						f4<=reg3[4];
						f5<=reg3[5];
						f6<=reg3[6];
						f7<=reg3[7];
						brojac_izlaz<=brojac_izlaz-1;
					end
				4: begin
						f0<=reg4[0];
						f1<=reg4[1];
						f2<=reg4[2];
						f3<=reg4[3];
						f4<=reg4[4];
						f5<=reg4[5];
						f6<=reg4[6];
						f7<=reg4[7];
						brojac_izlaz=brojac_izlaz-1;
					end
				5: begin
						f0<=reg5[0];
						f1<=reg5[1];
						f2<=reg5[2];
						f3<=reg5[3];
						f4<=reg5[4];
						f5<=reg5[5];
						f6<=reg5[6];
						f7<=reg5[7];
						brojac_izlaz=brojac_izlaz-1;
					end
			endcase
		
		
	end

endmodule