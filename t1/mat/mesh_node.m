close all
clear all

%%EXAMPLE SYMBOLIC COMPUTATIONS

pkg load symbolic

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
A\B

%% Matriz-resultado com valores numéricos da tensão nos nós do circuito (NODE)
C = [G7, 0, 0, 0, 0, 0, G6, 0; 1, -1, 0, 0, 0, 0, 0, 0; 0, 0, 0, 0, 0, 1, -1, 0; 0, 0, 0, -G2, G1+G2+G3, -G1, 0, -G3; 0, 0, G5, 0, G3, 0, G4+G6, -G3-G4-G5; 1, 0, 0, 0, 0, 0, Kc*G6, -1; 0, 0, 0, 0, G1, -G1, -G4-G6, G4; 0, 0, 0, -G2, Kb+G2, 0, 0, -Kb]
D = [0; 0; V; 0; I; 0; 0; 0]
C\D
