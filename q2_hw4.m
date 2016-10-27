% Poisson Solver for Carrier Density in Intrinsic Silicon

%% Define Constants
dlen = 10e-4 ;                      % In cm
h = dlen/50 ;
V = 400e-3 ;
domain = 0:h:dlen ;
dl = length(domain) ;
sol_lin = (V:-V/50:0) ;             % Assumed inital linear solution            
input = sym('X',[1 dl]) ;           % Define variables of interest
Y = poisson_q2(input,h) ;           % Obtain the system of equations

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
J = subs(J_equ, input, x') ;
F = -1*(subs(Y, input, x')) ;
num_F = cast(F, 'double') ;
num_J = cast(J, 'double') ;
x = num_J\num_F' + x ;
check = (num_F > 1e-10) | (num_F < -1e-10) ;    
end

%%
plot(domain,x,domain,sol_lin,'r--');
xlabel('Distance');
ylabel('Potential');