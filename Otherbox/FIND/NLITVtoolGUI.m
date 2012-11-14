function NLITVtoolGUI()
% Non linear interdependencies GUI
% function NLITVtoolGUI()
%
% J. A. Farrimond, B. J. Whalley, G. J. Stephens and S. J. Nasuto
% University of Reading, UK
% http://www.pharmacy.rdg.ac.uk/research/electrophys.htm

global BUTTON_HEIGHT;
global LABEL_HEIGHT;
global MESSAGEBAR_PANEL_HEIGHT;
global MESSAGEBAR_LEFT_OFFSET;
global MESSAGEBAR_RIGHT_OFFSET;
global nsFile;

try
    % Check if the NVITVtoolGUI is already open
    if ishandle(findobj('tag', 'NLITVtoolGUI'))
        close(findobj('tag', 'NLITVtoolGUI'));
    end;
    
    % GUI window posn
    GUIxPos=20;
    GUIyPos=20;
    GUIwidth=70;
    GUIheight=20;
    
    
    % NVITVtoolGUI - main window
    GUIwindow=figure('Units','characters',...
        'Position',[GUIxPos GUIyPos GUIwidth GUIheight], ...
        'Tag','NLITVtoolGUI', ...
        'Name','Non linear interdependencies GUI',...
        'MenuBar','none',...
        'NumberTitle','off',...
        'resize','off');
    
     % panels
    centralPanel=uipanel('Parent',GUIwindow,...
        'Units','characters',...
        'Position',[0 MESSAGEBAR_PANEL_HEIGHT ...
        GUIwidth (GUIheight-MESSAGEBAR_PANEL_HEIGHT)],...
        'Tag','sortSpikesGUI_centralPanel',...
        'BackgroundColor', [0.8 0.8 0.8]);
    
