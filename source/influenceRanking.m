function influenceRanking()
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

	global outdir
	global users vocab

	sampleSize = 10;
	type = 10;

	[ ...
		sample_profiles, ...
		sample_links,...
		sample_tweets,...
		sample_sim,...
		sample_distances]...
	= getSample(type, sampleSize);

	ranking = calcProximityRank(sample_profiles,sample_links,sample_distances,sample_sim);
	[s, i] = sort(ranking,'descend');
	
	sample = users(sample_profiles(:,1),:);
	
	varNames = {'id', 'statusCount','followersCount','FriendsCount'};
	tprof = array2table(sample_profiles,'VariableNames',varNames);
	varNames = {'ranking'};
	trank = array2table(ranking,'VariableNames',varNames);
	varNames = {'distances'};
	tdist = array2table(sample_distances(:,end-1),'VariableNames',varNames);
	
	sample = [sample tprof trank tdist];
	
	%csvwrite('resultSampleProfiles.txt', sample_profiles);
	writetable(sample,[outdir 'results.txt']);
end

