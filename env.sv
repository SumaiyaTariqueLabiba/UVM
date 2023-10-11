class alu_env extends uvm_env;
  `uvm_component_utils(alu_env)

  alu_agent agent;
  alu_scoreboard scoreboard;
  
  //constructor------------------------------------------------------------------------
  
  function new(string name = "alu_env", uvm_component parent);       
    super.new(name,parent);
    `uvm_info("Env_class","Inside env contructor!", UVM_HIGH)
  endfunction: new
  
  
  
   //Build Phase-----------------------------------------------------------------------
  
  function void build_phase(uvm_phase phase);                       
    super.build_phase(phase);
    `uvm_info("Env_class","Inside env build phase!", UVM_HIGH)
    
    agent = alu_agent::type_id::create("agent", this);   //containing agent & scoreboard inside env (diagram)
    scoreboard = alu_scoreboard::type_id::create("scoreboard",this); 
    
  endfunction: build_phase
  
  
  
  //Connect Phase----------------------------------------------------------------------
  
  function void connect_phase(uvm_phase phase);                    
    super.connect_phase(phase);
    `uvm_info("Env_class","Inside env connect phase!", UVM_HIGH)
    
    agent.monitor.monitor_port.connect(scoreboard.scoreboard_port);
    
  endfunction: connect_phase
  
  
  
  //Run Phase--------------------------------------------------------------------------
  
  task run_phase(uvm_phase phase);                                 
    super.run_phase(phase);
    `uvm_info("Env_class","Inside env run phase!", UVM_HIGH)
  endtask: run_phase
  
  
endclass: alu_env