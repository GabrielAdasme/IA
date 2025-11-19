export default function AgentLog({ logs }) {
  return (
    <div className="flex-1 overflow-auto p-3 bg-gray-850 border-b border-gray-700">
      <h2 className="text-lg font-semibold mb-2">Logs dos Agentes</h2>
      <pre className="text-sm text-gray-300 whitespace-pre-wrap">
        {logs || "Nenhuma atividade ainda..."}
      </pre>
    </div>
  );
}
