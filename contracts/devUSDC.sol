// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

ontract devUSDC is ERC20 {
    constructor() ERC20("devUSDC", "DUSDC") {
        _mint(msg.sender,200000000000000000000000);
    }
}

