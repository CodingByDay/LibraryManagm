create function formats_type_iu(i_id_formats_type integer, i_format character varying) returns integer
    language plpgsql
as
$$
DECLARE
    kljuc INTEGER;
BEGIN
    IF (i_id_formats_type IS NULL) THEN
    BEGIN
        -- uporabimo naslednjo vrednost seqvence
        kljuc = nextval('formats_type_id_formats_type_seq');
        -- izvršimo INSERT stavek
        INSERT INTO formats_type(id_formats_type, format) VALUES (kljuc, i_format);
        -- prestrezanje možnih izjem
        EXCEPTION
            WHEN integrity_constraint_violation THEN
                RAISE EXCEPTION 'Napaka ... referenčna integriteta.';
            WHEN not_null_violation THEN
                RAISE EXCEPTION 'Napaka ... ni zahtevane vrednosti polja.';
            WHEN foreign_key_violation THEN
                RAISE EXCEPTION 'Napaka ... neustrezna vrednost tujega ključa.';
            WHEN unique_violation THEN
                RAISE EXCEPTION 'Napaka ... ni enolične vrednosti polja.';
            WHEN check_violation THEN
                RAISE EXCEPTION 'Napaka ... validacijsko pravilo.';
            WHEN string_data_right_truncation THEN
                RAISE EXCEPTION 'Napaka ... vrednost vsebuje več znakov kot je dolžina polja.';
            -- v primeru ostalih napak
            WHEN others THEN
                RAISE EXCEPTION 'Napaka ...';
        END;
    ELSE
    BEGIN
        -- izvršimo UPDATE stavek
        UPDATE formats_type
            SET
                format = i_format
            WHERE id_formats_type = i_id_formats_type;
        kljuc = i_id_formats_type;
        -- prestrezanje možnih izjem
         EXCEPTION
            WHEN integrity_constraint_violation THEN
                RAISE EXCEPTION 'Napaka ... referenčna integriteta.';
            WHEN not_null_violation THEN
                RAISE EXCEPTION 'Napaka ... ni zahtevane vrednosti polja.';
            WHEN foreign_key_violation THEN
                RAISE EXCEPTION 'Napaka ... neustrezna vrednost tujega ključa.';
            WHEN unique_violation THEN
                RAISE EXCEPTION 'Napaka ... ni enolične vrednosti polja.';
            WHEN check_violation THEN
                RAISE EXCEPTION 'Napaka ... validacijsko pravilo.';
            WHEN string_data_right_truncation THEN
                RAISE EXCEPTION 'Napaka ... vrednost vsebuje več znakov kot je dolžina polja.';
                -- v primeru ostalih napak
                WHEN others THEN
                RAISE EXCEPTION 'Napaka ...';
    END;
    END IF;
    RETURN kljuc;
END;
$$;

alter function formats_type_iu(integer, varchar) owner to postgres;

