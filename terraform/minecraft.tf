# -------------------------------------------------------------------------------------------------
# Minecraft Server(s)
# -------------------------------------------------------------------------------------------------


# --------------------------------------------------------------------------------------
# Homeworld (Bedrock)
# --------------------------------------------------------------------------------------

resource "helm_release" "minecraft_homeworld" {
  name = "homeworld"

  namespace = "default"

  repository = "https://itzg.github.io/minecraft-server-charts/"
  chart      = "minecraft-bedrock"

  values = [
    "${file("extra/minecraft_homeworld_values.yml")}",
  ]
}
