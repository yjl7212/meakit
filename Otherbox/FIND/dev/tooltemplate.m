%-%------------------------------------------------------------------------
%-% TEMPLATE for FIND tool windows
%-%------------------------------------------------------------------------
%-%
%-% This is a template for a FIND tool and its GUI. The contents need to be
%-% placed in three different files:
%-%
%-% In the main window, FIND_GUI.m:
%-%   - push button that opens the tool window (to be put in FIND_GUI())
%-%   - callback function for the button
%-%
%-% In the tool's GUI file, <TOOL>GUI.m:
%-%   - main function that initializes the UI components, including
%-%       * the GUI figure
%-%       * a central panel (as default, more can be added)
%-%       * a panel for the messageBar
%-%       * the messageBar, which is a UIcontrol 'text'
%-%       * the RUN button that starts the actual tool function
%-%   - a callback function for the RUN button
%-%
%-% In the tool's file, <TOOL>.m
%-%   - the tool function, including proper argument managment
%-%
%-% EDITING:
%-%   - All occurrences of <TOOL> need to be replaced with the name of the 
%-%     tool (function) itself, e.g. simulateGamma. It is probably best to 
%-%     use search & replace for that, and to do it first. Note that you
%-%     might have to insert a underscore where <TOOL> is followed by "GUI" 
%-%     if <TOOL> ends with an acronym, or change a letter that follows
%-%     to lowercase (see naming conventions below).
%-%   - Lines/comments starting with %-% are comments for the template 
%-%     itself and should be removed.
%-%   - Lines starting with >>> need to be edited in part (look for <>) or 
%-%     be replaced with proper content. Of course, the marker >>> is to be 
%-%     removed afterwards. The occurances of <TOOL>, which can be replaced 
%-%     automatically, are not marked in this way.
%-%
%-% NAMING CONVENTIONS:
%-%   - Globals are usually all uppercase (with underscores).
%-%   - In general, everything else is mixedCase, e.g. myNeuronData, 
%-%     simulateGamma.m, simulateGamma(). The uppercase letter serves as 
%-%     visual distinction between words *where necessary*. For instance, 
%-%     abbreviations should be all uppercase, and the following word is 
%-%     lowercase: PSTHdata. If this doesn't help/apply, use underscores: 
%-%     FIND_GUI.
%-%   - Tags of ui components have the tag of the respective tool GUI 
%-%     followed by an underscore as prefix. They should usually end with
%-%     the type of the uicontrol (the 'Style' property): 
%-%     'simulateGammaGUI_openFilePushbutton, 'FIND_GUI_infoLabelText'.
%-%   - Paramater-Value-Pairs are usually used as arguments of the tool 
%-%     functions. The standard mixedCase naming conventions apply.
%-%
%-% DOCUMENTATION:
%-%   Add documentation just below function headers. First comes the 'H1
%-%   line', which is a short synopsis in just one (!) line, e.g. "Detect
%-%   spikes in analog data.". Then follows the help text, which is needed
%-%   especially for the tool functions, but can be brief or be omitted for 
%-%   FIND internal functions (comment on the arguments if necessary). See
%-%   below under the tool function for suggestions concercning the form of 
%-%   the help text.
%-%
%-% TODO:
%-%   - possibly: Add template for basic resize function/several panels.




%-%------------------------------------------------------------------------
%-% to be placed in FIND main window file 
%-%------------------------------------------------------------------------
function <TOOL>GUIpushbutton=uicontrol('Parent',bottomPanel,...
    'Units','characters',...
>>>    'Position',[<> 1 25 BUTTON_HEIGHT],... %-% 1 and 25 are suggestions
    'Style','pushbutton',...
>>>    'String',<>,...
    'Tag','FIND_GUI_<TOOL>GUIpushbutton',...
    'Enable','on',...
    'Callback',@<TOOL>GUIpushbuttonCallback); 
    %-% use {@myCallback,arg1,arg2,...} to have args

function <TOOL>GUIpushbuttonCallback(source,event)
% Callback for the button that starts the tool's GUI.
% Source and event args are generated by default.
try
    postMessage(''); % Clean up prior messages.
%-% some checks maybe here?
    <TOOL>GUI(); %-% usually no arguments should be necessary
catch
    handleError(lasterror); 
end



%-%------------------------------------------------------------------------
%-% to be placed in tool GUI file (<TOOL>GUI.m) 
%-%------------------------------------------------------------------------
function <TOOL>GUI()
% GUI initialization of the <TOOL> GUI.

global nsFile; %-% if needed.

global BUTTON_HEIGHT;
global LABEL_HEIGHT;
global MESSAGEBAR_PANEL_HEIGHT;
global MESSAGEBAR_LEFT_OFFSET;
global MESSAGEBAR_RIGHT_OFFSET;

