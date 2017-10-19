%%% Math 3353-001/2
%%% Fall 2016
%%% Lab #5: Solutions, with Optional plots

% #1: Setup
r = 0.05; z = 0.3; k=0.1;

A = [-r 0 0 0; r -z 0 0; 0 z -k 0; 0 0 k 0];

P  = eye(4) + A;



% Initial conditions
X0 = [0.999;0.001;0;0];

% Set up an empty matrix
X = zeros(4,29);

Xold = X0;

%Store the initial condition
X(:,1) = X0';

% Iterate
for j=1:28
    % Advance by one time unit
    Xnew =  P*Xold;
    
    % To store, transpose so the result is stored as a row vector
    X(:,j+1) = Xnew';
    
    Xold = Xnew;
end

echo on
% For your diary
% 1(a)
echo off
P

echo on
% 1(b): print X(n+1,:) for n=7,14,28
echo off
X(:,8)
X(:,15)
X(:,29)

echo on
% 1(c): Optional: plotting
echo off

figure;plot([0:28],X');
% To make the figure more readable 
set(gca,'FontSize',16);
legend('Susceptible (S)','Infected (I)', 'Zombie (Z)', 'Dead (D)');
xlabel('Time (days)');
ylabel('%% of population')

echo on
% #2a: DFW 
echo off

N = 6.7e6;
X0_2a = [1-1/N;1/N;0;0];

%% Same sequence of commands as in #1
% Set up an empty matrix
X_2a = zeros(4,29);

Xold = X0_2a;

%Store the initial condition
X_2a(:,1) = X0_2a;

% Iterate
for j=1:28
    % Advance by one time unit
    Xnew =  P*Xold;
    
    % To store, transpose so the result is stored as a row vector
    X_2a(:,j+1) = Xnew';
    
    Xold = Xnew;
end

% FOR YOUR DIARY
echo on
% #2a: DFW
echo off
X_2a(:,8)
X_2a(:,15)
X_2a(:,29)

echo on
% #2b: Edom 
echo off

N = 373;
X0_2b = [1-1/N;1/N;0;0];

%% Same sequence of commands as in #1
% Set up an empty matrix
X_2b = zeros(4,29);

Xold = X0_2b;

%Store the initial condition
X_2b(:,1) = X0_2b';

% Iterate
for j=1:28
    % Advance by one time unit
    Xnew =  P*Xold;
    
    % To store, transpose so the result is stored as a row vector
    X_2b(:,j+1) = Xnew';
    
    Xold = Xnew;
end

% FOR YOUR DIARY
echo on
% #2b: Edom
echo off
X_2b(:,8)
X_2b(:,15)
X_2b(:,29)

% #2: Optional: plotting
figure;plot([0:28],X_2a');
hold on;
plot([0:28],X_2b','--');

% To mke the figure more readable 
set(gca,'FontSize',16);
legend('DFW: Susceptible (S)','DFW: Infected (I)', 'DFW: Zombie (Z)', 'DFW: Dead (D)',...
    'Edom: Susceptible (S)','Edom: Infected (I)', 'Edom: Zombie (Z)', 'Edom: Dead (D)');
xlabel('Time (days)');
ylabel('% of population');

echo on
% #3a
% Set z large (here z = 0.99)
echo off

r = 0.05; z = 0.99; k=0.1;

A_3a = [-r 0 0 0; r -z 0 0; 0 z -k 0; 0 0 k 0];

P_3a = eye(4) + A_3a;
% Initial conditions
X0 = [0.999;0.001;0;0];

% Set up an empty matrix
X_3a = zeros(4,29);

Xold = X0;

%Store the initial condition
X_3a(:,1) = X0;

% Iterate
for j=1:28
    % Advance by one time unit
    Xnew =  P_3a*Xold;
    
    % To store, transpose so the result is stored as a row vector
    X_3a(:,j+1) = Xnew;
    
    Xold = Xnew;
end


% FOR YOUR DIARY
echo on
% #3a: 28 Days Later
echo off
% 3a: print X(n+1,:) for n=7,14,28
X_3a(:,8)
X_3a(:,15)
X_3a(:,29)

% 3a: Optional: plotting
figure;plot([0:28],X_3a');
% To mke the figure more readable 
set(gca,'FontSize',16);
legend('Susceptible (S)','Infected (I)', 'Zombie (Z)', 'Dead (D)');
xlabel('Time (days)');
ylabel('% of population');
title('Progression of the zombie virus: 28 days later');

echo on
% #3b
% Set r small (here, r = 0.011)
echo off

r = 0.011; z = 0.3; k=0.1;

A_3b = [-r 0 0 0; r -z 0 0; 0 z -k 0; 0 0 k 0];

P_3b = eye(4) + A_3b;
% Initial conditions
X0 = [0.999;0.001;0;0];

% Set up an empty matrix
X_3b = zeros(4,29);

Xold = X0;

%Store the initial condition
X_3b(:,1) = X0;

% Iterate
for j=1:28
    % Advance by one time unit
    Xnew =  P_3b*Xold;
    
    % To store, transpose so the result is stored as a row vector
    X_3b(:,j+1) = Xnew;
    
    Xold = Xnew;
end

% FOR YOUR DIARY
echo on
% #3b: Walking Dead
echo off
% 3a: print X(n+1,:) for n=7,14,28
X_3b(:,8)
X_3b(:,15)
X_3b(:,29)

% 3b: Optional: plotting
figure;plot([0:28],X_3b');
% To mke the figure more readable 
set(gca,'FontSize',16);
legend('Susceptible (S)','Infected (I)', 'Zombie (Z)', 'Dead (D)');
xlabel('Time (days)');
ylabel('% of population');
title('Progression of the zombie virus: Walking Dead');


% #4
echo on
% #4: Steady-state: everyone is dead
echo off
q_guess = [0;0;0;1];

echo on 
% 4a: Guess the equilibrium vector, q
echo off
q_guess

echo on 
% 4a: Confirm: P*q
echo off
P*q_guess

echo on 
% 4b: Confirm: Use "null"
echo off
null([P-eye(4)],'r')

echo on
% #5
echo off

r = 0.05; z = 0.3; k=0.1; b=0.01;
A_5 = [-r 0 0 b; r -z 0 0; 0 z -k 0; 0 0 k -b];

P_5  = eye(4) + A_5;

% #5a
echo on
% #5(a): show P_5 is a stochastic matrix
% P_5^2: still has zero entries
echo off
P_5^2
echo on
% P_5^3: all entries non-zero. Therefore P_5 is a stochastic matrix.
echo off
P_5^3


echo on
% #5b
% Use null(P-I) to get steady state q
%   (don't forget to normalize: divide by "sum"
echo off

temp=null(A_5,'r');
q5  = temp/sum(temp)

echo on
% #5c
%Repeat "28 Days Later", 3a
% Set z large (z = 0.99)
echo off

r = 0.05; z = 0.99; k=0.1; b=0.01;

A_5c = [-r 0 0 b; r -z 0 0; 0 z -k 0; 0 0 k -b];

P_5c = eye(4) + A_5c;
% Initial conditions
X0 = [0.999;0.001;0;0];

% Set up an empty matrix
X_5c = zeros(4,29);

Xold = X0;

%Store the initial condition
X_5c(:,1) = X0;

% Iterate
for j=1:28
    % Advance by one time unit
    Xnew =  P_5c*Xold;
    
    % To store, transpose so the result is stored as a row vector
    X_5c(:,j+1) = Xnew;
    
    Xold = Xnew;
end

% FOR YOUR DIARY
echo on
% #5c: 28 Days Later, with births
echo off
% 5c: print X(n+1,:) for n=7,14,28
X_5c(:,8)
X_5c(:,15)
X_5c(:,29)

% 5c (Redo of 3a): Optional: plotting
figure;plot([0:28],X_3a');hold on;
plot([0:28],X_5c','--');
% To mke the figure more readable 
set(gca,'FontSize',16);
legend('Susceptible (S)','Infected (I)', 'Zombie (Z)', 'Dead (D)',...
    'Susceptible (S), b > 0','Infected (I), b > 0', 'Zombie (Z), b > 0', 'Dead (D),b > 0');
xlabel('Time (days)');
ylabel('% of population');
title('Progression of the zombie virus: 28 days later w/ positive birth rate');





