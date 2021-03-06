close all
clear all

%%EXAMPLE SYMBOLIC COMPUTATIONS

pkg load symbolic

format long

%% Ler dados python

fp = fopen("data.txt", "r");
S = fscanf(fp,'%s = %f', [3 inf])
fclose(fp)

R1 = S(3,1)*1000
R2 = S(3,2)*1000
R3 = S(3,3)*1000
R4 = S(3,4)*1000
R5 = S(3,5)*1000
R6 = S(3,6)*1000
R7 = S(3,7)*1000
Vs = S(3,8)
C = S(2,9)*0.000001
Kb = S(2,10)/1000
Kd = S(2,11)*1000
G1 = 1/R1
G2 = 1/R2
G3 = 1/R3
G4 = 1/R4
G5 = 1/R5
G6 = 1/R6
G7 = 1/R7
Ca = S(2,9)
Kbb = S(2,10)

fid = fopen("data_python_tab.tex","w")
fprintf(fid, "R1 & %f kOhm \\\\ \\hline \n", R1/1000)
fprintf(fid, "R2 & %f kOhm \\\\ \\hline \n", R2/1000)
fprintf(fid, "R3 & %f kOhm \\\\ \\hline \n", R3/1000)
fprintf(fid, "R4 & %f kOhm\\\\ \\hline \n", R4/1000)
fprintf(fid, "R5 & %f kOhm \\\\ \\hline \n", R5/1000)
fprintf(fid, "R6 & %f kOhm\\\\ \\hline \n", R6/1000)
fprintf(fid, "R7 & %f kOhm\\\\ \\hline \n", R7/1000)
fprintf(fid, "$V_{s}$ & %f V \\\\ \\hline \n", Vs)
fprintf(fid, "C & %f uF\\\\ \\hline \n", Ca)
fprintf(fid, "$K_{b}$ & %f mS \\\\ \\hline \n", Kbb)
fprintf(fid, "$K_{d}$ & %f kOhm \\\\ \\hline \n", Kd/1000)
fclose(fid)

f_net=fopen("circuit1.txt","w");
fprintf(f_net, "*Circuito 1\nR1 1 2 %f \nR2 2 3 %f \nR3 5 2 %f \nR4 5 0 %f \nR5 6 5 %f \nR6 0 7 %f \nR7 4 8 %f \nC 6 8 %fu \nV 1 0 DC %f \nVf 7 4 0 \nH 5 8 Vf %f \nG 6 3 (2,5) %fm", R1,R2,R3,R4,R5,R6,R7,Ca,Vs,Kd,Kbb);
fclose(f_net);

%% Matriz-resultado com valores numéricos das tensões nos nós

A1 = [1, 0, 0, 0, 0, 0, 0 ; -G1, G1+G2+G3, -G2, -G3, 0, 0, 0; 0, Kb+G2, -G2, -Kb, 0, 0, 0 ; -G1, G1, 0, G4, 0, G6, 0 ; 0, 0, 0, 0, 0, -G6-G7, G7 ; 0, 0, 0, 1, 0, G6*Kd, -1 ; 0, -G3, 0, G3+G4+G5, -G5, G6, 0]
b1 = [Vs; 0; 0; 0; 0; 0; 0]
V1 = A1\b1

V_1 = V1(1)
V_2 = V1(2)
V_3 = V1(3)
V_4 = 0
V_5 = V1(4)
V_6 = V1(5)
V_7 = V1(6)
V_8 = V1(7)
I_R1 = (V_1-V_2)/R1
I_R2 = (V_2-V_3)/R2
I_R3 = (V_5-V_2)/R3
I_R4 = V_5/R4
I_R5 = (V_6-V_5)/R5
I_R6 = (-V_7)/R6
I_R7 = (V_7-V_8)/R7
I_Vs = I_R1
Ib = -I_R2
Ic = 0
I_kd = I_R6

Vx = V_6 - V_8

