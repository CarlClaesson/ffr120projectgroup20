%% 
clear all
clc
N = 100;
NAgents = 100;
Visibility_range = 3;
Lower_Limit_Metabolic_Rate = 0.1;
Upper_Limit_Metabolic_Rate = 0.2;
Metabolic_rate_vector = (Upper_Limit_Metabolic_Rate-Lower_Limit_Metabolic_Rate).*rand(1,NAgents) + Lower_Limit_Metabolic_Rate;
% Position in y seems to be be first row and position in x seems to be
% second row for some reason, atleast when plotting with scatter.
Agents = [round(unifrnd(1,N,2,NAgents));zeros(1,NAgents); Metabolic_rate_vector]; %Every column represent an Agent. First row: position x, Second row: position in y, Third row: wealth.
Collection_Rate = 0.8;
Regrow_Rate = 0.01;
environment = unifrnd(0,1,N,N);
fig = figure;
filename = sprintf('agentsEvolution.gif');
%%
for i = 1:10000
    environment = environment+unifrnd(0,1*Regrow_Rate,N,N);
    [Agents,environment] = Run_Simulation(N, NAgents, Visibility_range, Agents, Collection_Rate, environment);
    Map = imagesc(environment,[0.0 1.0]);
    colormap(autumn()) 
    freezeColors
    hold on;
    Normalize = max(Agents(3,:));
    Wealth = scatter(Agents(2,:),Agents(1,:),[],Agents(3,:)/Normalize,'filled');
    colormap(winter())
    hold off;
    axis ([1 100 1 100])
    title(['Agents Evolution'])
    %colorbar
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
