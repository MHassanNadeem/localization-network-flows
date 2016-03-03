function [ i j ] = node_index( num, Q, D )
    i = floor((num-1)/D)+1;
    j=(num-(i-1)*D);
end

