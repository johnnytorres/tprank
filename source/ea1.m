function  ea1( varargin )
%exploratoryAnalysis1 analyze variables distribution with probability plots
%   analyze if variables belong to a lognormal distribution

    tweets = varargin{1};
    followers = varargin{2};
    friends = varargin{3};
    global outdir

    figure;
    probplot('lognormal',[tweets followers friends])
    title('')
    legend('Tweets','Followers','Friends','Location','NW')
    %set(gca,'FontSize',14);
    saveas(gcf, [outdir 'VarsDist'],'eps');

    %envelope_qqplot(tweets, 'lognormal',100);
    %set(gca,'FontSize',14);
    %saveas(gcf, 'VarsDistTweetsEnvelop','epsc');

end

