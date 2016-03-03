##Robust Visual Robot Localization Across Seasons using Network Flows
This is Matlab implementation of [Tayyab Naseer's](http://www2.informatik.uni-freiburg.de/~naseer/) paper on [Robust Visual Robot Localization Across Seasons using Network Flows](http://www2.informatik.uni-freiburg.de/~spinello/naseerAAAI14.pdf).

###Requirements
Requires Matlab R2015b or above for [digraph](http://www.mathworks.com/help/matlab/ref/digraph.html).
- Computer Vision System Toolbox for [extractHOGFeatures](http://www.mathworks.com/help/vision/ref/extracthogfeatures.html)

###How to Run?
Run the script `hog_mat.m` in the `src` folder.

###Limitations
This implimentation is without the hidden nodes and the network is solved only for flow=1, in which case the minimum cost problem reduces to shortest path problem.