
/* View: CPSINT25, Owner: SYSDBA */

CREATE or alter VIEW "CPSINT25" (
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
            select cps1.codigocps, inter2.tratamento, inter2.parcela, cps1.codigopla, cps1.codigopac, inter2.a_data, cps1.a_datafat, inter2.a_hora, cps1.matricula, inter2.convenio, cps1.medresp, inter2.a_envio, cps1.a_situacao,
            inter2.a_datafim, cps1.datasaida, inter2.a_horafim, cps1.solcremeb, cps1.solesp1, cps1.principal, cps1.especialidade, cps1.empresa, cast(inter2.faturano as float), 
            inter2.datarepresenta, inter2.datarecebimento, cps1.codigo, inter2.faturaglosa, cps1.a_cid, inter2.tipoguia, cps1.conferido, inter2.fatura, inter2.a_guia, 
            cps1.maquineta, inter2.NUMEROGUIAOPERADORA, cps1.versaoguia, cps1.plano from inter2 
            left join cps1 on inter2.codigoint = cps1.codigocps
;