// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/

import UIKit
import Common

// MARK: Additional information shown when the info accessory button is tapped.
class TPAccessoryInfo: ThemedTableViewController {
    var isStrictMode = false

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(cellType: ThemedSubtitleTableViewCell.self)
        tableView.estimatedRowHeight = 130
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none

        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        applyTheme()
        listenForThemeChange(view)
    }

    func headerView() -> UIView {
        let stack = UIStackView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
        stack.axis = .vertical

        let header = UILabel()
        header.text = .TPAccessoryInfoBlocksTitle
        header.font = DefaultDynamicFontHelper.preferredFont(withTextStyle: .body, size: 13, weight: .semibold)
        header.textColor = themeManager.currentTheme.colors.textSecondary

        stack.addArrangedSubview(UIView())
        stack.addArrangedSubview(header)

        stack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true

        let topStack = UIStackView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        topStack.axis = .vertical
        let sep = UIView()
        topStack.addArrangedSubview(stack)
        topStack.addArrangedSubview(sep)
        topStack.spacing = 10

        topStack.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        topStack.isLayoutMarginsRelativeArrangement = true

        sep.backgroundColor = themeManager.currentTheme.colors.borderPrimary
        sep.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.width.equalToSuperview()
        }
        return topStack
    }

    override func applyTheme() {
        super.applyTheme()
        tableView.tableHeaderView = headerView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return isStrictMode ? 5 : 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCellFor(indexPath: indexPath)
        cell.applyTheme(theme: themeManager.currentTheme)
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.textLabel?.text = .TPSocialBlocked
            } else {
                cell.textLabel?.text = .TPCategoryDescriptionSocial
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.textLabel?.text = .TPCrossSiteBlocked
            } else {
                cell.textLabel?.text = .TPCategoryDescriptionCrossSite
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                cell.textLabel?.text = .TPCryptominersBlocked
            } else {
                cell.textLabel?.text = .TPCategoryDescriptionCryptominers
            }
        } else if indexPath.section == 3 {
            if indexPath.row == 0 {
                cell.textLabel?.text = .TPFingerprintersBlocked
            } else {
                cell.textLabel?.text = .TPCategoryDescriptionFingerprinters
            }
        } else if indexPath.section == 4 {
            if indexPath.row == 0 {
                cell.textLabel?.text = .TPContentBlocked
            } else {
                cell.textLabel?.text = .TPCategoryDescriptionContentTrackers
            }
        }
        cell.imageView?.tintColor = themeManager.currentTheme.colors.iconPrimary
        if indexPath.row == 1 {
            cell.textLabel?.font = LegacyDynamicFontHelper.defaultHelper.DefaultMediumFont
        }
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = themeManager.currentTheme.colors.textPrimary
        cell.selectionStyle = .none
        return cell
    }

    override func dequeueCellFor(indexPath: IndexPath) -> ThemedTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ThemedSubtitleTableViewCell.cellIdentifier, for: indexPath) as? ThemedSubtitleTableViewCell
        else {
            return ThemedSubtitleTableViewCell()
        }
        return cell
    }
}
