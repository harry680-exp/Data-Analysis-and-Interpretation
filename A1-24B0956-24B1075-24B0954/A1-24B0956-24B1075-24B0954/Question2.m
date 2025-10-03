function newMean = UpdateMean(OldMean,NewDataValue,n)
    Nmean= (n*OldMean + NewDataValue)/(n+1);
    newMean = Nmean;
end

function newMedian = UpdateMedian(oldMedian, NewDataValue,A,n)
    if mod(n,2) == 0
        if NewDataValue < oldMedian
            newMedian = A(n/2);
        elseif NewDataValue > oldMedian
            newMedian = A((n/2)+1);
        else 
            newMedian = NewDataValue;
        end
    else 
        mid = (n+1)/2;
        if NewDataValue < oldMedian
            newMedian = (A(mid)+ A(mid-1))/2;
        else
            newMedian = (A(mid)+A(mid+1))/2;
        end
    end
end

function newStd = UpdateStd(OldMean,OldStd,NewMean,NewDataValue,n)
      variance = (((n - 1) * OldStd^2)/n)+ (((NewDataValue - OldMean)^2 ) / n+1);
      newStd = sqrt(variance);
end


