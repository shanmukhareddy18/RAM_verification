`include "defines.svh"
interface ram_if(input logic clk,input logic reset);
  logic[`DATA_WIDTH-1:0]data_in;
  logic[`DATA_WIDTH-1:0]data_out;
  logic[$clog2(`DATA_DEPTH)-1:0]address;
  logic write_enb;
  logic read_enb;
  clocking drv_cb@(posedge clk);
    default input #1 output #1;
    input reset;
    output data_in;
    output address;
    output write_enb;
    output read_enb;
  endclocking
  clocking mon_cb@(posedge clk);
    default input #1 output #1;
    input data_out;
  endclocking
  clocking ref_cb@(posedge clk);
    default input #1 output #1;
  endclocking
modport DRV(clocking drv_cb);
modport MON(clocking mon_cb);
modport REF_SB(clocking ref_cb);
endinterface
