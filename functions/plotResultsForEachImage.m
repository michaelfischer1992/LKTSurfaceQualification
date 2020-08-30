function plotResultsForEachImage(rgbImage, rgb255, allPixelsK1, allPixelsK2, allPixelsK3, allPixelsK4, allPixelsK5)
R    = rgbImage(:, :, 1);
G    = rgbImage(:, :, 2);
B    = rgbImage(:, :, 3);
for i = 1 : length(allPixelsK4)
    R(allPixelsK4(i,2), allPixelsK4(i,1)) = rgb255(4, 1);
    G(allPixelsK4(i,2), allPixelsK4(i,1)) = rgb255(4, 2);
    B(allPixelsK4(i,2), allPixelsK4(i,1)) = rgb255(4, 3);
end
for i = 1 : length(allPixelsK5)
    R(allPixelsK5(i,2), allPixelsK5(i,1)) = rgb255(5, 1);
    G(allPixelsK5(i,2), allPixelsK5(i,1)) = rgb255(5, 2);
    B(allPixelsK5(i,2), allPixelsK5(i,1)) = rgb255(5, 3);
end
for i = 1 : length(allPixelsK1)
    R(allPixelsK1(i,2), allPixelsK1(i,1)) = rgb255(1, 1);
    G(allPixelsK1(i,2), allPixelsK1(i,1)) = rgb255(1, 2);
    B(allPixelsK1(i,2), allPixelsK1(i,1)) = rgb255(1, 3);
end
for i = 1 : length(allPixelsK2)
    R(allPixelsK2(i,2), allPixelsK2(i,1)) = rgb255(2, 1);
    G(allPixelsK2(i,2), allPixelsK2(i,1)) = rgb255(2, 2);
    B(allPixelsK2(i,2), allPixelsK2(i,1)) = rgb255(2, 3);
end
for i = 1 : length(allPixelsK3)
    R(allPixelsK3(i,2), allPixelsK3(i,1)) = rgb255(3, 1);
    G(allPixelsK3(i,2), allPixelsK3(i,1)) = rgb255(3, 2);
    B(allPixelsK3(i,2), allPixelsK3(i,1)) = rgb255(3, 3);
end
IMG1 = cat(3, G, R, B);
figure, imshow(IMG1)
end 