fid = fopen("data_constantsource_tab.tex","w")
fprintf(fid, "@$I_{R1}$ & %f \\\\ \\hline \n", I_R1*1000)
fprintf(fid, "@$I_{R2}$ & %f \\\\ \\hline \n", I_R2*1000)
fprintf(fid, "@$I_{R3}$ & %f \\\\ \\hline \n", I_R3*1000)
fprintf(fid, "@$I_{R4}$ & %f \\\\ \\hline \n", I_R4*1000)
fprintf(fid, "@$I_{R5}$ & %f \\\\ \\hline \n", I_R5*1000)
fprintf(fid, "@$I_{R6}$ & %f \\\\ \\hline \n", I_R6*1000)
fprintf(fid, "@$I_{R7}$ & %f \\\\ \\hline \n", I_R7*1000)
fprintf(fid, "@$I_{b}$ & %f \\\\ \\hline \n", Ib*1000)
fprintf(fid, "@$I_{C}$ & %f \\\\ \\hline \n", Ic*1000)
fprintf(fid, "@$I_{Vs}$ & %f \\\\ \\hline \n", I_Vs*1000)
fprintf(fid, "@$I_{Kd}$ & %f \\\\ \\hline \n", I_kd*1000)
fprintf(fid, "$V_{1}$ & %f \\\\ \\hline \n", V_1)
fprintf(fid, "$V_{2}$ & %f \\\\ \\hline \n", V_2)
fprintf(fid, "$V_{3}$ & %f \\\\ \\hline \n", V_3)
fprintf(fid, "$V_{4}$ & %f \\\\ \\hline \n", V_4)
fprintf(fid, "$V_{5}$ & %f \\\\ \\hline \n", V_5)
fprintf(fid, "$V_{6}$ & %f \\\\ \\hline \n", V_6)
fprintf(fid, "$V_{7}$ & %f \\\\ \\hline \n", V_7)
fprintf(fid, "$V_{8}$ & %f \\\\ \\hline \n", V_8)
fclose(fid)

f_net=fopen("circuit2.txt","w");
fprintf(f_net, "*Circuito 2\nR1 1 2 %f \nR2 2 3 %f \nR3 5 2 %f \nR4 5 0 %f \nR5 6 5 %f \nR6 0 7 %f \nR7 4 8 %f \nVs 1 0 0 \nVf 7 4 0 \nH 5 8 Vf %f \nG 6 3 (2,5) %fm", R1,R2,R3,R4,R5,R6,R7,Kd,Kbb);
fclose(f_net);

%% Resistência equivalente
A2 = [1, 0, 0, 0, 0, 0, 0 ; -G1, G1+G2+G3, -G2, -G3, 0, 0, 0; 0, Kb+G2, -G2, -Kb, 0, 0, 0 ; -G1, G1, 0, G4, 0, G6, 0 ; 0, 0, 0, 0, 0, -G6-G7, G7 ; 0, 0, 0, 1, 0, G6*Kd, -1 ; 0, 0, 0, 0, 1, 0, -1]
b2 = [0; 0; 0; 0; 0; 0; Vx]
V2 = A2\b2

V_11 = V2(1)
V_22 = V2(2)
V_33 = V2(3)
V_44 = 0
V_55 = V2(4)
V_66 = V2(5)
V_77 = V2(6)
V_88 = V2(7)

Ix = ((V_66-V_55)/R5) + ((V_33-V_22)/R2)

Req = abs(Vx/Ix)

tau = Req*C

f_tab=fopen("eq_tab.tex","w");
fprintf(f_tab, "$V_{x}$ & %f V\\\\ \\hline\n$V_{6}$ & %f V\\\\ \\hline\n$V_{8}$ & %f V\\\\ \\hline\n@$I_{x}$ & %f mA\\\\ \\hline\n$R_{eq}$ & %f kOhm\\\\ \\hline\n$tau$ & %f ms\\\\ \\hline", Vx, V_66, V_88, Ix*1000,Req/1000,tau*1000);
fclose(f_tab);

