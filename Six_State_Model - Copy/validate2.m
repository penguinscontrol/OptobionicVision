clear; clc;

load('will1');
will1 = data;
load('will2');
will2 = data;
load('c50');
c50 = data;
load('will3');
will3 = data;
load('p40');
p40 = data;

%% States

figure();
subplot(4,1,1);
plot(will1.t,will1.s1);
hold all;
plot(will1.t,will1.s2);
plot(will1.t,will1.s3);
plot(will1.t,will1.s4);
plot(will1.t,will1.s5);
plot(will1.t,will1.s6);
xlabel('Time (ms)');
ylabel('Probability of state');
legend('Dark adapted ground','trans-cis','High conductance open',...
    'Weak conductance open','cis-trans','Close (non-ground)',0);
subplot(3,1,2);
plot(will2.t,will2.s1);
hold all;
plot(will2.t,will2.s2);
plot(will2.t,will2.s3);
plot(will2.t,will2.s4);
plot(will2.t,will2.s5);
plot(will2.t,will2.s6);
xlabel('Time (ms)');
ylabel('Probability of state');
legend('Dark adapted ground','trans-cis','High conductance open',...
    'Weak conductance open','cis-trans','Close (non-ground)',0);
subplot(3,1,3);
plot(will3.t,will3.s1);
hold all;
plot(will3.t,will3.s2);
plot(will3.t,will3.s3);
plot(will3.t,will3.s4);
plot(will3.t,will3.s5);
plot(will3.t,will3.s6);
xlabel('Time (ms)');
ylabel('Probability of state');
legend('Dark adapted ground','trans-cis','High conductance open',...
    'Weak conductance open','cis-trans','Close (non-ground)',0);
%% Photocurrent, steady light
figure();
plot(will1.t,will1.iopt);
hold all;
plot(will2.t,will2.iopt);
plot(will3.t,will3.iopt);
plot(will1.t(will1.lstim > 0),zeros(1,sum(will1.lstim > 0)),'r.','MarkerSize',10);
legend('5.5 mW/mm^2, -20 mV','0.34 mW/mm^2, -80 mV','5.5 mW/mm^2, -80 mV','Light on')
axis([-0.1 will1.t(end) -0.2 0]);

