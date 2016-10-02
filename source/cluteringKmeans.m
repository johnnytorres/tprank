function [ output_args ] = cluteringKmeans( varargin )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
	
    % cluster tweets , k=5 (num topics)
    fprintf('calculating kMeans...');
    tic;
    [dt,idx,wt] = calcKMeans(tweets,10);
    %dt(dt==0) = min(dt(dt>0))-1;
    % calc sim between users with respect to the follower in relationship
	dt2 = dt;
	dt = log(1+dt);
    %sim = dt(:,idx(1)) / sum(dt(:,idx(1)));
    % harmonic f(x) to highlight % of sim
	% TO FIX
    %sim = 1./e;
    %sim = sim / sum(sim);
    %profiles = [profiles, sim];
    toc;
    fprintf('calculating kMeans...[ok]');

end

