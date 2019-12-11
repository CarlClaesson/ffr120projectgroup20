function plotHistogram(Wealth, AverageWealth, MedianWealth)
close all
hax=axes; 
h = histogram(Wealth, 50);
h.FaceColor = [0.3010 0.7450 0.9330];
xlabel('Units of Sugar')
ylabel('Number of Agents')
hold on
x1 = xline(AverageWealth,'--k', 'Average Wealth', 'LineWidth', 2);
x1.LabelVerticalAlignment = 'top';
x1.LabelHorizontalAlignment = 'center';
x2 = xline(MedianWealth,'--k', 'Median Wealth', 'LineWidth', 2, 'DisplayName', 'Average Wealth');
x2.LabelVerticalAlignment = 'top';
x2.LabelHorizontalAlignment = 'center';

end