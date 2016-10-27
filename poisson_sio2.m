function[y] = poisson_sio2(x,h1,h2,dsio2)
ni = 10e10 ; 
q = 1.6e-19 ;
ep = 8.85e-14 ;
si = 11.7 ;
sio2 = 3.9 ;
kT = 25.86e-3*q ;
%h = 1/50*1e-3 ;                   % Make variable later
V = 1;                             % Applied Voltage
constant1 = q*ni*(h2^2)/(ep*si);

y(1) = x(1) - V ;        % Boundary Condition at left electrode
y(2:dsio2-1) = x(3:dsio2) - 2*x(2:dsio2-1) + x(1:dsio2-2);      % No-carrier Poisson equation in SiO2
%y(dsio2) = si/(h2^2)*x(dsio2+1) - 1/h2*(si/h2 + sio2/h1)*x(dsio2) - (q*ni/ep)*exp(38.6*x(dsio2)) + sio2/(h1*h2)*x(dsio2-1);
y(dsio2) = si/(h2^2)*x(dsio2+1) - 1/h2*(si/h2 + sio2/h1)*x(dsio2) + sio2/(h1*h2)*x(dsio2-1); % No free charge
y(length(x)) = x(end);      % Boundary Condition on right end
y(dsio2+1:end-1) = x(dsio2+2:end) + x(dsio2:end-2) - (2*x(dsio2+1:end-1) + constant1*exp(38.6*x(dsio2+1:end-1)));

end
