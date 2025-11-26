module buffers(
	input clk,
	input [9:0]hc,
	input [9:0]vc, 
	input [9:0]RAM_addr,
	input [7:0]write_color,
	
	output [7:0]read_color
);

logic [7:0] buffer_A [0:767];  // first frame buffer
logic [7:0] buffer_B [0:767];  // second frame buffer

logic buffer_select = 0;  // 0 for Buf A, 1 for Buf B


always_ff @(posedge clk) begin
   if (hc == 0 && vc == 0) begin
       buffer_select <= ~buffer_select; 
		 // flip buffer select at new frame --> change which buffer read and write
   end
	
	if (buffer_select) begin
		buffer_B[RAM_addr] = write_color; // write to B
	end else begin
		buffer_A[RAM_addr] = write_color; //  and write to A
	end
end


always_comb begin
   if (buffer_select) begin
       read_color = buffer_A[RAM_addr];  // if buffer select = 1, read from A
   end else begin
       read_color = buffer_B[RAM_addr];  // else read to B
   end
end



endmodule
