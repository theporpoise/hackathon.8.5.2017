var MultiSig = artifacts.require("./MultiSig.sol");

module.exports = function(deployer) {
  deployer.deploy(MultiSig);
};
