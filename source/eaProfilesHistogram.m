function exploratoryAnalysisNormal( varargin )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
  global outdir
	profiles(:,2:end) = log(1+profiles(:,2:end));
	tweetsVar = profiles(:,profileTweetsIndex);
	followersVar = profiles(:,profileFollowersIndex);
	friendsVar = profiles(:, profileFriendsIndex);

	subplot(2,2,3);
	histfit(tweetsVar, 50, 'normal');
	xlabel('Tweets');
	ylabel('Users');
	title('Normalized tweets distribution');
	subplot(2,2,4)
	histfit(followersVar, 50, 'normal');
	xlabel('Followers');
	ylabel('Users');
	title('Normalized followers distribution');
	
	saveas(gcf,[outdir 'VarsHistogram'], 'eps');

end

