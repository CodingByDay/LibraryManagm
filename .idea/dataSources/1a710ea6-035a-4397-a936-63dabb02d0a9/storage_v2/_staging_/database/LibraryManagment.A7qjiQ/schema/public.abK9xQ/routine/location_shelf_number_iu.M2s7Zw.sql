create function location_shelf_number_iu(i_id_location_shelf_number integer, i_shelf_number integer, i_location_words character varying) returns integer
    language plpgsql
as
$$
DECLARE
    kljuc INTEGER;
BEGIN
    IF (i_id_location_shelf_number IS NULL) THEN
    BEGIN
        -- uporabimo naslednjo vrednost seqvence
        kljuc = nextval('locations_shelf_number_id_locations_shelf_number_seq');
        -- izvršimo INSERT stavek
        INSERT INTO locations_shelf_number(id_locations_shelf_number, shelf_number, location_words) VALUES (kljuc, i_shelf_number, i_location_words);
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
        UPDATE locations_shelf_number
            SET
                shelf_number = i_shelf_number,
                location_words = i_location_words
            WHERE id_locations_shelf_number = i_id_location_shelf_number;
        kljuc = i_id_location_shelf_number;
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

alter function location_shelf_number_iu(integer, integer, varchar) owner to postgres;