%% Natural solution
A22 = [1, 0, 0, 0, 0, 0, 0 ; -G1, G1+G2+G3, -G2, -G3, 0, 0, 0; 0, Kb+G2, -G2, -Kb, 0, 0, 0 ; -G1, G1, 0, G4, 0, G6, 0 ; 0, 0, 0, 0, 0, -G6-G7, G7 ; 0, 0, 0, 1, 0, G6*Kd, -1 ; 0, -G3, 0, G3+G4+G5, -G5, G6, 0]
b22 = [0; 0; 0; 0; 0; 0; 0]
V22 = A22\b22

V_11a = V22(1)
V_22a = V22(2)
V_33a = V22(3)
V_44a = 0
V_55a = V22(4)
V_66a = V22(5)
V_77a = V22(6)
V_88a = V22(7)

fid = fopen("data_nule_tab.tex","w")
fprintf(fid, "$V_{1}$ & %f \\\\ \\hline \n", V_11a)
fprintf(fid, "$V_{2}$ & %f \\\\ \\hline \n", V_22a)
fprintf(fid, "$V_{3}$ & %f \\\\ \\hline \n", V_33a)
fprintf(fid, "$V_{4}$ & %f \\\\ \\hline \n", V_44a)
fprintf(fid, "$V_{5}$ & %f \\\\ \\hline \n", V_55a)
fprintf(fid, "$V_{6}$ & %f \\\\ \\hline \n", V_66a)
fprintf(fid, "$V_{7}$ & %f \\\\ \\hline \n", V_77a)
fprintf(fid, "$V_{8}$ & %f \\\\ \\hline \n", V_88a)
fclose(fid)

f_net=fopen("circuit3.txt","w");
fprintf(f_net, "*Circuito 3\nR1 1 2 %f \nR2 2 3 %f \nR3 5 2 %f \nR4 5 0 %f \nR5 6 5 %f \nR6 0 7 %f \nR7 4 8 %f \nC 6 8 %fu \nVs 1 0 0 \nVf 7 4 0 \nH 5 8 Vf %f \nG 6 3 (2,5) %fm", R1,R2,R3,R4,R5,R6,R7,Ca,Kd,Kbb);
fclose(f_net);

syms t
syms A
syms wn
syms V6n(t)

V6n(t) = A*exp(wn*t)

A = Vx
wn = - (1/tau)

t=0:1e-5:20e-3;
V6n = A*exp(wn*t)

hf = figure (1);
plot (t*1000, V6n, "g");

xlabel ("t[ms]");
ylabel ("v6_n [V]");
legend ('V6_n(t)','Location','Northeast')
print (hf, "natural.eps", "-depsc");

%% Forced solution
w = 2*pi*1000

A3 = [1, 0, 0, 0, 0, 0, 0 ; -G1, G1+G2+G3, -G2, -G3, 0, 0, 0; 0, Kb+G2, -G2, -Kb, 0, 0, 0 ; -G1, G1, 0, G4, 0, G6, 0 ; 0, 0, 0, 0, 0, -G6-G7, G7 ; 0, 0, 0, 1, 0, G6*Kd, -1 ; 0, -G3, 0, G3+G4+G5, -G5-(j*w*C), G6, j*w*C]
b3 = [-j; 0; 0; 0; 0; 0; 0]
V3 = A3\b3

V1r = abs(V3(1))
V1teta = angle(V3(1))
V2r = abs(V3(2))
V2teta = angle(V3(2))
V3r = abs(V3(3))
V3teta = angle(V3(3))
V4r = 0
V4teta = 0
V5r = abs(V3(4))
V5teta = angle(V3(4))
V6r = abs(V3(5))
V6teta = angle(V3(5))
V7r = abs(V3(6))
V7teta = angle(V3(6))
V8r = abs(V3(7))
V8teta = angle(V3(7))

