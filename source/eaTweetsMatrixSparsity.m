function eaTweetsMatrixSparsity( varargin )
%eaTweetSparsity plot tweets sparsity
%   Try to get details about tweets's text 
  global outdir
	tweets = varargin{1};

	figure;
	spy(tweets(randperm(size(tweets,1), 100),:), 10)
	axis square
	xlabel('Words');
	ylabel('Users');
	%Title('');
	set(gca,'FontSize',14);
	saveas(gcf, [outdir 'TweetsSparsity'],'eps');
	
	% avg of num word by twitterers
	figure;
	numWords = sum(tweets > 0,2);
	numWords = numWords+1;
	[c,b] = hist(numWords,size(tweets,1));
	loglog(b,c,'.', 'MarkerSize',10)
	xlabel('Words');
	ylabel('Users');	
	set(gca,'FontSize',14);
	saveas(gcf, [outdir 'VocabDist'],'eps');

	pd = fitdist(numWords, 'lognormal');
	mean(pd);
end

