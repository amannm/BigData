CREATE INDEX concepts_trigram_idx 
ON rxnorm.concepts 
USING gist (str gist_trgm_ops)
where sab = 'RXNORM' and (tty = 'BN' or tty = 'IN')