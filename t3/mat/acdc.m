close all 
clear all

pkg load symbolic

format long

% DATA

R=15000
C=1e-5
f=50
A=230
N_coils=16
w=2*pi*f
T=1/f
n=2000
N_P=10
VON=(2/3)

% TIME VECTOR

t=linspace(0,T*N_P,n);

% Transformer

Amp=A/N_coils

Vs=Amp*cos(w*t);
Vo = zeros(1, length(t));

% FULL WAVE RECTIFIER

for i=1:length(t) 
     Vo(i)=abs(Vs(i));
end

% ***** ENVELOPE DETECTOR *****

toff=(1/w)*atan(1/(w*R*C))

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
title("Envelope detector voltage")
xlabel ("t[ms]")
ylabel ("Vo[V]")
print ("Venv.eps", "-depsc")

% ***** Voltage Regulator *****

N_D=18
r_D=0.026/((1e-14)*exp(VON/0.026))
R2=1000

V_DC = mean(Vo);
V_AC=Vo-V_DC;

V_AC_final=((N_D*r_D)/(N_D*r_D+R2))*V_AC;
V_final=V_AC_final+(N_D*VON);
V_level = N_D*VON;
V_ripple=max(V_final)-min(V_final)
V_deviation = V_final - 12;

figure
plot(t*1000,V_final)
title("Output voltage")
xlabel ("t[ms]")
ylabel ("Vo[V]")
print ("Vo.eps", "-depsc")

figure
plot(t*1000,V_deviation)
title("Output AC component")
xlabel ("t[ms]")
ylabel ("Vo[V]")
print ("deviation.eps", "-depsc")

cost=0.1*(N_D+4)+C*10^6+R*10^-3
merit=1/(cost*(V_ripple+max(V_deviation)+10^-6))
