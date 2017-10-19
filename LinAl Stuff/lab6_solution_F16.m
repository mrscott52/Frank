%%% Math 3353-001/2
%%% Fall 2016
%%% Lab #6: Solutions

diary Barreiro_lab6_diary.txt

%% #1: Define mini-web
A = zeros(7);

% Column by column
A(:,1) = [0 1 1 1 0 0 0];
A(:,2) = [0 0 0 1 1 0 1];
A(:,3) = [1 0 0 1 0 0 1];
A(:,4) = [0 0 0 0 1 1 1];
A(:,5) = [1 0 0 0 0 0 1];
A(:,6) = [0 1 1 1 1 0 1];
A(:,7) = [0 1 0 0 0 1 0];

P = A;
for j=1:7
    % Normalize each column
    P(:,j) = P(:,j)/sum(P(:,j));
end

A
P

%% #2: Crawl the web
X0 = [1;0;0;0;0;0;0];

% Set up an empty matrix
X = zeros(51,7);

Xold = X0;

%Store the initial condition
X(1,:) = X0';

% Iterate
for j=1:50
    % Advance by one time unit
    Xnew =  P*Xold;
    
    % To store, transpose so the result is stored as a row vector
    X(j+1,:) = Xnew';
    
    Xold = Xnew;
end

% Times 1, 2
X(2,:)
X(3,:)

%% #3
% Times 5,10, 20, 50
X(6,:)
X(11,:)
X(21,:)
X(51,:)

%% #4
[V,D] = eig(P);

echo on
%The first column of V corrresponds to the steady state.
echo off

% #4(b)
q = V(:,1);
% Normalize:
q = q/sum(q)

maxPR = find(q==max(q));
minPR = find(q==min(q));

% #4(c)
disp(sprintf('Site %d: ranked 1st: pagerank=%g',maxPR,q(maxPR))); 
disp(sprintf('Site %d: ranked last: pagerank=%g',minPR,q(minPR)));

% #5(a): In-degree
echo on
% In-degree: sum each row
echo off
d_in = sum(A')'

% #5(b): Out-degree
echo on
% Out-degree: sum each column
echo off
d_out = sum(A)'

% #5(c)
[q_sorted,Ivec]=sort(q,'descend');
d_in_sorted = d_in(Ivec);
d_out_sorted = d_out(Ivec);

% Print to your diary:
[q_sorted d_in_sorted d_out_sorted]
echo on
% It looks like having a high "din" is associated with having a high page
% rank.
% So, maybe we should try to increase "din" for 3 by adding an incoming
% connection.
% Let's add a 7->3 connection. Since 7 already has a high page rank, that
% means people will visit 7 frequently. With a 7->3 connection, they
% will now also visit 3...
echo off

% #6  
B = A;
B(3,7)=1;

Q = B;
for j=1:7
    % Normalize each column
    Q(:,j) = Q(:,j)/sum(Q(:,j));
end

echo on
% New matrices B and Q
echo off
B
Q

[VQ,DQ]=eig(Q); qalt = VQ(:,1); qalt=qalt/sum(qalt)

echo on
% Compare old rankings vs. new rankings
echo off
[qalt_sorted,Ivec_alt]=sort(qalt,'descend');
[q_sorted Ivec qalt_sorted Ivec_alt]

maxPRalt = find(qalt==max(qalt));
minPRalt = find(qalt==min(qalt));

disp(sprintf('Site %d: ranked 1st: pagerank=%g',maxPRalt,qalt(maxPRalt))); 
disp(sprintf('Site %d: ranked last: pagerank=%g',minPRalt,qalt(minPRalt)));

disp(sprintf('Site %d: new ranking: pagerank=%g',minPR,qalt(minPR)));

diary off


% This is extra.
%
% Survey all possibilities...
trynew=[];
for i=1:7
    for j=1:7
        % Can I add a connection there? 
        if (j ~= i && A(i,j) == 0)
            B = A;
            B(i,j) = 1;
            Q = B;
            for k=1:7
                % Normalize each column
                Q(:,k) = Q(:,k)/sum(Q(:,k));
            end

            [VQ,DQ]=eig(Q); qalt = VQ(:,1); qalt=qalt/sum(qalt);
            
            [qalt_sorted,Ivec_alt]=sort(qalt,'descend');
            
            trynew = [trynew; i j find(Ivec_alt==minPR) qalt(minPR)];
        end
    end
end
