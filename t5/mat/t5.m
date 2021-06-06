clear all

R1 = 1000
R2 = 1000
R3 = 1000
R4 = 150000
C1 = 220e-9
C2 = 110e-9

fid = fopen("initdata_tab.tex","w")
fprintf(fid, "$R_1$ & %f kOhm \\\\ \\hline \n", R1*0.001)
fprintf(fid, "$C_1$ & %f uFarad \\\\ \\hline \n", C1*1e6)
fprintf(fid, "$R_2$ & %f kOhm \\\\ \\hline \n", R2*0.001)
fprintf(fid, "$C_{21}$ & %f uFarad \\\\ \\hline \n", 2*C2*1e6)
fprintf(fid, "$C_{22}$ & %f uFarad \\\\ \\hline \n", 2*C2*1e6)
fprintf(fid, "$R_3$ & %f kOhm \\\\ \\hline \n", R3*0.001)
fprintf(fid, "$R_{4a}$ & %f kOhm \\\\ \\hline \n", 100)
fprintf(fid, "$R_{4b1}$ & %f kOhm \\\\ \\hline \n", 100)
fprintf(fid, "$R_{4b2}$ & %f kOhm \\\\ \\hline \n", 100)
fclose(fid)

f = logspace(1,8,70);
T = (R1*C1*2*pi*f*j)./(1+R1*C1*2*pi*f*j).*(1+R4/R3).*(1./(1+R2*C2*2*pi*f*j))
fig1 = figure();
semilogx(f,180*arg(T)/pi);
xlabel("log10(f) [Hz]");
ylabel("Phase [Degrees]");
title("Output Phase Difference (Frequency Response)");
print(fig1, "phase.eps", "-depsc");
fig2 = figure();
semilogx(f,20*log10(abs(T)));
xlabel("log10(f) [Hz]");
ylabel("Gain [dB]");
title("Output Gain (Frequency Response)");
print(fig2, "gain.eps", "-depsc");

wL = 1/(R1*C1)
wH = 1/(R2*C2)
wO = sqrt(wL*wH)

fid = fopen("frequency_tab.tex","w")
fprintf(fid, "Lower Cut-Off Frequency & %f Hz \\\\ \\hline \n", wL/(2*pi))
fprintf(fid, "Upper Cut-Off Frequency & %f Hz \\\\ \\hline \n", wH/(2*pi))
fprintf(fid, "Central Frequency & %f Hz \\\\ \\hline \n", wO/(2*pi))
fclose(fid)

AV_HP = abs((R1*C1*j*wO)/(1+R1*C1*j*wO))
AV_HPdb = 20*log10(AV_HP)
AV_Amp = (1+R4/R3)
AV_Ampdb = 20*log10(AV_Amp)
AV_LP = abs(1/(1+R2*C2*j*wO))
AV_LPdb = 20*log10(AV_LP)
AV = AV_HP*AV_Amp*AV_LP
AVdb = AV_HPdb + AV_Ampdb + AV_LPdb
z_in = R1 + 1/(j*wO*C1)
z_out = R2/(1+j*wO*R2*C2)

cost = 13323.29204 + (R1+R2+R3+(R4-50000)*3)*0.001 + (C1+(C2*2)*2)*1000000
merit = 1/(cost*(abs(AV-100)+abs((wO/(2*pi))-1000)+(1e-6)))

fid = fopen("theo_tab.tex","w")
fprintf(fid, "Gain & %f \\\\ \\hline \n", AV)
fprintf(fid, "Gain (dB) & %f dB \\\\ \\hline \n", AVdb)
fprintf(fid, "$Z_{in}$ & %f %fj Ohm \\\\ \\hline \n", real(z_in), imag(z_in))
fprintf(fid, "$Z_{in}$ modulus & %f Ohm \\\\ \\hline \n", abs(z_in))
fprintf(fid, "$Z_{in}$ phase & %f Degrees \\\\ \\hline \n", arg(z_in)*180/pi)
fprintf(fid, "$Z_{out}$ & %f %fj Ohm \\\\ \\hline \n", real(z_out), imag(z_out))
fprintf(fid, "$Z_{out}$ modulus & %f Ohm \\\\ \\hline \n", abs(z_out))
fprintf(fid, "$Z_{out}$ phase & %f Degrees \\\\ \\hline \n", arg(z_out)*180/pi)
fprintf(fid, "Cost & %fMU \\\\ \\hline \n", cost)
fprintf(fid, "Merit & %f$*10^{-6}$ \\\\ \\hline \n", merit*1000000)
fclose(fid)
