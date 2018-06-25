// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class BootstrapViewController: UITableViewController {
    
    private var migration = Migration()
    
    // ここで動作を定義します
    // =========================================================================
    private let items: [(section: String, rows: [(title: String, handler: (UIViewController)->Void)])] = [
        (section: "App",
         rows: [
            (title: "ゲームメイン画面", handler: { vc in
                vc.present(crossDissolve: MainViewController.create())
            }),
            (title: "アプリ起動", handler: { vc in
                vc.present(crossDissolve: LaunchViewController.create())
            }),
            ]),
        (section: "ゲームデータ作成",
         rows: [
            (title: "テスト", handler: { vc in
                print("open " + Path.documentDirectory)
                
                (vc as! BootstrapViewController).migration.migrate() {
                    print("complete")
                }
            }),
            ]),
        (section: "Realm",
         rows: [
            (title: "パス", handler: { vc in
                print("open " + Realm.path)
            }),
            (title: "プレディケート", handler: { vc in
                let pred = NSPredicate.empty
                    .and(NSPredicate("age", greaterThan: 30))
                    .and(NSPredicate("name", beginsWith: "Mc"))
                    .and(NSPredicate("published", fromDate: Date(), toDate: nil))
                    .and(NSPredicate("code", equal: "CD").or(NSPredicate("code", equal: "ED")))
                    .and(NSPredicate(isNil: "mark"))
                    .and(NSPredicate(ids: [1, 3, 20]))
                print(pred)
            }),
            ]),
        ]
    // =========================================================================
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.section].rows[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        items[indexPath.section].rows[indexPath.row].handler(self)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].section
    }
}
