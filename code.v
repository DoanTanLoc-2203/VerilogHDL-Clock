module final(Qh1,Qh0,Qpm,RCO,RCO1,RCO2,RCO3,RCO4,Qm1,Qm0,Qs1,Qs0,CLK,CLKout,QCLK,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7);
input CLK;
output Qh1,Qpm,RCO,RCO1,RCO2,RCO3,RCO4,CLKout;
output [3:0]Qh0,Qm1,Qm0,Qs1,Qs0;
output [15:0]QCLK;
output [6:0]HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7;

CLOCKDOWN A(CLK,CLKout,Q);
IC74160 SECOND0(0,0,0,0,CLKout,1,1,1,1,RCO,Qs0);
IC74160 SECOND1(0,0,0,0,CLKout,~(Qs1[2]&Qs1[1]),1,Qs0[3]&Qs0[0],1,RCO1,Qs1);

IC74160 MINUTE0(0,0,0,0,(Qs1[2]&Qs1[1]&~(Qs1[0])),1,1,1,1,RCO2,Qm0);
IC74160 MINUTE1(0,0,0,0,(Qs1[2]&Qs1[1]&~(Qs1[0])),~(Qm1[2]&Qm1[1]),1,Qm0[3]&Qm0[0],1,RCO3,Qm1);

HAMPM HOURS((Qm1[2]&Qm1[1]&~(Qm1[0])),RCO4,Qh0,Qh1,Qpm); 

BCDtoLED7 S0(Qs0,HEX2);
BCDtoLED7NEW S1(Qs1,HEX3);
BCDtoLED7 M0(Qm0,HEX4);
BCDtoLED7NEW M1(Qm1,HEX5);
BCDtoLED7 H0(Qh0,HEX6);
TWOBITtoLED7 H1(Qh1,HEX7);

assign HEX0=7'b1111111;
assign HEX1=7'b1111111;

endmodule

module TWOBITtoLED7(Q,LED);
input Q;
output [6:0]LED;
reg [6:0]LED;

