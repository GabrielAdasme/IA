from autogen import AssistantAgent

def build_agents(model_name="deepseek-coder"):
    planner = AssistantAgent(
        name="planner",
        system_message="Você cria planos detalhados para desenvolvimento de software."
    )

    coder = AssistantAgent(
        name="coder",
        system_message="Você escreve código limpo, modular e organizado."
    )

    reviewer = AssistantAgent(
        name="reviewer",
        system_message="Você revisa código, detecta erros e sugere melhorias."
    )

    executor = AssistantAgent(
        name="executor",
        system_message="Você executa código e retorna logs."
    )

    return planner, coder, reviewer, executor
