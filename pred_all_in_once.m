load('data1970.mat')
data=data1970(:,196:size(data1970,2));
lengthofdata=length(data);
Ltraining=round(0.75*lengthofdata); %For finding the length of 75% of the data
tdelay=1;  %put the delay time you want to perform the prediction for
n=10;      %number of nearest neighbours
Predicted1970All_5=nan(lengthofdata-Ltraining,10,n,size(data,2));
for i = 1:size(data,2)
        for embdim=2:10
             for k=1:n
                clear x;
                x(:,1) = data(1:Ltraining,i);
                    for j = 1:(lengthofdata-Ltraining)
                        x(Ltraining+j-1,1)        = data(Ltraining+j-1,i);
                        Predicted1970All_5(j,embdim,k,i) = predict5(x,tdelay,embdim,k);
                    end
             end
        end 
end

%%For saving the results:
file ='Predicted1970All_5.mat';
save (file,'Predicted1970All_5')


%%For finding the correlation of the predicted and observed data
Correlation1990All_4=nan(10,n,size(data,2));
for i=1:size(data,2)
    for m=2:10
       for k=1:n
             R=corrcoef(Predicted1970All_5(:,m,k,i),data(Ltraining+1:lengthofdata,i));
             Correlation1990All_4(m,k,i)=R(1,2);
        end
    end 
end 

%%For saving the results:
file ='Correlation1990All_4.mat';
save (file,'Correlation1990All_4')
%%For saving the optimum correlation values in one column
finalcorr=max(max (Correlation1990All_4));
Finalcorr=nan(size(data,2),1);
for i=1:size(data,2)
    Finalcorr(i,1)=finalcorr(:,:,i);
end 
%For finding the optimal embedding and number of neighbors
[row, column]=find (Correlation1990All_4(:,:,1:44)==max(max (Correlation1990All_4(:,:,1:44)));
for i=1:43
    column (i+1,1)=column (i+1,1)-(i*10);
end 
%storing the optimal emb and number of neighbors in one array
opt=nan(44,3);
opt(:,1)=Finalcorr(1:44,1);
opt(:,2)=row;
opt(:,3)=column;



%%For the root mean square error
RMSE1970All_1=nan(10,size(data,2));
for i=1:size(data,2)
    for m=2:10
        for j=1:(lengthofdata-Ltraining)
            RMSE=sqrt(sum((data(Ltraining+j,i)-Predicted1970All_5(j,m,i)).^2)/size(Predicted1970All_5,1));
            RMSE1970All_1(m,i)=RMSE;
        end 
    end 
end 

%%For saving the results:
file ='RMSE1970allemb.mat';
save (file,'RMSE1970All')