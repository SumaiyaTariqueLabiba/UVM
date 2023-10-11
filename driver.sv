class alu_driver extends uvm_driver#(alu_sequence_item) ;
  `uvm_component_utils(alu_driver)
  
  virtual alu_interface vif_driver;
  alu_sequence_item item;
  
  
    //Constuctor------------------------------------------------------------------------------------
  
  function new(string name = "alu_driver", uvm_component parent);        
    super.new(name,parent);
    `uvm_info("Driver_class","Inside driver contructor!", UVM_HIGH)
  endfunction: new
  
  
  
  //Build Phase----------------------------------------------------------------------------------

  function void build_phase(uvm_phase phase);                        
    super.build_phase(phase);
    `uvm_info("Driver_class","Inside driver build phase!", UVM_HIGH)
    
        
                                                                    //virtual interface get------
    uvm_config_db #(virtual alu_interface)::get(this, "*", "vif", vif_driver);          
    if(!( uvm_config_db #(virtual alu_interface)::get(this, "*", "vif", vif_driver))) begin
      `uvm_error("Driver_class","Cannot get virtual interface vif")
    end
    
    
  endfunction: build_phase
  
  
  
 //Connect Phase--------------------------------------------------------------------------------

  function void connect_phase(uvm_phase phase);                   
    super.connect_phase(phase);
    `uvm_info("Driver_class","Inside driver connect phase!", UVM_HIGH)
  endfunction: connect_phase
  
  
  
 //Run Phase------------------------------------------------------------------------------------

  task run_phase(uvm_phase phase);                                
    super.run_phase(phase);
    `uvm_info("Driver_class","Inside driver run phase!", UVM_HIGH)
    
    forever begin
      item = alu_sequence_item::type_id::create("item");  //driver running the logics (items) 
      seq_item_port.get_next_item(item);            //built-in arguments
        drive_1(item);
      seq_item_port.item_done();
    end
    
  endtask: run_phase
  
  
                                                          //drive item/logics---------------
  task drive_1(alu_sequence_item item);
    @(posedge vif_driver.clk);    //the clk from vif handle
    vif_driver.in <= item.in;     //driving items only in inputs
   
  endtask:drive_1
  
  
endclass: alu_driver