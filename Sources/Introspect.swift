import SwiftUI

#if os(macOS)
public typealias PlatformView = NSView
#endif
#if os(iOS) || os(tvOS)
public typealias PlatformView = UIView
#endif

#if os(macOS)
public typealias PlatformViewController = NSViewController
#endif
#if os(iOS) || os(tvOS)
public typealias PlatformViewController = UIViewController
#endif

/// Utility methods to inspect the UIKit view hierarchy.
public enum Introspect {
    
    /// Finds a subview of the specified type.
    /// This method will recursively look for this view.
    /// Returns nil if it can't find a view of the specified type.
    public static func findChild<AnyViewType: PlatformView>(
        ofType type: AnyViewType.Type,
        in root: PlatformView
    ) -> AnyViewType? {
        for subview in root.subviews {
            if let typed = subview as? AnyViewType {
                return typed
            } else if let typed = findChild(ofType: type, in: subview) {
                return typed
            }
        }
        return nil
    }
    
    /// Finds a child view controller of the specified type.
    /// This method will recursively look for this child.
    /// Returns nil if it can't find a view of the specified type.
    public static func findChild<AnyViewControllerType: PlatformViewController>(
        ofType type: AnyViewControllerType.Type,
        in root: PlatformViewController
    ) -> AnyViewControllerType? {
        for child in root.children {
            if let typed = child as? AnyViewControllerType {
                return typed
            } else if let typed = findChild(ofType: type, in: child) {
                return typed
            }
        }
        return root as? AnyViewControllerType
    }
    
    /// Finds a subview of the specified type.
    /// This method will recursively look for this view.
    /// Returns nil if it can't find a view of the specified type.
    public static func findChildUsingFrame<AnyViewType: PlatformView>(
        ofType type: AnyViewType.Type,
        in root: PlatformView,
        from originalEntry: PlatformView
    ) -> AnyViewType? {
        var children: [AnyViewType] = []
        for subview in root.subviews {
            if let typed = subview as? AnyViewType {
                children.append(typed)
            } else if let typed = findChild(ofType: type, in: subview) {
                children.append(typed)
            }
        }
        
        if children.count > 1 {
            for child in children {
                let converted = child.convert(
                    CGPoint(x: originalEntry.frame.size.width / 2, y: originalEntry.frame.size.height / 2),
                    from: originalEntry
                )
                if CGRect(origin: .zero, size: child.frame.size).contains(converted) {
                    return child
                }
            }
            return nil
        }
        
        return children.first
    }
    
    /// Finds a previous sibling that contains a view of the specified type.
    /// This method inspects siblings recursively.
    /// Returns nil if no sibling contains the specified type.
    public static func previousSibling<AnyViewType: PlatformView>(
        containing type: AnyViewType.Type,
        from entry: PlatformView,
        containerID: IntrospectionContainerID
    ) -> AnyViewType? {
        
        guard let superview = entry.superview,
            let entryIndex = superview.subviews.firstIndex(of: entry),
            entryIndex > 0
        else {
            return nil
        }
        
        for subview in superview.subviews[0..<entryIndex].reversed() {
            if let typed = findChild(ofType: type, in: subview) {
                return typed
            }
        }
        
        return nil
    }
    
    /// Finds a previous sibling that is of the specified type.
    /// This method inspects siblings recursively.
    /// Returns nil if no sibling contains the specified type.
    public static func previousSibling<AnyViewType: PlatformView>(
        ofType type: AnyViewType.Type,
        from entry: PlatformView,
        containerID: IntrospectionContainerID
    ) -> AnyViewType? {
        
        guard let superview = entry.superview,
            let entryIndex = superview.subviews.firstIndex(of: entry),
            entryIndex > 0
        else {
            return nil
        }
        
        for subview in superview.subviews[0..<entryIndex].reversed() {
            if let typed = subview as? AnyViewType {
                return typed
            }
        }
        
        return nil
    }
    
    /// Finds a previous sibling that contains a view controller of the specified type.
    /// This method inspects siblings recursively.
    /// Returns nil if no sibling contains the specified type.
    @available(macOS, unavailable)
    public static func previousSibling<AnyViewControllerType: PlatformViewController>(
        containing type: AnyViewControllerType.Type,
        from entry: PlatformViewController,
        containerID: IntrospectionContainerID
    ) -> AnyViewControllerType? {
        
        guard let parent = entry.parent,
            let entryIndex = parent.children.firstIndex(of: entry),
            entryIndex > 0
        else {
            return nil
        }
        
        for child in parent.children[0..<entryIndex].reversed() {
            if let typed = findChild(ofType: type, in: child) {
                return typed
            }
        }
        
        return nil
    }
    
