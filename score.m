pcos_genelist=pcos_union(:,5);

for i=1:size(go_genelist,1)

go_gene=go_genelist{i,5};
over_pre=intersect(go_gene,pcos_genelist);
go_genelist{i,6}=length(over_pre);

end

for i=1:size(go_genelist,1)

ld=go_genelist{i,4};
sd=go_genelist{i,6};
[p]=chaojihe(19393,ld,320,sd);
go_genelist{i,7}=p;
score=log((sd+1)/(ld+1)*19393/320);
go_genelist{i,8}=score;
end
