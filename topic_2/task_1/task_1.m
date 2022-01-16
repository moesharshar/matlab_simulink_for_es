function varargout = task_1(varargin)
% task_1 MATLAB code for task_1.fig
%      task_1, by itself, creates a new task_1 or raises the existing
%      singleton*.
%
%      H = task_1 returns the handle to a new task_1 or the handle to
%      the existing singleton*.
%
%      task_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in task_1.M with the given input arguments.
%
%      task_1('Property','Value',...) creates a new task_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before task_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to task_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help task_1

% Last Modified by GUIDE v2.5 16-Jan-2022 08:37:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @task_1_OpeningFcn, ...
                   'gui_OutputFcn',  @task_1_OutputFcn, ...
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


% --- Executes just before task_1 is made visible.
function task_1_OpeningFcn(hObject, eventdata, handles, varargin)
global happy;
global sad;
happy = imread("happy.jpg");
sad = imread("sad.jpg");
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to task_1 (see VARARGIN)

% Choose default command line output for task_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes task_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = task_1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global happy;
global sad;

data=str2double(get(handles.edit1,'String'));
axes(handles.axes1);
%disp(data);

if isnan(data) || isempty(data) || data < 0 || data > 100
    set(handles.text3, 'String', 'Not valid input');
    message = sprintf('I said it had to be a number and valid and between 0: 100.');
    uiwait(errordlg(message));  
    
elseif data>60 
   set(handles.text3,'String',"Happy");
   %axes(handles.axes1);
   imshow(happy);
else
    set(handles.text3,'String',"Sad");
    %axes(handles.axes1);
    imshow(sad);
end