    /// Finds a previous sibling that is a view controller of the specified type.
    /// This method does not inspect siblings recursively.
    /// Returns nil if no sibling is of the specified type.
    public static func previousSibling<AnyViewControllerType: PlatformViewController>(
        ofType type: AnyViewControllerType.Type,
        from entry: PlatformViewController,
        containerID: IntrospectionContainerID
    ) -> AnyViewControllerType? {
        
        guard let parent = entry.parent,
            let entryIndex = parent.children.firstIndex(of: entry),
            entryIndex > 0
        else {
            return nil
        }
        
        for child in parent.children[0..<entryIndex].reversed() {
            if let typed = child as? AnyViewControllerType {
                return typed
            }
        }
        
        return nil
    }
    
    /// Finds a next sibling that contains a view of the specified type.
    /// This method inspects siblings recursively.
    /// Returns nil if no sibling contains the specified type.
    public static func nextSibling<AnyViewType: PlatformView>(
        containing type: AnyViewType.Type,
        from entry: PlatformView,
        containerID: IntrospectionContainerID
    ) -> AnyViewType? {
        
        guard let superview = entry.superview,
            let entryIndex = superview.subviews.firstIndex(of: entry)
        else {
            return nil
        }
        
        for subview in superview.subviews[entryIndex..<superview.subviews.endIndex] {
            if let typed = findChild(ofType: type, in: subview) {
                return typed
            }
        }
        
        return nil
    }
    
    /// Finds a next sibling that if of the specified type.
    /// This method inspects siblings recursively.
    /// Returns nil if no sibling contains the specified type.
    public static func nextSibling<AnyViewType: PlatformView>(
        ofType type: AnyViewType.Type,
        from entry: PlatformView,
        containerID: IntrospectionContainerID
    ) -> AnyViewType? {
        
        guard let superview = entry.superview,
            let entryIndex = superview.subviews.firstIndex(of: entry)
        else {
            return nil
        }
        
        for subview in superview.subviews[entryIndex..<superview.subviews.endIndex] {
            if let typed = subview as? AnyViewType {
                return typed
            }
        }
        
        return nil
    }
    
    /// Finds an ancestor of the specified type.
    /// If it reaches the top of the view without finding the specified view type, it returns nil.
    public static func findAncestor<AnyViewType: PlatformView>(
        ofType type: AnyViewType.Type,
        from entry: PlatformView,
        containerID: IntrospectionContainerID
    ) -> AnyViewType? {
        var superview = entry.superview
        while let s = superview {
            if let typed = s as? AnyViewType {
                return typed
            }
            superview = s.superview
        }
        return nil
    }
    
    /// Finds an ancestor of the specified type.
    /// If it reaches the top of the view without finding the specified view type, it returns nil.
    public static func findAncestorOrAncestorChild<AnyViewType: PlatformView>(
        ofType type: AnyViewType.Type,
        from entry: PlatformView,
        containerID: IntrospectionContainerID
    ) -> AnyViewType? {
        var superview = entry.superview
        while let s = superview {
            if let typed = s as? AnyViewType ?? findChildUsingFrame(ofType: type, in: s, from: entry) {
                return typed
            }
            superview = s.superview
        }
        return nil
    }
    
    /// Finds the hosting view of a specific subview.
    /// Hosting views generally contain subviews for one specific SwiftUI element.
    /// For instance, if there are multiple text fields in a VStack, the hosting view will contain those text fields (and their host views, see below).
    /// Returns nil if it couldn't find a hosting view. This should never happen when called with an IntrospectionView.
    public static func findHostingView(
        from entry: PlatformView,
        containerID: IntrospectionContainerID
    ) -> PlatformView? {
        var superview = entry.superview
        while let s = superview {
            if NSStringFromClass(type(of: s)).contains("HostingView") {
                return s
            }
            superview = s.superview
        }
        return nil
    }
    
