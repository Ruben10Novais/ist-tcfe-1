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

%% Resistência equivalente
A2 = [1, 0, 0, 0, 0, 0, 0 ; -G1, G1+G2+G3, -G2, -G3, 0, 0, 0; 0, Kb+G2, -G2, -Kb, 0, 0, 0 ; -G1, G1, 0, G4, 0, G6, 0 ; 0, 0, 0, 0, 0, -G6-G7, G7 ; 0, 0, 0, 1, 0, G6*Kd, -1 ; 0, 0, 0, 0, 1, 0, -1]
b2 = [0; 0; 0; 0; 0; 0; Vx]
V2 = A2\b2

V_1 = V2(1)
V_2 = V2(2)
V_3 = V2(3)
V_4 = 0
V_5 = V2(4)
V_6 = V2(5)
V_7 = V2(6)
V_8 = V2(7)

Ix = ((V_6-V_5)/R5) + ((V_3-V_2)/R2)

Req = abs(Vx/Ix)

tau = Req*C

%% Natural solution
syms t
syms A
syms wn
syms V6n(t)

V6n(t) = A*exp(wn*t)

A = Vx
wn = - (1/tau)

t=0:1e-6:20e-3;
V6n = A*exp(wn*t)

hf = figure (1);
plot (t*1000, V6n, "g");

xlabel ("t[ms]");
ylabel ("v6_n [V]");
print (hf, "natural.eps", "-natura");

%%
%f_net=fopen("circuit1.net","w");
%fprintf(f_net, "*Circuito 1\n R1 1 2 %f \n R2 2 3 %f \n R3 2 5 %f \n R4 0 5 %f \n R5 5 6 %f \n R6 0 7 %f \n R7 7 8 %f \n C 6 8 %f \n V 1 0 DC %f \n H 5 8 %f \n G 3 6 %f", R1,R2,R3,R4,R5,R6,R7,C,Vs, V1(5)-V1(8), V1(6)-V1(3));
%fclose(f_net);

%f_net=fopen("circuit2.net","w");
%fprintf(f_net, "*Circuito 2\n R1 0 2 %f \n R2 2 3 %f \n R3 2 5 %f \n R4 0 5 %f \n R5 5 6 %f \n R6 0 7 %f \n R7 7 8 %f \n V 6 8 %f \n H 5 8 %f \n G 3 6 %f", R1,R2,R3,R4,R5,R6,R7,V1(6)-V1(8), V1(5)-V1(8), V1(6)-V1(3));
%fclose(f_net);

%f_net=fopen("circuit3.net","w");
%fprintf(f_net, "*Circuito 3\n R1 0 2 %f \n R2 2 3 %f \n R3 2 5 %f \n R4 0 5 %f \n R5 5 6 %f \n R6 0 7 %f \n R7 7 8 %f \n C 6 8 %f \n H 5 8 %f \n G 3 6 %f", R1,R2,R3,R4,R5,R6,R7,C, V2(5)-V2(8), V2(6)-V2(3));
%fclose(f_net);

%% Criar 2 ficheiros, que serão o input das tabelas com os resultados teóricos
%fid = fopen("data_current_tab.tex","w")
%fprintf(fid, "@$I_{a}$ & %f \\\\ \\hline \n", I11)
%fprintf(fid, "@$I_{b}$ & %f \\\\ \\hline \n", I12)
%fprintf(fid, "@$I_{c}$ & %f \\\\ \\hline \n", I13)
%fprintf(fid, "@$I_{d}$ & %f \\\\ \\hline \n", I14)
%fclose(fid)

%fid = fopen("data_voltage_tab.tex","w")
%fprintf(fid, "$V_{1}$ & %f \\\\ \\hline \n", V1(1))
%fprintf(fid, "$V_{2}$ & %f \\\\ \\hline \n", V1(2))
%fprintf(fid, "$V_{3}$ & %f \\\\ \\hline \n", V1(3))
%fprintf(fid, "$V_{4}$ & %f \\\\ \\hline \n", V1(4))
%fprintf(fid, "$V_{5}$ & %f \\\\ \\hline \n", V1(5))
%fprintf(fid, "$V_{6}$ & %f \\\\ \\hline \n", V1(6))
%fprintf(fid, "$V_{7}$ & %f \\\\ \\hline \n", V1(7))
%fprintf(fid, "$V_{8}$ & %f \\\\ \\hline \n", V1(8))
%fclose(fid)
