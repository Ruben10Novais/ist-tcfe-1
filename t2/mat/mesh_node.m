close all
clear all

%%EXAMPLE SYMBOLIC COMPUTATIONS

pkg load symbolic

fidd = fopen("data.txt","r")
fclose(fidd)

%% MESH AND NODE ANALYSIS 
R1 = 1.02183054686e3 %% Ohm
R2 = 2.00519295062e3
R3 = 3.01735849578e3
R4 = 4.15136004156e3
R5 = 3.04417402199e3
R6 = 2.02196984898e3
R7 = 1.00784334281e3
G1 = 1/R1
G2 = 1/R2
G3 = 1/R3
G4 = 1/R4
G5 = 1/R5
G6 = 1/R6
G7 = 1/R7
V = 5.11339870586 %% V
I = 1.0050415923e-3 %% A
Kb = 7.18106630963e-3 %% S
Kc = 8.1227111635e3 %% Ohm

%% Matriz-resultado com valores numéricos das correntes nas malhas
A = [0, 0, 0, 1; R1+R3+R4, -R3, -R4, 0; -R4, 0, R6+R7+R4-Kc, 0; -R3*Kb, R3*Kb - 1, 0, 0]
B = [I; -V; 0; 0]
C = A\B

%% Matriz-resultado com valores numéricos da tensão nos nós do circuito (NODE)
D = [G7, 0, 0, 0, 0, 0, G6, 0; 1, -1, 0, 0, 0, 0, 0, 0; 0, 0, 0, 0, 0, 1, -1, 0; 0, 0, 0, -G2, G1+G2+G3, -G1, 0, -G3; 0, 0, G5, 0, G3, 0, G4+G6, -G3-G4-G5; 1, 0, 0, 0, 0, 0, Kc*G6, -1; 0, 0, 0, 0, G1, -G1, -G4-G6, G4; 0, 0, 0, -G2, Kb+G2, 0, 0, -Kb]
E = [0; 0; V; 0; I; 0; 0; 0]
F = D\E

%% Atribuir às variáveis os seus valores
Ia = C(1,1)
Ib = C(2,1)
Ic = C(3,1)
Id = C(4,1)

V1 = F(1,1)
V2 = F(2,1)
V3 = F(3,1)
V4 = F(4,1)
V5 = F(5,1)
V6 = F(6,1)
V7 = F(7,1)
V8 = F(8,1)

%% Criar 2 ficheiros, que serão o input das tabelas com os resultados teóricos
fid = fopen("data_current_tab.tex","w")
fprintf(fid, "@$I_{a}$ & %f \\\\ \\hline \n", Ia)
fprintf(fid, "@$I_{b}$ & %f \\\\ \\hline \n", Ib)
fprintf(fid, "@$I_{c}$ & %f \\\\ \\hline \n", Ic)
fprintf(fid, "@$I_{d}$ & %f \\\\ \\hline \n", Id)
fclose(fid)

fid = fopen("data_voltage_tab.tex","w")
fprintf(fid, "$V_{1}$ & %f \\\\ \\hline \n", V1)
fprintf(fid, "$V_{2}$ & %f \\\\ \\hline \n", V2)
fprintf(fid, "$V_{3}$ & %f \\\\ \\hline \n", V3)
fprintf(fid, "$V_{4}$ & %f \\\\ \\hline \n", V4)
fprintf(fid, "$V_{5}$ & %f \\\\ \\hline \n", V5)
fprintf(fid, "$V_{6}$ & %f \\\\ \\hline \n", V6)
fprintf(fid, "$V_{7}$ & %f \\\\ \\hline \n", V7)
fprintf(fid, "$V_{8}$ & %f \\\\ \\hline \n", V8)
fclose(fid)
