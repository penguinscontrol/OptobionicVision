clear;clc;

vecs = {'s1','s2','s3','s4','s5','s6',...
    'iopt','isod','lstim','vsoma','m','n','h'};
data = struct('t',[],'s1',[],'s2',[],'s3',[],'s4',[],'s5',[],'s6',[],...
    'iopt',[],'isod',[],'lstim',[],'vsoma',[],'m',[],'n',[],'h',[]);

for a = 1:length(vecs)
    fid = fopen([vecs{a}, '.dat']);
    data.(vecs{a}) = fread(fid,'double');
end

dt = 1e-3;
data.t = [0:(length(data.s1)-1)]'.*dt; % in ms

finame = input('Save to: ','s');
save(finame,'data');