function [] = bundle_adjustment(inliers,points,best)
vSet = viewSet;
viewId = 1;
vSet = addView(vSet, viewId, 'Points', points{1}, 'Orientation', ...
    eye(3, 'like', points{1}.Location), 'Location', ...
    zeros(1, 3, 'like', prevPoints.Location));
for i = 1: 
end