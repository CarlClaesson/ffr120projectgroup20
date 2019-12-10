function plotDeaths(NDeaths,i,plotname)
time = 1:i;
plot(time,NDeaths);
title(plotname); 
grid on
xlabel('Time Step')
ylabel('Number Of Deaths')
drawnow
end