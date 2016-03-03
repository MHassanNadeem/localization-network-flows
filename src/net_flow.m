% http://www.mathworks.com/help/matlab/ref/digraph-object.html
% http://www.mathworks.com/help/matlab/graph-and-network-algorithms.html
% http://www.mathworks.com/help/matlab/ref/graph.plot.html
% http://www.mathworks.com/help/matlab/ref/graph.shortestpath.html


%% Doc
% Example usage net_flow(rand(Q,D), 1);
% Example usage net_flow(rand(3,4), 1);


function [path] = net_flow(sMat, visualize)

%% Generate Graph
cMat = 1./sMat; % Cost Matrix

K = 4;
D = size(sMat,2);
Q = size(sMat,1);

s=[];
t=[];
weights=[];

for i=1:Q-1
    for j=1:D
        for k=j:min(j+K,D)
            s(end+1) = node_num(i, j, Q, D);
            t(end+1) = node_num(i+1, k, Q, D);
            weights(end+1) = cMat(i+1,k);
        end
    end
end

% Add Source Node
sNode = D*Q+1; % Node Number of Source Node
s = [s ones(1,D)*sNode]; % Edges from source node
t = [t 1:D]; % Edges to first row to node

% Add Sink Node
tNode = sNode+1; % Node Number of Terminal Node
s = [s (D*Q-D+1):(D*Q)]; % Edges from last rows of nodes
t = [t ones(1,D)*tNode]; % Edges to terminal node

% Add Src Sink Weights
% weights = [weights zeros(1,D*2)]; %cMat(1,:)
weights = [weights cMat(1,:) zeros(1,D)]; %cMat(1,:)

G = digraph(s,t, weights);

%% Shortest Path
[path,d] = shortestpath(G,sNode,tNode);

%% Plot
if visualize
    x = repmat(1:D,1,Q);
    y = repmat(1:Q,D,1);
    y = reshape(y, 1, numel(y));
    
    % Add Source and Sink Node Locations
    x = [x (D+1)/2 (D+1)/2];
    y = [y -1 Q+2];
    
    % p = plot(G,'LineWidth',2, 'ArrowSize', 10);
    network_fig = figure('Name','Network Flow'); figure(network_fig);
    p = plot(G,'XData',x,'YData',y,'LineWidth',1, 'ArrowSize', 5);
    p.NodeColor = 'b';
    p.MarkerSize = 5;
    set(gca,'Ydir','reverse');
    axis([min(x) max(x) min(y) max(y)]);
    grid on;
    
    % Labels
    title('Shortest path visualization');
    xlabel('Database Image Sequence');
    ylabel('Query Image Sequence');
    highlight(p,path,'NodeColor','r','EdgeColor','r','LineWidth',2);
end
end