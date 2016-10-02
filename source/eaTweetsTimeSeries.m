function eaTweetsTimeSeries( varargin )
%exploratoryAnalysisTweets analyize tweets in time
%   time series of tweets

    %tweets = varargin{1};
    global outdir
    t = varargin{1};	
    ts = timeseries(t.tweets, t.date);
    ts.TimeInfo.Format = 'mmm-yyyy';
    plot(ts,'--s');
    ax=gca;
    ax.XTickLabelRotation=45;
    title('');
    grid on;
    %xlabel('Time');
    ylabel('Tweets');
    legend('Tweets','Location','NW')
    set(gca,'FontSize',14);
    saveas(gcf, [outdir 'TimeSeriesTweets'],'eps');

end

