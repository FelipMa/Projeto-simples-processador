module ram (address_write, data_write, write_enable,
address_read, data_read, read_enable);

parameter D_WIDTH = 32;
parameter A_WIDTH = 4;
parameter A_MAX = 16; // 2^A_WIDTH (Depth)

// Write port
input  [A_WIDTH-1:0] address_write;
input  [D_WIDTH-1:0] data_write;
input                write_enable;

// Read port
input  [A_WIDTH-1:0] address_read;
output [D_WIDTH-1:0] data_read;
input                read_enable;

reg	[D_WIDTH-1:0] data_read;

// Memory as multi-dimensional array
reg [D_WIDTH-1:0] memory [A_MAX-1:0];

// Write data to memory
always @(posedge write_enable) begin
	memory[address_write] <= data_write;
end

// Read data from memory
always @(posedge read_enable) begin
	data_read <= memory[address_read];
end

endmodule