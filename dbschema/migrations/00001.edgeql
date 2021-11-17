CREATE MIGRATION m13nabibq23bzg35acwxj5vc22thafyniyoahtgq2vlzie6oafpl7a
    ONTO initial
{
  CREATE TYPE default::Person {
      CREATE REQUIRED PROPERTY first_name -> std::str;
      CREATE REQUIRED PROPERTY last_name -> std::str;
  };
  CREATE TYPE default::Movie {
      CREATE MULTI LINK actors -> default::Person;
      CREATE LINK director -> default::Person;
      CREATE REQUIRED PROPERTY title -> std::str;
      CREATE PROPERTY year -> std::int64;
  };
};
