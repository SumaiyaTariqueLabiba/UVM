class alu_agent extends uvm_agent;
  `uvm_component_utils(alu_agent)
  
  alu_driver driver;
  alu_monitor monitor;
  alu_sequencer sequencer;
  
  
  //Constuctor------------------------------------------------------------------------------------
  
  function new(string name = "alu_agent", uvm_component parent);        
    super.new(name,parent);
    `uvm_info("Agent_class","Inside agent contructor!", UVM_HIGH)
  endfunction: new
  
  
  
   //Build Phase----------------------------------------------------------------------------------
  
  function void build_phase(uvm_phase phase);                       
    super.build_phase(phase);
    `uvm_info("Agent_class","Inside agent build phase!", UVM_HIGH)
    
    driver = alu_driver::type_id::create("driver", this);          //containing driver,monitor,seq-er inside agent (diagram)
    monitor = alu_monitor::type_id::create("monitor", this);   
    sequencer = alu_sequencer::type_id::create("sequencer", this);  
    
  endfunction: build_phase
  
  
  
   //Connect Phase--------------------------------------------------------------------------------
  
  function void connect_phase(uvm_phase phase);                   
    super.connect_phase(phase);
    `uvm_info("Agent_class","Inside agent connect phase!", UVM_HIGH)
    
    driver.seq_item_port.connect(sequencer.seq_item_export);   //connect driver-sequencer port-exports
    
  endfunction: connect_phase
  
  
  
   //Run Phase------------------------------------------------------------------------------------
  
  task run_phase(uvm_phase phase);                               
    super.run_phase(phase);
    `uvm_info("Agent_class","Inside agent run phase!", UVM_HIGH)
  endtask: run_phase
  
  
endclass: alu_agent