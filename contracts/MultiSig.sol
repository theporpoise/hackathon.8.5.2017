pragma solidity ^0.4.4;

contract owned {
	address public owner;

	function owned() {
		owner = msg.sender;
	}

	modifier onlyOwner {
		require(msg.sender == owner);
		_;
	}
}

contract mortal is owned {
	function kill() onlyOwner {
		selfdestruct(owner);
	}
}

contract MultiSig is owned, mortal {
	uint256 funds;
	address trustOne;
	address trustTwo;
	uint256 sigOne;
	uint256 sigTwo;
	address releaseAddress;

	function MultiSig() {
	}

	function () payable {
		funds += msg.value;
	}

	function transfer(address _to, uint256 amount) onlyOwner {
		require(funds >= amount);
		funds -= amount;
		_to.transfer(amount);
	}

	function setTrustees(address _trustOne, address _trustTwo) onlyOwner{
		trustOne = _trustOne;
		trustTwo = _trustTwo;
	}

	function setRelease(address _releaseAddress) onlyOwner {
		releaseAddress = _releaseAddress;
	}

	function sign() {
		if (msg.sender == trustOne) {
			sigOne = 1;
		} else if (msg.sender == trustTwo) {
			sigTwo = 1;
		}
	}

	function releaseFunds() {
		require((sigOne == 1) && (sigTwo == 1));
		releaseAddress.transfer(funds);
	}
}