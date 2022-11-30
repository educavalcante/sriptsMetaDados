COMMIT WORK;
SET AUTODDL OFF;
SET TERM ^ ;

ALTER PROCEDURE "CPS"
(
  "CONSULTA" VARCHAR(10000)
)
RETURNS
(
  "CODIGOCPS" FLOAT,
  "TRATAMENTO" INTEGER,
  "PARCELA" SMALLINT,
  "CODIGOPLA" SMALLINT,
  "CODIGOPAC" FLOAT,
  "A_DATAFAT" TIMESTAMP,
  "A_HORA" TIMESTAMP,
  "DATAREPRESENTA" TIMESTAMP,
  "MATRICULA" VARCHAR(30),
  "CONVENIO" INTEGER,
  "MEDRESP" INTEGER,
  "A_DATA" TIMESTAMP,
  "A_SITUACAO" CHAR(1),
  "DATASAIDA" TIMESTAMP,
  "HORASAIDA" TIMESTAMP,
  "SOLCREMEB" CHAR(8),
  "SOLESP1" CHAR(2),
  "PRINCIPAL" CHAR(8),
  "ESPECIALIDADE" CHAR(2),
  "EMPRESA" SMALLINT,
  "FATURA" FLOAT,
  "INDICE" FLOAT,
  "CODIGOSERV" FLOAT,
  "CODIGOAMB" CHAR(8),
  "A_MEDICOS" INTEGER,
  "QUANTIDADE" INTEGER,
  "VALOR" FLOAT,
  "CUSTO" FLOAT,
  "CO" FLOAT,
  "A_FILME" FLOAT,
  "GLOSA" FLOAT,
  "GLOSARECEBIDA" DOUBLE PRECISION,
  "GLOSADATA" TIMESTAMP,
  "GLOSATIPO" SMALLINT,
  "GLOSADEFINITIVA" CHAR(1),
  "REPRESENTA" FLOAT,
  "DATA" TIMESTAMP,
  "HORA" TIMESTAMP,
  "DHE" CHAR(1),
  "VIA" CHAR(1),
  "CODIGO" INTEGER,
  "DATARECEBIMENTO" TIMESTAMP,
  "FATURAGLOSA" INTEGER,
  "COBRAR" CHAR(1),
  "UNIDADENEGOCIO" INTEGER,
  "SENHA" VARCHAR(20),
  "CODIGOAMB1" CHAR(8),
  "GLOSARESPONSAVEL" INTEGER,
  "A_CID" VARCHAR(4),
  "CONFERIDO" CHAR(1),
  "SITUACAOITEM" VARCHAR(1),
  "GRAUPARTICIPACAO" CHAR(2),
  "TECNICA" CHAR(1),
  "PORTE" VARCHAR(4),
  "HORAFINAL" TIMESTAMP,
  "CODESPITEM" CHAR(2),
  "CREMEBSOLITEM" CHAR(6),
  "DATASINC" TIMESTAMP,
  "GRUPOSUS" VARCHAR(2),
  "JUSTIFICATIVAGLOSA" VARCHAR(5000),
  "MNM" VARCHAR(10),
  "TIPOGUIA" CHAR(1),
  "TIPOFATURA" CHAR(1),
  "UNNEG" INTEGER,
  "GLOSACERTA" CHAR(1),
  "ORIGEM" CHAR(1),
  "DATAGLOSA" TIMESTAMP,
  "A_GUIA" VARCHAR(30),
  "XMLID" INTEGER,
  "NOTAFISCAL" VARCHAR(1),
  "NUMEROGUIAOPERADORA" VARCHAR(30),
  "DATARECEBP1" TIMESTAMP,
  "DATARECEBP2" TIMESTAMP,
  "DATARECEBP3" TIMESTAMP,
  "DATARECEBP4" TIMESTAMP,
  "VALORRECEBP1" DOUBLE PRECISION,
  "VALORRECEBP2" DOUBLE PRECISION,
  "VALORRECEBP3" DOUBLE PRECISION,
  "VALORRECEBP4" DOUBLE PRECISION,
  "RECEBPARCIAL" CHAR(1),
  "DATARECEBITEM" TIMESTAMP,
  "PLANO" INTEGER
)
AS
declare variable hontipo integer;
declare variable totalrecibo double precision;
declare variable valorrecibo double precision;
declare variable auxvalor double precision;
declare variable auxco double precision;
declare variable auxfilme double precision;
declare variable auxglosa double precision;
declare variable vencaux timestamp;
begin
select gen_id(gen_hontipo,0) from rdb$database into :hontipo;
for execute statement 'select codigocps, tratamento, cast(parcela as smallint), codigopla, codigopac, a_datafat, a_hora,
datarepresenta, matricula, convenio, medresp, a_data, a_situacao, datasaida, horasaida, cast(solcremeb as char(8)), cast(solesp1 as char(2)),
 principal, especialidade, empresa, fatura, codigo, datarecebimento, faturaglosa, a_cid, conferido, a_guia, numeroguiaoperadora, plano from cpsamb ' || consulta
