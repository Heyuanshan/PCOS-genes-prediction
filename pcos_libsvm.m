s1=size(nonpcos_net);
s2=size(pocs_net);
I=[];
auc=[];
precision=[];
recall=[];
F1=[];
all_data=[nonpcos;pcos];
for i=1:s1(1,2)
 
 all_data(:,i)=libsvm_scale(all_data(:,i));
 
end
nonpcos=all_data(1:s1(1,1),:);
pcos=all_data((1+s1(1,1)):(s2(1,1)+s1(1,1)),:);
all_nonpcos={};
for j=1:1001
j/1001
I=randsample(s1(1,1),s2(1,1));
all_nonpcos{j,1}=nonpcos_net(I,:);
label=[ones(s2(1,1),1)*(-1);ones(s2(1,1),1)];
netplusgo_inst=[nonpcos_net(I,:);pocs_net];
predict=[];
ground_truth=[];
indices = crossvalind('Kfold',label,5);

for i = 1:5
    test = (indices == i); train = ~test;
    train_data=netplusgo_inst(train,:);
    train_truth=label(train,:);
    model = svmtrain(train_truth,train_data, '-b 1');
    
    test_data=netplusgo_inst(test,:);
    test_truth=label(test,:);
    [predict_label, accuracy, prob_estimates] = svmpredict( test_truth, test_data, model, '-b 1');
	predict=[predict;predict_label];
	ground_truth=[ground_truth;test_truth];
	
end

[pre,rec,F,auc1] = class_stats(predict, ground_truth);
auc=[auc;auc1];
precision=[precision;pre];
recall=[recall;rec];
F1=[F1;F];

end