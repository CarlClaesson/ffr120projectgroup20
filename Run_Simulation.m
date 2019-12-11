function [agents,environment, NDeaths] = Run_Simulation(N, NAgents, Visibility_range,Tax_Rate,Agents, environment)
    currentNAgents = length(Agents);
    for k = 1: currentNAgents
        AgentPositionX = Agents(1,k);
        AgentPositionY = Agents(2,k);
        AgentPositionXInVM = Visibility_range + 1;
        AgentPositionYInVM = Visibility_range + 1;
        Visibility1X = AgentPositionX-Visibility_range;
        Visibility1Y = AgentPositionY-Visibility_range;
        Visibility2X = AgentPositionX+Visibility_range;
        Visibility2Y = AgentPositionY+Visibility_range;
        if(Visibility1X<1)
            AgentPositionXInVM = AgentPositionXInVM - 1 + Visibility1X;
            Visibility1X = 1;
        end
        if(Visibility1Y<1)
            AgentPositionYInVM = AgentPositionYInVM - 1 + Visibility1Y;
            Visibility1Y = 1;
        end
        if(Visibility2X>N)
            Visibility2X = N;
        end
        if(Visibility2Y>N)
            Visibility2Y = N;
        end
        
        Visibility_Matrix = environment(Visibility1X:Visibility2X,Visibility1Y:Visibility2Y);
        for i=1:size(Visibility_Matrix,1) % Makes the visibilty a circle
            for j=1:size(Visibility_Matrix,2)
                if ((i-AgentPositionXInVM)^2+(j-AgentPositionYInVM)^2) > Visibility_range^2
                    Visibility_Matrix(i,j) = 0;
                end 
            end
        end
          
        [TargetX,TargetY] = find(Visibility_Matrix == max(max(Visibility_Matrix)));
        TargetX = TargetX+Visibility1X-1;
        TargetY = TargetY+Visibility1Y-1;
       
        r = rand;
        if r < 0.5
            if  TargetX - Agents(1,k) ~= 0
                Agents(1,k) = Agents(1,k) + sign(TargetX - Agents(1,k));
            else
                Agents(2,k) = Agents(2,k) + sign(TargetY - Agents(2,k));
            end
        else
            if  TargetY - Agents(2,k) ~= 0
                Agents(2,k) = Agents(2,k) + sign(TargetY - Agents(2,k));
            else
                Agents(1,k) = Agents(1,k) + sign(TargetX - Agents(1,k));
            end
        end
%         Not working as intended right now
%         Position_Sign = sign([TargetX;TargetY]-Agents(1:2,k));
%         Next_Position = [Agents(1,k)+Position_Sign(1),Agents(1,k);Agents(2,k),Agents(2,k)+Position_Sign(2);environment(Agents(1,k)+Position_Sign(1)),environment(Agents(2,k)+Position_Sign(2))];
%         [~,Next_Order] = find(Next_Position == max(Next_Position(3,:)));
%         NextX = Next_Position(1,Next_Order);
%         NextY = Next_Position(2,Next_Order);
%         Agents(1,k) = NextX(1); % Bug: Sometimes NextX has 2 values, that why we choose index 1
%         Agents(2,k) = NextY(1); % Bug: Sometimes NextY has 2 values, that why we choose index 1
    end
    
    Taxes = 0.0;
    %Collect_Order = randperm(NAgents); %random Collection order
    [~,idx] = sort(Agents(3,:));
    Agents = Agents(:,idx);
    Collect_Order = currentNAgents:-1:1;  % Richer collects first since it is sorted according to least wealth
    for m=1:currentNAgents
        Agents(3,Collect_Order(m)) = Agents(3,Collect_Order(m))+(1-Tax_Rate)*Agents(5,Collect_Order(m))*environment(Agents(1,Collect_Order(m)),Agents(2,Collect_Order(m)));
        Taxes = Taxes + Tax_Rate*Agents(5,Collect_Order(m))*environment(Agents(1,Collect_Order(m)),Agents(2,Collect_Order(m)));
        environment(Agents(1,Collect_Order(m)),Agents(2,Collect_Order(m))) = (1-Agents(5,Collect_Order(m)))*environment(Agents(1,Collect_Order(m)),Agents(2,Collect_Order(m)));
    end
    
    %Distribute_Taxes
    for i = 1:currentNAgents/4
        Agents(3,i) = Agents(3,i) + Taxes/(currentNAgents/4);
    end
    %Make agent consume suger (Metabolic rate)
    Agents(3,:) = max(0,(Agents(3,:) - Agents(4,:)));
    %disp(max(Agents(3,:)))
    %disp(min(Agents(3,:)))
    
    %Kill agents with zero 
    killList = find(Agents(3,:) == 0);
    if ~isempty(killList)
        for i =1:killList
            Agents(:,i) = [];
        end
    end
    currentNAgents = length(Agents);
    NDeaths = NAgents - currentNAgents;
    %Classify the agents
%     richestPerson = max(Agents(3,:));
%     for idx = 1:length(Agents)
%         if(Agents(3,idx)>0.7*richestPerson)
%             Agents(6,idx)=2;   
%         else
%             if(Agents(3,idx)>0.3*richestPerson)
%                 Agents(6,idx)=1;
%             else
%                 Agents(6,idx)=0;
%             end
%         end
%     end
    
    %Classify Agents (Diffrent approch)
    averageWealth = sum(Agents(3,:))/length(Agents(3,:));
    for idx = 1:length(Agents)
        if(Agents(3,idx)>3*averageWealth)
            Agents(6,idx)=2;   
        else
            if(Agents(3,idx)<0.7*averageWealth)
                Agents(6,idx)=0;
            else
                Agents(6,idx)=1;
            end
        end
    end
    agents = Agents;
end

