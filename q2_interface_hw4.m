% Poisson Solver for Carrier Density in Intrinsic Silicon

%% Define Constants
dsi = 10e-4 ;                      % In cm
dsio2 = 5e-7 ;
hsi = dsi/50 ;
hsio2 = dsio2/10 ;
V = 1 ;
domain_si = (dsio2 + hsi):hsi:(dsi + dsio2) ;
domain_sio2 = 0:hsio2:dsio2 ;
domain = [domain_sio2 domain_si] ;

dl2 = length(domain_si) ;              % Lengths 
dl  = length(domain_sio2) ;            % Lengths + 1

sol_lin = V-V/(dsi + dsio2)*domain ;   % Assumed inital linear solution            
input = sym('X',[1 (dl2+dl)]) ;        % Define variables of interest

Y = poisson_sio2(input,hsio2,hsi,dl) ;    % Obtain the system of equations


%% Solving for the initial value

J_equ = jacobian(Y,input);              % Construct general Jacobian for 'input'
J = subs(J_equ, input, sol_lin);        % Substitute inital guess i.e. linear solution
F = -1*(subs(Y, input, sol_lin));       % Evaluate functions at initial guess
num_F = cast(F, 'double');
num_J = cast(J, 'double'); 
x = num_J\num_F' + sol_lin';            % Next value of roots

check = (num_F > 1e-10) | (num_F < -1e-10) ;    % Iterate only if atleast one '1' is present

%% Begin iterating

 while ~(isempty(check(check==1)))
 drawnow
 plot(domain,x,domain,sol_lin,'r--');
 xlabel('Distance');
 ylabel('Potential');
 
 J = subs(J_equ, input, x') ;
 F = -1*(subs(Y, input, x')) ;
 num_F = cast(F, 'double') ;
 num_J = cast(J, 'double') ;
 x = num_J\num_F' + x ;
 check = (num_F > 1e-10) | (num_F < -1e-10) ;    
 end

%%
title('DONE!')
plot(domain,x,domain,sol_lin,'r--');
xlabel('Distance');
ylabel('Potential');