    /// Finds the view host of a specific view.
    /// SwiftUI wraps each UIView within a ViewHost, then within a HostingView.
    /// Returns nil if it couldn't find a view host. This should never happen when called with an IntrospectionView.
    public static func findViewHost(
        from entry: PlatformView,
        containerID: IntrospectionContainerID
    ) -> PlatformView? {
        var superview = entry.superview
        while let s = superview {
            if NSStringFromClass(type(of: s)).contains("ViewHost") {
                return s
            }
            superview = s.superview
        }
        return nil
    }
}

public enum TargetViewSelector {
    public static func siblingContaining<TargetView: PlatformView>(
        from entry: PlatformView,
        containerID: IntrospectionContainerID
    ) -> TargetView? {
        guard let viewHost = Introspect.findViewHost(from: entry, containerID: containerID) else {
            return nil
        }
        return Introspect.previousSibling(containing: TargetView.self, from: viewHost, containerID: containerID)
    }

    public static func siblingContainingOrAncestor<TargetView: PlatformView>(
        from entry: PlatformView,
        containerID: IntrospectionContainerID
    ) -> TargetView? {
        if let sibling: TargetView = siblingContaining(from: entry, containerID: containerID) {
            return sibling
        }
        return Introspect.findAncestor(ofType: TargetView.self, from: entry, containerID: containerID)
    }
    
    public static func siblingContainingOrAncestorOrAncestorChild<TargetView: PlatformView>(
        from entry: PlatformView,
        containerID: IntrospectionContainerID
    ) -> TargetView? {
        if let container = entry.recursivelyFind(\.superview, where: { $0.accessibilityIdentifier == containerID.uuidString }) {
            print("container found!", container)
        }
        print("entry", entry)
        if let sibling: TargetView = siblingContaining(from: entry, containerID: containerID) {
            return sibling
        }
        return Introspect.findAncestorOrAncestorChild(ofType: TargetView.self, from: entry, containerID: containerID)
    }
    
    public static func siblingOfType<TargetView: PlatformView>(
        from entry: PlatformView,
        containerID: IntrospectionContainerID
    ) -> TargetView? {
        if let container = entry.recursivelyFind(\.superview, where: { $0.accessibilityIdentifier == containerID.uuidString }) {
            print("container found!", container)
        }
        guard let viewHost = Introspect.findViewHost(from: entry, containerID: containerID) else {
            return nil
        }
        return Introspect.previousSibling(ofType: TargetView.self, from: viewHost, containerID: containerID)
    }

    public static func siblingOfTypeOrAncestor<TargetView: PlatformView>(
        from entry: PlatformView,
        containerID: IntrospectionContainerID
    ) -> TargetView? {
        if let container = entry.recursivelyFind(\.superview, where: { $0.accessibilityIdentifier == containerID.uuidString }) {
            print("container found!", container)
        }
        if let sibling: TargetView = siblingOfType(from: entry, containerID: containerID) {
            return sibling
        }
        return Introspect.findAncestor(ofType: TargetView.self, from: entry, containerID: containerID)
    }

    public static func ancestorOrSiblingContaining<TargetView: PlatformView>(
        from entry: PlatformView,
        containerID: IntrospectionContainerID
    ) -> TargetView? {
        if let container = entry.recursivelyFind(\.superview, where: { $0.accessibilityIdentifier == containerID.uuidString }) {
            print("container found!", container)
        }
        if let tableView = Introspect.findAncestor(ofType: TargetView.self, from: entry, containerID: containerID) {
            return tableView
        }
        return siblingContaining(from: entry, containerID: containerID)
    }
    
    public static func ancestorOrSiblingOfType<TargetView: PlatformView>(
        from entry: PlatformView,
        containerID: IntrospectionContainerID
    ) -> TargetView? {
        if let tableView = Introspect.findAncestor(ofType: TargetView.self, from: entry, containerID: containerID) {
            return tableView
        }
        return siblingOfType(from: entry, containerID: containerID)
    }
}

/// Allows to safely access an array element by index
/// Usage: array[safe: 2]
private extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}

extension UIView {
    func recursivelyFind(_ keyPath: (UIView) -> UIView?, where condition: (UIView) -> Bool) -> UIView? {
        if let view = keyPath(self) {
            if condition(view) {
                return view
            } else {
                return view.recursivelyFind(keyPath, where: condition)
            }
        } else {
            return nil
        }
    }
}
