class alu_sequencer extends uvm_sequencer#(alu_sequence_item);
  `uvm_component_utils(alu_sequencer)
  
  
  
 //Constuctor------------------------------------------------------------------------------------

  function new(string name = "alu_sequencer", uvm_component parent);       
    super.new(name,parent);
    `uvm_info("Sequencer_class","Inside sequencer contructor!", UVM_HIGH)
  endfunction: new
  
  
  
 //Build Phase----------------------------------------------------------------------------------

  function void build_phase(uvm_phase phase);                        
    super.build_phase(phase);
    `uvm_info("Sequencer_class","Inside sequencer build phase!", UVM_HIGH)
  endfunction: build_phase
  
  
  
 //Connect Phase--------------------------------------------------------------------------------

  function void connect_phase(uvm_phase phase);                   
    super.connect_phase(phase);
    `uvm_info("Sequencer_class","Inside sequencer connect phase!", UVM_HIGH)
  endfunction: connect_phase
                    
  
 //(No run Phase in sequencer)-----------------------------------------------------------------
  
endclass: alu_sequencer