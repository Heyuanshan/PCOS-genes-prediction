function [p]=chaojihe(lb,ld,sb,sd)
%lb :large background
%ld: large differentically expressed gene
%sb: small background
%sd: small differentially expressed gene

p=1-hygecdf(sd-1,lb,ld,sb);

%hygecdf(2,100,20,10)
%Suppose you have a lot of 100 floppy disks and you know that 20 of them are defective. 
%What is the probability of drawing zero to two defective floppies if you select 10 at random?