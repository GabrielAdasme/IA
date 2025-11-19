import Editor from "@monaco-editor/react";

export default function CodeEditor({ file, onChange }) {
  if (!file)
    return (
      <div className="flex-1 bg-gray-900 flex items-center justify-center text-gray-400">
        Nenhum arquivo selecionado
      </div>
    );

  return (
    <div className="flex-1 bg-gray-900">
      <Editor
        height="100%"
        theme="vs-dark"
        defaultLanguage="python"
        onChange={(value) => onChange(value)}
        defaultValue="// código do arquivo"
      />
    </div>
  );
}
