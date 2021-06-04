%gain stage

VT=25e-3
BFN=178.7
VAFN=69.7
VBEON=0.7
BFP = 227.3
VAFP = 37.2
VEBON = 0.7
RS=100
VCC=12
RB1=80000
RB2=20000
RE1=200
RC1=900
RE2 = 50
C_i=0.0001
C_b=0.0025
C_o=0.0015

fid = fopen("initialdata_tab.tex","w")
fprintf(fid, "VT& %f V \\\\ \\hline \n", VT)
fprintf(fid, "BFN& %f \\\\ \\hline \n", BFN)
fprintf(fid, "VAFN& %f V \\\\ \\hline \n", VAFN)
fprintf(fid, "VBEON& %f V \\\\ \\hline \n", VBEON)
fprintf(fid, "BFP& %f \\\\ \\hline \n", BFP)
fprintf(fid, "VAFP& %f V \\\\ \\hline \n", VAFP)
fprintf(fid, "VEBON& %f V \\\\ \\hline \n", VEBON)
fprintf(fid, "VCC& %f V \\\\ \\hline \n", VCC)
fprintf(fid, "RB1& %f kOhm \\\\ \\hline \n", RB1/1000)
fprintf(fid, "RB2& %f kOhm \\\\ \\hline \n", RB2/1000)
fprintf(fid, "RE1& %f Ohm \\\\ \\hline \n", RE1)
fprintf(fid, "RC1& %f Ohm \\\\ \\hline \n", RC1)
fprintf(fid, "RE2& %f Ohm \\\\ \\hline \n", RE2)
fprintf(fid, "$C_{input}$& %f mF \\\\ \\hline \n", C_i*1000)
fprintf(fid, "$C_{bypass}$& %f mF \\\\ \\hline \n", C_b*1000)
fprintf(fid, "$C_{output}$& %f mF \\\\ \\hline \n", C_o*1000)
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

fid = fopen("th_data_tab.tex","w")
fprintf(fid, "RB& %f Ohm \\\\ \\hline \n", RB)
fprintf(fid, "VEQ&%f V \\\\ \\hline \n", VEQ)
fprintf(fid, "IB1&%f A \\\\ \\hline \n", IB1)
fprintf(fid, "IC1&%f A \\\\ \\hline \n", IC1)
fprintf(fid, "IE1&%f A \\\\ \\hline \n", IE1)
fprintf(fid, "VE1&%f V \\\\ \\hline \n", VE1)
fprintf(fid, "VO1&%f V \\\\ \\hline \n", VO1)
fprintf(fid, "VCE&%f V \\\\ \\hline \n", VCE)
fprintf(fid, "$V_{in}$&0 V \\\\ \\hline \n")
fprintf(fid, "$V_{in2}$&0 V \\\\ \\hline \n")
fprintf(fid, "$V_{vcc}$&12 V \\\\ \\hline \n")
fprintf(fid, "$V_{base}$&%f V \\\\ \\hline \n",VE1+VBEON)
fprintf(fid, "$V_{coll}$&%f V \\\\ \\hline \n", VO1)
fprintf(fid, "$V_{emit}$&%f V \\\\ \\hline \n", VE1)
fclose(fid)

%Incremental

gm1=IC1/VT
rpi1=BFN/gm1
ro1=VAFN/IC1

ZI1 = 1/((1/RB)+(1/rpi1))
ZO1 = 1/((1/RC1)+(1/ro1))
AV1 = - gm1*ZO1*(ZI1/(ZI1+RS))
AV1dB = 20*log10(abs(AV1))

fid = fopen("gain_tab.tex","w")
fprintf(fid, "gm& %f S \\\\ \\hline \n", gm1)
fprintf(fid, "rpi&%f Ohm \\\\ \\hline \n", rpi1)
fprintf(fid, "ro&%f Ohm\\\\ \\hline \n", ro1)
fprintf(fid, "Input impedance&%f Ohm \\\\ \\hline \n", ZI1)
fprintf(fid, "Output impedance&%f Ohm \\\\ \\hline \n", ZO1)
fprintf(fid, "Gain&%f \\\\ \\hline \n", AV1)
fprintf(fid, "Gain(dB)&%f dB \\\\ \\hline \n", AV1dB)
fclose(fid)

%output stage

%Operating point

VI2 = VO1
IE2 = (VCC-VEBON-VI2)/RE2
IC2 = BFP/(BFP+1)*IE2
IB2 = IE2-IC2
VO2 = VCC - RE2*IE2

