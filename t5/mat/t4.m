clear all

R1 = 1000
R2 = 1000
R3 = 100000
R4 = 1000
C1 = 220e-9
C2 = 110e-9

fid = fopen("initdata_tab.tex","w")
fprintf(fid, "$R_1$ & %fOhm \\\\ \\hline \n", R1)
fprintf(fid, "$R_2$ & %fOhm \\\\ \\hline \n", R2)
fprintf(fid, "$R_3$ & %fOhm \\\\ \\hline \n", R3)
fprintf(fid, "$R_4$ & %fOhm \\\\ \\hline \n", R4)
fprintf(fid, "$C_1$ & %fFarad \\\\ \\hline \n", C1)
fprintf(fid, "$C_2$ & %fFarad \\\\ \\hline \n", C2)
fclose(fid)

f = logspace(1,8,70);
T = (R1*C1*2*pi*f*j)./(1+R1*C1*2*pi*f*j).*(1+R3/R4).*(1./(1+R2*C2*2*pi*f*j))
fig1 = figure();
semilogx(f,180*arg(T)/pi);
xlabel("Frequency [Hz]");
ylabel("Phase [Deg]");
title("Phase Frequency Response");
print(fig1, "phaseresponse.eps", "-depsc");
fig2 = figure();
semilogx(f,20*log10(abs(T)));
xlabel("Frequency [Hz]");
ylabel("Gain [dB]");
title("Gain Frequency Response");
print(fig2, "gainresponse.eps", "-depsc");


wL = 1/(R1*C1)
wH = 1/(R2*C2)
wO = sqrt(wL*wH)

fid = fopen("frequency_tab.tex","w")
fprintf(fid, "$f_L$ & %f Hz \\\\ \\hline \n", wL/(2*pi))
fprintf(fid, "$f_H$ & %f Hz \\\\ \\hline \n", wH/(2*pi))
fprintf(fid, "$f_O$ & %f Hz \\\\ \\hline \n", wO/(2*pi))
fclose(fid)

AV_HP = (R1*C1*j*wO)/(1+R1*C1*j*wO)
AV_HP = 20*log10(abs(AV_HP))
AV_Amp = (1+R3/R4)
AV_Amp = 20*log10(abs(AV_Amp))
AV_LP = 1/(1+R2*C2*j*wO)
AV_LP = 20*log10(abs(AV_LP))
AV= AV_HP + AV_Amp + AV_LP
z_in = R1 + 1/(j*wO*C1)
z_out = R2/(j*wO*C2)/(R2+1/(j*wO*C2))

costOPAmp=22*0.1+158125/1000+30*10^-6
cost=(R1+R2+R3+R4)/1000+(C1+C2)+costOPAmp
merit=1/(cost*abs(AV-40)*abs(wO-1000))

fid = fopen("theo_tab.tex","w")
fprintf(fid, "$AV_{HP}$ & %f dB \\\\ \\hline \n", AV_HP)
fprintf(fid, "$AV_{Amp}$& %f dB \\\\ \\hline \n", AV_Amp)
fprintf(fid, "$AV_{LP}$ & %f dB \\\\ \\hline \n", AV_LP)
fprintf(fid, "$AV$ & %f dB \\\\ \\hline \n", AV)
fprintf(fid, "$Z_{in}$ & %f Ohm \\\\ \\hline \n", z_in)
fprintf(fid, "$Z_{out}$ & %f Ohm \\\\ \\hline \n", z_out)
fprintf(fid, "Merit & %f\\\\ \\hline \n", merit)
fclose(fid)
