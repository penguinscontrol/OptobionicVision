clear all;clc; close all;

irrs = [1 10];
expr = [36e-4 36e-4];
vcl =  [-70 -70];
retina = validate(irrs,expr,vcl,'validate.hoc');
nums = length(irrs);

%% Compare states
figure();
subplot(nums,1,1);

for a = 1:nums
subplot(nums,1,a);
plot(retina(a).t,retina(a).s1);
hold all;
plot(retina(a).t,retina(a).s2);
plot(retina(a).t,retina(a).s3);
plot(retina(a).t,retina(a).s4);
plot(retina(a).t,retina(a).s5);
plot(retina(a).t,retina(a).s6);
xlabel('Time (ms)');
ylabel('Probability of state');
end
legend('Dark adapted ground','trans-cis','High conductance open',...
    'Weak conductance open','cis-trans','Close (non-ground)',0);

% savefig('validate1');
%% Compare Photocurrents
% One plot
figure()
plot(retina(1).t,retina(1).iopt);
hold on;
plot(retina(2).t,retina(2).iopt);
% savefig('validate2');
% Second plot

irrs = [1 10 50 100];
expr = [36e-4 36e-4 36e-4 36e-4];
vcl = [-70 -70 -70 -70];
plottitles = {'1 mW/mm^2','10 mW/mm^2','50 mW/mm^2','100 mW/mm^2'};
retina = validate(irrs,expr,vcl,'validate.hoc');
nums = length(irrs);
figure();
subplot(1,nums,1);
for a = 1:nums
    
subplot(1,nums,a);
plot(retina(a).t,retina(a).iopt);
title(plottitles{a});
xlabel('Time (ms)');
ylabel('Photocurrent (A?)');
hold on;
plot(retina(a).t(retina(a).lstim > 0),zeros(1,sum(retina(a).lstim > 0)),'r.','MarkerSize',10);
end

for a = 1:nums
    subplot(1,nums,a);
   axis([-0.05.*retina(nums).t(end) retina(nums).t(end) 1.1.*min(retina(nums).iopt) 0]); 
end

% savefig('validate3');

%% Validate voltage dependent inward rectification

irrs = ones(1,9).*40;
expr = ones(1,9).*36e-4;
vcl = [-5:4].*20;
retina = validate(irrs,expr,vcl,'validate.hoc');
nums = length(irrs);
figure();
for a = 1:nums
    plot(retina(a).t,retina(a).iopt);
hold all;
end

% savefig('validate4');

%% Validate pulsed
irrs = 40;
expr = 36e-4;
vcl = -70;
retina = validate(irrs,expr,vcl,'validate_pulsed.hoc');
figure();
plot(retina.t,retina.iopt);
% savefig('validate5');

%% Currents compare

irrs = 7e-1;
expr = 40e-3;
vcl = 0;
retina = validate(irrs,expr,vcl,'validate_AP.hoc');
vdep = @(x) (1-exp(-x./40))./(x./15);
voltagedep = vdep(retina.vsoma);
voltagedep(voltagedep>1) = ones(1,sum(voltagedep>1));
conductance = expr.*(retina.s3+0.05.*retina.s4).*voltagedep;
figure();
subplot(3,1,1);
plot(retina.t,retina.vsoma,'k-');
xlabel('Time (ms)');
ylabel('Membrane Voltage (mV)');
axis([175 180 1.1.*min(retina.vsoma(retina.t > 175 & retina.t < 180))...
    1.1*max(retina.vsoma(retina.t > 175 & retina.t < 180))]);
subplot(3,1,2);
plot(retina.t,conductance,'r-');
axis([175 180 1.1.*min(conductance(retina.t > 175 & retina.t < 180))...
    1.1*max(conductance(retina.t > 175 & retina.t < 180))]);
subplot(3,1,3);
plot(retina.t,retina.iopt.*10,'r-');
hold on;
plot(retina.t,retina.isod,'k-');
plot(retina.t,retina.ipot,'b-');
axis([175 180 1.1.*min(retina.iopt(retina.t > 175 & retina.t < 180).*10)...
    1.1*max(retina.ipot(retina.t > 175 & retina.t < 180))]);
hold all;

% savefig('validate6');