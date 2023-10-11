class alu_sequence_item extends uvm_sequence_item;
  `uvm_object_utils(alu_sequence_item)
  
  rand logic in;                                                  //instantiation----------------
  logic out;              //outputs aren't randomly generated
  logic sign;
  logic carr;
  logic zero;
                          //Add input constraints(optional)
  
  
  //Constuctor------------------------------------------------------------------------------------

  function new(string name = "alu_sequence_item");             
    super.new(name);
    `uvm_info("Sequence_item_class", "At sequence_item constructor!", UVM_HIGH)
  endfunction:new
  
endclass: alu_sequence_item