let
  nyx = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPe4SX4TqpeC4WSWKwv/k52oZL+7cT/Y8YOkmv3rlO5B";
  taylor = "";
  users = [nyx taylor];

  down = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPe4SX4TqpeC4WSWKwv/k52oZL+7cT/Y8YOkmv3rlO5B";
  top = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFqx1SnbfmUcYiOrKnXxd/hc88l6+KtrNOBM2/BtPub6";

  systems = [top down];
in {
  "slskd_env.age".publicKeys = systems;
  "secret1.age".publicKeys = [nyx down];
  "secret2.age".publicKeys = users ++ systems;
}
