const main = artifacts.require("main.sol");

module.exports = function (deployer) {
    deployer.deploy(main,"123","Kiran","kiran@gmail.com","asdb","985545200","123");
};