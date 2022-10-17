`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.08.2022 15:59:32
// Design Name: 
// Module Name: image_enhancement_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module image_enhancement_tb();
  reg clk;
  reg en;
  reg [7:0]inp_data;
  wire [7:0]out_data_enhanced;
  wire [7:0]out_data_smothened;
  wire [7:0]out_data_sharpened;
  wire en_out1;
  wire en_out2;
  wire en_out3;
  integer outfile0;
  integer outfile1;
  integer outfile2;
  integer outfile3;
  integer i,j;
  image_enhancement i0(inp_data, en, clk, out_data_enhanced,out_data_smothened,out_data_sharpened, en_out1, en_out2, en_out3);
  initial begin
    i=0;
    clk=1;

    outfile0 = $fopen("C:/Users/vraje/OneDrive/Desktop/VLSI Labs/Q1_Lab1/images_initial.txt","r");
//    outfile1=$fopen("C:/Users/vraje/OneDrive/Desktop/VLSI Labs/Que1/images_smothened.txt","w");
//    outfile2=$fopen("C:/Users/vraje/OneDrive/Desktop/VLSI Labs/Que1/images_sharpened.txt","w");
//    outfile3=$fopen("C:/Users/vraje/OneDrive/Desktop/VLSI Labs/Que1/images_enhanced.txt","w");

    while (! $feof(outfile0)) begin
      $fscanf(outfile0,"%d\n",inp_data);

      if (i==0)
        en=1;
      else
        en=0;
      i = i+1;
      #2;
    end

    $fclose(outfile0);
    #1;
    i=0;
    outfile1=$fopen("C:/Users/vraje/OneDrive/Desktop/VLSI Labs/Q1_Lab1/images_smothened.txt","w");
    while(!en_out1)begin
    #1;
    end
    while(i!=16384)begin
      $fwrite(outfile1, "%d\n", out_data_smothened);
      #2;
      i=i+1;
      end
    
    $fclose(outfile1);
    
    #1;
    i=0;
    outfile2=$fopen("C:/Users/vraje/OneDrive/Desktop/VLSI Labs/Q1_Lab1/images_sharpened.txt","w");
    while(!en_out2)begin
      #1;
    end
    while(i!=16384)begin
      $fwrite(outfile2, "%d\n", out_data_sharpened);
      #2;
      i=i+1;
      end
    
    $fclose(outfile2);
    
    #1;
    i=0;
    outfile3=$fopen("C:/Users/vraje/OneDrive/Desktop/VLSI Labs/Q1_Lab1/images_enhanced.txt","w");
    while(!en_out3)begin
      #1;
    end
    while(i!=16384)begin
      $fwrite(outfile3, "%d\n", out_data_enhanced);
      #2;
      i=i+1;
      end
    
    $fclose(outfile3);

  end
  
  

  always
    #1 clk=~clk;

endmodule


//      if(en_out2) begin
//      $fwrite(outfile1,"%d\n",out_data_smothened); 
//      end
//      $fdisplay(outfile2,"%d\n",out_data_sharpened); 
//      $fdisplay(outfile3,"%d\n",out_data_enhanced);
//  initial begin
    
//    outfile1=$fopen("C:/Users/vraje/OneDrive/Desktop/VLSI Labs/Que1/images_smothened.txt","w");
//    if (en_out1)begin
//    j=0;
//    while (j<16384) begin
//      $fwrite(outfile1,"%d\n",out_data_smothened);
//      j=j+1;
//    end
//    $fclose(outfile1);
//    end
//  end
  