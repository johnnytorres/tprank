function eaClustering( varargin )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

	global outdir
	tweets = varargin{1};
	vocab = varargin{2};
	k = 3;
	pc = 2;

	n = 10;
	%ut = tweets(randperm(size(tweets,1), n), randperm(size(tweets,2), n));
	ut = tweets(1:n,1:n);
	[idx, centroids, score, j] = clustering(ut, k, pc);
	
	figure;
	palette = hsv(k+1);
	colors=palette(idx, :);
	scatter(score(:,1),score(:,2), 15, colors);
	
	%hold on;
	%plot(centroids(:,1), centroids(:,2), 'x', ...
	%     'MarkerEdgeColor','k', ...
	%     'MarkerSize', 10, 'LineWidth', 3);


	%[vocab.retuiteado(j(:,1)), vocab.retuiteado(j(:,2))]
	str = strcat(vocab.Var1(j(:,1)) ,',', vocab.Var1(j(:,2)));
	text(centroids(:,1), centroids(:,2), str, 'FontSize',18);
	set(gca,'FontSize',14);
	ylim([-2 2])
	xlim([-2 3])
	ylabel('tweets PCA 2')
	xlabel('tweets PCA 1')
	saveas(gcf, [outdir 'TextClustering'],'eps');


end

