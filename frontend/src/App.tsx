import React, { useEffect } from "react";
import logo from "./logo.svg";
import "./App.css";
import { WalletSelector } from "@aptos-labs/wallet-adapter-ant-design";
import { Provider, Network } from "aptos";
import { useWallet } from "@aptos-labs/wallet-adapter-react";
import "@aptos-labs/wallet-adapter-ant-design/dist/index.css";

export const provider = new Provider(Network.DEVNET);
export const moduleAddress =
  "0xa2860e98cec346e494daa79d20c790635b67eb92397f0f27c65a8de5ee09a3b9";

function App() {
  const [globalCount, setGlobalCount] = React.useState(0);
  const { account, signAndSubmitTransaction } = useWallet();

  const fetchGlobalCounter = () => {
    setInterval(async () => {
      try {
        const counter_struct_resource = await provider.getAccountResource(
          moduleAddress,
          `${moduleAddress}::moveCounter::CounterStruct`
        );
        setGlobalCount(
          (counter_struct_resource as any).data.global_counter as number
        );
      } catch (e) {
        console.log(e);
      }
    }, 2000);
  };

  const handleClick = async () => {
    if (!account) return;
    const paylpad = {
      type: "entry_function_payload",
      function: `${moduleAddress}::moveCounter::increment_counter`,
      type_arguments: [],
      arguments: [],
    };
    try {
      const response = await signAndSubmitTransaction(paylpad);
      await provider.waitForTransaction(response);
      setGlobalCount((count) => count + 1);
    } catch (e) {
      console.log(e);
    }
  };
  useEffect(() => {
    fetchGlobalCounter();
  }, []);

  return (
    <div className="App">
      <div className="outer">
        {account?.address && (
          <p title={account?.address}>
            Logged in: ...{account?.address.substring(60, 66)}
          </p>
        )}
      </div>
      <h1 className="appname">Counter App</h1>

      <div>
        {account?.address ? (
          <div>
            <p className="counter">
              {String(globalCount).padStart(4, "0")}
            </p>

            <button
              
              onClick={handleClick}
            >
              Increment
            </button>
          </div>
        ) : (
          <div style={{margin:10}}>
            
            <WalletSelector />
          </div>
        )}
      </div>
    </div>
  );
}

export default App;
