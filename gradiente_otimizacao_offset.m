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
t = [1:length(celula_carga)];

%% algoritmo do gradiente descendente adaptados
Foff = [-30; -4; -10];
gamma = 0.001;

regiao=zeros(3,3,3);

for int=1:1:8000
for i=-1:1:1
   for j=-1:1:1
      for k=-1:1:1
          Offset(:)= Foff(:)+[i*gamma;j*gamma;k*gamma];
         regiao(i+2,j+2,k+2)=func_obj(Offset',forca_array);
      end
   end
end

%[i_min,j_min,k_min]=find(regiao==min(min(min(regiao))));

[i_min,j_min,k_min]=ind2sub(size(regiao),find(regiao==min(min(min(regiao)))));

Foff = Foff +[(i_min-2);(j_min-2);(k_min-2)]*gamma;
end

for i=1:1:size(forca_array,2)
    d(:,i) = forca_array(:,i) - Foff;
    P(i) = norm(d(:,i),2);
end

massa = mean(P) / 9.81;

fprintf('Foffx: %.3f N \nFoffy: %.3f N \nFoffz: %.3f N \n', Foff(1), Foff(2), Foff(3)) 
fprintf('\nmassa: %.3f kg', massa);
