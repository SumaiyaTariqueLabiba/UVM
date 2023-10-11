class alu_scoreboard extends uvm_test;              //extends from uvm_test?
  `uvm_component_utils(alu_scoreboard)

  uvm_analysis_imp #(alu_sequence_item, alu_scoreboard) scoreboard_port;
  alu_sequence_item transaction[$];
  
  
  //Constuctor-------------------------------------------------------------------------------------

  function new(string name = "alu_scb", uvm_component parent);       
    super.new(name,parent);
    `uvm_info("Scb_class","Inside scb contructor!", UVM_HIGH)
    
  endfunction:new
  
  
 
 //Build Phase-------------------------------------------------------------------------------------

  function void build_phase(uvm_phase phase);                        
    super.build_phase(phase);
    `uvm_info("Scb_class","Inside scb build phase!", UVM_HIGH)
    
    scoreboard_port = new("scoreboard_port",this);
        
  endfunction:build_phase
  
  
  
 //Connect Phase-----------------------------------------------------------------------------------

  function void connect_phase(uvm_phase phase);                    
    super.connect_phase(phase);
    `uvm_info("Scb_class","Inside scb connect phase!", UVM_HIGH)
  endfunction:connect_phase
  
  
  
  
  function void write(alu_sequence_item item);              //Write method-------
    transaction.push_back(item);       //push items into transaction
  endfunction:write
  
  
 
  //Run Phase-----------------------------------------------------------------------------------------

  task run_phase(uvm_phase phase);                                
    super.run_phase(phase);
    `uvm_info("Scb_class","Inside scb run phase!", UVM_HIGH)
    
    forever begin
      alu_sequence_item current_trans;
      current_trans = transaction.pop_front();      //pops out of transaction, call them current_trans
      compare(current_trans);
    end
  endtask: run_phase
  
  
  
  
  task compare(alu_sequence_item current_trans);
    logic [3:0] expected;
    logic [3:0] actual;
    logic [11:0] in_temp = current_trans.in;  //in_temp as (current_trans.in) array cannot be sliced
    logic A = in_temp[3:0];
    logic B = in_temp[7:4];
    
    logic [3:0] A_temp = A;   //A, B cannot be sliced [1:0] directly
    logic [3:0] B_temp = B;
    
    logic [4:0] y;
    

    if (y[4:0] == 0) current_trans.zero = 1;
    else current_trans.zero = 0;
    
    case(in_temp[11:8])
      4'b1101:
         begin
           y = A + B;
           if(y > 4'b1111) current_trans.carr = 1;
         end  
      4'b1001:y = A & B;
      4'b0101:y = A_temp[1:0] * B_temp[1:0];
      4'b0001:y = ~ A;
      4'b1100:y = ~(A & B);
      4'b0010:
         begin
           if(B > A) begin
               y = B - A; 
               current_trans.sign = 1;
               end
            else y = A - B;
         end
      4'b0011:y = ~(A ^ B);
      4'b0110:y = ~(A | B);
      default y = 0; 
    endcase
      
    expected = y[3:0];             //calc output - expected  
    actual = current_trans.out;    //outputs - actual

    if(actual != expected) begin   //check
      `uvm_error("Compare", $sformatf("Error! Actual %d != Expected %d", actual,expected))
    end
    else begin      //optional
      `uvm_info("Compare", $sformatf("Transaction successful! Actual %d, Expected %d", actual, expected), UVM_LOW)
    end
    
  endtask:compare
  
  
endclass:alu_scoreboard