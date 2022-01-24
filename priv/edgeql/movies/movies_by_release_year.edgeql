# edgedb: :query!
SELECT default::Movie {
    title,
    director: {
        full_name := .first_name ++ " " ++ .last_name
    },
    actors: {
        first_name,
        last_name
    }
}
FILTER .year = <int64>$release_year;
