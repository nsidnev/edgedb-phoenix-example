# edgedb: :query_required_single!
WITH person := (
    INSERT Person {
        first_name := <str>$first_name,
        last_name := <str>$last_name
    }
)
SELECT person {
    id,
    first_name,
    last_name
};
