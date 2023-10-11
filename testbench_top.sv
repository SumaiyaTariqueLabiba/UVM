// Code your testbench here

`timescale 1ns/1ns

import uvm_pkg::*;
`include "uvm_macros.svh"

 `include "interface.sv"            //include files--------------           
 `include "sequence_item.sv"    //maintain serial (diagram)                           
 `include "sequence.sv"
 `include "sequencer.sv"
 `include "driver.sv"
 `include "monitor.sv"
 `include "agent.sv"
 `include "scoreboard.sv"
 `include "env.sv"
 `include "test.sv"


module top();
  
  logic clk;                       //instantiation--------------
  
  alu_interface intf(.clk(clk));   //connecting with interface----------
  
  ALU_design DUT(
      .clk(intf.clk),

      .in(intf.in),        //design var(interface var)
      .out(intf.out),
      .sign(intf.sign),
      .carr(intf.carr),
      .zero(intf.zero)
      );                                  
  
                                            //virtual interface set------
    initial begin                                     
      uvm_config_db #(virtual alu_interface)::set(null, "*", "vif", intf);          
    end 
  
  
  
  initial begin                 //start test
    run_test();
  end
  
  
  
  initial begin                   //clk generation (optional)----------
    clk=0;
    forever #5 clk=~clk;
  end
  
  
  initial begin                 //End simulation-------------- 
    #3000 
    $display("sumulation runtime has ended!!");
    $finish;
  end
  
  initial begin                 //For EDA (optional)--------------
    $dumpfile("alu_uvm.vcd");
    $dumpvars;
  end
  
endmodule: top


