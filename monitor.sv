class alu_monitor extends uvm_monitor#(alu_sequence_item);
  `uvm_component_utils(alu_monitor)
  
  virtual alu_interface vif_monitor;
  alu_sequence_item item;
  
  uvm_analysis_port #(alu_sequence_item) monitor_port;
  
  
  
 //Constuctor------------------------------------------------------------------------------------

  function new(string name = "alu_monitor", uvm_component parent);        
    super.new(name,parent);
    `uvm_info("Monitor_class","Inside monitor contructor!", UVM_HIGH)
  endfunction: new
  
  
  
  //Build Phase----------------------------------------------------------------------------------
  
  function void build_phase(uvm_phase phase);                       
    super.build_phase(phase);
    `uvm_info("Monitor_class","Inside monitor build phase!", UVM_HIGH)
         
    monitor_port = new("monitor_port",this);
    
                                                                    //virtual interface get------
    uvm_config_db #(virtual alu_interface)::get(this, "*", "vif", vif_monitor);          
    if(!( uvm_config_db #(virtual alu_interface)::get(this, "*", "vif", vif_monitor))) begin
      `uvm_error("Monitor_class","Cannot get virtual interface vif")
    end
  endfunction: build_phase
  
  
  
 //Connect Phase--------------------------------------------------------------------------------
  
  function void connect_phase(uvm_phase phase);                    
    super.connect_phase(phase);
    `uvm_info("Monitor_class","Inside monitor connect phase!", UVM_HIGH)
  endfunction: connect_phase
  
  
  
  
//Run Phase------------------------------------------------------------------------------------
  
  task run_phase(uvm_phase phase);                                 
    super.run_phase(phase);
    `uvm_info("Monitor_class","Inside monitor run phase!", UVM_HIGH)
    
    item = alu_sequence_item::type_id::create("item");
    
    forever begin                              
                                    // wait(!vif_monitor.reset)-where applicable
      @(posedge vif_monitor.clk);   //sampling inputs
      item.in = vif_monitor.in;
      
      @(posedge vif_monitor.clk);   //sampling outputs
      item.out = vif_monitor.out;
      item.sign = vif_monitor.sign;
      item.carr = vif_monitor.carr;
      item.zero = vif_monitor.zero;
    end
    
    monitor_port.write(item);       //Send item to scoreboard
    
  endtask: run_phase
  
  
endclass: alu_monitor