into :codigocps, :tratamento, :parcela, :codigopla, :codigopac, :a_datafat, :a_hora, :datarepresenta, :matricula, :convenio, :medresp,
 :a_data, :a_situacao, :datasaida, :horasaida, :solcremeb, :solesp1, :principal, :especialidade, :empresa, :fatura, :codigo, :datarecebimento,
 :faturaglosa, :a_cid, :conferido, :a_guia, :numeroguiaoperadora, :plano do
begin
  NOTAFISCAL = NULL;
  SELECT NOTA_FISCAL FROM CPS1_COMPL WHERE CODIGOCPS = :CODIGOCPS INTO NOTAFISCAL;
  if ((a_situacao <> '5') or (a_situacao is null)) then
  for select indice, codigoserv, codigoamb, codigoamb1, a_medicos, quantidade, valor, custo, co, a_filme, glosa, glosarecebida,
  glosadata, glosatipo, representa, glosadefinitiva, data, hora, dhe, via, cobrar, unidadenegocio, senha, glosaresponsavel, a_situacao,
  grauparticipacao, tecnica, horasaida, cremebsol, gruposus, datasinc, justificativa, MNM, glosacerta, dataglosa, xmlid,
   datarecebp1, datarecebp2, datarecebp3, datarecebp4,
  VALORRECEBP1, VALORRECEBP2, VALORRECEBP3, VALORRECEBP4, RECEBPARCIAL, DATARECEBITEM   from cps2 Where codigocps2 = :codigocps
  into :indice, :codigoserv, :codigoamb, :codigoamb1, :a_medicos, :quantidade, :valor, :custo, :co, :a_filme, :glosa,
  :glosarecebida, :glosadata, :glosatipo, :representa, :glosadefinitiva, :data, :hora, :dhe, :via, :cobrar, :unidadenegocio,
   :senha, :glosaresponsavel, :situacaoitem, :grauparticipacao, :tecnica, :horafinal, :cremebsolitem, :gruposus, :datasinc, :justificativaglosa,
    :MNM, :glosacerta, :dataglosa, :xmlid,
     :datarecebp1, :datarecebp2, :datarecebp3, :datarecebp4,
     :VALORRECEBP1, :VALORRECEBP2, :VALORRECEBP3, :VALORRECEBP4, :RECEBPARCIAL, :DATARECEBITEM  do
  begin
    codespitem = especialidade;
    if (glosa is null) then
      glosa = 0;
    if (a_filme is null) then
      a_filme = 0;
    if (dhe is null) then
      dhe = 'N';
    if (horafinal is null) then
      horafinal = hora;
    --if ((glosa <> 0) and (glosatipo > 0) and (exists(select administrativa from motivoglosa where numero = :glosatipo and administrativa = 'S'))) then
    --  glosa = 0;
    if ((hontipo = 3) and (exists(select * from cpsrateio where cps = cast(:codigocps as integer) and tratamento = :tratamento)) )then
    begin
      auxvalor = valor;
      auxco = co;
      auxfilme = a_filme;
      auxglosa = glosa;
      for select databaixa,vencimento,parcela,total from cpsrateio where cps = cast(:codigocps as integer) and tratamento = :tratamento into data, vencaux, valorrecibo, totalrecibo do
      begin
        situacaoitem = null;
        if (data is null) then
        begin
         data = vencaux;
         situacaoitem = 'A';
        end
        valor = auxvalor*valorrecibo/totalrecibo;
        co = auxco*valorrecibo/totalrecibo;
        a_filme = auxfilme*valorrecibo/totalrecibo;
        glosa = auxglosa*valorrecibo/totalrecibo;
        suspend;
      end
    end
    else
      suspend;
  end
  cremebsolitem = null;
  tecnica = null;
  grauparticipacao = null;
  a_medicos = medresp;
  codigoamb = 0;
  a_filme = 0;
  dhe = 'M';
  via = 0;
  co = 0;
  senha = null;
  situacaoitem = null;
  codespitem = null;
  if ((a_situacao <> '5') or (a_situacao is null)) then
  for select indice, codigomm, data , hora, quantidade, total, custo, glosa, glosarecebida, glosadata, glosatipo, representa, glosadefinitiva,
   a_medicos, unidadenegocio, cobrar, glosaresponsavel, gruposus, datasinc, justificativa, glosacerta, dataglosa, xmlid
   ,datarecebp1, datarecebp2, datarecebp3, datarecebp4,
    VALORRECEBP1, VALORRECEBP2, VALORRECEBP3, VALORRECEBP4, RECEBPARCIAL, DATARECEBITEM   from cps3 where codigocps = :codigocps
  into :indice, :codigoserv, :data , :hora, :quantidade, :valor, :custo, :glosa, :glosarecebida, :glosadata, :glosatipo, :representa,
  :glosadefinitiva, :a_medicos, :unidadenegocio, :cobrar,:glosaresponsavel, :gruposus, :datasinc, :justificativaglosa, :glosacerta, :dataglosa,
   :xmlid,  :datarecebp1, :datarecebp2, :datarecebp3, :datarecebp4,
     :VALORRECEBP1, :VALORRECEBP2, :VALORRECEBP3, :VALORRECEBP4, :RECEBPARCIAL, :DATARECEBITEM  do
  begin
    codigoamb = null;
    select first 1 codigoconv from matmedconv where codigomm = :codigoserv and convenio = :convenio into codigoamb;
    if (codigoamb is null) then
    begin
      select a_codamb from matmed where codigomm = :codigoserv into :codigoamb;
      if (codigoamb = '72140011') then
         select codmed from convenio where convenio = :convenio into :codigoamb;
      else if (codigoamb = '72140046') then
         select codmat from convenio where convenio = :convenio into :codigoamb;
      else if (codigoamb = '72000000') then
         select codesp from convenio where convenio = :convenio into :codigoamb;
      else if (codigoamb = '72000001') then
         select codcontr from convenio where convenio = :convenio into :codigoamb;
      else if (codigoamb = '72000002') then
         select codmed from convenio where convenio = :convenio into :codigoamb;
      else if (codigoamb = '72000008') then
         select codortprot from convenio where convenio = :convenio into :codigoamb;
      else if (codigoamb = '72000009') then
         select codmed from convenio where convenio = :convenio into :codigoamb;
      else
         select codmed from convenio where convenio = :convenio into :codigoamb;
    end
    if (a_medicos is null or a_medicos = 0 ) then
    Begin
        select a_medicos from matmed where codigomm = :codigoserv into a_medicos;
        if (a_medicos is null or a_medicos = 0) then
           a_medicos = gen_id( gen_medico_hosp, 0 );
        if ( a_medicos is null or a_medicos = 0 ) then
           a_medicos = medresp;
    end
    horafinal = hora;
   -- if ((glosa <> 0) and (glosatipo > 0) and (exists(select administrativa from motivoglosa where numero = :glosatipo and administrativa = 'S'))) then
   --   glosa = 0;
    if ((hontipo = 3) and (exists(select * from cpsrateio where cps = cast(:codigocps as integer) and tratamento = :tratamento)) )then
    begin
      auxvalor = valor;
      auxco = co;
      auxfilme = a_filme;
      auxglosa = glosa;
      for select databaixa,vencimento,parcela,total from cpsrateio where cps = cast(:codigocps as integer) and tratamento = :tratamento into data, vencaux, valorrecibo, totalrecibo do
      begin
        situacaoitem = null;
        if (data is null) then
        begin
         data = vencaux;
         situacaoitem= 'A';
        end
        valor = auxvalor*valorrecibo/totalrecibo;
        co = auxco*valorrecibo/totalrecibo;
        a_filme = auxfilme*valorrecibo/totalrecibo;
        glosa = auxglosa*valorrecibo/totalrecibo;
        suspend;
      end
    end
    else
      suspend;
  end
