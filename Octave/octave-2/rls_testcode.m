% Testfile for rls_const
% 2016/6/28 Yoshi Ri
% 
% yn = -a1 * yn-1 - a2 * yn-2 + b1 * un-1 + b2 + un-1;
% solve a1 a2 b1 b2
% from sequence of yn and un
%

clear all;
close all;
clc;

%% answer
a1 = -1.5;
a2 = 0.7;
b1 = 1.0;
b2 = 0.5;
Answer = [a1,a2,b1,b2];

%% setup
Len = 100;
Signal = 1;
Noise = 0.1;
n = 2;

x = zeros(Len,1);
v = Noise * (rand(Len,1) - 0.5);
u = Signal * rand(Len,1);
est = zeros(Len,4);

%% estimation
Est_0 = zeros(2*n,1);
% In this case we have 2 dim
estimater = rls_const(2,0.99);
% If you want, you can set your original initial value for estimation
estimater.reinitialize(zeros(2*n,1),1000*eye(2*n),0.99);


% prepare for the simulation 
x(1) = 0; x(2) = 0;
y(1:2) = x(1:2) + v(1:2);
% estimation step
for i = 3:Len
    % calculate output from input
    x(i) = - a1 * x(i-1) - a2 * x(i-2) + b1 * u(i-1) + b2 * u(i-2);
    y(i) = x(i) + v(i);
    % The val pushed to the RLS estimater
    Zn = [-y(i-1); -y(i-2); u(i-1); u(i-2)];
    Yn = [y(i)];
    % Estimation
    Theta = estimater.estimate(Yn,Zn);
    est(i,:) = Theta' ;
end

%%
plot(est);
hold on;
plot(repmat(Answer,[ Len,1]),'--');
legend('a1','a2','b1','b2','a1*','a2*','b1*','b2*');
