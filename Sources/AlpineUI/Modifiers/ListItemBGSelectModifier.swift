import SwiftUI

public struct ListItemBGSelectModifier: ViewModifier {

    @State var isLongPress = false
    @State var localId: UUID?
    
    @Binding var selectedID: UUID?
    
    var id: UUID?
    var showSelected: Bool
    
    var selectedColor = Color(hex: "B8E994")
    var longPressColor = Color(hex: "E17355")
    
    var bgColor: Color? {
        if isLongPress && localId == id {
            return longPressColor
        }
        if let id = id {
            if showSelected && id == selectedID {
                return selectedColor
            }
        }
        return nil
    }
    
    public init(id: UUID? = nil, selectedID: Binding<UUID?>?, showSelected: Bool) {
        self.id = id
        self._selectedID = selectedID ?? .constant(nil)
        self.showSelected = showSelected
    }
    
    public func body(content: Content) -> some View {
        content
            .background(bgColor)
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("ListItemLongPress"))) { id in
                localId = id.userInfo?.first?.value as? UUID
                isLongPress = true
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("AlertCancel"))) { _ in
                isLongPress = false
            }
    }
}

extension View {
    public func listItemBackGround(id: UUID?, selectedID: Binding<UUID?>?, showSelected: Bool = true) -> some View {
        return modifier(ListItemBGSelectModifier(id: id, selectedID: selectedID, showSelected: showSelected))
    }
}
