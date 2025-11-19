import { useState } from "react";

export default function Terminal() {
  const [output, setOutput] = useState("");

  return (
    <div className="bg-black text-green-400 h-48 p-2 font-mono overflow-auto border-t border-gray-700">
      <p className="text-yellow-300">Terminal</p>
      <pre>{output}</pre>
    </div>
  );
}
