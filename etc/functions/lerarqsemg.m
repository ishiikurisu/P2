function n=lerarqsemg(pasta)
%arqecg formato idsujeito;nomearqecg
clc
%Defini�ao da localiza�ao dos arquivos
localorigem = 'C:\Users\t\Documents\UnB\Pesquisa\Tratados\asciiA\cortados\'; 
localdestino = 'C:\Users\t\Documents\UnB\Pesquisa\Analises\';

localorigem = strcat(localorigem, char(pasta), '\')

n = 0;
% Prompt user and get the name of the input file.
disp('Iniciar a leitura do arquivo de arquivos');

%if arqsecg==null 
%Solicitar entrada de arquivo
%    arqsecg = input('Informe o nome do arquivo de arquivos emg (idsujeito nomearqemg): ','s');
%end;
arqsemg=strcat('C:\Users\t\Documents\UnB\Pesquisa\Tratados\arqsints', char(pasta),'.xls');

% Abrir o arquivo
[N,T]=xlsread(arqsemg);

arq1=strcat(localdestino, 'emgc\data\', 'emgc', char(pasta), 'var', '.txt');
arq2=strcat(localdestino, 'emgz\data\', 'emgz', char(pasta), 'var', '.txt');

%abre arquivo para cabecalho: sujeito   fragmento   numA    emgm    emgsd
%emgvar emgpower emgrms
fid1=fopen(arq1,'a');
fprintf(fid1,'%s\n', 'sujeito   teste   epoca   tentativa   emgm    emgsd   emgvar   power   emgrms   emgrmsN');

fid2=fopen(arq2,'a');
fprintf(fid2,'%s\n', 'sujeito   teste   epoca   tentativa   emgm    emgsd   emgvar   power   emgrms   emgrmsN');

%(ASCII+32768)*0,250003814755474-8192
fa=32768;
fb=0,250003814755474;
fc=8192;
fs=2000;

int1=0
int2=0.1

%Ajusta o intervalo a amostragem
int1=int1*fs;
int2=int2*fs;

if int1==0
   int1=1
end;


%Iniciar varredura para calculo do emg
for i=1:size(N)
 sujeito=T(i+1,1);
 teste= T(i+1,2);
 arq= T(i+1,3);
 epoca= T(i+1,4);
 rec=T(i+1,5);
 tentativa=N(i,1);
 
 disp (char(rec));
 
 %Define o nome dos arquivos de emg
 arq=strcat(localorigem, char(arq));
 
 %emgrfunc(arqemg)
 ampsemg=load(arq);
 
 DIM=size(ampsemg)
 
if DIM(1)>=int2 
    %Extrai os dados no intervalo de dados
    ampsemg=ampsemg(int1:int2,:);
end;

 if size(ampsemg)>0 
     %prepara m�dia R
     
     DIM=size(ampsemg);

    %ampsemg=((ampsemg+fa)*fb)-fc; 
     
     emgm = mean(ampsemg);
     emgsd = std(ampsemg);
     for j=1:DIM
             ampsemgN(j)=(ampsemg(j)-emgm)/emgsd
         end;
         
         emgm=mean(ampsemgN)
         emgsd=std(ampsemgN)
     
     
     emgvar = var(ampsemgN);
     emgrms = sqrt(sum(ampsemgN.*conj(ampsemgN))/size(ampsemgN,1));
     emgrmsN = norm(ampsemgN)/sqrt(lenght(ampsemgN))
    
    %pxx=abs(fft(x,n)).^2/n 
    specdata=abs(fft(ampsemgN.*hanning(length(ampsemgN))))./length(ampsemgN);
     
    powtotal=0;
    for i6=1:length(specdata)/2
        powtotal=powtotal+specdata(i6)^2;
    end
    
     %sujeito   teste   epoca   tentativa   emgm    emgsd   emgvar
    if strcmpi(char(rec), 'emc')
       fprintf(fid1,'%s\t%s\t%s\t%d\t%f\t%f\t%f\t%f\t%f\t%f\n', char(sujeito), char(teste), char(epoca), tentativa, emgm, emgsd, emgvar, powtotal, emgrms, emgrmsN);
    elseif strcmpi(char(rec), 'emz')
           fprintf(fid2,'%s\t%s\t%s\t%d\t%f\t%f\t%f\t%f\t%f\t%f\n', char(sujeito), char(teste), char(epoca), tentativa, emgm, emgsd, emgvar, powtotal, emgrms, emgrmsN);
    end;
    
 end;
  
end;

fclose(fid1);
fclose(fid2);

disp('Done.');
