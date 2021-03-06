function out=MEAtableassignGUI(in)
h=figure('Units','Normalized',...
    'Tag','MEAtableassignGUI', ...
    'Name','manual MEA electrode to entityID assignment',...
    'NumberTitle','off',...
    'MenuBar','none');

FIND_GUIdata=get(findobj('Tag','FIND_GUI'),'UserData');

MEAmap=FIND_GUIdata.MEAmap;
MEAmap=flipud(fliplr(MEAmap))
MEAtable=uitable('Parent',h,...
    'Data',MEAmap,...
    'Tag','MEAmaptable',...
    'ColumnEditable',logical(ones(1,size(MEAmap,1))),...
    'Units','normalized',...
    'Position',[0.05 0.15 0.9 0.8]);

setvaluespushbutton=uicontrol('Parent',h,...
    'Style','Pushbutton',...
    'String','Apply',...
    'Units','normalized',...
    'Callback','MEAchannelassignfromvar(flipud(fliplr(get(findobj(''Tag'',''MEAmaptable''),''Data''))))',...
    'Position',[0.4 0.05 0.2 0.08]);


