const { ethers } = require("hardhat");
const { expect } = require("chai");

describe("IntefaceContract", function () {

  async function deployIdentityContract() {
    const [deployer] = await ethers.getSigners();
    const IdentityContract = await ethers.getContractFactory("IdentityContract");
    const identityeContract = await IdentityContract.deploy(
      (await ethers.getSigners())[0].address
    );
    return identityeContract;
  }

  it("Should support interface id", async function () {
    const identityContract = await deployIdentityContract();
    const interfaceId = await identityContract.supportsInterface("0x01ffc9a7");
    expect(interfaceId).to.be.true;
  });

});