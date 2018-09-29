# DIP_Panorama-Stitching
Panaroma Stitching


Problem Definition

Problem: Given multiple images of one scene, reconstruct a single panoramic image. The input images can be unordered, orientation, scale or illumination invariant. It also takes care of the noise images which are not a part of the scene during the reconstruction process. Automatic straightening and Multi Band Blending is applied to achieve the final output.

Action Plan:
● The first step in the algorithm is to find the common features in all the images using SIFT Descriptor, which is independent of rotation and scale.
● Next we group images with maximum matching features and use some fixed number of images for reconstruction. A probabilistic
model is used to verify all the matches.
● Then we find the pairwise homographies between the matched images using RANSAC.
● Next we use Bundle Adjustment by adding each matched image one by one to the original image using the above extracted pairwise homographies. It will remove the accumulated errors and disregard multiple constraints between images.
● Next Automatic Straightening, Gain compensation and Multi Band Blending techniques are applied to find the final enhanced panorama output of the given input images.

Timeline: 
20th October : Feature extraction and Image Matching 
8th November : Bundle Adjustment 
20th November: Gain Compensation and Multi Band Blending 



