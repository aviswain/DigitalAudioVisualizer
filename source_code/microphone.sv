
module microphone(
	input logic adc_clk,
	input logic sampling_clk,
	input logic rst,
	output logic [15:0] time_domain
);

	logic [11:0] sound;
	logic [11:0] sound_16bit;
	
	adc u0 (
		.CLOCK    (adc_clk),    
		.RESET    (1'b0),    	
		.CH0      (sound),                  
	);
	
	assign sound_16bit = {4'b0, sound[11:0]}; //5b'0 11:1
	
	always @(posedge sampling_clk) begin
		time_domain <= sound;
	end
	
	
endmodule

/*


module microphone(
	input logic adc_clk,
	input logic sampling_clk,
	input logic rst,
	output logic [15:0] time_domain // CHANGE
);

	logic [11:0] sound;
	logic [11:0] sound_16bit; // CHANGE
	
	adc u0 (
		.CLOCK    (adc_clk),    
		.RESET    (1'b0),    	
		.CH0      (sound),                  
	);
	
	assign sound_16bit = {sound, 4'b0000}; // CHANGE
	
	always @(posedge sampling_clk) begin
		time_domain <= sound; // CHANGE: assign 16 bit sound signal to output signal
	end
	
	
endmodule
*/