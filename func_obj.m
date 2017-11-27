function fob = func_obj(off,forca_array)
for i=1:1:size(forca_array,2)
d(:,i) = forca_array(:,i) - off;
P(i) = norm(d(:,i),2);

end

u = mean(P);

for k=1:1:size(forca_array,2)
   erro_q(k)=(P(k)-u)^2; 
end

fob = sum(erro_q)/(length(erro_q));

end