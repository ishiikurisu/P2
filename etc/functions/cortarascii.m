function arqnovo=cortarascii(namostragem,arqorigem,arqdestino,int1,int2)
 disp('cortar');
%carrega o arquivo de dados
arqascii=load(arqorigem, '-ascii');

%Ajusta o intervalo a amostragem
int1=int1*namostragem;
int2=int2*namostragem;

DIM=size(arqascii);
if DIM(1)>=int2 
    %Extrai os dados no intervalo de dados
    cortearq=arqascii(int1:int2,:);
    
 disp('dim 0');
 
    if DIM(2) == 1
    %Salva o corte no arquivo destino especificado
    %save ('arqdestino', 'cortearq', '-ascii');
disp('dim 1');
        arqdestcompleto=strcat(arqdestino,'.ascii');
        fid=fopen(arqdestcompleto,'wt');
        fprintf(fid,'%d\n', cortearq);
        fclose(fid);
               
    else
        
 disp('dim 1');       
        arqdestcompleto=strcat(arqdestino,'.ascii');
        
        %Fp1A1, F3A1, C3A1, P3A1, O1A1, F7A1, T3A1, T5A1, Fp2A2, F4A2, C4A2, P4A2, O2A2, F8A2, T4A2, T6A2, FzA1, CzA2, PzA1, FpzA2, OzA2, ECG(5), RGP(1), DC(DC1)

        fid=fopen(arqdestcompleto,'wt');
        fprintf(fid,'%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n', cortearq);
        fclose(fid);

        arqascii=load(arqdestcompleto, '-ascii');

        derivacoes='C:\Users\t\Documents\Unb\Noseafix\Dados\Analises\derivsasc.xls';
        [A,T]=xlsread(derivacoes);
        DIM=size(T)

        for i=1:DIM(2)
            arqdestderiv=strcat(arqdestino,char(T(i)),'.ascii');
            fid=fopen(arqdestderiv,'wt');
            fprintf(fid,'%d\n', arqascii(:,i)); %gravar a coluna inteira
            fclose(fid);
        end;
    end;
    
else 
        disp(strcat('O arquivo ', arqorigem, ' � menor que o corte. '));
end;