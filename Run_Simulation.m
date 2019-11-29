function f = Run_Simulation(N, NAgents, Visibility_range, Agents, Collection_Rate, Regrow_Rate, environment)
    environment = environment+unifrnd(0,1*Regrow_Rate,N,N);
    for k = 1: NAgents
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
        
        Position_Sign = sign([TargetX;TargetY]-Agents(1:2,k));
        Next_Position = [Agents(1,k)+Position_Sign(1),Agents(1,k);Agents(2,k),Agents(2,k)+Position_Sign(2);environment(Agents(1,k)+Position_Sign(1)),environment(Agents(2,k)+Position_Sign(2))];
        [~,Next_Order] = find(Next_Position == max(Next_Position(3,:)));
        NextX = Next_Position(1,Next_Order);
        NextY = Next_Position(2,Next_Order);
        Agents(1,k) = NextX(1); % Bug: Sometimes NextX has 2 values, that why we choose index 1
        Agents(2,k) = NextY(1); % Bug: Sometimes NextY has 2 values, that why we choose index 1
    end
    
    Collect_Order = randperm(NAgents);
    for m=1:NAgents
        Agents(3,Collect_Order(m)) = Agents(3,Collect_Order(m))+Collection_Rate*environment(Agents(1,Collect_Order(m)),Agents(2,Collect_Order(m)));
        environment(Agents(1,Collect_Order(m)),Agents(2,Collect_Order(m))) = (1-Collection_Rate)*environment(Agents(1,Collect_Order(m)),Agents(2,Collect_Order(m)));
    end
    f = Agents;
end

