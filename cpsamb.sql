
/* View: CPSAMB, Owner: SYSDBA */

CREATE OR ALTER VIEW "CPSAMB" (
  "CODIGOCPS", 
  "TRATAMENTO", 
  "PARCELA", 
  "CODIGOPLA", 
  "CODIGOPAC", 
  "A_DATAFAT", 
  "DATAENTRADA", 
  "A_HORA", 
  "MATRICULA", 
  "CONVENIO", 
  "MEDRESP", 
  "A_DATA", 
  "A_SITUACAO", 
  "DATASAIDA", 
  "DATATERMINO", 
  "HORASAIDA", 
  "SOLCREMEB", 
  "SOLESP1", 
  "PRINCIPAL", 
  "ESPECIALIDADE", 
  "EMPRESA", 
  "FATURA", 
  "DATAREPRESENTA", 
  "DATARECEBIMENTO", 
  "CODIGO", 
  "FATURAGLOSA", 
  "A_CID", 
  "TIPOGUIA", 
  "CONFERIDO", 
  "TIPOFATURA", 
  "A_GUIA", 
  "MAQUINETA", 
  "NUMEROGUIAOPERADORA", 
  "VERSAOGUIA", 
  "PLANO"
) AS
            select cps1.codigocps, 0,1, cps1.codigopla, cps1.codigopac, cps1.a_datafat, cps1.a_datafat, cps1.a_hora, cps1.matricula, cps1.convenio, cps1.medresp,
                cps1.a_data, cps1.a_situacao, cps1.datasaida, cps1.datasaida, cps1.horasaida, cps1.solcremeb, cps1.solesp1, cps1.principal, cps1.especialidade, 
                cps1.empresa, cps1.fatura, cps1.datarepresenta, cps1.datarecebimento, cps1.codigo, cps1.faturaglosa, cps1.a_cid, '0', cps1.conferido, '0', cps1.a_guia,
                cps1.maquineta, CPS1.NUMEROGUIAOPERADORA, cps1.versaoguia, cps1.plano
                from cps1 where codigopla <> 3
;