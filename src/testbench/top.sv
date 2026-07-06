`include "RAM.sv"
`include "interface.sv"
`include "ram_package.sv"
import ram_package::*;
module top();
        logic clk;
        logic reset;
        initial begin clk=0;end
        initial begin
                forever #10 clk=~clk;
        end
        initial begin
                reset=1;
                @(posedge clk);
                reset=0;
                repeat(5)@(posedge clk);

                reset=1;
        end
        ram_if intrf(clk,reset);
 RAM DUV(.data_in(intrf.data_in),.read_enb(intrf.read_enb),.write_enb(intrf.write_enb),.data_out(intrf.data_out),.address(intrf.address),.clk(clk),.reset(reset));
        ram_test test;
        initial begin
                test=new(intrf.DRV,intrf.MON,intrf.REF_SB);
                test.run();
                $finish();
        end
endmodule
