function eaLinksDistribution( varargin )
%eaLinksDistribution links distributions exploratory analysis 
%   characterize links distribution

	global outdir
	followers = varargin{1};
	friends = varargin{2};

	figure;
	loglog(followers, friends,'.');
	xlabel('Number of followers');
	ylabel('Number of friends');
	%Title('');
	set(gca,'FontSize',14);
	saveas(gcf, [outdir 'FollowersVsFriends'],'epsc');
	
	%calculate pearson correlation
	
	corr(followers,friends);

end