%     % panels
%     % Top panel
%     TopPanel=uipanel('Parent',GUIwindow,...
%         'Units','characters',...
%         'Position',[0 (((HMBH/3)*2)+MBH) GUIwidth (HMBH/3)],...
%         'Tag','NLITVtoolGUI_TopPanel',...
%         'BackgroundColor', [0.8 0.8 0.8]);
%         
%     % Middle panel
%     MidPanel=uipanel('Parent',GUIwindow,...
%         'Units','characters',...
%         'Position',[0 ((HMBH/3)+MBH) GUIwidth (HMBH/3)],...
%         'Tag','NLITVtoolGUI_BottomPanel',...
%         'BackgroundColor', [0.8 0.8 0.8]);
%     
%     % Bottom panel
%     BottomPanel=uipanel('Parent',GUIwindow,...
%         'Units','characters',...
%         'Position',[0 MBH GUIwidth (HMBH/3)],...
%         'Tag','NLITVtoolGUI_BottomPanel',...
%         'BackgroundColor', [0.8 0.8 0.8]);
    
    % message bar
    messageBarPanel=uipanel('Parent',GUIwindow,...
        'Units','characters',...
        'Position',[0 0 ...
        GUIwidth MESSAGEBAR_PANEL_HEIGHT],...
        'Tag','NLITVtoolGUI_messageBarPanel');
    
   
    % Data entry text boxes
    % Embedding dimension
    uicontrol('Parent',centralPanel,...
        'Units','characters',...
        'Position',[5    13.5    15    BUTTON_HEIGHT],...
        'Style','edit',...
        'String','10',...
        'Tag','NLITVtoolGUI_m',...
        'Enable','on');
    uicontrol('Parent',centralPanel,...
        'Units','characters',...
        'Position',[5    15    15    2*BUTTON_HEIGHT],...
        'Style','text',...
        'String','Embedding Dimension',...
        'Tag','NLITVtoolGUI_mcom',...
        'Enable','on');
    
    % Tau
    uicontrol('Parent',centralPanel,...
        'Units','characters',...
        'Position',[25    13.5    15    BUTTON_HEIGHT],...
        'Style','edit',...
        'String','2',...
        'Tag','NLITVtoolGUI_tau',...
        'Enable','on');
    uicontrol('Parent',centralPanel,...
        'Units','characters',...
        'Position',[25    15    15    2*BUTTON_HEIGHT],...
        'Style','text',...
        'String','Tau constant',...
        'Tag','NLITVtoolGUI_taucom',...
        'Enable','on');
    
    % Nearest neighbours
    uicontrol('Parent',centralPanel,...
        'Units','characters',...
        'Position',[45    13.5    15    BUTTON_HEIGHT],...
        'Style','edit',...
        'String','10',...
        'Tag','NLITVtoolGUI_nneighbours',...
        'Enable','on');
    uicontrol('Parent',centralPanel,...
        'Units','characters',...
        'Position',[45    15    15    2*BUTTON_HEIGHT],...
        'Style','text',...
        'String','# Nearest neighbours',...
        'Tag','NLITVtoolGUI_nneighbourscom',...
        'Enable','on');
    
    % Theiler correction constant
    uicontrol('Parent',centralPanel,...
        'Units','characters',...
        'Position',[5    8    15    BUTTON_HEIGHT],...
        'Style','edit',...
        'String','50',...
        'Tag','NLITVtoolGUI_thel',...
        'Enable','on');
    uicontrol('Parent',centralPanel,...
        'Units','characters',...
        'Position',[5    9.5    15    2*BUTTON_HEIGHT],...
        'Style','text',...
        'String','Theiler correction',...
        'Tag','NLITVtoolGUI_thelcom',...
        'Enable','on');
    
    % Shiftlength (Currently set to 100 - to be updated in a later version)
    uicontrol('Parent',centralPanel,...
        'Units','characters',...
        'Position',[25    8    15    BUTTON_HEIGHT],...
        'Style','edit',...
        'String','100',...
        'Tag','NLITVtoolGUI_shiftlength',...
        'Enable','off');
    uicontrol('Parent',centralPanel,...
        'Units','characters',...
        'Position',[25    9.5    15    2*BUTTON_HEIGHT],...
        'Style','text',...
        'String','Shift length',...
        'Tag','NLITVtoolGUI_shiftlengthcom',...
        'Enable','on');
    
    % Sample frequency (Currently set to 10Khz - to be updated in a later
    % version)
    uicontrol('Parent',centralPanel,...
        'Units','characters',...
        'Position',[45    8    15    BUTTON_HEIGHT],...
        'Style','edit',...
        'String','10000',...
        'Tag','NLITVtoolGUI_samplefreq',...
        'Enable','off');
    uicontrol('Parent',centralPanel,...
        'Units','characters',...
        'Position',[45    9.5    15    2*BUTTON_HEIGHT],...
        'Style','text',...
        'String','Sample frequency',...
        'Tag','NLITVtoolGUI_samplefreqcom',...
        'Enable','on');
    
    % X electrode data input
    uicontrol('Parent',centralPanel,...
        'Units','characters',...
        'Position',[7    4    22    BUTTON_HEIGHT],...
        'Style','edit',...
        'String','',...
        'Tag','NLITVtoolGUI_xelec',...
        'Enable','on');
    uicontrol('Parent',centralPanel,...
        'Units','characters',...
        'Position',[7    5.5    22    BUTTON_HEIGHT],...
        'Style','text',...
        'String','X Electrode - EntityID',...
        'Tag','NLITVtoolGUI_xeleccom',...
        'Enable','on');
    
    % Y electrode data input
    uicontrol('Parent',centralPanel,...
        'Units','characters',...
        'Position',[35    4    22    BUTTON_HEIGHT],...
        'Style','edit',...
        'String','',...
        'Tag','NLITVtoolGUI_yelec',...
        'Enable','on');
    uicontrol('Parent',centralPanel,...
        'Units','characters',...
        'Position',[35    5.5    22    BUTTON_HEIGHT],...
        'Style','text',...
        'String','Y Electrode - EntityID',...
        'Tag','NLITVtoolGUI_yeleccom',...
        'Enable','on');
    
%% RUN BUTTON for NLITVtool.m
    uicontrol('Parent',centralPanel,...
        'Units','characters',...
        'Position',[1 BUTTON_HEIGHT+0.6 GUIwidth-3 BUTTON_HEIGHT],... 
        'Style','pushbutton',...
        'String','RUN NLITVtool - Warning : time consuming',...
        'Tag','NLITVtoolGUI_NLITVtoolPushbutton',...
        'Enable','on',...
        'Callback',@NLITVtoolPushbuttonCallback); 
    
%% RUN Button for NLItool.m
    uicontrol('Parent',centralPanel,...
        'Units','characters',...
        'Position',[1 0.3 GUIwidth-3 BUTTON_HEIGHT],... 
        'Style','pushbutton',...
        'String','RUN NLItool',...
        'Tag','NLItoolGUI_NLItoolPushbutton',...
        'Enable','on',...
        'Callback',@NLItoolPushbuttonCallback); 

catch
    close(findobj('tag', 'NLITVtoolGUI'));
    rethrow(lasterror);
end


