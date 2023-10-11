// Multiple  classes for each items: (reset, general items, etc)

 //class for reset packet------------------------------------------------------------------------

class alu_sequence_base extends uvm_sequence;        
  `uvm_object_utils(alu_sequence_base)
  
  alu_sequence_item reset_packet;
  
  
  function new(string name = "alu_sequence_base");                      //Base Constructor-------
    super.new(name);
    `uvm_info("Sequence_base","Inside sequence base constructor!", UVM_HIGH)
    
  endfunction:new
  
  task body();
    `uvm_info("Sequence_base","Inside sequence base body!", UVM_HIGH)
                                                                           //packet create-------
    reset_packet = alu_sequence_item::type_id::create ("reset_packet");
    start_item(reset_packet);
      reset_packet.randomize();    //optional to add-- with {reset==1}
    finish_item(reset_packet); 
  endtask:body
  
endclass:alu_sequence_base



 //class for test/item packet---------------------------------------------------------------------


class alu_sequence_test extends alu_sequence_base;               
  `uvm_object_utils(alu_sequence_test)
  
  alu_sequence_item item_packet;
  
  
  function new(string name = "alu_sequence_test");                    //Base Constructor-------
    super.new(name);
    `uvm_info("Sequence_test","Inside sequence test constructor!", UVM_HIGH)
    
  endfunction:new
  
  task body();
    `uvm_info("Sequence_test","Inside sequence test body!", UVM_HIGH)
                                                                          //packet create-------
    item_packet = alu_sequence_item::type_id::create ("item_packet");
    start_item(item_packet);
       item_packet.randomize();    //optional to add-- with {reset==0}
    finish_item(item_packet); 
  endtask:body
  
endclass:alu_sequence_test