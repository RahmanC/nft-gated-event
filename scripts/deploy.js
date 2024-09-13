// scripts/deploy.js
const hre = require("hardhat");

async function main() {
  const NFTGatedEventManager = await hre.ethers.getContractFactory(
    "NFTGatedEventManager"
  );

  const nftGatedEventManager = await NFTGatedEventManager.deploy();

  await nftGatedEventManager.deployed();

  // Output the address of the deployed contract
  console.log(
    "NFTGatedEventManager deployed to:",
    nftGatedEventManager.address
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
