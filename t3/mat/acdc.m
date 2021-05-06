close all 
clear all

pkg load symbolic

format long

% DATA

R=9e5
C=9e-4
f=50
A=230
N_coils=9.107
w=2*pi*f
T=1/f
n=8000
N_P=10
VON=0.6

fid = fopen("initialdata_tab.tex","w")
fprintf(fid, "R & %f Ohm \\\\ \\hline \n", R)
fprintf(fid, "C & %f Farad \\\\ \\hline \n", C)
fprintf(fid, "Number of Coils & %f \\\\ \\hline \n", N_coils)
fprintf(fid, " & %f \\\\ \\hline \n", merit)
fclose(fid)

% TIME VECTOR

t=linspace(3.8,T*N_P+3.8,n);

% Transformer

Amp=A/N_coils

Vs=Amp*cos(w*t);
Vo = zeros(1, length(t));

% FULL WAVE RECTIFIER

for i=1:length(t) 
     Vo(i)=abs(Vs(i));
end

% ***** ENVELOPE DETECTOR *****

toff=(1/w)*atan(1/(w*R*C))+3.8

for i=1:length(t)
  
  if t(i)<=toff
    
  elseif Amp*abs(cos(w*toff))*exp(-(t(i)-toff)/(R*C))>Vo(i)
     Vo(i) = Amp*abs(cos(w*toff))*exp(-(t(i)-toff)/(R*C));
  else
     toff = toff + (T/2);
  endif
  
endfor

% OBS: the decay function takes abs() since we're using values that make the cos goes negative

% *** Plot Saw-Tooth ***
figure
plot(t*1000, Vo , "r")
title("Envelope detector output voltage")
xlabel ("t[ms]")
ylabel ("Venv[V]")
legend ('V_e(t)','Location','Northeast')
print ("Venv.eps", "-depsc")

% ***** Voltage Regulator *****

N_D=20
r_D=0.026/((1e-14)*exp(VON/0.026))
R2=1e5

V_DC = mean(Vo);
V_AC=Vo-V_DC;

V_AC_final=((N_D*r_D)/(N_D*r_D+R2))*V_AC;
V_final=V_AC_final+(N_D*VON);
V_level = N_D*VON;
V_ripple=max(V_final)-min(V_final)
V_deviation = V_final - 12;

figure
plot(t*1000,V_final)
title("Voltage regulator output voltage")
xlabel ("t[ms]")
ylabel ("Vreg[V]")
legend ('V_r(t)','Location','Northeast')
print ("Vreg.eps", "-depsc")

figure
plot(t*1000,V_deviation)
title("Output deviation from 12V")
xlabel ("t[ms]")
ylabel ("Vdev[V]")
legend ('V_d(t)','Location','Northeast')
print ("deviation.eps", "-depsc")

figure
plot(t*1000,Vs, "r");
hold on
plot(t*1000,Vo, "b");
hold on
plot(t*1000,V_final, "g");
title("Comparison of output voltages from the transformer, the envelope detector and the voltage regulator")
xlabel ("t[ms]")
ylabel ("Vtransf , Venv , Vreg [V]")
legend ('V_t(t)','V_e(t)','V_r(t)','Location','Northeast')
print ("comparison.eps", "-depsc")

cost=0.1*(N_D+4)+C*(1e6)+R*(1e-3)+R2*(1e-3)
merit=1/(cost*(V_ripple+abs(12-V_level)+(1e-6)))

fid = fopen("data_tab.tex","w")
fprintf(fid, "@$V_{DC}$ & %f \\\\ \\hline \n", V_level)
fprintf(fid, "@$V_{ACripple}$ & %f \\\\ \\hline \n", V_ripple)
fprintf(fid, "Cost & %f \\\\ \\hline \n", cost)
fprintf(fid, "Merit & %f \\\\ \\hline \n", merit)
fclose(fid)
