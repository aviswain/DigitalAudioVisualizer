
module clock_divider #(
	parameter BASESPEED = 50000000 // 50 Mhz
) (
	input clk,
	input [$clog2(1000000) - 1:0] speed, // Speed in Hz, up to 1 MHz
	input rst,
	output logic outClk
);

	// internal signals
	logic [$clog2(BASESPEED) - 1:0] ratio;
	logic [$clog2(BASESPEED) - 1:0] counter;
	logic outClk_d;

	assign ratio = BASESPEED / speed; // Output clk is "ratio"-times slower than base clk
       
	/*
        * Determine the value of the output clock for the next clock cycle
        * using a 50% duty cycle 
        */	
	always_comb begin		
		if (counter < (ratio / 2)) begin 
			outClk_d = 0;
		end else begin
			outClk_d = 1;
		end
	end

	/*
	 * Update the counter and clock
	 */
	always @(posedge clk) begin
		if (rst) begin
			counter <= 0;
		end else begin
			if (counter < (ratio - 1'b1)) begin
				counter <= counter + 1'b1;
			end else begin
				counter <= 0;
			end
		end
		outClk <= outClk_d;
	end
endmodule
