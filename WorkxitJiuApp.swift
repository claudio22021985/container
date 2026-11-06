import SwiftUI

@main
struct WorkxitJiuApp: App {
    var body: some Scene {
        WindowGroup {
            StudentHome()
                .tint(.red)
        }
    }
}

private struct StudentHome: View {
    var body: some View {
        TabView {
            NavigationStack {
                AttendanceCard()
                    .navigationTitle("Presenças")
            }
            .tabItem { Label("Presenças", systemImage: "calendar") }

            NavigationStack {
                CheckIn()
                    .navigationTitle("Check-in")
            }
            .tabItem { Label("Check-in", systemImage: "wifi") }

            NavigationStack {
                Finance()
                    .navigationTitle("Financeiro")
            }
            .tabItem { Label("Financeiro", systemImage: "creditcard") }
        }
    }
}

private struct DemoNotice: View {
    var body: some View {
        Label("Demonstração · dados fictícios", systemImage: "info.circle")
            .font(.footnote)
            .foregroundStyle(.secondary)
    }
}

private struct AttendanceCard: View {
    var body: some View {
        List {
            DemoNotice()
            Section("Cartão do aluno") {
                LabeledContent("Aluno", value: "ALUNO DEMONSTRAÇÃO")
                LabeledContent("Turma", value: "GB1 Adulto")
                LabeledContent("Competência", value: "Novembro de 2026")
            }
            Section("Histórico de aulas") {
                attendance("06/11 · 19h", present: true)
                attendance("04/11 · 19h", present: false)
                attendance("02/11 · 19h", present: true)
            }
        }
    }

    private func attendance(_ lesson: String, present: Bool) -> some View {
        LabeledContent(lesson) {
            Label(present ? "Presença" : "Falta",
                  systemImage: present ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundStyle(present ? Color.blue : Color.red)
        }
    }
}

private struct CheckIn: View {
    @State private var network: DemoNetwork = .mobile
    @State private var result: String?

    enum DemoNetwork: String, CaseIterable {
        case mobile = "Dados móveis"
        case otherWiFi = "Outro Wi-Fi"
        case academy = "Wi-Fi da academia"
    }

    var body: some View {
        Form {
            DemoNotice()
            Section("Aula de demonstração") {
                LabeledContent("Turma", value: "GB1 Adulto")
                LabeledContent("Horário", value: "19h")
            }
            Section("Simular conexão") {
                Picker("Rede", selection: $network) {
                    ForEach(DemoNetwork.allCases, id: \.self) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .onChange(of: network) { _, _ in result = nil }
                Button("Simular check-in") {
                    result = network == .academy
                        ? "Wi-Fi aceito na simulação. Nenhuma presença foi registrada."
                        : "Check-in bloqueado. Conecte-se ao Wi-Fi da academia."
                }
                if let result {
                    Text(result)
                }
            }
        }
    }
}

private struct Finance: View {
    @State private var showPixDetails = false
    private let currency = Decimal.FormatStyle.Currency(
        code: "BRL", locale: Locale(identifier: "pt_BR")
    )

    var body: some View {
        List {
            DemoNotice()
            Section("Mensalidade") {
                LabeledContent("Novembro de 2026", value: Decimal(180).formatted(currency))
                LabeledContent("Situação", value: "Pendente")
            }
            Section("Consumo em aberto") {
                LabeledContent("Água", value: Decimal(5).formatted(currency))
                LabeledContent("Energético", value: Decimal(12).formatted(currency))
                LabeledContent("Total de consumo", value: Decimal(17).formatted(currency))
            }
            Section("Pagamento") {
                LabeledContent("Total em aberto", value: Decimal(197).formatted(currency))
                Button("Ver fluxo de pagamento Pix") { showPixDetails = true }
            }
        }
        .sheet(isPresented: $showPixDetails) {
            NavigationStack {
                List {
                    DemoNotice()
                    Text("O aluno poderá pagar a mensalidade, quitar todo o consumo em aberto ou pagar o total em uma única cobrança.")
                    Text("A cobrança real exibirá QR Code, Pix Copia e Cola e o status da confirmação.")
                    Text("A integração Pix ainda está pendente.")
                }
                .navigationTitle("Pagamento Pix")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Fechar") { showPixDetails = false }
                    }
                }
            }
        }
    }
}
