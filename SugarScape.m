%% 
clear all
clc
N = 100;
NAgents = 1000;
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
% Collection_Rate, sixth row is class
Agents = [round(unifrnd(1,N,2,NAgents));ones(1,NAgents); Metabolic_rate_vector; Collection_rate_vector; zeros(1,NAgents)]; 
Regrow_Rate = 0.02;
Tax_Rate =0.3;

numberOfPatches = 4;
xSpots = randi(N,numberOfPatches,1);
ySpots = randi(N,numberOfPatches,1);
environment = zeros(N);
position = 3; %Represent the position of the environment [2,3]
environment = landscapeGrowingGaussian(N,xSpots,ySpots,numberOfPatches,environment,position);   
initialEnvironment = environment;

fig = figure;
filename = sprintf('agentsEvolution.gif');
plotname = sprintf('Class classification V=%d; A=%d',Visibility_range,NAgents);
%%
for i = 1:10000
    if(mod(i,10000)==0) %Moves patches outside of matrix for long simulations, temporary disabled
        position = position-1/100; %Represent the position of the environment [2,3]
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
    
    if(mod(i,100)==0) 
        plotWealth(richClass,mediumClass,lowClass,i,plotname);
    end
   %disp(NDeaths)
   %plotname = sprintf('Class classification V=%d; A=%d\n T=%d',Visibility_range,NAgents,i); %Just for the GIF
   %plotEvolution(Agents,environment,filename,plotname,fig,i); 
   %vectorDeaths(i) = NDeaths;
   %plotDeaths(vectorDeaths,i,plotname);
   %Just to calculate the difference between classes
    k = find(Agents(6,:)==0);
    lowClassResources(i) = mean(Agents(3,k));
    k = find(Agents(6,:)==2);
    highClassResources(i) = mean(Agents(3,k));
    %plotDifference(lowClassResources,highClassResources,plotname); 
    
end  
AverageWealth = sum(Agents(3,:))/length(Agents(3,:));
MedianWealth = median(Agents(3,:));
plotHistogram(Agents(3,:), AverageWealth, MedianWealth)
