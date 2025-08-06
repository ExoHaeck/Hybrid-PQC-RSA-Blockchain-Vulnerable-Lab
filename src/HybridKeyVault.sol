// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HybridKeyVault {
    string public publicKeyPQC;
    string public publicKeyRSA;
    string private encryptedFlag;

    constructor(
        string memory _pqc,
        string memory _rsa,
        string memory _encFlag
    ) {
        publicKeyPQC = _pqc;
        publicKeyRSA = _rsa;
        encryptedFlag = _encFlag;
    }

    function getPublicKeys()
        public
        view
        returns (string memory, string memory)
    {
        return (publicKeyPQC, publicKeyRSA);
    }

    function getEncryptedFlag() public view returns (string memory) {
        return encryptedFlag;
    }
}
