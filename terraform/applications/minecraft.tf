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
  version    = "2.8.1"

  values = ["${file("values/minecraft_homeworld.yaml")}"]
}
