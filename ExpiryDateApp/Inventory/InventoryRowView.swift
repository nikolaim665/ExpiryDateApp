import SwiftUI

struct InventoryRowView: View {
    let item: InventoryItem

    private var daysUntilExpiration: Int? {
        Calendar.current.dateComponents([.day], from: Date(), to: item.expirationDate).day
    }

    private var expirationLabel: String {
        guard let daysUntilExpiration else { return "Unknown" }
        switch daysUntilExpiration {
        case ..<0:
            return "Expired"
        case 0:
            return "Expires today"
        case 1:
            return "1 day left"
        default:
            return "\(daysUntilExpiration) days left"
        }
    }

    private var urgencyColor: Color {
        guard let daysUntilExpiration else { return .secondary }
        switch daysUntilExpiration {
        case ..<0: return .red
        case 0...2: return .orange
        default: return .green
        }
    }

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: item.category.systemImageName)
                .frame(width: 32, height: 32)
                .foregroundStyle(urgencyColor)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                Text(expirationLabel)
                    .font(.subheadline)
                    .foregroundStyle(urgencyColor)
            }

            Spacer()

            Text("\(item.quantity)")
                .font(.body.monospacedDigit())
                .padding(6)
                .background(.quaternary.opacity(0.5), in: RoundedRectangle(cornerRadius: 6))
        }
        .padding(.vertical, 4)
    }
}

struct InventoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryRowView(item: InventoryItem.sampleData.first!)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
