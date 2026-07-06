module RAM(clk,reset,address,data_in,write_enb,read_enb,data_out);
    input[4:0]address;
    input write_enb;
    input read_enb;
    input[7:0]data_in;
    input clk;
    input reset;
    output[7:0]data_out;
    reg[7:0]data_out;
    reg[7:0]memory[0:31];
    always@(posedge clk)begin
      if(!reset)
      memory[address]<=8'bz;
      else if(write_enb==1 && read_enb==0)
        memory[address]<=data_in;
    end
    always@(posedge clk)begin
      if(!reset)
        data_out<=8'bz;
      else if(read_enb==1 && write_enb==0)
        data_out<=memory[address];
    else
    data_out<=8'bz;
end
endmodule
