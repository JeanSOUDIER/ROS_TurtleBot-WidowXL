%------------------------------------
% Read the image into an array.
Img = TakePhoto(mypi,-1);
saveas(gcf,'testt.png');
RGB = 'D:\école\GE4\Stage\TURTLEBOTxWIDOWX_XL\prgm\MATLAB_SCRIPT\testt.png';
%------------------------------------
% Display the original image.
subplot(2, 3, 1);
imshow(RGB);
title('Original RGB Image');
yellowMask = colorDetectHSV(RGB, [0.2 0.9 0], [0.05 0.05 0.05]);
redMask =colorDetectHSV(RGB, [1 1 1], [0.1 0.2 0.2]);
blueMask =colorDetectHSV(RGB, [0.6 0.5 0.6], [0.2 0.3 0.4]);
% Or can try this for blue color:
% blueMask =colorDetectHSV(RGB, [1 0.5 0], [0.4 0.4 0.3]);
greenMask =colorDetectHSV(RGB, [0.369 0.786 0.769], [0.2 0.2 0.2]);
% Display them.
subplot(2, 3, 2);
imshow(yellowMask);
title('Yellow Mask');
subplot(2, 3, 3);
imshow(greenMask);
title('Green Mask');
subplot(2, 3, 4);
imshow(blueMask);
title('Blue Mask');
subplot(2, 3, 5);
imshow(redMask);
title('Red Mask');