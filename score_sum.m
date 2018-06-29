
score={};
count=0;
for i=1:size(go_genelist,1)
 len=go_genelist{i,4};
 for j=1:len
 score{count+j,1}=go_genelist{i,5}{j,1};
 score{count+j,2}=go_genelist{i,8};
 
 end
 count=count+len;
end

score_sum=unique(score(:,1));
score_sort=sortrows(score,1);
count=1;


for i=1:size(score_sum,1)
  
  sum=0;
  while strcmp(score_sort{count,1},score_sum{i,1})
    sum=sum+score_sort{count,2};
	count=count+1;
  end 
  score_sum{i,2}=sum;
end
