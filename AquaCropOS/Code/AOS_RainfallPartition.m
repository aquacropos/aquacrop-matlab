function [Runoff,Infl,NewCond] = AOS_RainfallPartition(P,Soil,FieldMngt,...
    InitCond)
% Function to partition rainfall into surface runoff and infiltration     
% using the curve number approach                                        

%% Store initial conditions for updating %%
NewCond = InitCond;

%% Calculate runoff %%
if (FieldMngt.SRinhb == 'N') && ((FieldMngt.Bunds == 'N') || (FieldMngt.zBund < 0.001))
    % Surface runoff is not inhibited and no soil bunds are on field
    % Reset submerged days
    NewCond.DaySubmerged = 0;
    % Adjust curve number for field management practices
    CN = Soil.CN*(1+(FieldMngt.CNadjPct/100));
    if Soil.AdjCN == 1 % Adjust CN for antecedent moisture
        % Calculate upper and lowe curve number bounds
        CNbot = round(1.4*(exp(-14*log(10)))+(0.507*CN)-...
            (0.00374*CN^2)+(0.0000867*CN^3));
        CNtop = round(5.6*(exp(-14*log(10)))+(2.33*CN)-...
            (0.0209*CN^2)+(0.000076*CN^3));
        % Check which compartment cover depth of top soil used to adjust
        % curve number
        comp_sto = find(Soil.Comp.dzsum>=Soil.zCN,1,'first');
        if isempty(comp_sto)
            comp_sto = Soil.nComp;
        end
        % Calculate weighting factors by compartment
        xx = 0;
        wrel = zeros(1,comp_sto);
        for ii = 1:comp_sto
            if Soil.Comp.dzsum(ii) > Soil.zCN
                Soil.Comp.dzsum(ii) = Soil.zCN;
            end
            wx = 1.016*(1-exp(-4.16*(Soil.Comp.dzsum(ii)/Soil.zCN)));
            wrel(ii) = wx-xx;
            if wrel(ii) < 0
                wrel(ii) = 0;
            elseif wrel(ii) > 1
                wrel(ii) = 1;
            end
            xx = wx;
        end
        % Calculate relative wetness of top soil
        wet_top = 0;
        for ii = 1:comp_sto
            layeri = Soil.Comp.Layer(ii);
            th = max(Soil.Layer.th_wp(layeri),InitCond.th(ii));
            wet_top = wet_top+(wrel(ii)*((th-Soil.Layer.th_wp(layeri))/...
                (Soil.Layer.th_fc(layeri)-Soil.Layer.th_wp(layeri))));
        end
        % Calculate adjusted curve number
        if wet_top > 1
            wet_top = 1;
        elseif wet_top < 0
            wet_top = 0;
        end
        CN = round(CNbot+(CNtop-CNbot)*wet_top);
    end
    % Partition rainfall into runoff and infiltration (mm) 
    S = (25400/CN)-254;
    term = P-((5/100)*S);
    if term <= 0
        Runoff = 0;
        Infl = P;
    else
        Runoff = (term^2)/(P+(1-(5/100))*S);
        Infl = P-Runoff;
    end
else
    % Bunds on field, therefore no surface runoff 
    Runoff = 0;
    Infl = P;
end
    
end

