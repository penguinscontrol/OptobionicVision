function plotall( input_args )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

load(input_args);

figure();
plot(data.t,data.s1);
hold all;
plot(data.t,data.s2);
plot(data.t,data.s3);
plot(data.t,data.s4);
plot(data.t,data.s5);
plot(data.t,data.s6);
xlabel('Time (ms)');
ylabel('Probability of state');
legend('Dark adapted ground','trans-cis','High conductance open',...
    'Weak conductance open','cis-trans','Close (non-ground)');

figure();
plot(data.t,data.iopt);
hold all;
plot(data.t(data.lstim > 0),zeros(1,sum(data.lstim > 0)),'r.','MarkerSize',10);
axis([-10 data.t(end) -0.2 0]);

figure();
vdep = @(x) (1-exp(-x./40))./(x./15);
plot(data.t,(data.s3+data.s4.*0.05).*vdep(data.vsoma));
title('Channel Conductance (relative to max)');

end

