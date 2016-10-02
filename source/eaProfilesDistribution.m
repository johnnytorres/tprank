function eaProfilesDistribution( varargin )
%plot using histogram counts
%   log log plot count for variables

    global outdir
    tweets = varargin{1};
    followers = varargin{2};
    friends = varargin{3};

    figure;
    
    bins = size(tweets,1);
    [counts,values] = hist(tweets, bins);
    loglog(values, counts, 's');
    
    hold on;
    
    bins = size(followers,1);
    [counts,values] = hist(followers, bins);
    loglog(values, counts, 'x');

    bins = size(friends,1);
    [counts,values] = hist(friends, bins);
    loglog(values, counts, 'o');
    
    hold off
    
    %grid on
    
    xlabel('Data');
    ylabel('Count');
    legend('Tweets','Followers','Friends','Location','NE')
    set(gca,'FontSize',14);
    saveas(gcf, [outdir 'VarsDistHist'],'eps');

    
end

