// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/HybridKeyVault.sol";

contract Deploy is Script {
    function run() external {
        // 1) Leer variables de entorno
        string memory pqc = vm.envString("PQC_PUBLIC_KEY");
        string memory rsa = vm.envString("RSA_PUBLIC_KEY");
        string memory encFlag = vm.envString("ENCRYPTED_FLAG");

        // 2) Desplegar el contrato
        vm.startBroadcast();
        HybridKeyVault vault = new HybridKeyVault(pqc, rsa, encFlag);
        vm.stopBroadcast();

        // 3) Preparar la dirección y la ruta de salida
        string memory addr = vm.toString(address(vault));
        string memory path = "contract_address.txt";

        // 4) Declarar array de 3 strings en memoria para vm.ffi
        string[] memory cmds = new string[](3);
        cmds[0] = "bash";
        cmds[1] = "-c";
        cmds[2] = string(abi.encodePacked("echo ", addr, " > ", path));

        // 5) Ejecutar el comando externo para escribir el archivo
        vm.ffi(cmds);

        // 6) Log en consola (opcional)
        console.log("HybridKeyVault deployed to:", address(vault));
        console.log("Address saved in:", path);
    }
}
