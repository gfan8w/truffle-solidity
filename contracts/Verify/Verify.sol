// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//参考： https://medium.com/chainsafe-systems/how-to-verify-a-signed-message-in-solidity-6b3100277424

// 1)在浏览器中运行 index.html
// 2)会调用metamask，它用一个地址的私钥签名一个消息，得到一个signature，把signature分割为 r、s、v 三部分。
// 3)传入到合约中，解开，返回得到一个公钥地址，该地址就是原来签名的那个私钥 对应的公钥地址

// "\x19Ethereum Signed Message:\n" + length(message) + message
// \x19 表示控制字符 End of MEDIUM，一般表示磁带等用完了。
// 因为 hash后的 message的长度是 32。所以直接这样表示：
// "\x19Ethereum Signed Message:\n32" + Keccak256(message)


// 签名的更多参考： https://medium.com/mycrypto/the-magic-of-digital-signatures-on-ethereum-98fe184dc9c7


contract Verify {

    function VerifyMessage(bytes32 _hashedMessage, uint8 _v, bytes32 _r, bytes32 _s) public pure returns (address) {
        bytes memory prefix = "\x19Ethereum Signed Message:\n32";
        bytes32 prefixedHashMessage = keccak256(abi.encodePacked(prefix, _hashedMessage));
        address signer = ecrecover(prefixedHashMessage, _v, _r, _s);
        return signer;
    }

}







