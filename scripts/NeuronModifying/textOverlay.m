function image = textOverlay(im,overlayString,xPos,yPos)
%     YourText = sprintf(overlayString);
    h = figure;
    imshow(im);
    hText = text(xPos,yPos,overlayString,'Color',[1 1 1],'FontSize',20);
    hFrame = getframe(gca);
    image = hFrame.cdata;
    close(h);
end
