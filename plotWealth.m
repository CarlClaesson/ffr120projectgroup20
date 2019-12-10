function plotWealth(richClass,mediumClass,lowClass,timeStep)
time = 1:timeStep;
        
plot(time,richClass,'Color','blue')
hold on;
plot(time,mediumClass,'Color','green')
plot(time,lowClass,'Color','red')
hold off;
end