f_tab1=fopen("eq2_tab.tex","w");
fprintf(f_tab1, "$V_{1}$ & %f & %f\\\\ \\hline\n$V_{2}$ & %f & %f\\\\ \\hline\n$V_{3}$ & %f & %f\\\\ \\hline\n$V_{4}$ & %f & %f\\\\ \\hline\n$V_{5}$ & %f & %f\\\\ \\hline\n$V_{6}$ & %f & %f\\\\ \\hline\n$V_{7}$ & %f & %f\\\\ \\hline\n$V_{8}$ & %f & %f\\\\ \\hline", V1r,V1teta*180/pi,V2r,V2teta*180/pi,V3r,V3teta*180/pi,V4r,V4teta*180/pi,
V5r,V5teta*180/pi,V6r,V6teta*180/pi,V7r,V7teta*180/pi,V8r,V8teta*180/pi);
fclose(f_tab1);

%% Total solution
f_net=fopen("circuit4.txt","w");
fprintf(f_net, "*Circuito 4\nR1 1 2 %f \nR2 2 3 %f \nR3 5 2 %f \nR4 5 0 %f \nR5 6 5 %f \nR6 0 7 %f \nR7 4 8 %f \nC 6 8 %fu \nVs 1 0 0.0 AC 1.0 -90 SIN(0 1 1000) \nVf 7 4 0 \nH 5 8 Vf %f \nG 6 3 (2,5) %fm", R1,R2,R3,R4,R5,R6,R7,Ca,Kd,Kbb);
fclose(f_net);

V6f = V6r*cos((w*t)+V6teta)
V6t = V6n + V6f

tneg=-5e-3:1e-5:0;
tt=[tneg,t];
Vsneg = Vs + 0*tneg
Vspos = sin(w*t)
V6neg = V_6 + 0*tneg
V6pos = V6t
Vs_t = [Vsneg,Vspos];
V6_t = [V6neg,V6pos];

hf2 = figure (2);
plot (tt, Vs_t, "b");
hold on
plot (tt, V6_t, "r");

xlabel ("t[s]");
ylabel ("V_s(t) , V_6(t) [V]");
legend ('V_s(t)','V_6(t)','Location','Northeast')
print (hf2, "total.eps", "-depsc");

%% Frequency response
f = logspace(-1, 6, 50)

for i=1:1:50

w=2*pi*f(i)
A3 = [1, 0, 0, 0, 0, 0, 0 ; -G1, G1+G2+G3, -G2, -G3, 0, 0, 0; 0, Kb+G2, -G2, -Kb, 0, 0, 0 ; -G1, G1, 0, G4, 0, G6, 0 ; 0, 0, 0, 0, 0, -G6-G7, G7 ; 0, 0, 0, 1, 0, G6*Kd, -1 ; 0, -G3, 0, G3+G4+G5, -G5-(j*w*C), G6, j*w*C]
b3 = [-j; 0; 0; 0; 0; 0; 0]
V3 = A3\b3
V6(i)=V3(5)
V8(i)=V3(7)
Vs(i)=V3(1)
Vc(i)=V6(i)-V8(i)

end 

hf3 = figure (3);
plot (log10(f), 20*log10(abs(Vs)), "g");
hold on
plot (log10(f), 20*log10(abs(V6)), "r");
hold on
plot (log10(f), 20*log10(abs(Vc)), "b");

xlabel ("Frequency, in logarithmic scale [Hz]");
ylabel ("Magnitude [dB]");
legend ('Vs','V6', 'Vc','Location','Northeast')
print (hf3, "magnitude.eps", "-depsc");

hf4 = figure (4);
plot (log10(f), (180*angle(Vs))/pi, "g");
hold on
plot (log10(f), (180*angle(V6))/pi, "r");
hold on
plot (log10(f) , (180*angle(Vc))/pi, "b");

xlabel ("Frequency, in logarithmic scale [Hz]");
ylabel ("Phase [Degrees]");
legend ('Vs','V6', 'Vc','Location','Northeast')
print (hf4, "phase.eps", "-depsc");
