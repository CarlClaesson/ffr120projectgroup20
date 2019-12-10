function plotDifference(lowClassResources,highClassResources,plotname)
time = 1:length(lowClassResources);
plot(time,highClassResources-lowClassResources);
title(plotname)
grid on;
xlabel('Time Step');
ylabel('Wealth Difference');
drawnow;
end
