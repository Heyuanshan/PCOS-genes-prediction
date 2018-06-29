function x=libsvm_scale(x)
min_x=min(x);
max_x=max(x);
if min_x~=max_x
x=(x-min_x)/(max_x-min_x);
end
