PROMPT CREATE OR REPLACE TRIGGER alerta_versao_doc_sigiloso_editor_2
CREATE OR REPLACE TRIGGER alerta_versao_doc_sigiloso_editor_2
 AFTER INSERT ON editor_versao_documento
   FOR EACH ROW

DECLARE

  docPertenceLista NUMBER;
  conteudoEmail VARCHAR(4000);
  mensagemEnviada VARCHAR(4000);
  conteudoTitulo VARCHAR(4000);
  tituloEnviado VARCHAR(4000);

BEGIN


   SELECT Count(*) INTO docPertenceLista
     FROM listagem_docs_sigiloso
    WHERE listagem_docs_sigiloso.cd_versao_editor = 2
      AND listagem_docs_sigiloso.cd_documento = :NEW.cd_documento
      AND listagem_docs_sigiloso.sn_ativo = 'S';

   conteudoEmail := '<center><b>************************** ATENCAO **************************</b></center><br><center>Foi criada uma nova versão para o documento ' || :NEW.cd_documento || ' (Editor 2) vinculado ao protocolo de alerta sigiloso!</center><br><center>Será necessário reconfigurar o cadastro do alerta na tela M_ALERTA_PROTOCOLO.</center>';
   mensagemEnviada := conteudoEmail;
   conteudoTitulo := 'Nova versão do documento ' || :NEW.cd_documento || ' vinculado ao diagnstico sigiloso';
   tituloEnviado := conteudoTitulo;

   IF :NEW.cd_tipo_versao = 1 AND docPertenceLista >= 1
 THEN
   emailgeralacompanhamento(
       tituloEnviado
     , mensagemEnviada
     , 'email@contato.com'
     , 'disparos@contato.com'
     , 'Equipe de TI'
     , true);

   END IF;

--EXCEPTION
--  WHEN Others THEN
END;
/

