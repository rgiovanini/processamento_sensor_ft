% script que realiza a otimização dos dados médios de força lidos pelo
% sensor F/T, com base na minimização da variância do erro. 
clear all 
clc

%% carregando e separando os dados
celula_carga = dlmread('array_medio_forca_torque.txt');
base_flange = dlmread('array_medio_base_flange.txt');
celula_carga = celula_carga(1:6,:);
base_flange = base_flange(1:6,:);

forca_array = celula_carga(1:3,:);
torque_array = celula_carga(4:6,:);
xyz_array = base_flange(1:3,:);
abc_array = base_flange(4:6,:);
t = [1:length(celula_carga)]; % vetor horizontal (para plots)

%% definindo funcoes e constantes
R_sensor_flange = [1 0 0; 0 1 0; 0 0 -1];

%% definicao de funcoes
%geracao de matriz de rotacao com base nos valores fornecidos com notação
%de angulos de euler

function R_flange_base = euler_matrix(a,b,c)
    R_flange_base = [cos(a)*cos(b) cos(a)*sin(b)*sin(c)-sin(a)*sin(c) cos(a)*sin(b)*cos(c)+sin(a)*sin(c);
                     sin(a)*cos(b) sin(a)*sin(b)*sin(c)+cos(a)*cos(c) sin(a)*sin(b)*cos(c)+cos(a)*sin(c);
                     -sin(b) cos(b)*sin(c) cos(b)*cos(c)];
end