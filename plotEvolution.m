function plotEvolution(Agents,environment,filename,plotname,fig,i)
    Map = imagesc(environment,[0.0 1.0]);
    colormap(autumn()) ;
    freezeColors
    hold on;
    k = find(Agents(6,:)==0);
    Wealth = scatter(Agents(2,k),Agents(1,k),[],'black','filled');
    k = find(Agents(6,:)==1);
    Wealth = scatter(Agents(2,k),Agents(1,k),[],'green','filled');
    k = find(Agents(6,:)==2);
    Wealth = scatter(Agents(2,k),Agents(1,k),[],'blue','filled');
    hold off;
    axis ([1 100 1 100]);
    axis off;
    title(plotname);
    legend('Low class','Medium class','High class','Location','Southoutside','Orientation','Horizontal')
    legend boxoff
    h = colorbar;
    set(get(h,'title'),'string','Resources');
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