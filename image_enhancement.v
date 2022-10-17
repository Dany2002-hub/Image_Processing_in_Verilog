`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.08.2022 15:59:02
// Design Name: 
// Module Name: image_enhancement
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


module image_enhancement(inp_data, en, clk, out_data_enhanced,out_data_smothened,out_data_sharpened,en_out1, en_out2, en_out3,en_final_out1);
  input [7:0]inp_data;
  input clk;
  input en;
  output reg en_out1;
  output reg en_out2;
  output reg en_out3;
  output reg en_final_out1;
  output reg [7:0]out_data_enhanced;
  output reg [7:0]out_data_smothened;
  output reg [7:0]out_data_sharpened;
  reg [7:0]inp_matrix[128:1][128:1];
  reg [7:0]smothened_matrix[128:1][128:1];
  reg [7:0]sharpened_matrix[128:1][128:1];
  reg [7:0]out_matrix[128:1][128:1];
  reg [7:0]padded_inp_matrix[129:0][129:0];
  reg [7:0]padded_smothened_matrix[129:0][129:0];

  integer a,b,a1,b1;
  integer i,i1,i2,i3,i4;
  integer j,j1,j2,j3,j4;


  
  always @(posedge clk or en)
  begin
    if (en)
    begin
      a=2;
      b=1;
      i=0;
      j=0;
      i1=1;
      j1=1;
      i2=0;
      j2=0;
      a1=2;
      b1=1;
      i3=1;
      j3=1;
      i4=1;
      j4=1;
      en_out1=0;
      en_out2=0;
      en_out1=0;
      en_final_out1=0;
      inp_matrix[1][1]=inp_data;
      padded_inp_matrix[0][0] = 0;
      padded_smothened_matrix[0][0] = 0;
    end
    else begin
    
    if(a<129 & b<129) begin
      inp_matrix[a][b]=inp_data;
      a=a+1;
      if (a==129) begin
        a=1;
        b=b+1;
      end
    end
    if (i<130 & j<130) begin
        if (i==0 || i==129 || j==0 || j==129)begin
          padded_inp_matrix[i][j] = 0;
          padded_inp_matrix[0][j] = 0;
          padded_inp_matrix[i][129] = 0;
        end
        else begin
          padded_inp_matrix[i][j]=inp_matrix[i][j];
        end
        if (i==129)begin
          i=0;
          j=j+1;
        end
        i=i+1;
        if (j>=128) begin
          en_out1=1;
        end
    end
    end
    end
  always @(posedge clk) begin  
    if (en_out1)begin
      if(i1<129 & j1<129) begin
      smothened_matrix[i1][j1] = (padded_inp_matrix[i1][j1]+padded_inp_matrix[i1-1][j1-1]+padded_inp_matrix[i1-1][j1+1]+padded_inp_matrix[i1-1][j1]+padded_inp_matrix[i1][j1-1]+padded_inp_matrix[i1][j1+1]+padded_inp_matrix[i1+1][j1-1]+padded_inp_matrix[i1+1][j1]+padded_inp_matrix[i1+1][j1+1])/9;
      out_data_smothened=smothened_matrix[i1][j1];
      en_final_out1=1;
      i1=i1+1;
      if (i1==129) begin
        i1=1;
        j1=j1+1;
      end

    end
    if (i2<130 & j2<130) begin
        if (i2==0 || i2==129 || j2==0 || j2==129)begin
          padded_smothened_matrix[i2][j2] = 0;
          padded_smothened_matrix[0][j2] = 0;
          padded_smothened_matrix[i2][129] = 0;
        end
        else begin
          padded_smothened_matrix[i2][j2]=smothened_matrix[i2][j2];
        end
        if (i2==129)begin
          i2=0;
          j2=j2+1;
        end
        i2=i2+1;
    end
    if (j2>=128) begin
        en_out2=1;
      end
    end
   end  
    
    
  always @(posedge clk) begin  
    if (en_out2)begin
      if(i3<129 & j3<129) begin
      sharpened_matrix[i3][j3] = 4*padded_smothened_matrix[i3][j3] - padded_smothened_matrix[i3-1][j3]-padded_smothened_matrix[i3][j3-1]-padded_smothened_matrix[i3][j3+1]-padded_smothened_matrix[i3+1][j3];
      if (sharpened_matrix[i3][j3]>50)begin
        sharpened_matrix[i3][j3]=0;
      end
      out_data_sharpened = sharpened_matrix[i3][j3];
      i3=i3+1;
      if (i3==129) begin
        i3=1;
        j3=j3+1;
      end
      if (j3>=128) begin
        en_out3=1;
      end
    end

    end
    
    end   
    
  always @(posedge clk) begin  
    if (en_out3)begin
      if(i4<129 & j4<129) begin
      out_matrix[i4][j4] = inp_matrix[i4][j4]+sharpened_matrix[i4][j4];
       if (out_matrix[i4][j4]<0)begin
         out_matrix[i4][j4]=0;
       end
       else if(out_matrix[i4][j4]>255)begin
         out_matrix[i4][j4]=255;
       end
       out_data_enhanced = out_matrix[i4][j4];
      i4=i4+1;
      if (i4==129) begin
        i4=1;
        j4=j4+1;
      end
    end

    end
    
    end
    
    
endmodule
