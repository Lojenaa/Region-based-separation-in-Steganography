function im_histogram(ima)
red_plane=ima(:,:,1);
green_plane=ima(:,:,2);
blue_plane=ima(:,:,3);
[red_data pixel_level]=imhist(red_plane);
[green_data pixel_level]=imhist(green_plane);
[blue_data pixel_level]=imhist(blue_plane);
bar(pixel_level, red_data,'r');
hold on;
bar(pixel_level, green_data,'g');
bar(pixel_level, blue_data,'b');
xlabel('Gray Level', 'FontSize', 20);
ylabel('Pixel Count', 'FontSize', 20);
title('Histogram', 'FontSize', 20);
end 