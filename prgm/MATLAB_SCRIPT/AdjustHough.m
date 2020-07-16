function [Success NbPlot] = AdjustHough(mypi, tbot, NbPlot)
    img = TakePhoto(mypi, -1);
    rotI = rgb2gray(img);

    LIM_ANGLE = 20;

    BW = edge(rotI,'canny');

    [H,T,R] = hough(BW);
    P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
    x = T(P(:,2)); y = R(P(:,1));

    lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);
    figure(NbPlot), imshow(rotI), hold on
    NbPlot = NbPlot+1;
    max_len = 0;
    Result = [];
    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];
        plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
   
        %find end
        D = lines(k).point2-lines(k).point1;
        [R, Gamma] = cart2pol(D(1),D(2));
        if(abs(R) > 0.005) & (Gamma > -LIM_ANGLE+90) & (Gamma < LIM_ANGLE+90)
            plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
            plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
            if(R > 0)
                Result = [Result Gamma];
            else
                Result = [Result 180-Gamma];
            end
        end
    end

    Moy = mean(Result)
    Angle = mod(Moy-90,360)*pi/180;

    if(Angle > 0) & (Angle < 2*pi)
        Go([0 0 Angle], tbot);
        Angle
        Success = true;
    else
        fprintf("pas d'objet\n");
        Success = false;
    end
end
