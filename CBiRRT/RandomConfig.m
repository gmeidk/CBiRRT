function n_rand = RandomConfig(robot)
    config_rand = randomConfiguration(robot);
    n_rand = Node.config2node(config_rand,robot);
end