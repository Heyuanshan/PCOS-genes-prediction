
go_genelist={};
term_bp=findi(term,'biological_process',3);
go_genelist=term_bp(:,1:4);


for i=1:size(term_bp,1)
 
 
 a=findi(graphpath,term_bp{i,1},2);
 
 b=findi(term_bp,unique(a(:,3)),1);
 c=findi(goa_human,b(:,4),5);
 go_genelist{i,5}=length(unique(c(:,2)));
 go_genelist{i,6}=unique(c(:,2));
 go_genelist{i,7}=unique(c(:,3));
end

save go_genelist;