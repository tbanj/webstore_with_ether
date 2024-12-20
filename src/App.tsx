import "./App.css";

import { useEffect, useState } from "react";
import { ethers } from "ethers";

// ABIs
import Ethcommerce from "./abis/Ethcommerce.json";

// Config
import config from "./config.json";

function App() {
  const [provider, setProvider] = useState<any>(null);
  const [ethcommerce, setEthcommerce] = useState(null);

  const [electronics, setElectronics] = useState(null);
  const [clothing, setClothing] = useState(null);
  const [toys, setToys] = useState(null);
  const [account, setAccount] = useState(null);

  const loadBlockchainData = async () => {
    const provider = new ethers.BrowserProvider(window.ethereum);
    setProvider(provider);
    const network = await provider.getNetwork();

    const loadedEthcommerce = new ethers.Contract(
      config[network.chainId].ethcommerce.address,
      Ethcommerce,
      provider
    );
    console.log(await loadedEthcommerce.items(1));
    setEthcommerce(loadedEthcommerce);

    const items = [];

    for (var i = 0; i < 9; i++) {
      const item = await ethcommerce.items(i + 1);
      items.push(item);
    }
    console.log(items, loadedEthcommerce, "hi");
    const electronics = items.filter((item) => item.category === "electronics");
    const clothing = items.filter((item) => item.category === "clothing");
    const toys = items.filter((item) => item.category === "toys");

    setElectronics(electronics);
    setClothing(clothing);
    setToys(toys);
  };

  useEffect(() => {
    loadBlockchainData();
  }, []);

  return (
    <div>
      <h2>Ethcommerce Best Sellers</h2>
    </div>
  );
}

export default App;
