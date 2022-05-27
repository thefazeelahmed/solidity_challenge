// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract EthStaking {
    address public walletAddress;
    mapping(address => uint256) private _stakeHolders;
    AggregatorV3Interface internal priceFeed;

    constructor() {
        walletAddress = msg.sender;
        priceFeed = AggregatorV3Interface(
            0x9326BFA02ADD2366b30bacB125260Af641031331
        );
    }

    function logError(uint256 errorType)
        internal
        pure
        returns (string memory errorMsg_)
    {
        if (errorType == 1) {
            errorMsg_ = "Stakes must be more than 5 Eths.";
        }
        return errorMsg_;
    }

    function stakeEth(uint256 value) public payable {
        if (value < 5000000000000000000) {
            address payable addr = payable(walletAddress);
            addr.transfer(value);
            _stakeHolders[msg.sender] = value;
        } else {
            logError(1);
        }
    }

    function stakeholderStakes(address addr)
        public
        view
        returns (uint256 stakes)
    {
        return _stakeHolders[addr];
    }

    function getLatestPrice() public view returns (int256) {
        (
            uint80 roundID,
            int256 price,
            uint256 startedAt,
            uint256 timeStamp,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();

        return price;
    }
}