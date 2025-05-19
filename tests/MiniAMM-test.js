
const { expect } = require("chai");

describe("MiniAMM", function () {
  let MiniAMM, amm;

  beforeEach(async function () {
    MiniAMM = await ethers.getContractFactory("MiniAMM");
    amm = await MiniAMM.deploy();
    await amm.init(1000, 1000);
  });

  it("swapXforY 应符合恒定积公式", async function () {
    const dy = await amm.swapXforY(100);
    expect(dy).to.equal(91); // 手动计算后替换成正确值
  });
  it("兑换值为0时，不应有任何兑换", async function () {
    const dy = await amm.swapXforY(0);
    expect(dy).to.equal(0); 
  });
  it("兑换值为存储值时，不可将池子清空", async function () {
    const dy = await amm.swapXforY(1000);
    expect(dy).to.equal(500);
  });
});
