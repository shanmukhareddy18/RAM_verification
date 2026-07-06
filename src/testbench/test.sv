class ram_test;
    virtual ram_if.DRV drv_vif;
    virtual ram_if.MON mon_vif;
    virtual ram_if.REF_SB ref_vif;
    ram_environment env;
      function new(virtual ram_if.DRV drv_vif,virtual ram_if.MON mon_vif,virtual ram_if.REF_SB ref_vif);
          this.drv_vif=drv_vif;
        $display("ENV constructor drv_vif=%p",this.drv_vif);
        this.mon_vif=mon_vif;
        this.ref_vif=ref_vif;
    endfunction
    task run();
   $display("TEST drv_vif=%p",drv_vif);
    env=new(drv_vif,mon_vif,ref_vif);
    $display("TEST drv_vif=%p",drv_vif);
    env.build();
    env.start();
  endtask
endclass
