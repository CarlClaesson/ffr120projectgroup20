%% 
clear all
clc
N = 100;
NAgents = 100;
Visibility_range = 3;

Lower_Limit_Metabolic_Rate = 0.2;
Upper_Limit_Metabolic_Rate = 0.4;
Metabolic_rate_vector = (Upper_Limit_Metabolic_Rate-Lower_Limit_Metabolic_Rate).*rand(1,NAgents)...
    + Lower_Limit_Metabolic_Rate;

Lower_Limit_Collection_Rate = 0.6;
Upper_Limit_Collection_Rate = 0.9;
Collection_rate_vector = (Upper_Limit_Collection_Rate-Lower_Limit_Collection_Rate).*rand(1,NAgents)...
    + Lower_Limit_Collection_Rate;

% Position in y seems to be be first row and position in x seems to be
% second row for some reason, atleast when plotting with scatter.
%Every column represent an Agent. First row: position x, Second row:
%position in y, Third row: wealth. Forth row: metabolic rate, Fith row:
% Collection_Rate
Agents = [round(unifrnd(1,N,2,NAgents));zeros(1,NAgents); Metabolic_rate_vector; Collection_rate_vector]; 

Regrow_Rate = 0.01;

numberOfPatches = 4;
xSpots = randi(N,numberOfPatches,1);
ySpots = randi(N,numberOfPatches,1);
environment = zeros(N);
environment = landscapeGrowing(N,xSpots,ySpots,numberOfPatches,environment);   
initialEnvironment = environment;

fig = figure;
filename = sprintf('agentsEvolution.gif');
%%
for i = 1:1000
    environment = environment+Regrow_Rate*landscapeGrowing(N,xSpots,ySpots,numberOfPatches,environment);
    for idx1 = 1:N
        for idx2 = 1:N
            if(environment(idx1,idx2)>initialEnvironment(idx1,idx2))
                environment(idx1,idx2) = initialEnvironment(idx1,idx2);
            end
        end
    end
    
    [Agents,environment] = Run_Simulation(N, NAgents, Visibility_range, Agents, environment);
    
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
