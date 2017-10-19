%%% Math 3353-001/2
%%% Fall 2016
%%% Lab #7: Extra Credit

diary Barreiro_lab7_diary.txt

echo on
% #1 Load the data
echo off
load ../lab7_data.mat

echo on
% #1
echo off
size(V)
size(Fv)


echo on
% Demonstration of "element-wise" arithmetic operations
% You will use these when constructing your matrix "A" for the normal
% equations
echo off

echo on
% #2 Fit to a line
% Use the normal equations
echo off
A2 = [ones(size(V)) V];

A2TA2 = A2'*A2;
A2Tb  = A2'*Fv;

xhat = A2TA2\A2Tb;

Cline  = xhat(1)
Dline  = xhat(2)

echo on
% #3 Find error of linear approximation
echo off

yhat2 = A2*xhat;
E_Linear = sum((Fv-yhat2).^2)/length(V)

echo on
% #4a  Fit to a parabola
% Again, use the normal equations
% Add one more column to A, corresponding to V^2
echo off
A4 = [A2 V.^2];

A4TA4 = A4'*A4;
A4Tb  = A4'*Fv;

xhat  = A4TA4\A4Tb;

Cquad = xhat(1)
Dquad = xhat(2)
Equad = xhat(3)

echo on
% #4b Find a, Vthr, Vrest
%   One way to do this: Vrest, Vthr are the roots of the polynomial.
%   Use the quadratic formula to find the roots of C + DV + EV^2.
%   Then a=E
echo off
Vrest       = (-Dquad - sqrt(Dquad^2 - 4*Cquad*Equad))/(2*Equad)
Vthr        = (-Dquad + sqrt(Dquad^2 - 4*Cquad*Equad))/(2*Equad)
a           = Equad

echo on
% #4c Find error of quadratic approximation
echo off
yhat4  = A4*xhat;
E_Quad = sum((Fv-yhat4).^2)/length(V)


echo on
% #5  Fit to a cubic function
% Again, use the normal equations
% Add one more scolumn to A, corresponding to V^3
echo off
A5 = [A4 V.^3];

A5TA5 = A5'*A5;
A5Tb  = A5'*Fv;

xhat  = A5TA5\A5Tb;

Ccubic = xhat(1)
Dcubic = xhat(2)
Ecubic = xhat(3)
Gcubic = xhat(4)

yhat5  = A5*xhat;
E_Cubic = sum((Fv-yhat5).^2)/length(V)


figure;
plot(V,Fv,'.');hold on;set(gca,'FontSize',16);
plot(V,yhat2,'.','LineWidth',2);
plot(V,yhat4,'.','LineWidth',2);
plot(V,yhat5,'.','LineWidth',2);
legend('Data','Linear Fit','Quadratic Fit','Cubic Fit');
axis([-74,-30,-15,10]);grid;

diary off