fid = fopen("outoper_tab.tex","w")
fprintf(fid, "IB2&%f A \\\\ \\hline \n", IB2)
fprintf(fid, "IC2&%f A \\\\ \\hline \n", IC2)
fprintf(fid, "IE2&%f A \\\\ \\hline \n", IE2)
fprintf(fid, "VO2&%f V \\\\ \\hline \n", VO2)
fprintf(fid, "$V_{vcc}$&12 V \\\\ \\hline \n")
fprintf(fid, "$V_{coll}$&%f V \\\\ \\hline \n",VO1)
fprintf(fid, "$V_{emit2}$&%f V \\\\ \\hline \n", VO2)
fprintf(fid, "$V_{out}$&0 V \\\\ \\hline \n")
fclose(fid)

%Incremental

gm2 = IC2/VT
go2 = IC2/VAFP
gpi2 = gm2/BFP
ge2 = 1/RE2

AV2 = (gm2+gpi2)/(gm2+gpi2+go2+ge2)
AV2dB = 20*log10(AV2)
ZI2=(1/gpi2)/(1-AV2)
ZO2 = 1/(gm2+gpi2+go2+ge2)

fid = fopen("output_tab.tex","w")
fprintf(fid, "gm2& %f S \\\\ \\hline \n", gm2)
fprintf(fid, "rpi2&%f Ohm \\\\ \\hline \n", 1/gpi2)
fprintf(fid, "ro2&%f Ohm \\\\ \\hline \n", 1/go2)
fprintf(fid, "Input impedance&%f Ohm \\\\ \\hline \n", ZI2)
fprintf(fid, "Output impedance&%f Ohm \\\\ \\hline \n", ZO2)
fprintf(fid, "Gain&%f \\\\ \\hline \n", AV2)
fprintf(fid, "Gain(dB)&%f dB \\\\ \\hline \n", AV2dB)
fclose(fid)

%Circuito geral

rpi2=1/gpi2

ZI=ZI1
ZO = 1/(go2+(gm2*(rpi2/(rpi2+ZO1)))+ge2+(1/(rpi2+ZO1)))

prep1=1/(rpi2+ZO1)
prep2=(gm2*rpi2)/(rpi2+ZO1)
AV=(prep1+prep2)/(prep1+ge2+go2+prep2)*AV1
AVdB=20*log10(abs(AV))

fid = fopen("circuit_tab.tex","w")
fprintf(fid, "Input impedance&%f Ohm \\\\ \\hline \n", ZI)
fprintf(fid, "Output impedance&%f Ohm \\\\ \\hline \n", ZO)
fprintf(fid, "Gain&%f \\\\ \\hline \n", AV)
fprintf(fid, "Gain(dB)&%f dB \\\\ \\hline \n", AVdB)
fclose(fid)

%frequency response

f=logspace(1,8,70)

gpi1=1/rpi1 
go1=1/ro1
gRC=1/RC1
gR_out=1/RE2
gE1 = 1/RE1
R_L=8

T=1:length(f)

for i=1:length(f)

C=[0, 0, -gpi2-gm2, gR_out+gpi2+gm2+go2+j*2*pi*f(i)*C_o, -j*2*pi*f(i)*C_o, 0 ; gm1, -gm1, go1+gRC+gpi2, -go1-gpi2, 0, 0 ; -gpi1-gm1, gE1+gpi1+gm1+go1+j*2*pi*f(i)*C_b, -go1, 0, 0, 0 ; j*2*pi*f(i)*C_i+gpi1, -gpi1, 0, 0, 0, -j*2*pi*f(i)*C_i ; -j*2*pi*f(i)*C_i, 0, 0, 0, 0, (1/RS)+j*2*pi*f(i)*C_i ; 0, 0, 0, -j*2*pi*f(i)*C_o, j*2*pi*f(i)*C_o+(1/R_L), 0]
D=[0 ; 0 ; 0 ; 0 ; 0.01/RS; 0]

R=C\D

T(i)=R(5)/R(6)

endfor

T_M=20*log10(abs(T))
Tp=angle(T)*180/pi

Gain=max(abs(T))
GaindB=max(T_M)
yi=max(T_M)-3
xi=interp1(T_M,f,yi)

figure
plot(log10(f),T_M)
title("Load voltage gain (frequency response)")
xlabel("log10(f) [Hz]")
xlim([1 8])
ylabel("Gain [dB]")
ylim([0 50])
print("Gain.eps", "-depsc")

figure
plot(log10(f),Tp)
title("Load voltage phase difference (frequency response)")
xlabel("log10(f) [Hz]")
xlim([1 8])
ylabel("Phase [Degrees]")
print("Phase.eps", "-depsc")

fid = fopen("frequency_tab.tex","w")
fprintf(fid, "Gain&%f \\\\ \\hline \n", Gain)
fprintf(fid, "Gain(dB)&%f dB \\\\ \\hline \n", GaindB)
fprintf(fid, "Lower cut-off frequency&%f Hz \\\\ \\hline \n", xi)
fclose(fid)
