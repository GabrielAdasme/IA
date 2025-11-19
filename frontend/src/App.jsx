import Sidebar from "./components/Sidebar";
import FileExplorer from "./components/FileExplorer";
import CodeEditor from "./components/CodeEditor";
import Terminal from "./components/Terminal";
import AgentLog from "./components/AgentLog";
import { useState } from "react";

export default function App() {
  const [selectedFile, setSelectedFile] = useState(null);
  const [projectFiles, setProjectFiles] = useState({});
  const [logs, setLogs] = useState("");

  return (
    <div className="flex h-screen">
      {/* Coluna esquerda */}
      <Sidebar />

      {/* Explorer */}
      <FileExplorer
        files={projectFiles}
        onSelect={(file) => setSelectedFile(file)}
      />

      {/* Editor */}
      <CodeEditor
        file={selectedFile}
        onChange={(newCode) => {
          setProjectFiles({
            ...projectFiles,
            [selectedFile]: newCode
          })
        }}
      />

      {/* Coluna direita */}
      <div className="w-1/4 bg-gray-800 flex flex-col border-l border-gray-700">
        <AgentLog logs={logs} />

        <Terminal />
      </div>
    </div>
  );
}
