function[data]=importNeuron()
list=dir(['*.dat']);
iter=size(list);
data=struct();
for n=1:iter
    fid= fopen(list(n).name);
    name=list(n).name(1:end-4);
    data=setfield(data,name,fread(fid,'double'));
    fclose(fid)
end

data=setfield(data,'dt',1e-3);