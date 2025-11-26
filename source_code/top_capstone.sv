
module top_capstone(
	input logic rst,
	input logic clk_50,
	input logic adc_clk,
	input logic [9:0] switches,
	output logic [3:0] red,
   output logic [3:0] green,
   output logic [3:0] blue,
	output logic hsync,
	output logic vsync
);

	logic done;
	logic start_stop = 1;
	
	
	logic [15:0] sound_sample; 
	logic sampling_clk;
	logic display_clk;
	logic fft_clk;
	
	logic [31:0] sound_sr [0:15];
	logic [255:0] display_sigs;
	
	logic [31:0] fd_out [0:15];
	
	clock_divider clk_div(
		.clk(adc_clk),
		.speed(5000), 
		.rst(1'b0),
		.outClk(sampling_clk)
	);
	
	clock_divider clk_dv(
		.clk(clk_50),
		.speed(300), 
		.rst(1'b0),
		.outClk(fft_clk)
	);
	
	fft fft(
		.td(sound_sr),
		.clk(fft_clk),
		.rst_btn(rst),
		.start_stop_btn(start_stop),
		.fd(fd_out),
		.done(done)
	);
	
	magnitude magnitude(
		.fd(fd_out), // need to fix this (WORKS WITH sound_sr though)
		//.fd(sound_sr),
		.mag(display_sigs)
	);
	 
	microphone microphone_module(
		.adc_clk(adc_clk),
		.sampling_clk(sampling_clk),
		.rst(rst),
		.time_domain(sound_sample)
	);
	
	top_vga top_vga_module( //60 Fps --> 60 Hz 
		.rst(rst),
		.clk_50(clk_50),
		.sound_input(display_sigs),
		.red(red),
		.green(green),
		.blue(blue),
		.hsync(hsync),
		.vsync(vsync),
		.switches(switches[3:0]),
		.current_sound(sound_sample)
	);
	
	always @(posedge sampling_clk) begin
		for (int i = 15; i > 0; i--) begin
			sound_sr[i] <= sound_sr[i-1];
		end
    
		sound_sr[0] <= {sound_sample, 16'h0000};
	end
	
	always @(posedge fft_clk) begin
		if (done) begin
			start_stop <= 1;
		end else begin
			start_stop <= 0;
		end
	end
	
	
endmodule


/*

module top_capstone(
	input logic rst,
	input logic clk_50,
	input logic adc_clk,
	output logic [3:0] red,
   output logic [3:0] green,
   output logic [3:0] blue,
	output logic hsync,
	output logic vsync
);

	logic [15:0] sound_sample; // CHANGE
	logic sampling_clk;
	logic display_clk;
	
	logic [255:0] sound_sr; // CHANGE
	
	clock_divider clk_div(
		.clk(adc_clk),
		.speed(5000),
		.rst(1'b0),
		.outClk(sampling_clk)
	);
	
	microphone microphone_module(
		.adc_clk(adc_clk),
		.sampling_clk(sampling_clk),
		.rst(rst),
		.time_domain(sound_sample)
	);
	
	top_vga top_vga_module(
		.rst(rst),
		.clk_50(clk_50),
		.sound_input(sound_sr),
		.red(red),
		.green(green),
		.blue(blue),
		.hsync(hsync),
		.vsync(vsync),
	);
	
	always @(posedge sampling_clk) begin
		sound_sr <= {sound_sr[239:0], sound_sample}; // CHANGE
	end

endmodule*/