% % RUN button callback function for NLITVtool.m
function NLITVtoolPushbuttonCallback(source,event)
% Run tool button callback; starts detectSpikes.
% Source and event args are generated by default.
global nsFile; %-% if needed
try
    % posting 'busy' message
    postMessage('Busy - please wait...');
    disp('PROCESSING');
    
    % Collect data from user input
    % m
    tmp = findobj('Tag','NLITVtoolGUI_m');
    userString = get(tmp(1),'String');
    minput = str2num((userString));
    
    % Tau
    tmp = findobj('Tag','NLITVtoolGUI_tau');
    userString = get(tmp(1),'String');
    tauinput = str2num((userString));

    % Nearest neighbours
    tmp = findobj('Tag','NLITVtoolGUI_nneighbours');
    userString = get(tmp(1),'String');
    nneighboursinput = str2num((userString));

    % Theiler correction
    tmp = findobj('Tag','NLITVtoolGUI_thel');
    userString = get(tmp(1),'String');
    thelinput = str2num((userString));
    
    % Shift length
    tmp = findobj('Tag','NLITVtoolGUI_shiftlength');
    userString = get(tmp(1),'String');
    shiftlengthinput = str2num((userString));

    % Sampling frequency
    tmp = findobj('Tag','NLITVtoolGUI_samplefreq');
    userString = get(tmp(1),'String');
    samplefreqinput = str2num((userString));
    
    % X Electrode
    tmp = findobj('Tag','NLITVtoolGUI_xelec');
    userString = get(tmp(1),'String');
    xelecinput = str2num((userString));
    
    % Y Electrode
    tmp = findobj('Tag','NLITVtoolGUI_yelec');
    userString = get(tmp(1),'String');
    yelecinput = str2num((userString));
   
    % some checks
    if ~isfield(nsFile,'Analog') || ~isfield(nsFile.Analog,'Data') ...
            || isempty(nsFile.Analog.Data)
        error('FIND:noAnalogData','No analog data found in nsFile variable.');
    end
    
     if isempty(xelecinput)|| isempty(yelecinput)
        postMessage('Please select Entities first');
        return;
     end
    
     if isempty(intersect(nsFile.Analog.DataentityIDs,xelecinput))||...
             isempty(intersect(nsFile.Analog.DataentityIDs,yelecinput))
          postMessage('selected analog Entities do not exist');
        return;
     end
     
    % Form dataset
    selecX=find(nsFile.Analog.DataentityIDs==xelecinput);
    selecY=find(nsFile.Analog.DataentityIDs==yelecinput);
    ltest = length(nsFile.Analog.Data);
    
    if (ltest > 0)
        if ((xelecinput) < (yelecinput))
            xfull=nsFile.Analog.Data(:,selecX);
            yfull=nsFile.Analog.Data(:,selecY);
        else
            xfull=nsFile.Analog.Data(:,selecY);
            yfull=nsFile.Analog.Data(:,selecX);
        end
    else
        postMessage('Please select electrode values');
    end
             
   NLITVtool(xfull,yfull,minput,tauinput,nneighboursinput,thelinput,shiftlengthinput,samplefreqinput);
  
    postMessage('Complete');
catch
   handleError(lasterror);
end


    % % RUN button callback function for NLItool.m
function NLItoolPushbuttonCallback(source,event)
% Run tool button callback; starts detectSpikes.
% Source and event args are generated by default.
global nsFile; %-% if needed
try
    % posting 'busy' message
    postMessage('Busy - please wait...');
    disp('PROCESSING');
    
    % Collect data from user input
    % m
    tmp = findobj('Tag','NLITVtoolGUI_m');
    userString = get(tmp(1),'String');
    minput = str2num((userString));
    
    % Tau
    tmp = findobj('Tag','NLITVtoolGUI_tau');
    userString = get(tmp(1),'String');
    tauinput = str2num((userString));

    % Nearest neighbours
    tmp = findobj('Tag','NLITVtoolGUI_nneighbours');
    userString = get(tmp(1),'String');
    nneighboursinput = str2num((userString));

    % Theiler correction
    tmp = findobj('Tag','NLITVtoolGUI_thel');
    userString = get(tmp(1),'String');
    thelinput = str2num((userString));
       
    % X Electrode
    tmp = findobj('Tag','NLITVtoolGUI_xelec');
    userString = get(tmp(1),'String');
    xelecinput = str2num((userString));
    
    % Y Electrode
    tmp = findobj('Tag','NLITVtoolGUI_yelec');
    userString = get(tmp(1),'String');
    yelecinput = str2num((userString));
   
    % Form dataset
    inputmatrix = nsFile.Analog.Data;
    ltest = length(inputmatrix);
    
    if (ltest > 0)
        if ((xelecinput) < (yelecinput))
            xfull2=inputmatrix(:,1);
            yfull2=inputmatrix(:,2);
        else
            xfull2=inputmatrix(:,2);
            yfull2=inputmatrix(:,1);
        end
    else
        postMessage('Please select electrode values');
    end
             
    NLItool(xfull2,yfull2,minput,tauinput,nneighboursinput,thelinput)
    
    postMessage('Complete');
catch
   handleError(lasterror);
end