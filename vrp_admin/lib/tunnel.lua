Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
Resource = GetCurrentResourceName()
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
RegisterTunnel = {}
Tunnel.bindInterface(Resource, RegisterTunnel)

if IsDuplicityVersion() then

    Tools = module("vrp","lib/Tools")
    vTunnel = Tunnel.getInterface(Resource)
    arena = Tunnel.getInterface("mirtin_arena")
    garage = Proxy.getInterface("thunder_garages")
else
    vRP = Proxy.getInterface("vRP")

    RegisterTunnel = {}
    Tunnel.bindInterface(Resource, RegisterTunnel)

    vTunnel = Tunnel.getInterface(Resource)
end