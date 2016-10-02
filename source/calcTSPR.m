function r = calcTSPR(links,sim)  transition_matrix = double(links);  nodes_weight = sum(transition_matrix);  nodes_weight = (nodes_weight ==0) + nodes_weight; %avoid NaN  num_nodes = size(transition_matrix,1);  for i=1:num_nodes    transition_matrix(:,i) = transition_matrix(:,i) / nodes_weight(i);  end  r = ones(num_nodes, 1);  r = r / num_nodes;    beta = 0.5;  for i=1:50    r = beta * transition_matrix*r + (1-beta)*sim;  endend