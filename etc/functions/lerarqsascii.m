function n=lerarqsascii(arqsascii)
%arqecg formato idsujeito;nomearqecg
clc
%Definiçao da localizaçao dos arquivos
localorigem = 'C:\Users\t\Documents\UnB\Pesquisa\ascii\';
localdestino = 'C:\Users\t\Documents\UnB\Pesquisa\Analises\';
n = 0;
% Prompt user and get the name of the input file.
disp('Iniciar a leitura do arquivo de arquivos');

%if arqsecg==null 
%Solicitar entrada de arquivo
%    arqsecg = input('Informe o nome do arquivo de arquivos rgp (idsujeito nomearqrgp): ','s');
%end;
arqseeg='C:\Users\t\Documents\UnB\Pesquisa\Analises\arqseegascii.xls';

% Abrir o arquivo
[N,T]=xlsread(arqseeg);
disp(T)

%Iniciar varredura para calculo do rgp
for i=1:size(T)
 sujeito= T(i,1);
 arq= T(i,2);

 
 arq1=strcat(localdestino, 'eeg\', char(sujeito), '.ascii');
 disp(arq1)
 
 %Define o nome dos arquivos de rgp
 arq=strcat(localorigem, char(arq),'.asc');
 disp(arq);
 if exist(arq)==2 

     fidascii = fopen(arq,'r')

  
 fiddata=fopen(arq1,'w');
  
 % Craindo arquivo geral sem os comentários 
 linhaArquivo = '' ; 
 while ~feof( fidascii ) % | ~isempty( linhaArquivo )
            
   linhaArquivo = fgetl( fidascii ) ; 
   if ~( isempty( linhaArquivo ) | linhaArquivo( 1 ) == ';') 
      
       fprintf( fiddata , linhaArquivo ) ; 
       fprintf( fiddata , '\n' ) ;
       
   end %if
   
 end %while
 
 fclose(fiddata); 
 
% arqeegdata=load (arq1)
arqeegdata=''
 if exist(arq1)==2 
     
   fiddata = fopen(arq1);
   %arqeegdata = textscan(fiddata, '%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f');
   %arqeegdata = textscan(arq1);

 end;
 
 if size(arqeegdata)>0 
     
     DIM=size(arqeegdata)

     numA=DIM(1,2)
     
      arqecg=strcat(localdestino, 'ecg\ecg', char(condicao), char(sujeito), '.ascii');
      fidecg=fopen(arqecg,'w');
      fprintf(fidecg,'%f\n', arqeegdata(:,22));
      fclose(fidecg) ;
      
      arqrgp=strcat(localdestino, 'rgp\rgp', char(condicao), char(sujeito), '.ascii');
      fidrgp=fopen(arqrgp,'w');
      fprintf(fidrgp,'%f\n', arqeegdata(:,23));
      fclose(fidrgp) ;

      arqemg=strcat(localdestino, 'emg\emg', char(condicao), char(sujeito), '.ascii');
      fidemg=fopen(arqemg,'w');
      fprintf(fidemg,'%f	%f\n', arqeegdata(:,24), arqeegdata(:,25));
      fclose(fidemg) ;
     
 end; %if
 
    fclose(fiddata);
 
 fclose(fidascii);
 end; %if
end; %for