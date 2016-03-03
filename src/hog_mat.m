clc; close all;

Qn = 0:70;

Q = numel(Qn);
D = 161;

hog_cellsize = [64 64];

%% Read Images and Calculate Hog descriptor
if ~exist('hog_D','var') || numel(hog_D)~=D
   disp('Reading Database Image Set');
   img_D = cell(1,D);
   hog_D = cell(1,D);
   for i=1:D
       path = sprintf('set1\\%d.jpg',i);
       img_D{i} = imread(path);
       hog_D{i} = extractHOGFeatures(img_D{i}, 'CellSize',hog_cellsize);
   end
end

if ~exist('hog_Q','var') || numel(hog_Q)~=Q
   disp('Reading Query Image Set');
   img_Q = cell(1,Q);
   hog_Q = cell(1,Q);
   for i=1:Q
       path = sprintf('set2\\%d.jpg',i);
       img_Q{i} = imread(path);
       hog_Q{i} = extractHOGFeatures(img_Q{i}, 'CellSize',hog_cellsize);
   end
end

%% Calculate Similarity Matrix
if ~exist('sMat','var') | ~isequal(size(sMat), [Q D])
    disp('Calculating Similarity Matrix');
    sMat = zeros(Q,D);
   for i=1:Q
       for j=1:D
           sMat(i,j) = (1 - pdist([hog_D{j};hog_Q{i}],'cosine'));
       end
   end
end

%% Plot HeatMap
disp('Plotting HeatMap');

heat_fig = figure('Name','Color Map');
figure(heat_fig);

colormap('jet');
imagesc(sMat);
colorbar;
xlabel('Database Image Seq');
ylabel('Query Image Seq');
title('Heatmap of Cosine Similarity Matrix');
hold on;

%% Find and plot Best Matches
disp('Finding Best Matching Images');
[maxvals, maxindices] = sort(sMat, 2, 'descend'); % Sort rows
maxindices = maxindices(:,1); % Select index of the Max of each row

plot(maxindices,[1:numel(maxindices)], 'w', 'LineWidth',2);

%% Plot Shortest Path
path = net_flow(sMat, 1);

xm = [];
ym = [];
for i=2:numel(path)-1
    [ym(end+1) xm(end+1)] = node_index(path(i),Q,D);
end

figure(heat_fig);
plot(xm,ym, '-.k', 'LineWidth',2);

legend('Best Match','Shortest Path');