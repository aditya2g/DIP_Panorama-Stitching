function pano = stitch(img_a,h,best)
img_arr = {};
for i = 1:size(best,1)
    img_arr{i} = img_a{best(i,1)};
end
img_arr{i+1} = img_a{best(i,2)};
len = size(img_arr,2);
imageSize = zeros(len,2);
for i = 1:len
    temp = size(img_arr{i});
    imageSize(i,:) = temp(1:2);
end
len = size(h,2);
for i = 1:len
    [xlim(i,:), ylim(i,:)] = outputLimits(h(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);
end
avgXLim = mean(xlim, 2);

[~, idx] = sort(avgXLim);

centerIdx = floor((numel(h)+1)/2);

centerImageIdx = idx(centerIdx);
Tinv = invert(h(centerImageIdx));
I = img_arr{1};
for i = 1:numel(h)
    h(i).T = h(i).T * Tinv.T;
end
for i = 1:numel(h)
    [xlim(i,:), ylim(i,:)] = outputLimits(h(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);
end

maxImageSize = max(imageSize);

% Find the minimum and maximum output limits
xMin = min([1; xlim(:)]);
xMax = max([maxImageSize(2); xlim(:)]);

yMin = min([1; ylim(:)]);
yMax = max([maxImageSize(1); ylim(:)]);

% Width and height of panorama.
width  = round(xMax - xMin);
height = round(yMax - yMin);

% Initialize the "empty" panorama.
panorama = zeros([height width 3], 'like', I);
blender = vision.AlphaBlender('Operation', 'Binary mask', ...
    'MaskSource', 'Input port');
% blender1 = vision.AlphaBlender('Operation','blend');
% Create a 2-D spatial reference object defining the size of the panorama.
xLimits = [xMin xMax];
yLimits = [yMin yMax];
panoramaView = imref2d([height width], xLimits, yLimits);

% Create the panorama.
for i = 1:len
    
    I = img_arr{i};
    
    % Transform I into the panorama.
    warpedImage = imwarp(I, h(i), 'OutputView', panoramaView);
    
    % Generate a binary mask.
    mask = imwarp(true(size(I,1),size(I,2)), h(i), 'OutputView', panoramaView);
    
    % Overlay the warpedImage onto the panorama.
    panorama = step(blender, panorama, warpedImage, mask);
%     panorama1 = (panorama1/2+step(blender1,panorama1,warpedImage)/2);
%     panorama2 = (panorama1-step(blender1,panorama1,warpedImage)) ;
%     panorama1 = panorama1 + panorama2;
%     panorama1 = step(blender1,panorama1,warpedImage);
%     imshow(panorama1);
%     pause(2);
end
pano = panorama;
end