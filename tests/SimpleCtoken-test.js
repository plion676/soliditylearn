const { expect } = require("chai");
const { ethers } = require("hardhat");
describe("SimpleCtoken", function () {
  let CToken,cToken;
  let owner,user1;

  beforeEach(async function () {
    [owner, user1] = await ethers.getSigners(); // 获取两个测试账户
    CToken = await ethers.getContractFactory("SimpleCtoken");
    cToken = await CToken.deploy();
  });

  it("应mintcETH和更新用户余额", async function () {
    await cToken.connect(user1).mint({value:ethers.parseEther("1")});
    const balance=await cToken.balances(user1.address);
    expect(balance).to.equal(ethers.parseEther("1"));
  });
  it("应成功赎回ETH", async function () {
    await cToken.connect(user1).mint({value:ethers.parseEther("1")});
    await cToken.connect(user1).redeem(ethers.parseEther("0.5"));
    const balance=await cToken.balances(user1.address);
    expect(balance).to.equal(ethers.parseEther("0.5"));
  });
  it("余额不足时回滚", async function () {
    await cToken.connect(user1).mint({value:ethers.parseEther("1")});
    await expect(cToken.connect(user1).redeem(ethers.parseEther("1.2"))).to.revertedWith("余额不足");
  });
});
