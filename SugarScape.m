%% 
clear all
clc
N = 100;
NAgents = 100;
Visibility_range = 3;

Lower_Limit_Metabolic_Rate = 0.01;
Upper_Limit_Metabolic_Rate = 0.1;
Metabolic_rate_vector = (Upper_Limit_Metabolic_Rate-Lower_Limit_Metabolic_Rate).*rand(1,NAgents)...
    + Lower_Limit_Metabolic_Rate;

Lower_Limit_Collection_Rate = 0.1;
Upper_Limit_Collection_Rate = 0.9;
Collection_rate_vector = (Upper_Limit_Collection_Rate-Lower_Limit_Collection_Rate).*rand(1,NAgents)...
    + Lower_Limit_Collection_Rate;

% Position in y seems to be be first row and position in x seems to be
% second row for some reason, atleast when plotting with scatter.
%Every column represent an Agent. First row: position x, Second row:
%position in y, Third row: wealth. Forth row: metabolic rate, Fith row:
% Collection_Rate, sixth 
Agents = [round(unifrnd(1,N,2,NAgents));10.*ones(1,NAgents); Metabolic_rate_vector; Collection_rate_vector; zeros(1,NAgents)]; 
Regrow_Rate = 0.01;
Tax_Rate =0.1;

numberOfPatches = 4;
xSpots = randi(N,numberOfPatches,1);
ySpots = randi(N,numberOfPatches,1);
environment = zeros(N);
position = 3; %Represent the position of the environment [2,3]
environment = landscapeGrowingGaussian(N,xSpots,ySpots,numberOfPatches,environment,position);   
initialEnvironment = environment;

fig = figure;
filename = sprintf('agentsEvolution.gif');
plotname = sprintf('Agents Evolution for V=%d; A=%d',Visibility_range,NAgents);
%%
for i = 1:1000
    if(mod(i,100)==0)
        position = position-1/10; %Represent the position of the environment [2,3]
        auxEnvironment = landscapeGrowingGaussian(N,xSpots,ySpots,numberOfPatches,environment,position);   
        initialEnvironment = auxEnvironment;
    end
    environment = environment+Regrow_Rate*landscapeGrowingGaussian(N,xSpots,ySpots,numberOfPatches,environment,position);
    for idx1 = 1:N
        for idx2 = 1:N
            if(environment(idx1,idx2)>initialEnvironment(idx1,idx2))
                environment(idx1,idx2) = initialEnvironment(idx1,idx2);
            end
        end
    end
    
    [Agents,environment, NDeaths] = Run_Simulation(N, NAgents, Visibility_range, Tax_Rate, Agents, environment);
    
    richClass(i) = sum(Agents(6,:)==2);
    mediumClass(i) = sum(Agents(6,:)==1);
    lowClass(i) = sum(Agents(6,:)==0);
    
   plotWealth(richClass,mediumClass,lowClass,i)
   disp(NDeaths)
   % plotEvolution(Agents,environment,filename,plotname,fig)   
end    
