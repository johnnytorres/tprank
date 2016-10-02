
function printProgress( i, n)
    msg = sprintf('%6.0d /%5.0d', i, n);
    l=numel(msg); 
    
    if i == 1
        l=0;
    end 
    
    fprintf(repmat('\b',1,l));
    fprintf(msg);
    pause(0.00001);
end
