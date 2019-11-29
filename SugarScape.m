%% 
clear all
clc
N = 100;
NAgents = 100;
Visibility_range = 5; %The visibility is right now a square, change to circle later?
Agents = [round(unifrnd(1,N,2,NAgents));zeros(1,NAgents)]; %Every column represent an Agent. First row: position x, Second row: position in y, Third row: wealth.
Collection_Rate = 0.5;
Regrow_Rate = 0.5;
environment = unifrnd(0,1,N,N);
%%
for i = 1:1000
    Agents = Run_Simulation(N, NAgents, Visibility_range, Agents, Collection_Rate, Regrow_Rate, environment);
    disp(Agents(3,1:10)) % Temporary displaying the wealth of the 10 first agents every time step.
end    
