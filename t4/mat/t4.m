%gain stage

VT=25e-3
BFN=178.7
VAFN=69.7
RE1=200
RC1=950
RB1=80000
RB2=20000
VBEON=0.7
VCC=12
RS=100

fid = fopen("initialdata_tab.tex","w")
fprintf(fid, "VT & %f \\\\ \\hline \n", VT)
fprintf(fid, "BFN& %f \\\\ \\hline \n", BFN)
fprintf(fid, "VAFN& %f \\\\ \\hline \n", VAFN)
fprintf(fid, "RE1& %f \\\\ \\hline \n", RE1)
fprintf(fid, "RC1& %f \\\\ \\hline \n", RC1)
fprintf(fid, "RB1& %f \\\\ \\hline \n", RB1)
fprintf(fid, "RB2& %f \\\\ \\hline \n", RB2)
fprintf(fid, "VBEON& %f \\\\ \\hline \n", VBEON)
fprintf(fid, "VCC& %f \\\\ \\hline \n", VCC)
fprintf(fid, "RS& %f \\\\ \\hline \n", RS)
fclose(fid)

%Operating point

RB=1/(1/RB1+1/RB2)
VEQ=RB2/(RB1+RB2)*VCC
IB1=(VEQ-VBEON)/(RB+(1+BFN)*RE1)
IC1=BFN*IB1
IE1=(1+BFN)*IB1
VE1=RE1*IE1
VO1=VCC-RC1*IC1
VCE=VO1-VE1

fid = fopen("data_tab.tex","w")
fprintf(fid, "RB%f \\\\ \\hline \n", RB)
fprintf(fid, "VEQ%f \\\\ \\hline \n", VEQ)
fprintf(fid, "IB1%f \\\\ \\hline \n", IB1)
fprintf(fid, "IC1%f \\\\ \\hline \n", IC1)
fprintf(fid, "IE1%f \\\\ \\hline \n", IE1)
fprintf(fid, "VE1%f \\\\ \\hline \n", VE1)
fprintf(fid, "VO1%f \\\\ \\hline \n", VO1)
fprintf(fid, "VCE%f \\\\ \\hline \n", VCE)
fclose(fid)

%Incremental

gm1=IC1/VT
rpi1=BFN/gm1
ro1=VAFN/IC1

ZI1 = 1/((1/RB)+(1/rpi1))
ZO1 = 1/((1/RC1)+(1/ro1))
AV1 = - gm1*ZO1*(ZI1/(ZI1+RS))
AV1dB = 20*log10(abs(AV1))


%output stage

%Operating point

BFP = 227.3
VAFP = 37.2
RE2 = 50
VEBON = 0.7
VI2 = VO1
IE2 = (VCC-VEBON-VI2)/RE2
IC2 = BFP/(BFP+1)*IE2
VO2 = VCC - RE2*IE2

%Incremental

gm2 = IC2/VT
go2 = IC2/VAFP
gpi2 = gm2/BFP
ge2 = 1/RE2

AV2 = (gm2+gpi2)/(gm2+gpi2+go2+ge2)
AV2dB = 20*log10(AV2)
ZI2=(1/gpi2)/(1-AV2)
ZO2 = 1/(gm2+gpi2+go2+ge2)


%Circuito geral

rpi2=1/gpi2

ZI=ZI1
ZO = 1/(go2+(gm2*(rpi2/(rpi2+ZO1)))+ge2+(1/(rpi2+ZO1)))

prep1=1/(rpi2+ZO1)
prep2=(gm2*rpi2)/(rpi2+ZO1)
AV=(prep1+prep2)/(prep1+ge2+go2+prep2)*AV1
AVdB=20*log10(abs(AV))

%frequency response

