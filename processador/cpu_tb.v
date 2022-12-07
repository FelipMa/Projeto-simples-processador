`timescale 1ns/10ps 

module cpu_tb;

reg clock;
reg [27:0] mir;
wire [31:0] on_c, on_b, on_ram_read, on_ram_write;

cpu dut (.clock(clock), .mir(mir), 
.on_c(on_c), .on_b(on_b), .on_ram_read(on_ram_read), .on_ram_write(on_ram_write));

initial
begin
clock = 1'b0;
mir = 28'b0;

$display("save 1 on mbr");
#10
mir = 28'b00_110001_00_0000_0000001000_0000;

toggleClock;

displayOut;

$display("write mbr(1) on memory addr 0001");
#10
mir = 28'b00_000000_10_0001_0000000101_0000; // mar and pc must be enabled

toggleClock;

displayOut;

$display("read memory addr 0001 (1), data goes to mdr after two clocks");
#10
mir = 28'b00_000000_01_0001_0000000111_0000; // mar, pc and mdr must be enabled

toggleClock;
toggleClock;

displayOut;

$display("enable mdr(1) to b_bus, increment, and save on H and mbr registers, after two clocks");
#10
mir = 28'b00_110101_00_0000_1000001000_0001; //

toggleClock;
toggleClock;

displayOut;

$display("write mbr(2) on memory addr 0010");
#10
mir = 28'b00_000000_10_0010_0000000101_0000; // mar and pc must be enabled

toggleClock;

displayOut;

$display("read memory addr 0010 (2), data goes to mdr after two clocks");
#10
mir = 28'b00_000000_01_0010_0000000111_0000; // mar, pc and mdr must be enabled

toggleClock;
toggleClock;

displayOut;

$display("enable mdr(2) to b_bus, perform H(2) + mdr(2), and save on mbr, after two clocks");
#10
mir = 28'b00_111100_00_0000_0000001000_0001; //

toggleClock;
toggleClock;

displayOut;

$display("write mbr(4) on memory addr 0100");
#10
mir = 28'b00_000000_10_0100_0000000101_0000; // mar and pc must be enabled

toggleClock;

displayOut;

$display("read memory addr 0100 (4), data goes to mdr after two clocks");
#10
mir = 28'b00_000000_01_0100_0000000111_0000; // mar, pc and mdr must be enabled

toggleClock;
toggleClock;

displayOut;

end

task displayOut;
begin
#1 $display("on_c = %0d -- on_b = %0d -- on_ram_read = %0d -- on_ram_write = %0d",
on_c, on_b, on_ram_read, on_ram_write);
#1 $display("");
end
endtask

task toggleClock;
begin
#5 clock = ~clock;
#5 clock = ~clock;
end
endtask

endmodule
