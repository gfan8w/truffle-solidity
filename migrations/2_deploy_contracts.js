var Adoption = artifacts.require("Adoption");
var ERC20MinterBurnerPauser = artifacts.require("ERC20MinterBurnerPauser");


// 强制重新部署： truffle  migrate --reset

module.exports = function(deployer) {
    deployer.deploy(Adoption);
    deployer.deploy(ERC20MinterBurnerPauser,"SARO","SARO",18);

    //let address= ERC20MinterBurnerPauser.deployed();
    //console.log("ERC20MinterBurnerPauser contract address:",address)
};
