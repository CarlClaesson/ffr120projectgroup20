function plotHistogram(Wealth, AverageWealth, MedianWealth, Death_Rate, Tax_rate, NAgents)
% Calculate Death_Rate by: ((NAgents - length(Agents))/NAgents) in SugerScape file when calling this method
close all
hax=axes; 
h = histogram(Wealth, 50);
h.FaceColor = [0.3010 0.7450 0.9330];
xlabel('Units of Sugar','FontSize', 14)
ylabel('Number of Agents', 'FontSize', 14)
pbaspect([1 1 1])
NAgentsString = sprintf('%.0f',NAgents);
taxRateString = sprintf('%.0f',Tax_rate*100);
DeathRateString = sprintf('%.0f',Death_Rate*100);

title(join(['Wealth Distribution ', NAgentsString,' Agents, Tax rate: ',taxRateString,'%, Death rate: ', DeathRateString,'%']));
hold on
x1 = xline(AverageWealth,'--k', 'Average Wealth', 'LineWidth', 2);
x1.LabelVerticalAlignment = 'top';
x1.LabelOrientation = 'horizontal';
x2 = xline(MedianWealth,'--k', 'Median Wealth', 'LineWidth', 2, 'DisplayName', 'Average Wealth');
x2.LabelVerticalAlignment = 'top';
x2.LabelHorizontalAlignment = 'left';
x2.LabelOrientation = 'horizontal';

end
