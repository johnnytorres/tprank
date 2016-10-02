function r = calcProximityRank(profiles, links, distances,sim)  num_nodes = size(distances,1);  temp = repmat(sum(distances),num_nodes,1);  transition_matrix = 1-abs(distances./temp);    temp = repmat(sum(transition_matrix),num_nodes,1);  transition_matrix= transition_matrix./temp;  %transition_matrix(transition_matrix==Inf)=0;  %transition_matrix= transition_matrix.*links;    r = ones(num_nodes, 1);  r = r / num_nodes;    %e = ones(num_nodes,1) / num_nodes;  beta = 0.95;  for i=1:50    r = beta * transition_matrix*r + (1-beta)*sim;  end    %r(2) = 1;end