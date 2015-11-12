function varargout = timemodule2(varargin)
% TIMEMODULE2 M-file for timemodule2.fig
%      TIMEMODULE2, by itself, creates a new TIMEMODULE2 or raises the existing
%      singleton*.
%
%      H = TIMEMODULE2 returns the handle to a new TIMEMODULE2 or the handle to
%      the existing singleton*.
%
%      TIMEMODULE2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TIMEMODULE2.M with the given input arguments.
%
%      TIMEMODULE2('Property','Value',...) creates a new TIMEMODULE2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before timemodule2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to timemodule2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help timemodule2

% Last Modified by GUIDE v2.5 12-Nov-2015 10:37:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @timemodule2_OpeningFcn, ...
                   'gui_OutputFcn',  @timemodule2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before timemodule2 is made visible.
function timemodule2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to timemodule2 (see VARARGIN)

% Choose default command line output for timemodule2
handles.output = hObject;
if strcmp(get(hObject,'Visible'),'off')
    plot(0);
end

handles.signalnames = {};
handles.signals = {};
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = timemodule2_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

% --- Plots the signal on chosen axes.
function [step] = get_step(signal)
global fs
step = 0:1/fs:(length(signal) - 1)/fs;

function context_plot(signal)
plot(get_step(signal), signal);

% --- Executes on button press in plotbutton.
function plotbutton_Callback(hObject, eventdata, handles)
axes(handles.axes1);
xlabel('Time [s]');
ylabel('Amplitude [s]');
cla;

if length(handles.signals) > 0
	context_plot(handles.signals{get(handles.ListboxSignal, 'Value')});
end

% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
global fa fb fc fs
[signalname, signalpath] = uigetfile('*.ascii', 'Choose the data file');

if ~isequal(signalname, 0)
	signal = load(strcat(signalpath, signalname));
    signal = (signal + fa)*fb - fc;
	signalname = signalname(1:length(signalname)-6);

	handles.signalnames{length(handles.signalnames)+1} = signalname;
	handles.signals{length(handles.signals)+1} = signal;
	set(handles.ListboxSignal, 'String', handles.signalnames);
	if isequal(length(handles.signals), 1)
		context_plot(signal);
	end
end

guidata(hObject, handles);

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
selection = questdlg(['Close ''Time domain'' module?'],...
                     ['Close ''Time domain'' module...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end
delete(handles.figure1)

% --- Executes on selection change in ListboxSignal.
function ListboxSignal_Callback(hObject, eventdata, handles)
context_plot(handles.signals{get(hObject, 'Value')});

% --- Executes during object creation, after setting all properties.
function ListboxSignal_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'),...
	               get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in ButtonStatistics.
function ButtonStatistics_Callback(hObject, eventdata, handles)
global fs
% # Statistics text
% Signal:
% Interval:
% Mean:
% Standard Deviation:
% Median:
% Minimum:
% Latency of minimum:
% Maximum:
% Latency of maximum:
% Recording time:
set(handles.textStatistics, 'Enable', 'on');

signal = handles.signals{get(handles.ListboxSignal, 'Value')};
signalname = handles.signalnames{get(handles.ListboxSignal, 'Value')};
signalmean = mean(signal);
signalmedian = median(signal);
signalstd = std(signal);
[signalminimum signalminlat] = min(signal);
[signalmaximum signalmaxlat] = max(signal);
signalinterval = length(signal) / fs; % fix this when selection of intervals is enabled
signalrecordingtime = length(signal) / fs;

set(handles.textStatistics, 'String', {...
	['Signal: ' signalname];...
	['Interval: ' num2str(signalinterval)];...
	['Mean: ' num2str(signalmean)];...
	['Standard deviation: ' num2str(signalstd)];...
	['Median: ' num2str(signalmedian)];...
	['Minimum: ' num2str(signalminimum)];...
	['Latency of minimum: ' num2str(signalminlat/fs)];...
	['Maximum: ' num2str(signalmaximum)];...
	['Latency of maximum: ' num2str(signalmaxlat/fs)];...
	['Recording time: ' num2str(signalrecordingtime)]});

guidata(hObject, handles);


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in CheckFine.
function CheckFine_Callback(hObject, eventdata, handles)
flag = 'off';

if isequal(get(hObject, 'Value'), true)
	flag = 'on';
end

set(handles.editMin, 'Enable', flag);
set(handles.editMax, 'Enable', flag);
set(handles.ButtonAdjust, 'Enable', flag);
guidata(hObject, handles);

function editMin_Callback(hObject, eventdata, handles)
% hObject    handle to editMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMin as text
%        str2double(get(hObject,'String')) returns contents of editMin as a double


% --- Executes during object creation, after setting all properties.
function editMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'),...
	               get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ButtonAdjust.
function ButtonAdjust_Callback(hObject, eventdata, handles)
global fs
beginning = round(str2num(get(handles.editMin, 'String')) * fs);
ending = round(str2num(get(handles.editMax, 'String')) * fs);
index = get(handles.ListboxSignal, 'Value');
signal = handles.signals{index};
signal = signal(beginning:ending);
context_plot(signal);
handles.signals{index} = signal;
guidata(hObject, handles);

function editMax_Callback(hObject, eventdata, handles)
% hObject    handle to editMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMax as text
%        str2double(get(hObject,'String')) returns contents of editMax as a double


% --- Executes during object creation, after setting all properties.
function editMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'),...
	               get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
