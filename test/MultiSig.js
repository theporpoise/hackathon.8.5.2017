var MultiSig = artifacts.require("./MultiSig.sol")
describe("MultiSig", () => {
  contract("transfer", (accounts) => {
    it("send 10000 to contract", () => {
      return Promise.resolve()
      .then(() => MultiSig.deployed())
      .then(() => {
        instance = web3.eth.contract(MultiSig.abi).at(MultiSig.address)
        web3.eth.sendTransaction({from: accounts[0], to: instance.address, value: 100000})
      })
    })
    it("set trustees and release" , () => {
      return Promise.resolve()
      .then(() => {
        instance = web3.eth.contract(MultiSig.abi).at(MultiSig.address)
        instance.setTrustees(accounts[1], accounts[2], {from: accounts[0]})
        instance.setRelease(accounts[3], {from: accounts[0]})
      })
    })
    it("sign release", () => {
      return Promise.resolve()
      .then(() => {
          instance = web3.eth.contract(MultiSig.abi).at(MultiSig.address)
          instance.sign({from: accounts[1]})
          instance.sign({from: accounts[2]})
      })
    })
    it("release funds" , () => {
      return Promise.resolve()
      .then(() => {
        instance = web3.eth.contract(MultiSig.abi).at(MultiSig.address)
        console.log("contract balance: ", web3.eth.getBalance(MultiSig.address).toNumber())
        console.log("account 3 balance: ", web3.eth.getBalance(accounts[3]).toNumber())    
        instance.releaseFunds({from: accounts[4]})  
        console.log("contract balance: ", web3.eth.getBalance(MultiSig.address).toNumber())
        console.log("account 3 balance: ", web3.eth.getBalance(accounts[3]).toNumber())                
      })
    })
  })
})
