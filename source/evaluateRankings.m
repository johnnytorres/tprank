function [ rankings ] = evaluateRankings( varargin )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
  global outdir
	sampleSize = 30;
	numTrials = 10;
	typeTrials = 9;
	numRankings = 5;
	rankingQuality = zeros(numTrials*typeTrials,numRankings+1);

	% links simulation
	% nNodes = size(links,1);
	% links = rand(nNodes, nNodes)>0.5;
	
	rc = zeros(5,5);

	for type = 1:typeTrials
	for trial = 1:numTrials
		tic

		[ ...
		sample_profiles, ...
		sample_links,...
		sample_tweets,...
		sample_sim,...
		sample_distances]...
		= getSample(type, sampleSize);

		ind_ranking = calcIndegreeRank(sample_profiles);
		pr_ranking = calcPageRank(sample_links);
		tspr_ranking = calcTSPR(sample_links,sample_sim);
		tr_ranking = calcTwitterRank(sample_profiles,sample_links,sample_sim);
		proximity_ranking = calcProximityRank(sample_profiles,sample_links,sample_distances,sample_sim);

		rankings = [ ind_ranking, pr_ranking, tspr_ranking, tr_ranking, proximity_ranking];

		% evaluate known friendship's ranking  
		realSampleSize = size(sample_profiles,1);
		[s, i] = sort(rankings,'descend');
		% calculate ranking corr 
		rc = rc+ corr(i,'type','Spearman');
		% look for the position of the friend
		[r, c] = find(i== realSampleSize); 
		% quality of recommedation
		idxTrial = (type-1)*numTrials+trial;
		rankingQuality(idxTrial,1) = type;
		rankingQuality(idxTrial,2:end) = ((realSampleSize+1-r)/realSampleSize)' ;
		fprintf('%d of %d trials\n',idxTrial, typeTrials*numTrials);

		toc
	end
	end

	rc = rc./ (numTrials*typeTrials);
	csvwrite([outdir 'rankcorr.txt'], rc);
	
	varNames = {'Type', 'In Degree','Page Rank','Topic Sensitive Page Rank','Twitter Rank','Proximity Rank'};
	ds = mat2dataset(rankingQuality,'VarNames',varNames);
	statarray = grpstats(ds,'Type');
	b = double(statarray);

	figure;
	bar(b(1:3,3:end));
	typeName = {'FP10','FIQ','FP90'};
	set(gca,'xticklabel',typeName);
	ylbls = get(gca, 'YTickLabel');
	ylabel('quality')
	yperc = str2double(ylbls)*100;
	set(gca,'YTickLabel',sprintf('%g%%\n',yperc))
	set(gca,'FontSize',14);
	legend(varNames(2:end),'Location','southoutside');
	%saveas(gcf, [outdir 'RankingQualityFollowers'],'epsc');

	figure;
	bar(b(4:6,3:end));
	typeName = {'TP10', 'TIQ','TP90'};
	set(gca,'xticklabel',typeName);
	ylbls = get(gca, 'YTickLabel');
	ylabel('quality')
	yperc = str2double(ylbls)*100;
	set(gca,'YTickLabel',sprintf('%g%%\n',yperc))
	set(gca,'FontSize',14);
	legend(varNames(2:end),'Location','southoutside')
	%saveas(gcf, [outdir 'RankingQualityTopics'],'epsc');
	
	figure;
	bar(b(7:9,3:end));
	typeName = {'DP10', 'DIQ','DP90'};
	set(gca,'xticklabel',typeName);
	ylbls = get(gca, 'YTickLabel');
	ylabel('quality')
	yperc = str2double(ylbls)*100;
	set(gca,'YTickLabel',sprintf('%g%%\n',yperc))
	set(gca,'FontSize',14);
	legend(varNames(2:end),'Location','southoutside')
	%saveas(gcf, [outdir 'RankingQualityProximity'],'epsc');

end

