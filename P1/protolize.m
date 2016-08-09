
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INICIAL CONDITIONS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
close all
% clear 
% clc

fa=4096;
fb=0.0610426077402027;
fc=250;
fs=256;
userdata{1}='\n';
userdata{2}='\n';
userdata{3}='\n';
userdata{4}='200';
userdata{5}='7';
userdata{6}='60';
deltaf1=0.5;
deltaf2=3.5;
thetaf1=3.5;
thetaf2=7;
alphaf1=8;
alphaf2=13;
bethaf1=15;
bethaf2=24;
gammaf1=30;
gammaf2=70;
calcok=0;
userok=0;
tsst_enable=0;
fft_enable=0;
sfft_enable=0;
cwt_enable=0;
dwt_enable=0;
edit_enable=0;
time_enable=0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%FRONTAL PANEL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

hin_protolize=figure('units','normalized',...
    'position',[0.0038,0.0495,0.993,0.89],...
    'menubar','none',...
    'numbertitle','off',...
    'name','PROTOLIZE',...
    'color','white',...
    'deletefcn','close all;clear;clc');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%MENU%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

hin_menuarquivo=uimenu('label','Arquivo');
hin_sair=uimenu(hin_menuarquivo,'label','Sair','callback','close all;clear;clc');

hin_menuajuda=uimenu('label','Ajuda');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%LABELS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 


hin_frame1=uicontrol('style','frame',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.02,0.2,0.3,0.67]);  

hin_frame11=uicontrol('style','frame',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.02,0.89,0.3,0.09]);  

hin_protlabel=uicontrol('style','text',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.086,0.91,0.17,0.05],...
    'fontname','arial',...
    'fontsize',20,...
    'string','PROTOCOLOS');

hin_frame2=uicontrol('style','frame',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.35,0.2,0.3,0.67]);

hin_frame22=uicontrol('style','frame',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.35,0.89,0.3,0.09]);

hin_editlabel=uicontrol('style','text',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.45,0.91,0.1,0.05],...
    'fontname','arial',...
    'fontsize',20,...
    'string','EDI��O');

hin_frame3=uicontrol('style','frame',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.68,0.2,0.3,0.67]);

hin_frame33=uicontrol('style','frame',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.68,0.89,0.3,0.09]);

hin_analizelabel=uicontrol('style','text',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.775,0.91,0.12,0.05],...
    'fontname','arial',...
    'fontsize',20,...
    'string','AN�LISE');

hin_frame4=uicontrol('style','frame',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.35,0.02,0.63,0.15]);

hin_frame5=uicontrol('style','frame',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.02,0.02,0.3,0.15]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PROTOCOL BUTTONS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

fin_tsst_fcn=['switch tsst_enable;'...
        'case 1;'...
            'figure(htsst_f);'...
        'case 0;'...
            'tsstmodule;'...
    'end;'];

hin_tsst=uicontrol('style','pushbutton',...
    'units','normalized',...
    'fontname','arial',...
    'fontsize',12,...
    'string','TSST',...
    'Interruptible','off',...
    'position',[0.065,0.51,0.2,0.07],...
    'callback',fin_tsst_fcn);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%EDITION BUTTONS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

fin_edit_fcn=['switch edit_enable;'...
        'case 1;'...
            'figure(h5editfig);'...
        'case 0;'...
            'editionmodule;'...
    'end;'];

hin_edittf=uicontrol('style','pushbutton',...
    'units','normalized',...
    'fontname','arial',...
    'fontsize',12,...
    'string','Tempo / Espectro',...
    'Interruptible','off',...
    'position',[0.405,0.58,0.2,0.07],...
    'callback',fin_edit_fcn);

fin_dwt_fcn=['switch dwt_enable;'...
        'case 1;'...
            'figure(h7dwt);'...
        'case 0;'...
            'dwtmodule;'...
    'end;'];

hin_editdwt=uicontrol('style','pushbutton',...
    'units','normalized',...
    'fontname','arial',...
    'fontsize',12,...
    'string','DWT',...
    'Interruptible','off',...
    'position',[0.405,0.44,0.2,0.07],...
    'callback',fin_dwt_fcn);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ANALIZE BUTTONS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

fin_time_fcn=['switch time_enable;'...
        'case 1;'...
            'figure(h0showsignal);'...
        'case 0;'...
            'timemodule;'...
    'end;'];

hin_antempo=uicontrol('style','pushbutton',...
    'units','normalized',...
    'fontname','arial',...
    'fontsize',12,...
    'string','Dom�nio do Tempo',...
    'Interruptible','off',...
    'position',[0.735,0.72,0.2,0.07],...
    'callback',fin_time_fcn);

fin_fft_fcn=['switch fft_enable;'...
        'case 1;'...
            'figure(h1fourier);'...
        'case 0;'...
            'fouriermodule;'...
    'end;'];

hin_anfourier=uicontrol('style','pushbutton',...
    'units','normalized',...
    'fontname','arial',...
    'fontsize',12,...
    'string','Fourier',...
    'Interruptible','off',...
    'position',[0.735,0.58,0.2,0.07],...
    'callback',fin_fft_fcn);

fin_sfft_fcn=['switch sfft_enable;'...
        'case 1;'...
            'figure(h2showsignal);'...
        'case 0;'...
            'sfftmodule;'...
    'end;'];

hin_ansfft=uicontrol('style','pushbutton',...
    'units','normalized',...
    'fontname','arial',...
    'fontsize',12,...
    'string','STFT',...
    'Interruptible','off',...
    'position',[0.735,0.44,0.2,0.07],...
    'callback',fin_sfft_fcn);

fin_cwt_fcn=['switch cwt_enable;'...
        'case 1;'...
            'figure(h6cwt);'...
        'case 0;'...
            'cwtmodule;'...
    'end;'];

hin_ancwt=uicontrol('style','pushbutton',...
    'units','normalized',...
    'fontname','arial',...
    'fontsize',12,...
    'string','CWT',...
    'Interruptible','off',...
    'position',[0.735,0.3,0.2,0.07],...
    'callback',fin_cwt_fcn);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CONFIG BUTTONS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 


hin_userconfig=uicontrol('style','pushbutton',...
    'units','normalized',...
    'fontname','arial',...
    'fontsize',12,...
    'string','Configurar Usuario',...
    'Interruptible','off',...
    'position',[0.065,0.057,0.2,0.07],...
    'callback','userconfig');

hin_paramconfig=uicontrol('style','pushbutton',...
    'units','normalized',...
    'fontname','arial',...
    'fontsize',12,...
    'string','Configurar Par�metros',...
    'Interruptible','off',...
    'position',[0.405,0.057,0.2,0.07],...
    'callback','regconfig');

hin_ritconfig=uicontrol('style','pushbutton',...
    'units','normalized',...
    'fontname','arial',...
    'fontsize',12,...
    'string','Configurar Ritmos',...
    'Interruptible','off',...
    'position',[0.735,0.057,0.2,0.07],...
    'callback','ritconfig');

