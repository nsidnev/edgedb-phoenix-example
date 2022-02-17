alias EdgeDB

priv_dir = :code.priv_dir(:epe)
seeds_dir = Path.join([priv_dir, "edgeql", "seeds"])
seeds_queries =
  for seed_file <- File.ls!(seeds_dir) do
    seed_path = Path.join(seeds_dir, seed_file)
    File.read!(seed_path)
  end

{:ok, pid} = EdgeDB.start_link(connection: EdgeDB.Connection)

for query <- seeds_queries do
  EdgeDB.query!(pid, query)
end
