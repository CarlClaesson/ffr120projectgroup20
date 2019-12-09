%% 
clear all
clc
N = 100;
NAgents = 100;
Visibility_range = 5; %The visibility is right now a square, change to circle later?
Agents = [round(unifrnd(1,N,2,NAgents));zeros(1,NAgents)]; %Every column represent an Agent. First row: position x, Second row: position in y, Third row: wealth.
Collection_Rate = 0.8;
Regrow_Rate = 0.01;
environment = unifrnd(0,1,N,N);

fig = figure;
filename = sprintf('agentsEvolution.gif');
%%
for i = 1:1000
    [Agents,environment] = Run_Simulation(N, NAgents, Visibility_range, Agents, Collection_Rate, Regrow_Rate, environment);
   
    Map = imagesc(environment,[0.0 1.0]);
    hold on;
    Wealth = scatter(Agents(1,:),Agents(2,:),[],Agents(3,:),'filled');
    hold off;
    axis ([1 100 1 100])
    title(['Agents Evolution']) 
    drawnow;
    
    frame = getframe(fig);
    im = frame2im(frame);
    [imind1,cm]=rgb2ind(im,256);
    
    if i==1
        imwrite(imind1,cm,filename,'gif','Loopcount',inf);
    else
        imwrite(imind1,cm,filename,'gif','WriteMode','append');
    end
end    
