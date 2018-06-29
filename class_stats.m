function  [precision,recall,F1,auc] = class_stats(predict, ground_truth)
%pos_num=TP+FN;
%neg_num=FP+TN;
pos_num = sum(ground_truth==1);
neg_num = sum(ground_truth==-1);
m=size(ground_truth,1);

    numcorrect = sum(ground_truth==predict);
    d = find(ground_truth== 1);    
    TP= length(find(predict(d)==1));
    
	TN=numcorrect-TP;
	
	
	FP=neg_num-TN;
	FN=pos_num-TP;


precision=TP/(TP+FP);
recall=TP/(TP+FN);
F1=2 * (precision*recall) / (precision+recall);

[pred,Index]=sort(predict);
ground_truth=ground_truth(Index);
x=zeros(m+1,1);
y=zeros(m+1,1);
auc=0;
x(1)=1;y(1)=1;


for i=2:m
tp=sum(ground_truth(i:m)==1);fp=sum(ground_truth(i:m)==-1);
tn =sum(ground_truth(1:i-1) == -1);
fn = sum(ground_truth(1:i-1) == 1);

x(i)=fp/neg_num;
y(i)=tp/pos_num;
auc=auc+(y(i)+y(i-1))*(x(i-1)-x(i))/2;
end;


x(m+1)=0;y(m+1)=0;
auc=auc+y(m)*x(m)/2;