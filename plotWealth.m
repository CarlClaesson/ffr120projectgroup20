function plotWealth(richClass,mediumClass,lowClass,timeStep,plotname)
time = 1:timeStep;
        
plot(time,richClass,'Color','blue')
hold on;
plot(time,mediumClass,'Color','green')
plot(time,lowClass,'Color','red')
hold off;
title(plotname);
grid on
legend('High','Medium','Low')
legend boxoff
xlabel('Time Iterations')
ylabel('Number of Agents')
drawnow;
end
