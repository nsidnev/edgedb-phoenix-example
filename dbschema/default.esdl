module default {
    type Person {
        required property first_name -> str;
        required property last_name -> str;
    }

    type Movie {
        required property title -> str;
        property year -> int64;
        link director -> Person;
        multi link actors -> Person;
    }
};
