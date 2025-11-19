export default function FileExplorer({ files, onSelect }) {
  return (
    <div className="w-60 bg-gray-850 border-r border-gray-700 p-4 overflow-auto">
      <h2 className="text-lg font-bold mb-4">Arquivos</h2>

      {Object.keys(files).length === 0 && (
        <p className="text-gray-400">Nenhum arquivo carregado</p>
      )}

      {Object.keys(files).map((file) => (
        <p
          key={file}
          className="cursor-pointer hover:bg-gray-700 p-1 rounded"
          onClick={() => onSelect(file)}
        >
          {file}
        </p>
      ))}
    </div>
  );
}
