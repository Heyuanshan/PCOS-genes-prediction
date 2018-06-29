s1=size(nonpcos);
s2=size(pcos);
DT_result={};
leafs = logspace(1,2,10);
N=numel(leafs);

all_data=[nonpcos;pcos];
for i=1:s1(1,2)
 
 all_data(:,i)=libsvm_scale(all_data(:,i));
 
end
nonpcos=all_data(1:s1(1,1),:);
pcos=all_data((1+s1(1,1)):(s2(1,1)+s1(1,1)),:);
all_nonpcos={};
for k=1:N
I=[];
auc=[];
precision=[];
recall=[];
F1=[];
for j=1:1001
j/1001
I=randsample(s1(1,1),s2(1,1));
all_nonpcos{j,1}=nonpcos(I,:);
netplusgo_label=[ones(s2(1,1),1)*(-1);ones(s2(1,1),1)];
netplusgo_inst=[nonpcos(I,:);pcos];
pre_label=[];
ground_truth=[];
indices = crossvalind('Kfold',netplusgo_label,5);

for i = 1:5
    tes = (indices == i); tra = ~tes;
    tra_data=netplusgo_inst(tra,:);
    tra_truth=netplusgo_label(tra,:);
    ctree = fitctree(tra_data,tra_truth,'MinLeaf',leafs(k));
    
    tes_data=netplusgo_inst(tes,:);
    tes_truth=netplusgo_label(tes,:);
    [label,score,node,cnum] = predict(ctree,tes_data);
	pre_label=[pre_label;label];
	ground_truth=[ground_truth;tes_truth];
	
end


[pre,rec,F,auc1] = class_stats(pre_label, ground_truth);
auc=[auc;auc1];
precision=[precision;pre];
recall=[recall;rec];
F1=[F1;F];
end
DT_result(k,1)={leafs(k)};
DT_result(k,2)={all_nonpcos};
DT_result(k,3)={precision};
DT_result(k,4)={recall};
DT_result(k,5)={F1};
DT_result(k,6)={auc};
DT_result{k,7}(1,1)=median(precision);
DT_result{k,7}(1,2)=median(recall);
DT_result{k,7}(1,3)=median(F1);
DT_result{k,7}(1,4)=median(auc);
end