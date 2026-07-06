class ram_scoreboard;
    ram_transaction ref2sb_trans,mon2sb_trans;
    mailbox#(ram_transaction)mbx_rs;
    mailbox#(ram_transaction)mbx_ms;
    logic[`DATA_WIDTH-1:0]ref_mem[`DATA_DEPTH-1:0];
    logic[`DATA_WIDTH-1:0]mon_mem[`DATA_DEPTH-1:0];
    int MATCH=0;
    int MISMATCH=0;
    function new(mailbox#(ram_transaction)mbx_rs,mailbox#(ram_transaction)mbx_ms);
      this.mbx_rs=mbx_rs;
      this.mbx_ms=mbx_ms;
    endfunction
  task start();
    for(int i=0;i<`num_transactions;i++)begin
    ref2sb_trans=new();
      mon2sb_trans=new();
    fork
      begin
      mbx_rs.get(ref2sb_trans);
      ref_mem[ref2sb_trans.address]=ref2sb_trans.data_out;
      $display("SCB REF data_out=%0h,ADDRESS=%0h",ref_mem[ref2sb_trans.address],ref2sb_trans.address,$time);
      end
      begin
        mbx_ms.get(mon2sb_trans);
        mon_mem[mon2sb_trans.address]=mon2sb_trans.data_out;
        $display("SCB MON data_out=%0h,ADDRESS=%0h",mon_mem[mon2sb_trans.address],mon2sb_trans.address,$time);
    end
    join
    if(i!=(`num_transactions-1))
    compare_report();
    end
  endtask
  task compare_report();
  if(ref_mem[ref2sb_trans.address]===mon_mem[mon2sb_trans.address])begin
    $display("SCB REF data_out=%0h,MON data_out=%0h",ref_mem[ref2sb_trans.address],mon_mem[mon2sb_trans.address],$time);
    ++MATCH;
    $display("DATA MATCH SUCCESS.COUNT =%0d",MATCH);
  end
  else begin
    $display("SCB REF data_out=%0h,MON data_out=%0h",ref_mem[ref2sb_trans.address],mon_mem[mon2sb_trans.address],$time);
    ++MISMATCH;
    $display("DATA MATCH FAIL.COUNT %0d",MISMATCH);
  end
  endtask
endclass

