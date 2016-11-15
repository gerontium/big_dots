clear
close all
clc

load('resp_locked_example.mat')


%% Plot each individual participant's CPPr_slope with same time-window
slope_timeframe_index=[find(tr==-110),find(tr==-10)];
for s=1:length(allsubj)
    clear h
    figure
    for side = 1:2
        h(side) = plot(tr,CPPr_side(s,:,side),'LineWidth',3,'LineStyle','-');hold on       
        coef = polyfit(tr(slope_timeframe_index(1):slope_timeframe_index(2)),(CPPr_side(s,slope_timeframe_index(1):slope_timeframe_index(2),side)),1);% coef gives 2 coefficients fitting r = slope * x + intercept
        CPP_slope(s,side)=coef(1);
        r = coef(1) .* tr(slope_timeframe_index(1):slope_timeframe_index(2)) + coef(2); %r=slope(x)+intercept, r is a vectore representing the linear curve fitted to the erpr during slope_timeframe
        plot(tr(slope_timeframe_index(1):slope_timeframe_index(2)), r,'Linewidth',2, 'LineStyle', ':');   
    end
    
    set(gca,'FontSize',16,'xlim',[-500,100]);%,'ylim',[-4,8],'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
    ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
    xlabel('Time (ms)','FontName','Arial','FontSize',16)
    title([subject_folder{s}, ' CPP (resp-locked) by Hemifield'])
    line([0,0],ylim,'Color','k','LineWidth',1.5,'LineStyle','--');
    line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle','-');
    legend(h,side_tags,'FontSize',16,'Location','NorthWest');
   pause(1) 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
keyboard 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Now plot each individual participant's CPPr_slope with time-window allowed to vary per participant

%CPP build-up defined as the slope of a straight line fitted to the
%response-locked waveform  during "slope_timeframe_index" defined for
%each participant here:
clear slope_timeframe_index 
for s=1:length(allsubj)
 slope_timeframe_index(s,2)=find(mean(CPPr_side(s,:,:),3)==max(mean(CPPr_side(s,find(tr<0),:),3)));%max amplitude index
end
slope_timeframe_index(:,1)=slope_timeframe_index(:,2)-50;%subtract 50samples (i.e. 100ms) from max amplitude index to form slope_timeframe window
%Now find and save CPPr slope
for s=1:length(allsubj)
    for side = 1:2  
        coef = polyfit(tr(slope_timeframe_index(s,1):slope_timeframe_index(s,2)),(CPPr_side(s,slope_timeframe_index(s,1):slope_timeframe_index(s,2),side)),1);% coef gives 2 coefficients fitting r = slope * x + intercept
        CPPr_slope(s,side)=coef(1);  
    end
end

%Now plot:
for s=1:length(allsubj)
    clear h
    figure
    for side = 1:2
        h(side) = plot(tr,CPPr_side(s,:,side),'LineWidth',3,'LineStyle','-');hold on       
        coef = polyfit(tr(slope_timeframe_index(s,1):slope_timeframe_index(s,2)),(CPPr_side(s,slope_timeframe_index(s,1):slope_timeframe_index(s,2),side)),1);% coef gives 2 coefficients fitting r = slope * x + intercept
        CPP_slope(s,side)=coef(1);
        r = coef(1) .* tr(slope_timeframe_index(s,1):slope_timeframe_index(s,2)) + coef(2); %r=slope(x)+intercept, r is a vectore representing the linear curve fitted to the erpr during slope_timeframe
        plot(tr(slope_timeframe_index(s,1):slope_timeframe_index(s,2)), r,'Linewidth',2, 'LineStyle', ':');   
    end
    
    set(gca,'FontSize',16,'xlim',[-500,100]);%,'ylim',[-4,8],'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
    ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
    xlabel('Time (ms)','FontName','Arial','FontSize',16)
    title([subject_folder{s}, ' CPP (resp-locked) by Hemifield'])
    line([0,0],ylim,'Color','k','LineWidth',1.5,'LineStyle','--');
    line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle','-');
    legend(h,side_tags,'FontSize',16,'Location','NorthWest');
   pause(1) 
end



