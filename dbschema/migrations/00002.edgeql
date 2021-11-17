CREATE MIGRATION m1wjzfpevmq5f33uwi6vlptyd6tmwt2khwmvgcfzc7x4zwvwesgxna
    ONTO m13nabibq23bzg35acwxj5vc22thafyniyoahtgq2vlzie6oafpl7a
{
    WITH MODULE default
    INSERT Movie {
        title := "Harry Potter and the Philosopher's Stone",
        year := 2001,

        director := (
            INSERT Person {
                first_name := "Chris",
                last_name := "Columbus",
            }
        ),
        actors := (
            WITH
                d_radcliffe := (
                    INSERT Person {
                        first_name := "Daniel",
                        last_name := "Radcliffe"
                    }
                ),
                r_grint := (
                    INSERT Person {
                        first_name := "Rupert",
                        last_name := "Grint"
                    }
                ),
                e_watson := (
                    INSERT Person {
                        first_name := "Emma",
                        last_name := "Watson"
                    }
                ),
            SELECT {
                d_radcliffe,
                r_grint,
                e_watson
            }
        )
    };
};
