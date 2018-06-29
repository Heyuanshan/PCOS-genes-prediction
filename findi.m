
function  [result,ia,ib]=findi(data1,data2,col,col2)

% data1 could be a cell or mat
% data2 could be cell or str or mat when data1 is cell; however when data1
% is a mat, data2 could only be a numeric or array
% col is the column that usr want to search data2 in data1. 
% result is all searched result in data1

if nargin==2
    
    col=1;
    col2=1;
end

if nargin==3
    col2=1;
end

if isnumeric(data1)
    data1_table=array2table(data1);
end
if iscell(data1)
    data1_table=cell2table(data1);
end
    


if(ischar(data2))
    data3={data2};
end

if(isnumeric(data2))
    data3=num2cell(data2);
end

if(iscell(data2))
    data3=data2;
end

data2_table=cell2table(data3);


[c,ia,ib]=innerjoin(data1_table,data2_table,'leftkeys',col,'rightkeys',col2);


%c = outerjoin(data1_table,data2_table,'Type','left');

%c = outerjoin(data1_table,data2_table,'leftkeys',col,'rightkeys',col2);


if (isnumeric(data1)&isnumeric(data2))
    result=table2array(c);
else
    result=table2cell(c);
end


