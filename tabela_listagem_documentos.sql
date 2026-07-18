PROMPT CREATE TABLE listagem_docs_sigiloso
CREATE TABLE listagem_docs_sigiloso (
  cd_documento     NUMBER  NULL,
  cd_versao_editor NUMBER  NULL,
  sn_ativo         CHAR(1) DEFAULT 'S' NOT NULL
)
  TABLESPACE mv2000_d
  STORAGE (
    NEXT       1024 K
  )
  LOGGING
/

PROMPT ALTER TABLE listagem_docs_sigiloso ADD CONSTRAINT chk_sn_ativo CHECK
ALTER TABLE listagem_docs_sigiloso
  ADD CONSTRAINT chk_sn_ativo CHECK (
    sn_ativo IN ('S', 'N')
  )
/

GRANT SELECT, INSERT, UPDATE, DELETE ON listagem_docs_sigiloso ti24077;

GRANT SELECT ON listagem_docs_sigiloso public;


