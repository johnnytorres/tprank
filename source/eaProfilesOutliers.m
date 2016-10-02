function  exploratoryAnalysisOutliers( varargin )
%exploratoryAnalysisOutliers plot outliers for twitterers profiles 
%   visualize outliers using box plots with log10 normalization
	global outdir
	tweets = varargin{1};
	followers = varargin{2};
	friends = varargin{3};

	normVars = [tweets, followers, friends];
	normVars = log10(1+normVars);
	
	figure;
	boxplot(normVars, 'labels', {'Tweets', 'Followers', 'Friends'});
	%title('Outliers analysis for Twitterers variables');
	ylabel('count (scale power of 10)')
	grid on;
	set(gca,'FontSize',14);
	saveas(gcf, [outdir 'VarsBoxPlot'],'eps');

end