end
cremebsolitem = null;
for execute statement 'select codigocps, tratamento, parcela, codigopla, codigopac, a_datafat, a_hora, datarepresenta, matricula, convenio, medresp, a_data,
  a_situacao, datasaida, horasaida, solcremeb, cast(solesp1 as char(2)), principal, especialidade, cast(empresa as smallint), fatura, codigo, datarecebimento,
  faturaglosa, a_cid, conferido, tipoguia, tipofatura, a_guia, numeroguiaoperadora, plano from cpsint25 ' || consulta
  into :codigocps, :tratamento, :parcela, :codigopla, :codigopac, :a_datafat, :a_hora, :datarepresenta, :matricula, :convenio, :medresp, :a_data, :a_situacao, :datasaida,
  :horasaida, :solcremeb, :solesp1, :principal, :especialidade, :empresa, :fatura, :codigo, :datarecebimento, :faturaglosa, :a_cid, :conferido, :tipoguia, :tipofatura,
  :a_guia, :numeroguiaoperadora, :plano do
begin
  NOTAFISCAL = NULL;
  SELECT NOTA_FISCAL FROM CPS1_COMPL WHERE CODIGOCPS = :CODIGOCPS INTO NOTAFISCAL;
  if ((a_situacao <> '5') or (a_situacao is null)) then
  for select inter3no, codigoserv, codigoamb, codigoamb1, a_medicos, quantidade, valor, custo, co, a_filme, glosa, glosarecebida, glosadata, glosatipo, representa, glosadefinitiva, a_data, a_hora, dhe, 0, cobrar, unidadenegocio, senha, glosaresponsavel, a_situacao, grauparticipacao, tecnica, porte, horafinal,codesp, gruposus, datasinc, justificativa, glosacerta, dataglosa, xmlid,
   datarecebp1, datarecebp2, datarecebp3, datarecebp4,
    VALORRECEBP1, VALORRECEBP2, VALORRECEBP3, VALORRECEBP4, RECEBPARCIAL, DATARECEBITEM   from inter3 where codigoint = :codigocps and tratamento = :tratamento
  into :indice, :codigoserv, :codigoamb, :codigoamb1, :a_medicos, :quantidade, :valor, :custo, :co, :a_filme, :glosa, :glosarecebida, :glosadata,
   :glosatipo, :representa, :glosadefinitiva, :data, :hora, :dhe, :via, :cobrar, :unidadenegocio, :senha, :glosaresponsavel, :situacaoitem,
   :grauparticipacao, :tecnica, :porte, :horafinal, :codespitem, :gruposus, :datasinc, :justificativaglosa, :glosacerta, :dataglosa, :xmlid
   , :datarecebp1, :datarecebp2, :datarecebp3, :datarecebp4,
    :VALORRECEBP1, :VALORRECEBP2, :VALORRECEBP3, :VALORRECEBP4, :RECEBPARCIAL, :DATARECEBITEM  do
  begin
    if (glosa is null) then
      glosa = 0;
    if (a_filme is null) then
      a_filme = 0;
    if (dhe is null) then
      dhe = 'N';
    if (horafinal is null) then
      horafinal = hora;
    --if ((glosa <> 0) and (glosatipo > 0) and (exists(select administrativa from motivoglosa where numero = :glosatipo and administrativa = 'S'))) then
    --  glosa = 0;
    if ((hontipo = 3) and (exists(select * from cpsrateio where cps = cast(:codigocps as integer) and tratamento = :tratamento)) )then
    begin
      auxvalor = valor;
      auxco = co;
      auxfilme = a_filme;
      auxglosa = glosa;
      for select databaixa,vencimento,parcela,total from cpsrateio where cps = cast(:codigocps as integer) and tratamento = :tratamento into data, vencaux, valorrecibo, totalrecibo do
      begin
        situacaoitem = null;
        if (data is null) then
        begin
         data = vencaux;
         situacaoitem= 'A';
        end
        valor = auxvalor*valorrecibo/totalrecibo;
        co = auxco*valorrecibo/totalrecibo;
        a_filme = auxfilme*valorrecibo/totalrecibo;
        glosa = auxglosa*valorrecibo/totalrecibo;
        suspend;
      end
    end
    else
      suspend;
  end
  tecnica = null;
  porte = null;
  grauparticipacao = null;
  a_medicos = medresp;
  codigoamb = null;
  a_filme = 0;
  dhe = 'M';
  via = 0;
  co = 0;
  senha = null;
  situacaoitem = null;
  codespitem = null;
  if ((a_situacao <> '5') or (a_situacao is null)) then
  for select inter3no, codigomm, a_data, a_hora, quantidade, total, custo, glosa, glosarecebida, glosadata, glosatipo, representa,
   glosadefinitiva, a_medicos, unidadenegocio, cobrar, glosaresponsavel, datasinc, justificativa, glosacerta, dataglosa, xmlid
   , datarecebp1, datarecebp2, datarecebp3, datarecebp4,
    VALORRECEBP1, VALORRECEBP2, VALORRECEBP3, VALORRECEBP4, RECEBPARCIAL, DATARECEBITEM   from inter32 where codigoint = :codigocps and tratamento = :tratamento
  into :indice, :codigoserv, :data , :hora, :quantidade, :valor, :custo, :glosa, :glosarecebida, :glosadata, :glosatipo, :representa,
  :glosadefinitiva, :a_medicos, :unidadenegocio, :cobrar,:glosaresponsavel, :datasinc, :justificativaglosa, :glosacerta, :dataglosa, :xmlid
  , :datarecebp1, :datarecebp2, :datarecebp3, :datarecebp4,
   :VALORRECEBP1, :VALORRECEBP2, :VALORRECEBP3, :VALORRECEBP4, :RECEBPARCIAL, :DATARECEBITEM   do
  begin
    codigoamb = null;
    select first 1 codigoconv from matmedconv where codigomm = :codigoserv and convenio = :convenio into codigoamb;
    if (codigoamb is null) then
    begin
      select a_codamb from matmed where codigomm = :codigoserv into :codigoamb;
      if (codigoamb = '72140011') then
         select codmed from convenio where convenio = :convenio into :codigoamb;
      else if (codigoamb = '72140046') then
         select codmat from convenio where convenio = :convenio into :codigoamb;
      else if (codigoamb = '72000000') then
         select codesp from convenio where convenio = :convenio into :codigoamb;
      else if (codigoamb = '72000001') then
         select codcontr from convenio where convenio = :convenio into :codigoamb;
      else if (codigoamb = '72000002') then
         select codmed from convenio where convenio = :convenio into :codigoamb;
      else if (codigoamb = '72000008') then
         select codortprot from convenio where convenio = :convenio into :codigoamb;
      else if (codigoamb = '72000009') then
         select codmed from convenio where convenio = :convenio into :codigoamb;
      else
         select codmed from convenio where convenio = :convenio into :codigoamb;
    end
    if (a_medicos is null or a_medicos = 0 ) then
    Begin
        select a_medicos from matmed where codigomm = :codigoserv into a_medicos;
        if (a_medicos is null or a_medicos = 0) then
           a_medicos = gen_id( gen_medico_hosp, 0 );
        if ( a_medicos is null or a_medicos = 0 ) then
           a_medicos = medresp;
    end
    horafinal = hora;
   -- if ((glosa <> 0) and (glosatipo > 0) and (exists(select administrativa from motivoglosa where numero = :glosatipo and administrativa = 'S'))) then
   --   glosa = 0;
    if ((hontipo = 3) and (exists(select * from cpsrateio where cps = cast(:codigocps as integer) and tratamento = :tratamento)) )then
    begin
      auxvalor = valor;
      auxco = co;
      auxfilme = a_filme;
      auxglosa = glosa;
      for select databaixa,vencimento,parcela,total from cpsrateio where cps = cast(:codigocps as integer) and tratamento = :tratamento into data, vencaux, valorrecibo, totalrecibo do
      begin
        situacaoitem = null;
        if (data is null) then
        begin
         data = vencaux;
         situacaoitem= 'A';
        end
        valor = auxvalor*valorrecibo/totalrecibo;
        co = auxco*valorrecibo/totalrecibo;
        a_filme = auxfilme*valorrecibo/totalrecibo;
        glosa = auxglosa*valorrecibo/totalrecibo;
        suspend;
      end
    end
    else
      suspend;
  end
end
end
 ^

SET TERM ; ^
COMMIT WORK;
SET AUTODDL ON;