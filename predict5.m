%%Function code for predicting one step ahead, using phase space
%%reconstruction
function [predictedvalue,nearestneighbor,pred,linearindices,psr] = predict5(x,tdelay,embdim,k)
%% For phase space reconstruction 
psr=phaseSpaceReconstruction(x,tdelay,embdim);

%for finding the distance between the vectors
distance=zeros(size(psr,1),size(psr,1));
for i=1:size(psr,1)
  for   j=1:size(psr,1)
    distance(i,j)=sqrt(sum((psr(i,:)-psr(j,:)).^2));
  end 
end
index=1:size(distance,1)+1:size(distance,1)*size(distance,1);
distance(index)=nan;
%For finding the nearest neighbour
nearestneighbor=mink(distance(size(distance,1),:),k);
nearestneighbor=nearestneighbor';

%%For predicting the values
linearindices=nan(k,1);
pred=nan(k,1);
for i=1:k
row = find (distance(size(distance,1),:)==nearestneighbor(i,1));
if size(row,2)>1
 linearindices(i,1) = row(1,1);
else
linearindices(i,1)=find (distance(size(distance,1),:)==nearestneighbor(i,1));
end
pred(i,1)=(psr((linearindices(i,1)+1),size(psr,2)));
end
%For taking the average of the predicted values
predictedvalue=mean(pred);
end


