function license(mode)

switch mode
 case 'create'

  if ~isempty(findobj('Tag','License'))
   figure(findobj('Tag','License'));
   return
  end

  fp=fopen('license.txt','r');
  LicenseText={};
  i=1;
  while feof(fp)==0
  s=fgetl(fp);
  i=i+1;
  LicenseText{i}=s;
 end
 fclose(fp);

 sp=get(0,'ScreenSize');
 f=figure(...
    'Tag','License',...
    'MenuBar','none',...
    'Resize', 'off', ...
    'Name', 'License', ...
    'NumberTitle', 'off', ...
    'Position',[floor(sp(3)/2)-225, floor(sp(4)/2)-175,450,350]...
   );

 t=uicontrol(...
    'Style','Text',...
    'Position',[20 313 300 30],...
    'BackgroundColor',get(f,'Color'),...
    'FontName','Helvetica',...
    'FontSize',18,...
    'FontWeight','bold',...
    'HorizontalAlignment', 'left', ...
    'String','GNU Public License'...
   );

 t=uicontrol(...
    'Style','Listbox',...    
    'BackgroundColor',get(f,'Color'),...
    'Position',[20 50 380 250],...
    'String',LicenseText,...   
    'Max',5 ...
   );

 t=uicontrol(...
    'Style','Pushbutton',...   
    'BackgroundColor',get(f,'Color'),...
    'Position',[350 10 70 30],...
    'FontName','Helvetica',...
    'FontSize',14,...    
    'String','Close',...
    'Callback','license(''close'')'...
   );

  uiwait(findobj('Tag','SplashScreen'));

 case 'close' 
  f=findobj('Tag','License');
  close(f); 
 otherwise
  error('License::UnknownMode');
end