try
    
    % Check if the <TOOL> GUI is already open
    if ishandle(findobj('tag', '<TOOL>GUI'))
        close(findobj('tag', '<TOOL>GUI'));
    end;

    % GUI window
    %-% Values are suggestions for small window
    GUIxPos=20;
    GUIyPos=20;
    GUIwidth=70;
    GUIheight=20;
    
    GUIwindow=figure('Units','characters',...
        'Position',[GUIxPos GUIyPos GUIwidth GUIheight], ... 
        'Tag','<TOOL>GUI', ...
>>>        'Name',<>,...
        'MenuBar','none',...
          'NumberTitle','off',...
        'resize','off'); 

    % panels
    centralPanel=uipanel('Parent',GUIwindow,...
        'Units','characters',...
        'Position',[0 MESSAGEBAR_PANEL_HEIGHT ...
                    GUIwidth (GUIheight-MESSAGEBAR_PANEL_HEIGHT)],...
        'Tag','<TOOL>GUI_centralPanel',...
        'BackgroundColor', [0.8 0.8 0.8]);

    messageBarPanel=uipanel('Parent',GUIwindow,...
        'Units','characters',...
        'Position',[0 0 ...
                    GUIwidth MESSAGEBAR_PANEL_HEIGHT],...
        'Tag','<TOOL>GUI_messageBarPanel');

    % message bar
    messageBarPanelPos=get(messageBarPanel,'Position');
    uicontrol('Parent',messageBarPanel,...
        'Units','characters',...
        'Position',[(messageBarPanelPos(1)+MESSAGEBAR_LEFT_OFFSET) ...
                    (messageBarPanelPos(2)) ...
                    (messageBarPanelPos(3)-MESSAGEBAR_RIGHT_OFFSET) ...
                    LABEL_HEIGHT],...
        'Tag','<TOOL>GUI_messageBarText',...
        'Enable','on',...
        'String','',...
        'HorizontalAlignment','left',...
        'Style','text');

    % button to run the tool
    uicontrol('Parent',centralPanel,...
        'Units','characters',...
        'Position',[55 10 10 BUTTON_HEIGHT],... 
        'Style','pushbutton',...
        'String','RUN',...
        'Tag','<TOOL>GUI_<TOOL>Pushbutton',...
        'Enable','on',...
        'Callback',@<TOOL>PushbuttonCallback); 
        %-% use {@myCallback,arg1,arg2,...} to have args

        
    %-% rest of GUI below...   

    
catch
    % if error occurs here, the window is closed, the error is rethrown
    % and then catched by the main window
    close(findobj('tag', '<TOOL>GUI'));
    rethrow(lasterror);
end




function <TOOL>PushbuttonCallback(source,event) 
% Run tool button callback; starts <TOOL>.
% Source and event args are generated by default.
global nsFile; %-% if needed
try
    % posting 'busy' message
    postMessage('Busy - please wait...');

%-% some checks maybe here?

    <TOOL>(); %-% arguments?
    postMessage('...done.'); 
catch
   handleError(lasterror); 
end


%-%------------------------------------------------------------------------
%-% to be placed in tool file (<TOOL>.m)
%-%------------------------------------------------------------------------
function <TOOL>(varargin)
>>> % H1 line
>>> % Help text; use something like:
%-%% <summary text>
%-%%
%-%% Parameters to be passed as parameter-value pairs:
%-%%
%-%% %%%%% Obligatory Parameters %%%%%
%-%%
%-%% 'parameter1': Does this and that. Takes vector as argument. etc.
%-%%
%-%% 'parameter2': Does this and that.
%-%% Possible values:
%-%%    'value1' - does this. And that.
%-%%    
%-%%    'value2' - does something else.
%-%%
%-%% 'parameter3':
%-%% parameter3',[start,end]
%-%% Does this and that.
%-%%
%-%% %%%%% Optional Parameters %%%%%
%-%%
%-%% ... 
%-%%
%-%% Further comments:
%-%%
%-%% ... 
%-%%
%-%% Notes:
%-%%
%-%% - ...
%-%% - ...
%-%% ...
%-%% --------------------------------------------------
%-%% Original References of this tool
%-%% Futhere References: Analysis used in .....
%-%% Author of this Function (Year)
%-%% Original Version by .... (if applicable)
%-%% Example Call..


global nsFile; %-% if needed

% obligatory argument names
obligatoryArgs={}; %-% e.g. {'x','y'}

% optional arguments names with default values
optionalArgs={}; 
%-% e.g.: 
%-% a=500;
%-% b='spikes';

% Valid var names provided? Otherwise, error is generated. You can also
% supply functions to test the validity of the values, see checkPVP for
% details.
errorMessage=checkPVP(varargin,obligatoryArgs,optionalArgs);
if ~isempty(errorMessage)
  error(errorMessage,''); %used this format so that the '\n' are converted
end

% loading parameter value pairs into workspace, overwriting defaul values
pvpmod(varargin);

% It's a good idea to check whether appropriate data is stored in the
% nsFile. Throw an error if that's not the case. If the tool function is
% called from within the GUI, handleError() will be used (see above).
% Certain errors are handled in a specific way. To discern those, an error
% identifier is used when calling error(). See handleError.m for which
% identifiers are used. Below is an example. Here the availability of
% analog data is checked, and if necessary an error is thrown with the
% identifier "FIND:noAnalogData".
%
%-% if ~isfield(nsFile,'Analog') || ~isfield(nsFile.Analog,'Data') ...
%-%        || isempty(nsFile.Analog.Data)
%-%      error('FIND:noAnalogData','No analog data found in nsFile variable.');   
%-% end


% main function code
