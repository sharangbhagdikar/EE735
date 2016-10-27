function[y] = poisson_q2(x,h)
ni = 10e10 ; 
q = 1.6e-19 ;
ep = 8.85e-14 ;
si = 11.7 ;
sio2 = 3.9 ;
kT = 25.86e-3*q ;
%h = 1/50*1e-3 ;                   % Make variable later
V = 400e-3 ;                      % Applied Voltage
constant1 = q*ni*(h^2)/(ep*si);


y(1) = x(1) - V;
y(length(x)) = x(end);
y(2:end-1) = x(3:end) + x(1:end-2) - (2*x(2:end-1) + constant1*exp(38.6*x(2:end-1)));

end
