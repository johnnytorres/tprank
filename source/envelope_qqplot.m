function paramhat_vec = envelope_qqplot( indata, distribution, samples )
%%
% Description
% 	fit the distribution data to BiPareto distribution, the parameters are fitted via maximum likelihood
% Input data
% 	indata : input data vector
%	distribution : fitted distribution
%	samples : number of synthetic data samples used to produce the envelop
% Output data
%	paramhat_vec : parameters used to produce synthetic data (simulation envelop)
%%

    fs = indata;
    values = length(fs);
    paramhat_index = 1;
    %===============================
    % create simulation data
    %===============================
    s = sprintf('Create synthetic data');
    switch lower(distribution)
        case {'weibull'}
           [paramhat] = wblfit( fs );
           wdata0 = wblrnd(paramhat(1,1),paramhat(1,2),values,1 );
        case {'lognormal'}
           [paramhat] = lognfit( fs );
           wdata0 = lognrnd(paramhat(1,1),paramhat(1,2),values,1 );
        case {'exponential'}
           [paramhat] = expfit( fs );
           wdata0 = exprnd(paramhat(1,1),values,1 );
        case {'extreme_value'}
           [paramhat] = evfit( fs );
           wdata0 = evrnd(paramhat(1,1),paramhat(1,2),values,1 );
        case {'generalized_extreme_value'}
           [paramhat] = gevfit( fs );
           wdata0 = gevrnd(paramhat(1,1),paramhat(1,2),paramhat(1,3),values,1 );
        case {'pareto'}
           [paramhat] = gpfit( fs - min(fs)+ eps);
           wdata0 = gevrnd(paramhat(1,1),paramhat(1,2),min(fs),values,1 );
        case {'gamma'}
           [paramhat] = gamfit( fs );
           wdata0 = gamrnd(paramhat(1,1),paramhat(1,2),values,1 );
        case {'rayleigh'}
           [paramhat] = raylfit( fs );
           wdata0 = raylrnd(paramhat(1,1),values,1 );
        case {'bipareto'}
           %[paramhat] = fitBiPareto( fs, 60, 'FS', 'FS' );
            [paramhat] = fitBiPareto( fs, 60, 'FS');
           wdata0 = floor(randbipareto(500, paramhat(1,1), paramhat(1,2), paramhat(1,3), min(fs)));
           % these functions elapse at ~8ms
       otherwise
           error('Invalid distribution');
    end
    paramhat_vec(paramhat_index,:) = paramhat; paramhat_index = paramhat_index + 1;
    disp ( s );
    f1 = figure;
    hold on;
    %===============================
    % create simulation envelope
    %===============================
    for envel = 1:samples  
        switch lower(distribution)
            case {'weibull'}
                s = sprintf('\t[weibull]Generating simulation envelope: run[%d]', envel);
                %[paramhat] = wblfit( fs );
                wdata = wblrnd(paramhat(1,1),paramhat(1,2),values,1 );
            case {'lognormal'}
                s = sprintf('\t[lognormal]Generating simulation envelope: run[%d]', envel);
                %[paramhat] = lognfit( fs );
                wdata = lognrnd(paramhat(1,1),paramhat(1,2),values,1 );
            case {'exponential'}
                s = sprintf('\t[exponential]Generating simulation envelope: run[%d]', envel);
                wdata = exprnd(paramhat(1,1),values,1 );
            case {'extreme_value'}
                s = sprintf('\t[extreme_value]Generating simulation envelope: run[%d]', envel);
                wdata = evrnd(paramhat(1,1),paramhat(1,2),values,1 );
            case {'gamma'}
                s = sprintf('\t[gamma]Generating simulation envelope: run[%d]', envel);
                wdata = gamrnd(paramhat(1,1),paramhat(1,2),values,1 );
            case {'generalized_extreme_value'}
                s = sprintf('\t[generalized_extreme_value]Generating simulation envelope: run[%d]', envel);
                wdata = gevrnd(paramhat(1,1),paramhat(1,2),paramhat(1,3),values,1 );
            case {'pareto'}
                s = sprintf('\t[pareto]Generating simulation envelope: run[%d]', envel);
                wdata = gprnd(paramhat(1,1),paramhat(1,2),min(fs),values,1 );
            case {'rayleigh'}
                s = sprintf('\t[rayleigh]Generating simulation envelope: run[%d]', envel);
                wdata = raylrnd(paramhat(1,1),values,1 );
            case {'bipareto'}
                s = sprintf('\t[bipareto]Generating simulation envelope: run[%d]', envel);
                %[paramhat] = fitBiPareto( fs, 60, 'FS', 'FS' );
                wdata = floor(randbipareto(2000, paramhat(1,1), paramhat(1,2), paramhat(1,3), min(fs)));
            otherwise
                error('Invalid distribution');
        end
        disp ( s );
        h = qqplot(wdata0,wdata);
        delete(h(2)); delete(h(3));
        set(h(1),'Color','cyan')
        set(h(1),'MarkerEdgeColor','cyan');
        paramhat_vec(paramhat_index,:) = paramhat; paramhat_index = paramhat_index + 1;
    end
    h = qqplot(wdata0,fs);
    delete(h(2)); delete(h(3));
    ah = gca;
    xlim = get(ah,'XLim');
    ylim = get(ah,'YLim');
%     f2 = figure;
%     compCopy(f1, f2);
    figure(f1);
    %===============================
    % Plot data in original scale
    %===============================
    if( xlim(1,2) > ylim(1,2) )
        axes_max = ylim;
    else
        axes_max = xlim;
    end
    axes_max(1,1) = 0;
    ah = gca;
    set(ah,'XLim', axes_max);
    set(ah,'YLim', axes_max);
    ideal = (0:100:axes_max(1,2));
    plot(ideal,ideal,'Color','r','LineWidth',2);
    xlabel('Synthetic data quantiles');
    ylabel('Original data quantiles');
    grid on; hold off;
    %===============================
    % Plot data in log scale
    %===============================
%     figure(f2);
%     if( xlim(1,2) > ylim(1,2) )
%         axes_max = xlim;
%     else
%         axes_max = ylim;
%     end
%     axes_max(1,1) = 0;
%     ah = gca;
%     set(ah,'XLim', axes_max);
%     set(ah,'YLim', axes_max);
%     ideal = [0:100:axes_max(1,2)];
%     plot(ideal,ideal,'Color','r','LineWidth',4);
%     set(gca,'XScale','log'); set(gca,'YScale','log');
%     xlabel('Synthetic data quantiles [log scale]');
%     ylabel('Original data quantiles [log scale]');   
%     grid on;
    %===============================
    % Save data
    %===============================
%     switch lower(distribution)
%         case {'weibull'}
%            savename = [ 'qqfit_orig_weibull_' int2str(samples)];
%         case {'lognormal'}
%            savename = [ 'qqfit_orig_lognormal_' int2str(samples)];
%         case {'bipareto'}
%            savename = [ 'qqfit_orig_bipareto_' int2str(samples)];
%        otherwise
%            error('Invalid distribution');
%     end
    %saveas( f1, [ savename '.fig']);
    %saveas( f1, [ savename '.jpg']);
%     savenamelog = [ savename '_log'];
    %close(f1);
    %saveas( f2, [ savenamelog '.fig']);
%     saveas( f2, [ savenamelog '.jpg']);
%     close(f2);
    
    
    
    
    
    
    
    
    
    
    
    
    
