function varargout = plot_stuff(varargin)
% This modele provides the way for the user to clear the data
% obtained from the analysis made for the beginning of a word.
% If there's more data being recorded as a speech, the user can
% leave it unmarked to be erased when the file is saved.
%

% Edit the above text to modify the response to help plot_stuff

% Last Modified by GUIDE v2.5 07-Nov-2016 09:36:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
					 'gui_Singleton',  gui_Singleton, ...
					 'gui_OpeningFcn', @plot_stuff_OpeningFcn, ...
					 'gui_OutputFcn',  @plot_stuff_OutputFcn, ...
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


% --- Executes just before plot_stuff is made visible.
function plot_stuff_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plot_stuff (see VARARGIN)

% Choose default command line output for plot_stuff
handles.output = hObject;
handles.files = varargin{1};
handles.stuff = varargin{2};

% Update handles structure
set(handles.figure1, 'Name', 'Verificacao dos Momentos');
repeated = 1;
handles.repeated = repeated;

if repeated == length(handles.files)
	set(handles.pushbuttonSave, 'String', 'Salvar');
end
[handles.record, handles.fs] = refresh_signal(hObject, handles,...
							   handles.files, handles.stuff, handles.repeated);
guidata(hObject, handles);

% UIWAIT makes plot_stuff wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plot_stuff_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
%varargout{2} = handles.stuff; % TODO Check when these objects are returned

% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
	open(file);
end

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
					 ['Close ' get(handles.figure1,'Name') '...'],...
					 'Yes','No','Yes');
if strcmp(selection,'No')
	return;
end

delete(handles.figure1)


% --------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function textFilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in popupmenuFiles.
function popupmenuFiles_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenuFiles contents 
%                                         as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuFiles


% --- Executes during object creation, after setting all properties.
function popupmenuFiles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), ...
		   get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listboxMoments.
function listboxMoments_Callback(hObject, eventdata, handles)
% hObject    handle to listboxMoments (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

filename = get(handles.textFilename, 'String');
moments = handles.stuff.get(filename);
maxlist = numel(moments);
set(handles.listboxMoments, 'Max', maxlist);


% --- Executes during object creation, after setting all properties.
function listboxMoments_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxMoments (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), ...
		   get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonView.
function pushbuttonView_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

filename = get(handles.textFilename, 'String');
moments = cellstr(get(handles.listboxMoments, 'String'));
list = get(handles.listboxMoments, 'Value');

for n = 1:numel(list)
	selected(n) = moments(list(n));
end

% TODO Find a better way to "replot"
hold(handles.axes1, 'on');
m = 1;

for n = 1:numel(moments)
	if m <= numel(selected)
	if strcmp(moments(n), selected(m)), 
		xposition = str2double(selected(m));
		plot(xposition, -1:0.01:1, 'g', 'LineWidth', 2,...
			 'MarkerFaceColor', 'g', 'MarkerSize', 10);
		m = m + 1;
	else
		xposition = str2double(moments(n));
		plot(xposition, -1:0.01:1, 'r', 'LineWidth', 2,...
			 'MarkerFaceColor', 'g', 'MarkerSize', 10);
	end
	else
	xposition = str2double(moments(n));
	plot(xposition, -1:0.01:1, 'r', 'LineWidth', 2,...
		 'MarkerFaceColor', 'g', 'MarkerSize', 10);
	end
end
hold off;


% --- Executes on button press in pushbuttonSave.
function pushbuttonSave_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global abcxyz;
repeated = handles.repeated;

filename = get(handles.textFilename, 'String');
moments = cellstr(get(handles.listboxMoments, 'String'));
list = get(handles.listboxMoments, 'Value');

selection = questdlg({'Avancar salva apenas os momentos selecionados.' 'Deseja continuar?'},...
					 ['Salvar ' filename '?'],...
					 'Ok','Cancelar','Ok');
if strcmp(selection,'Cancelar')
	return;
end

for n = 1:numel(list)
	list(n) = str2double(moments(list(n)));
end

recordtime = length(handles.record)/handles.fs;
moments = turn_to_moment(handles.stuff.get(filename), list, recordtime);

handles.stuff.put(filename, moments);
set(handles.listboxMoments, 'Value', 1);

repeated = repeated + 1;
handles.repeated = repeated;

if repeated <= length(handles.files)
	if repeated == length(handles.files)
		set(handles.pushbuttonSave, 'String', 'Salvar');
	end
	[handles.record, handles.fs] = refresh_signal(hObject, handles,...
							       handles.files, handles.stuff, handles.repeated);
	guidata(hObject, handles);
else
	abcxyz = handles.stuff;
	delete(handles.figure1); % After storing the result of plot_stuff
						 	 % in abcxyz, closes the window
end