always@(Q)
begin
if(Q==1'b0)
LED=7'b0000001;
else if(Q==1'b1)
LED=7'b1001111;
end

endmodule

module BCDtoLED7NEW(Q,HEX0);
input [3:0]Q;
output [6:0]HEX0;
reg [6:0]HEX0;

always@(Q)
begin
if(Q==4'b0000)//0
HEX0=7'b0000001;
else if(Q==4'b0001)//1
HEX0=7'b1001111;
else if(Q==4'b0010)//2
HEX0=7'b0010010;
else if(Q==4'b0011)//3
HEX0=7'b0000110;
else if(Q==4'b0100)//4
HEX0=7'b1001100;
else if(Q==4'b0101)//5
HEX0=7'b0100100;
else if(Q==4'b0110)//6
HEX0=7'b0000001;
end

endmodule

module BCDtoLED7(Q,HEX0);
input [3:0]Q;
output [6:0]HEX0;
reg [6:0]HEX0;

always@(Q)
begin
if(Q==4'b0000)//0
HEX0=7'b0000001;
else if(Q==4'b0001)//1
HEX0=7'b1001111;
else if(Q==4'b0010)//2
HEX0=7'b0010010;
else if(Q==4'b0011)//3
HEX0=7'b0000110;
else if(Q==4'b0100)//4
HEX0=7'b1001100;
else if(Q==4'b0101)//5
HEX0=7'b0100100;
else if(Q==4'b0110)//6
HEX0=7'b0100000;
else if(Q==4'b0111)//7
HEX0=7'b0001111;
else if(Q==4'b1000)//8
HEX0=7'b0000000;
else if(Q==4'b1001)//9
HEX0=7'b0000100;
end
endmodule

module CLOCKDOWN(clkin,clkout,Q);
input clkin;
output clkout;
wire clkout;
output [15:0]Q;

jk_ff A0(1,1,clkin,Q[0],1);
jk_ff A1(1,1,Q[0],Q[1],1);
jk_ff A2(1,1,Q[1],Q[2],1);
jk_ff A3(1,1,Q[2],Q[3],1);
jk_ff A4(1,1,Q[3],Q[4],1);
jk_ff A5(1,1,Q[4],Q[5],1);
jk_ff A6(1,1,Q[5],Q[6],1);
jk_ff A7(1,1,Q[6],Q[7],1);
jk_ff A8(1,1,Q[7],Q[8],1);
jk_ff A9(1,1,Q[8],Q[9],1);
jk_ff A10(1,1,Q[9],Q[10],1);
jk_ff A11(1,1,Q[10],Q[11],1);
jk_ff A12(1,1,Q[11],Q[12],1);
jk_ff A13(1,1,Q[12],Q[13],1);
jk_ff A14(1,1,Q[13],Q[14],1);
jk_ff A15(1,1,Q[14],Q[15],1);
//jk_ff A16(1,1,Q[15],Q[16],1);
//jk_ff A17(1,1,Q[16],Q[17],1);
//jk_ff A18(1,1,Q[17],Q[18],1);
//jk_ff A19(1,1,Q[18],Q[19],1);
//jk_ff A20(1,1,Q[19],Q[20],1);
//jk_ff A21(1,1,Q[20],Q[21],1);
//jk_ff A22(1,1,Q[21],Q[22],1);
//assign clkout=~(Q[22]&Q[21]&Q[20]&Q[19]&Q[18]&Q[17]&Q[16]&Q[15]&Q[14]&Q[13]&Q[12]&Q[11]&Q[10]&Q[9]&Q[8]&Q[7]&Q[6]&Q[5]&Q[4]&Q[3]&Q[2]&Q[1]&Q[0]);
assign clkout=~(Q[15]);
endmodule

module HAMPM(CLK,RCO,Q,Qh,Qpm);
input CLK;
output RCO,Qh,Qpm;
output [3:0]Q;
wire A,B,C,D;

assign A=1&Qh;
assign B=A&Q[1];
assign C=~B;
assign D=Q[0]&A;
IC74160 COUTER_MOD10(1,0,0,0,CLK,C,1,1,1,RCO,Q);
jk_ff H1(RCO,B,CLK,Qh,1);
jk_ff AMPM(D,D,CLK,Qpm,1);

endmodule

module IC74160(A,B,C,D,CLK,LOAD,CLR,ENP,ENT,RCO,Q);
input A,B,C,D,CLK,LOAD,CLR,ENP,ENT;
output RCO;
output [3:0]Q;
wire ENPENT,LOADb,CLRb,CLKb,EEQb,EEQc,EEQd1,EEQd2,EEQd,RCO;

assign LOADb=~LOAD;
assign CLRb=CLR;
assign ENPENT=ENP&ENT;
newjk_ff QA(LOADb,A,ENPENT,CLK,CLRb,Q[0]);
assign EEQb=ENPENT&Q[0]&(~Q[3]);
newjk_ff QB(LOADb,B,EEQb,CLK,CLRb,Q[1]);
assign EEQc=ENPENT&Q[0]&Q[1];
newjk_ff QC(LOADb,C,EEQc,CLK,CLRb,Q[2]);
assign EEQd1=Q[0]&Q[1]&Q[2]&ENPENT;
assign EEQd2=Q[0]&ENPENT&Q[3];
assign EEQd=EEQd1|EEQd2;
newjk_ff QD(LOADb,D,EEQd,CLK,CLRb,Q[3]);
assign RCO=ENT&Q[0]&Q[3];

endmodule

module newjk_ff(LOAD,DATA,E,CLK,CLR,Q);
input LOAD,DATA,E,CLK,CLR;
output Q;
wire a,b,c,out1,out2;
 
assign a=~(DATA & LOAD);
assign b=~(LOAD & a);
assign c=LOAD|E;
assign out1=b&c;
assign out2=a&c;
jk_ff A(out1,out2,CLK,Q,CLR);

endmodule

module jk_ff(j,k,clk,q,clr);
input j,k,clr,clk;
output q;
reg q;
always@(posedge clk or negedge clr)
begin
if(clr==0)
q=1'b0;
else if(j==0&&k==0)
q=q;
else if(j==0&&k==1)
q=1'b0;
else if(j==1&&k==0)
q=1'b1;
else if(j==1&&k==1)
q=!q;
end
endmodule 