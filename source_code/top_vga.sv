module top_vga(
	input logic rst,
	input logic clk_50,
	input logic [255:0] sound_input,
	input logic [3:0] switches,
	input [15:0] current_sound,
	output logic [3:0] red,
   output logic [3:0] green,
   output logic [3:0] blue,
	
	output logic hsync,
	output logic vsync
);

	logic [2:0] input_red;
   logic [2:0] input_green;
   logic [1:0] input_blue;
	
	logic [9:0] hc_out;
   logic [9:0] vc_out;
	logic [9:0] pixel_address;
	
	logic clk_25;
	logic [9:0] addr;
	
	logic [7:0] ram_color;
	
	
	
	vgaclk vgaclk(
		.inclk0(clk_50),
		.c0(clk_25)
	);
	
	vga vgamodule(
		 .vgaclk(clk_25),
		 .rst(rst),
		 .input_red(ram_color[7:5]),
		 .input_green(ram_color[4:2]),
		 .input_blue(ram_color[2:0]),
		 .hc_out(hc_out),
		 .vc_out(vc_out),
		 .hsync(hsync),
		 .vsync(vsync),
		 .red(red),
		 .green(green),
		 .blue(blue)
	);
	
	
	buffers buffersmodule(
		.clk(clk_25),
		.hc(hc_out),
		.vc(vc_out),
		.RAM_addr(addr),
		.write_color({input_red, input_green, input_blue}),
		.read_color(ram_color)
	);
	
	graphics graphicsmodule(
		.vga_clk(clk_25),
		.hc(hc_out),
		.vc(vc_out),
		.sound_signal(sound_input),
		.pixel_address(addr),
		.red(input_red),
		.green(input_green),
		.blue(input_blue),
		.switches(switches),
		.current_sound(current_sound)
	);

endmodule

/*
module top_vga(
	input logic rst,
	input logic clk_50,
	input logic [255:0] sound_input, // CHANGE
	output logic [3:0] red,
   output logic [3:0] green,
   output logic [3:0] blue,
	
	output logic hsync,
	output logic vsync
);

	logic [2:0] input_red;
   logic [2:0] input_green;
   logic [1:0] input_blue;
	
	logic [9:0] hc_out;
   logic [9:0] vc_out;
	logic [9:0] pixel_address;
	
	logic clk_25;
	logic [9:0] addr;
	
	logic [7:0] ram_color;
	
	
	
	vgaclk vgaclk(
		.inclk0(clk_50),
		.c0(clk_25)
	);
	
	vga vgamodule(
		 .vgaclk(clk_25),
		 .rst(rst),
		 .input_red(ram_color[7:5]),
		 .input_green(ram_color[4:2]),
		 .input_blue(ram_color[2:0]),
		 .hc_out(hc_out),
		 .vc_out(vc_out),
		 .hsync(hsync),
		 .vsync(vsync),
		 .red(red),
		 .green(green),
		 .blue(blue)
	);
	
	
	buffers buffersmodule(
		.clk(clk_25),
		.hc(hc_out),
		.vc(vc_out),
		.RAM_addr(addr),
		.write_color({input_red, input_green, input_blue}),
		.read_color(ram_color)
	);
	
	graphics graphicsmodule(
		.vga_clk(clk_25),
		.hc(hc_out),
		.vc(vc_out),
		.sound_signal(sound_input),
		.pixel_address(addr),
		.red(input_red),
		.green(input_green),
		.blue(input_blue)
	);

endmodule
*/