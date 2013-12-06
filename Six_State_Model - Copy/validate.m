clear; clc;

load('c1');
c1 = data;
load('c10');
c10 = data;
load('c50');
c50 = data;
load('c100');
c100 = data;
load('p40');
p40 = data;

%% States

figure();
subplot(4,1,1);
plot(c1.t,c1.s1);
hold all;
plot(c1.t,c1.s2);
plot(c1.t,c1.s3);
plot(c1.t,c1.s4);
plot(c1.t,c1.s5);
plot(c1.t,c1.s6);
xlabel('Time (ms)');
ylabel('Probability of state');
legend('Dark adapted ground','trans-cis','High conductance open',...
    'Weak conductance open','cis-trans','Close (non-ground)',0);
subplot(4,1,2);
plot(c10.t,c10.s1);
hold all;
plot(c10.t,c10.s2);
plot(c10.t,c10.s3);
plot(c10.t,c10.s4);
plot(c10.t,c10.s5);
plot(c10.t,c10.s6);
xlabel('Time (ms)');
ylabel('Probability of state');
legend('Dark adapted ground','trans-cis','High conductance open',...
    'Weak conductance open','cis-trans','Close (non-ground)',0);
subplot(4,1,3);
plot(c50.t,c50.s1);
hold all;
plot(c50.t,c50.s2);
plot(c50.t,c50.s3);
plot(c50.t,c50.s4);
plot(c50.t,c50.s5);
plot(c50.t,c50.s6);
xlabel('Time (ms)');
ylabel('Probability of state');
legend('Dark adapted ground','trans-cis','High conductance open',...
    'Weak conductance open','cis-trans','Close (non-ground)',0);
subplot(4,1,4);
plot(c100.t,c100.s1);
hold all;
plot(c100.t,c100.s2);
plot(c100.t,c100.s3);
plot(c100.t,c100.s4);
plot(c100.t,c100.s5);
plot(c100.t,c100.s6);
xlabel('Time (ms)');
ylabel('Probability of state');
legend('Dark adapted ground','trans-cis','High conductance open',...
    'Weak conductance open','cis-trans','Close (non-ground)',0);
%% Photocurrent, steady light
figure();

subplot(1,4,1);
plot(c1.t,c1.iopt);
title('1 mW/mm^2');
hold on;
plot(c1.t(c1.lstim > 0),zeros(1,sum(c1.lstim > 0)),'r.','MarkerSize',10);
axis([-0.05.*c100.t(end) c100.t(end) 1.1.*min(c100.iopt) 0]);

subplot(1,4,2);
plot(c10.t,c10.iopt);
title('10 mW/mm^2');
hold on;
plot(c10.t(c10.lstim > 0),zeros(1,sum(c10.lstim > 0)),'r.','MarkerSize',10);
axis([-0.05.*c100.t(end) c100.t(end) 1.1.*min(c100.iopt) 0]);

subplot(1,4,3);
plot(c50.t,c50.iopt);
title('50 mW/mm^2');
hold on;
plot(c50.t(c50.lstim > 0),zeros(1,sum(c50.lstim > 0)),'r.','MarkerSize',10);
axis([-0.05.*c100.t(end) c100.t(end) 1.1.*min(c100.iopt) 0]);

subplot(1,4,4);
plot(c100.t,c100.iopt);
title('100 mW/mm^2');
hold on;
plot(c100.t(c100.lstim > 0),zeros(1,sum(c100.lstim > 0)),'r.','MarkerSize',10);
axis([-0.05.*c100.t(end) c100.t(end) 1.1.*min(c100.iopt) 0]);

%% Photocurrent, pulsed
figure();
plot(p40.t,p40.iopt);
hold all;
plot(p40.t(p40.lstim > 0),zeros(1,sum(p40.lstim > 0)),'r.','MarkerSize',10);
axis tight;

%% Peak vs irr
irr = [1 10 50 100];
ip = ([max(abs(c1.iopt)) max(abs(c10.iopt)) max(abs(c50.iopt)) max(abs(c100.iopt))]./max(abs(c100.iopt))).*100; % peak current

figure()
subplot(2,2,1);
semilogx(irr,ip);

iss = ([abs(c1.iopt (c1.t == 300)) abs(c10.iopt (c10.t == 300)) abs(c50.iopt (c50.t == 300)) abs(c100.iopt (c100.t == 300))]./max(abs(c100.iopt))).*100;
subplot(2,2,3);
semilogx(irr,iss);