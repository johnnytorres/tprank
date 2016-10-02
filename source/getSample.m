function [ ...
	sample_profiles, ...
	sample_links,...
	sample_tweets,...
	sample_sim,...
	sample_distances]...
	= getSample( type, sampleSize)
    
	global profiles links tweets distances

	% select sample users for experiment
	
    [non_friends, follower, friend] = getRandomUsers(type);
	non_friends = non_friends(non_friends < size(profiles,1));
    num_non_friends = size(non_friends,1);
            
    % select non friends minus the two already selected
    if sampleSize > num_non_friends
        realSampleSize = num_non_friends;
    else
        realSampleSize = sampleSize;
    end    
    
    non_friends = non_friends(randperm(num_non_friends, realSampleSize-2));

    % build sample matrix containing two twitterers with friendship and 
	% remaning twitterers without friendship
    sample = [ non_friends;follower; friend ];
    sample_profiles = profiles(sample, :);
    sample_links = links(sample, sample');
    % remove the friendship in order to predict
	sample_links(end, end-1) = 0; 
	
	try 
    sample_tweets = tweets(sample,:);
	catch
		warning('error indexing sample')
	end
	
    sample_distances = distances(sample, sample');
	
	% topic similarity
	[idx, centroids, score, j, dt] = clustering(sample_tweets, 3, 3);
	dtSample = dt(:,idx(end-1)); % select follower similarity
	sim = dtSample / sum(dtSample);
	sim = 1-abs(sim(end-1) - sim);
	sample_sim = sim/sum(sim);
	%sample_sim = sim;
end

