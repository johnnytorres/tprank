function eaDistances( varargin )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

	global outdir
	profiles = varargin{1};
	distances = varargin{2};
	links = varargin{3};
	dfh = varargin{4};
	
	numUsers = size(profiles,1);

	% plot probability dist for distances for all users
	figure
	rind = randperm(numUsers, 100);
	dsel = distances(rind,rind);
	nelem=numel(dsel);
	d=reshape(dsel, nelem,1);
	[c,b] = hist(d,500);
	loglog(b, c, '--d');
	% plot probability dist for distances for friends
	hold on
	d = distances(links==1);
	[c, b] = hist(d,500);
	loglog(b,c,'--x');
	xlabel('Km');
	ylabel('Twitterers');
	legend('All twitterers','Friends');
	set(gca,'FontSize',14);
	saveas(gcf, [outdir 'DistanceDist'],'epsc');

	% plot probability dist for tweets distances from home
	figure;
	d=dfh;
	[c,b] = hist(d,500);
	loglog(b, c, '--s');%,'MarkerSize', 10);	
	xlabel('Km');
	ylabel('Twitterers');
	legend('All twitterers','Friends','Distances from home');
	set(gca,'FontSize',14);
	saveas(gcf, [outdir 'DistanceDistFromHome'],'epsc');


end

