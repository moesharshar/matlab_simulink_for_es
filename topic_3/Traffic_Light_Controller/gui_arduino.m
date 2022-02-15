function varargout = gui_arduino(varargin)
% GUI_ARDUINO MATLAB code for gui_arduino.fig
%      GUI_ARDUINO, by itself, creates a new GUI_ARDUINO or raises the existing
%      singleton*.clear
%
%      H = GUI_ARDUINO returns the handle to a new GUI_ARDUINO or the handle to
%      the existing singleton*.
%
%      GUI_ARDUINO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_ARDUINO.M with the given input arguments.
%
%      GUI_ARDUINO('Property','Value',...) creates a new GUI_ARDUINO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_arduino_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_arduino_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_arduino

% Last Modified by GUIDE v2.5 05-Feb-2022 11:51:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_arduino_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_arduino_OutputFcn, ...
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


% --- Executes just before gui_arduino is made visible.
function gui_arduino_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_arduino (see VARARGIN)

% Choose default command line output for gui_arduino
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global maxPeople;
global maxCars;
global maintenanceFlag;
maintenanceFlag=0;
global modeFlag;
global go;
global stop;
%modeFlag='automaticBtn';
%set(handles.maintenanceBtn1,'string','Press here')
set(handles.maintenanceStatus,'string','Maintenance mode activated')
maxCars=0;
maxPeople=0;
go = imread('green.jpg');
stop=imread('red.jpg');

delete(instrfind({'Port'},{'COM9'}))
global ArduinoObject;
ArduinoObject=arduino('COM9','UNO');
configurePin(ArduinoObject,'D13','DigitalOutput');
configurePin(ArduinoObject,'D12','DigitalOutput');
configurePin(ArduinoObject,'D11','DigitalOutput');

set(handles.maintenancePanel,'Visible','on');
set(handles.manualPanal,'Visible','off');
set(handles.automaticPanel,'Visible','off');
set(handles.trafficStatus,'Visible','off');


    set(handles.carsCounter,'string','0');
    set(handles.peopleCounter,'string','0');
    plot(handles.trafficStatus,0,0);
    writeDigitalPin(ArduinoObject,'D11',0); %red
    writeDigitalPin(ArduinoObject,'D12',0); %yellow
    writeDigitalPin(ArduinoObject,'D13',0); %green

% UIWAIT makes gui_arduino wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_arduino_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ON.
function ON_Callback(hObject, eventdata, handles)
%global ArduinoObject;
%writeDigitalPin(ArduinoObject,'D13',1);


