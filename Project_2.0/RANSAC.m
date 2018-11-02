function [inliers,best] = RANSAC(matches,k,pairs)
n = size(matches,1);
%%%% Col one shows best image and col 2 shows the number of inliers.
best = zeros(k-1,3);
inliers = {};
count = 1;
for i = 1:n
    pair1 = matches{i,1};
    pair2 = matches{i,2};
    [inliers_a,inliers_b] = estimateFundamentalMatrixRANSAC(pair1.Location,pair2.Location);
    if (best(pairs(i,1),2) < size(inliers_b,1))
        best(pairs(i,1),1) = pairs(i,2);
        best(pairs(i,1),3) = count;
        best(pairs(i,1),2) = size(inliers_b,1);
    end
    inliers{i} = [inliers_a,inliers_b];
    count = count+1;
end
end