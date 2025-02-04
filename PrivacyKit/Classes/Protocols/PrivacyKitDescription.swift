//
//  PrivacyKitDescription.swift
//  PrivacyKit
//
//  Created by Jacob Fielding on 7/18/18.
//  Updated by Jacob Fielding on 10/31/18.
//

import Foundation

public extension PrivacyKit {

    func getDescription() -> NSMutableAttributedString? {
        return self.descriptionAttributed
    }

    internal func buildDescription() {
        self.descriptionParts = self.splitMessage()
        self.descriptionAttributed = self.getAttributed()
        self.bindLinks()
    }

    private func splitMessage() -> [String]? {
        if self.termsOfServiceLink != nil {
            if let privacyTextRange = self.termsOfServiceDescription.range(of: self.privacyPolicyText),
                let termsTextRange = self.termsOfServiceDescription.range(of: self.termsOfServiceText) {

                if privacyTextRange.lowerBound > termsTextRange.upperBound {
                    self.descriptionParts = [
                        String(self.termsOfServiceDescription[..<termsTextRange.lowerBound]),
                        String(self.termsOfServiceDescription[termsTextRange.lowerBound..<termsTextRange.upperBound]),
                        String(self.termsOfServiceDescription[termsTextRange.upperBound..<privacyTextRange.lowerBound]),
                        String(self.termsOfServiceDescription[privacyTextRange.lowerBound..<privacyTextRange.upperBound]),
                        String(self.termsOfServiceDescription[privacyTextRange.upperBound...])
                    ]
                }
                return [
                    String(self.termsOfServiceDescription[..<privacyTextRange.lowerBound]),
                    String(self.termsOfServiceDescription[privacyTextRange.lowerBound..<privacyTextRange.upperBound]),
                    String(self.termsOfServiceDescription[privacyTextRange.upperBound..<termsTextRange.lowerBound]),
                    String(self.termsOfServiceDescription[termsTextRange.lowerBound..<termsTextRange.upperBound]),
                    String(self.termsOfServiceDescription[termsTextRange.upperBound...])
                ]
            }
        }

        if let privacyTextRange = self.privacyDescription.range(of: self.privacyPolicyText) {
            return [
                String(self.privacyDescription[..<privacyTextRange.lowerBound]),
                String(self.privacyDescription[privacyTextRange.lowerBound..<privacyTextRange.upperBound]),
                String(self.privacyDescription[privacyTextRange.upperBound...])
            ]
        }

        return nil
    }

    private func getAttributed() -> NSMutableAttributedString {
        let description = NSMutableAttributedString(string: String(""))

        if let parts = self.descriptionParts {
            for part in parts {
                var attributes: [NSAttributedString.Key: Any] = self.paragraphAttr
                if part == privacyPolicyText || part == termsOfServiceText {
                    attributes = self.highlightAttr
                }
                description.append(
                    NSMutableAttributedString(
                        string: part,
                        attributes: attributes
                    )
                )
            }
        }

        return description
    }

    private func bindLinks() {
        if let privacyTextRange = self.descriptionAttributed?.mutableString.range(of: self.privacyPolicyText) {
            self.privacyPolicyLinkRange = privacyTextRange
            if let privacyLink = self.privacyPolicyLink {
                self.descriptionAttributed?.addAttribute(.link, value: privacyLink, range: privacyTextRange)
            }
        }

        if let termsOfServiceRange = self.descriptionAttributed?.mutableString.range(of: self.termsOfServiceText) {
            self.termsOfServiceLinkRange = termsOfServiceRange
            if let termsLink = self.termsOfServiceLink {
                self.descriptionAttributed?.addAttribute(.link, value: termsLink, range: termsOfServiceRange)
            }
        }
    }
}
