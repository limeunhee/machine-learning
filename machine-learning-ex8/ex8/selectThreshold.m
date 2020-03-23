function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%

bestEpsilon = 0;
bestF1 = 0;
F1 = 0;

stepsize = (max(pval) - min(pval)) / 1000;
for epsilon = min(pval):stepsize:max(pval)
    
    % ====================== YOUR CODE HERE ======================
    % Instructions: Compute the F1 score of choosing epsilon as the
    %               threshold and place the value in F1. The code at the
    %               end of the loop will compare the F1 score for this
    %               choice of epsilon and set it to be the best epsilon if
    %               it is better than the current choice of epsilon.
    %               
    % Note: You can use predictions = (pval < epsilon) to get a binary vector
    %       of 0's and 1's of the outlier predictions

    cVPredictions = zeros(size(yval,1),1);
    
    for i = 1:size(yval,1)
        if (pval(i) < epsilon) & (yval(i) ==0) %fp
            cVPredictions(i)=1;
        elseif (pval(i) < epsilon) & (yval(i) ==1) %tp
            cVPredictions(i)=2;
        elseif (pval(i) >= epsilon) & (yval(i) ==0) %tn
            cVPredictions(i)=3;
        elseif (pval(i) >= epsilon) & (yval(i) ==1) %fn
            cVPredictions(i)=4;
        end
    end
    
    fp = sum(cVPredictions(:) == 1);
    tp = sum(cVPredictions(:) == 2);
    tn = sum(cVPredictions(:) == 3);
    fn = sum(cVPredictions(:) == 4);
    
    prec = tp/(tp+fp);
    rec =  tp/(tp+fn);
    F1 = 2*prec*rec/(prec+rec);
    
    % =============================================================

    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end

end
