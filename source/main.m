
%% load data
clear ; close all; clc

profileTweetsIndex = 2;
profileFollowersIndex=3;
profileFriendsIndex=4;

global profiles tweets tweetsTs vocab links
global distances dfh meanlocations numUsers
global users outdir
dsdir = '../dataset/';
outdir = '../output/';

tic
profiles = loadProfiles([dsdir 'users.txt']);
tweets = loadTweets([dsdir 'tweets.txt']);
tweetsTs = readtable([dsdir 'tweetsbymonth.csv']);
vocab = readtable([dsdir 'wordsmap.txt'],'ReadVariableNames',false);
users = readtable([dsdir 'usersmap.txt'],'ReadVariableNames',false);
numUsers = size(profiles,1);
[distances, dfh, meanlocations] = proximityEstimation([dsdir 'locations.txt'],numUsers);
links = loadLinks([dsdir 'links.txt'],numUsers);
toc

tweetsVar = profiles(:,profileTweetsIndex)+1;
followersVar = profiles(:,profileFollowersIndex)+1;
friendsVar = profiles(:, profileFriendsIndex)+1;

%% exploratory analysis

ea1(tweetsVar, followersVar, friendsVar);
eaProfilesDistribution(tweetsVar, followersVar, friendsVar);
eaProfilesOutliers(tweetsVar, followersVar, friendsVar);
eaLinksDistribution(followersVar, friendsVar);
eaTweetsTimeSeries(tweetsTs);
eaTweetsMatrixSparsity(tweets);
eaDistances(profiles,distances, links, dfh);
eaClustering(tweets,vocab);


%% Twitter Proximity Ranking

influenceRanking();

%% evaluate ranking algorithms

evaluateRankings(profiles, links, tweets, distances);