% hObject    handle to ON (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in OFF.
function OFF_Callback(hObject, eventdata, handles)
%global ArduinoObject;
%writeDigitalPin(ArduinoObject,'D13',0);
% hObject    handle to OFF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
%{
global ArduinoObject;
i=0;
x=[i];

oldV = readVoltage(ArduinoObject,'A0');
y=[oldV];
plot(handles.axes1,x,y);
while(1)
    voltage = readVoltage(ArduinoObject,'A0');
    if(voltage~=oldV)
            %set(handles.text2,'string',double2str(voltage));
            i=i+1;
            y=[y voltage]
            x=[x i]
            oldV=voltage;
            plot(handles.axes1,x,oldV);
            ylim(handles,[-1,6])
            xlim(handles,[-1,100])
            
    end
end
%}
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in redBtn.
function redBtn_Callback(hObject, eventdata, handles)

global ArduinoObject;
global stop;

axes(handles.trafficStatus);
imshow(stop);

writeDigitalPin(ArduinoObject,'D11',1); %red
writeDigitalPin(ArduinoObject,'D12',0); %yellow
writeDigitalPin(ArduinoObject,'D13',0); %green


% hObject    handle to redBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in greenBtn.
function greenBtn_Callback(hObject, eventdata, handles)
global maintenanceFlag;
global modeFlag;
global ArduinoObject;
global go;
axes(handles.trafficStatus);
imshow(go);


writeDigitalPin(ArduinoObject,'D11',0); %red
writeDigitalPin(ArduinoObject,'D12',0); %yellow
writeDigitalPin(ArduinoObject,'D13',1); %green

% hObject    handle to greenBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in yellowBtn.
function yellowBtn_Callback(hObject, eventdata, handles)

global maintenanceFlag;
global modeFlag;
global ArduinoObject;
writeDigitalPin(ArduinoObject,'D11',0); %red
writeDigitalPin(ArduinoObject,'D12',1); %yellow
writeDigitalPin(ArduinoObject,'D13',0); %green

% hObject    handle to yellowBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function peopleCounterSetup_Callback(hObject, eventdata, handles)
% hObject    handle to peopleCounterSetup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of peopleCounterSetup as text
%        str2double(get(hObject,'String')) returns contents of peopleCounterSetup as a double


% --- Executes during object creation, after setting all properties.
function peopleCounterSetup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to peopleCounterSetup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function carsCounterSetup_Callback(hObject, eventdata, handles)
% hObject    handle to carsCounterSetup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of carsCounterSetup as text
%        str2double(get(hObject,'String')) returns contents of carsCounterSetup as a double


% --- Executes during object creation, after setting all properties.
function carsCounterSetup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to carsCounterSetup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in maintenanceBtn1.
function maintenanceBtn1_Callback(hObject, eventdata, handles)
global maintenanceFlag;
global modeFlag;
global maxPeople;
global maxCars;
global ArduinoObject;

    
writeDigitalPin(ArduinoObject,'D11',0); %red
writeDigitalPin(ArduinoObject,'D12',0); %yellow
writeDigitalPin(ArduinoObject,'D13',0); %green

    maintenanceFlag=1;
    set(handles.maintenancePanel,'Visible','on');
    set(handles.manualPanal,'Visible','off');
    set(handles.automaticPanel,'Visible','off');
    set(handles.trafficStatus,'Visible','off');
    set(handles.maintenanceStatus,'string','Maintenance mode activated');
    
       
    
% hObject    handle to maintenanceBtn1 (see GCBO)tn
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of maintenanceBtn1


% --- Executes on button press in deployBtn.
function deployBtn_Callback(hObject, eventdata, handles)
global maintenanceFlag;
global modeFlag;
global maxPeople;
global maxCars;
global ArduinoObject;
global stop;
global go;

set(handles.maintenanceStatus,'string','Operational mode activated')

%modeFlag=get(handles.mode,'Value');
h=get(handles.mode,'SelectedObject');
modeFlag=get(h,'Tag');

switch modeFlag
case 'automaticBtn'

    set(handles.maintenancePanel,'Visible','off');
    set(handles.manualPanal,'Visible','off');
    set(handles.automaticPanel,'Visible','on');
    set(handles.trafficStatus,'Visible','off');
    
    maxCars=str2double(get(handles.carsCounterSetup,'string'));
    maxPeople=str2double(get(handles.carsCounterSetup,'string'));
    break_flag=0;
    axes(handles.trafficStatus);
while(1) %automatic
        
        imshow(stop);
        writeDigitalPin(ArduinoObject,'D11',1); %red
        for i = maxPeople:-1:0
            set(handles.peopleCounter,'string',i);
            if(maintenanceFlag==1)
                break_flag=1;
                break
            end
            
                
            pause(1);
        end
        
        
        writeDigitalPin(ArduinoObject,'D11',0); %red
        if(break_flag==1)
            break
        end
        writeDigitalPin(ArduinoObject,'D12',1); %yellow
        pause(3);
        writeDigitalPin(ArduinoObject,'D12',0); %yellow

        
        imshow(go);
        writeDigitalPin(ArduinoObject,'D13',1); %green
        for i = maxCars:-1:0
            set(handles.carsCounter,'string',i);
            if(maintenanceFlag==1)
                break_flag=1;
                break;
            end
            pause(1);
        end
    
    
        
            
end

    case 'manualBtn'
        set(handles.maintenancePanel,'Visible','off');
        set(handles.manualPanal,'Visible','on');
        set(handles.automaticPanel,'Visible','off');
        set(handles.trafficStatus,'Visible','off');
  
end
      
        
    
    
    

    
    

% hObject    handle to deployBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in maintenanceBtn2.
function maintenanceBtn2_Callback(hObject, eventdata, handles)
% hObject    handle to maintenanceBtn2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of maintenanceBtn2
global maintenanceFlag;
global ArduinoObject;
maintenanceFlag=1;
set(handles.maintenancePanel,'Visible','on');
set(handles.manualPanal,'Visible','off');
set(handles.automaticPanel,'Visible','off');
set(handles.trafficStatus,'Visible','off');
set(handles.maintenanceStatus,'string','Maintenance mode activated');
writeDigitalPin(ArduinoObject,'D11',0); %red
writeDigitalPin(ArduinoObject,'D12',0); %yellow
writeDigitalPin(ArduinoObject,'D13',0); %green
