
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import "./lib/EnumerableMap.sol";
// 调用合约
// AddressToUintMap
contract AddressToUintMapMock {
    using EnumerableMap for EnumerableMap.AddressToUintMap;

    event OperationResult(bool result);

    EnumerableMap.AddressToUintMap private _map;

    function contains(address key) public view returns (bool) {
        return _map.contains(key);
    }

    function set(address key, uint256 value) public {
        bool result = _map.set(key, value);
        emit OperationResult(result);
    }

    function remove(address key) public {
        bool result = _map.remove(key);
        emit OperationResult(result);
    }

    function length() public view returns (uint256) {
        return _map.length();
    }

    function at(uint256 index) public view returns (address key, uint256 value) {
        return _map.at(index);
    }

    function tryGet(address key) public view returns (bool, uint256) {
        return _map.tryGet(key);
    }

    function get(address key) public view returns (uint256) {
        return _map.get(key);
    }

    function getWithMessage(address key, string calldata errorMessage) public view returns (uint256) {
        return _map.get(key, errorMessage);
    }
}
