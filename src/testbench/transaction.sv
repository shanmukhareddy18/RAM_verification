
class ram_transaction;
  rand logic[`DATA_WIDTH-1:0]data_in;
  rand logic write_enb,read_enb;
  rand logic[ADDR_WIDTH-1:0]address;
  logic[`DATA_WIDTH-1:0]data_out;
  constraint wr_rd_constraint{{write_enb,read_enb}inside{[0:3]};}
//constraint wr_not_equal_rd{{write_enb,read_enb}!=2'b11;}
  virtual function ram_transaction copy();
  copy=new();
  copy.data_in=this.data_in;
  copy.write_enb=this.write_enb;
  copy.read_enb=this.read_enb;
  copy.address=this.address;
  return copy;
  endfunction
endclass
