create function books_authors_iu(i_id_books_authors integer, i_id_book integer, i_id_authors integer) returns integer
    language plpgsql
as
$$
DECLARE
    kljuc INTEGER;
BEGIN
    IF (i_id_books_authors IS NULL) THEN
    BEGIN
        -- uporabimo naslednjo vrednost seqvence
        kljuc = nextval('books_authors_id_books_authors_seq');
        -- izvršimo INSERT stavek
        INSERT INTO books_authors VALUES (kljuc, i_id_books_authors, i_id_book, i_id_authors);
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
        UPDATE books_authors
            SET
             id_book = i_id_book,
             id_authors = i_id_authors

            WHERE id_books_authors = i_id_books_authors;
        kljuc = i_id_books_authors;
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

alter function books_authors_iu(integer, integer, integer) owner to postgres;

