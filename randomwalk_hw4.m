%% Random Walk based Simulation for Heat/Diffusion Equation

%% Define constants
D = 1e-3 ;
dt = 2.5e-10 ;      
dx = 10e-7 ;
prob = D*dt/dx^2;
domain = 0:dx:1e-3 ;
len = length(domain) ;
N = 500 ;

particle = zeros(1,len) ;       % Stores the number of particles in each domain
particle((len-1)/2) = N ;              % 
probm = zeros(len,3);           % Stores particles staying put(1),coming from left(2) and right(3)
%% Begin iterating for 1000 time intants
for t = 0:1000
    
for i = 1:len
    % Will need condition check if boundary conditions are to be included
    a = rand(1,particle(i));                              % Create a random array from 1 to 4
    probm(i,1) = length(a(a>=prob & a<=1-prob)) ;         % Condition for 1/2 prob 
    if (i ~= 1)
        probm(i-1,3) = length(a(a<prob)) ;            % Particle from right at 3
        particle(i-1) = sum(probm(i-1,:)) ;           % probm(i-1) is already filled, thus compute sum
    end
    if (i ~= len)    
        probm(i+1,2) = length(a(a>1-prob)) ;        % Particle from left at 2
    else
        particle(i) = sum(probm(i,:)) ;         % Last particle, hence compute sum
    end    
end
    if(mod(t,10) == 0)
        plot(domain,particle);
        hold on
    end
end
%% End
xlabel('Distance');
ylabel('Concentration of Particles');
