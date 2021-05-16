%gain stage

VT=25e-3
BFN=178.7
VAFN=69.7
RE1=100
RC1=1000
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

gm1=IC1/VT
rpi1=BFN/gm1
ro1=VAFN/IC1

AV1 = RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)

AV1simple = gm1*RC1/(1+gm1*RE1)

RE1=0
AV1 = RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)
AV1simple = gm1*RC1/(1+gm1*RE1)

RE1=100

ZI1 = ((ro1+RC1+RE1)*(RB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)/(ro1+RC1+RE1)

ZX = ro1*((RB+rpi1)*RE1/(RB+rpi1+RE1))/(1/(1/ro1+1/(rpi1+RB)+1/RE1+gm1*rpi1/(rpi1+RB)))

ZO1 = 1/(1/ZX+1/RC1)



%output stage
BFP = 227.3
VAFP = 37.2
RE2 = 100
VEBON = 0.7
VI2 = VO1
IE2 = (VCC-VEBON-VI2)/RE2
IC2 = BFP/(BFP+1)*IE2
VO2 = VCC - RE2*IE2


gm2 = IC2/VT
go2 = IC2/VAFP
gpi2 = gm2/BFP
ge2 = 1/RE2

AV2 = gm2/(gm2+gpi2+go2+ge2)



ZI2 = (gm2+gpi2+go2+ge2)/gpi2/(gpi2+go2+ge2)

ZO2 = 1/(gm2+gpi2+go2+ge2)
