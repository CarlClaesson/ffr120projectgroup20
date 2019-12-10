function plotEvolution(Agents,environment,filename,plotname,fig)
    Map = imagesc(environment,[0.0 1.0]);
    colormap(autumn()) ;
    freezeColors
    hold on;
    Normalize = max(Agents(3,:));
    Wealth = scatter(Agents(2,:),Agents(1,:),[],Agents(3,:)/Normalize,'filled');
    colormap(winter());
    hold off;
    axis ([1 100 1 100]);
    axis off;
    title(plotname);
    %colorbar
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