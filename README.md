# Matlab-code
%%This code is wrote for prediction of stream flow using phase space reconstrution
% x is the data, tdelay is the time delay in phase space reconstruction and embdim is embedding dimension
function [predictedvalue,column,nearestneighbor,psr,distance] = predict(x,tdelay,embdim)
psr=phaseSpaceReconstruction(x,tdelay,embdim);
%
distance=zeros(size(psr,1),size(psr,1));
for i=1:size(psr,1)
  for   j=1:size(psr,1)
    distance(i,j)=sqrt(sum((psr(i,:)-psr(j,:)).^2));
  end 
end
index=1:size(distance,1)+1:size(distance,1)*size(distance,1);
distance(index)=nan;
%
nearestneighbor=min(distance(size(distance,1),:));
[row,column]=find (distance(size(distance,1),:)==nearestneighbor);
predictedvalue=(psr((column(1,1)+1),size(psr,2)));
end
