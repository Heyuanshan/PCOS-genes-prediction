nodes <- read.csv("i2d_network_nodes.csv", header=T, as.is=T);
links <- read.csv("i2d_network_edges.csv", header=T, as.is=T);
library(igraph)
net <- graph_from_data_frame(d=links, vertices=nodes, directed=F);
deg <- degree(net, mode="all");
bet<-betweenness(net, directed=F, weights=NA);
kc <- coreness(net, mode="all");
i2d_data<-nodes;
i2d_data$degree<-deg;
i2d_data$betweenness<-bet;
i2d_data$kcore<-kc;

pcos<- read.csv("pcos genes.csv", header=T, as.is=T);
genelist<-pcos$UniProt.accession;
l<-nrow(nodes)
ratio<-vector(mode="numeric",length=0)
for (i in 1:l) {
    a<- ego(net,0,i)
    b<- ego(net,1,i)
    x<-setdiff(b[[1]],a[[1]])

    neighbors<-nodes$uniprot_ID[unlist(x)]
    gene<- intersect(neighbors,genelist)
    ratio[i]<-length(gene)/((ego_size(net,1,i)-ego_size(net,0,i)))

}
 i2d_data$first_ratio<-ratio;
ratio2<-vector(mode="numeric",length=0)
 for (i in 1:l) {
    a<- ego(net,1,i)
    b<- ego(net,2,i)
    x<-setdiff(b[[1]],a[[1]])

    neighbors<-nodes$uniprot_ID[unlist(x)]
    gene<- intersect(neighbors,genelist)
    if(ego_size(net,2,i)!=ego_size(net,1,i)){
	ratio2[i]<-length(gene)/((ego_size(net,2,i)-ego_size(net,1,i)))
}else{
    ratio2[i]<- 0
}
}
i2d_data$second_ratio<-ratio2;

write.table(i2d_data, file = "i2d_data.csv", sep = ",", row.names = FALSE);