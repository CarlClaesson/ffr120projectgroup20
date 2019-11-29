%% 
clear all
clc

%%
N = 100;
NAgents = 100;
Visibility_range = 10;
Agents = [round(unifrnd(1,N,2,NAgents));zeros(1,NAgents)];
Collection_Rate = 0.5;
% environment = zeros(N+2*Visibility_range,N+2*Visibility_range);

environment = zeros(N,N);
%%
for i = 1:1000
    environment = environment+unifrnd(0,1,N,N);
    for k = 1: NAgents
        Visibility1X = Agents(1,k)-Visibility_range;
        Visibility1Y = Agents(2,k)-Visibility_range;
        Visibility2X = Agents(1,k)+Visibility_range;
        Visibility2Y = Agents(2,k)+Visibility_range;
        if(Visibility1X<1)
            Visibility1X = 1;
        end
        if(Visibility1Y<1)
            Visibility1Y = 1;
        end
        if(Visibility2X>N)
            Visibility2X = N;
        end
        if(Visibility2Y>N)
            Visibility2Y = N;
        end
        
        Visibility_Matrix = environment(Visibility1X:Visibility2X,Visibility1Y:Visibility2Y);
        
        [TargetX,TargetY] = find(Visibility_Matrix == max(max(Visibility_Matrix)));
        TargetX = TargetX+Visibility1X-1;
        TargetY = TargetY+Visibility1Y-1;
        
        Position_Sign = sign([TargetX;TargetY]-Agents(1:2,k));
        Next_Position = [Agents(1,k)+Position_Sign(1),Agents(1,k);Agents(2,k),Agents(2,k)+Position_Sign(2);environment(Agents(1,k)+Position_Sign(1)),environment(Agents(2,k)+Position_Sign(2))];
        [~,Next_Order] = find(Next_Position == max(Next_Position(3,:)));
        NextX = Next_Position(1,Next_Order);
        NextY = Next_Position(2,Next_Order);     
    end
    
    Collect_Order = randperm(NAgents);
    for m=1:NAgents
        Agents(3,Collect_Order(m)) = Agents(3,Collect_Order(m))+Collection_Rate*environment(Agents(1,Collect_Order(m)),Agents(2,Collect_Order(m)));
        environment(Agents(1,Collect_Order(m)),Agents(2,Collect_Order(m))) = (1-Collection_Rate)*environment(Agents(1,Collect_Order(m)),Agents(2,Collect_Order(m)));
    end
    
end    

