// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import Nimble
import Quick
@testable import Itadaki

class StringExtensionTestSpec: QuickSpec {
    override func spec() {
        describe("String#subscript") {
            let str = "ABCDEFGHIJ"
            context("対象の文字列をABCDEFGHIJの10文字としたとき") {
                it("開始を0、終了を5にするとABCDEFが戻ること 正常系テスト") {
                    let target = str.substring(start: 0, end: 5)
                    expect(target).to(equal("ABCDEF"))
                }
                it("開始を3、終了を6にするとDEFGが戻ること 正常系テスト") {
                    let target = str.substring(start: 3, end: 6)
                    expect(target).to(equal("DEFG"))
                }
                it("開始を4、終了を4にするとEが戻ること 正常系テスト") {
                    let target = str.substring(start: 4, end: 4)
                    expect(target).to(equal("E"))
                }
                it("開始を-1、終了を2にするとABCが戻ること 開始が負の数の場合は0とするテスト") {
                    let target = str.substring(start: -1, end: 2)
                    expect(target).to(equal("ABC"))
                }
                it("開始を6、終了を12にするとGHIJが戻ること 終了が文字列長を超える場合は最後の文字までを取得するテスト") {
                    let target = str.substring(start: 6, end: 12)
                    expect(target).to(equal("GHIJ"))
                }
                it("終了より開始が大きい時は空文字が戻ること 範囲超えテスト") {
                    let target = str.substring(start: 5, end: 4)
                    expect(target).to(equal(""))
                }
                it("終了が0より小さい時は空文字が戻ること 範囲超えテスト") {
                    let target = str.substring(start: -2, end: -1)
                    expect(target).to(equal(""))
                }
                it("開始が文字列長より大きい時は空文字が戻ること 範囲超えテスト") {
                    let target = str.substring(start: 15, end: 20)
                    expect(target).to(equal(""))
                }
            }
        }
        describe("String#removedBackward") {
            let str = "ABCDEFGHIJ"
            context("対象の文字列をABCDEFGHIJとしたとき") {
                it("引数を渡さない場合にABCDEFGHIが戻ること 正常系テスト") {
                    let target = str.removedBackward()
                    expect(target).to(equal("ABCDEFGHI"))
                }
                it("引数に3を渡した場合にABCDEFGが戻ること 正常系テスト") {
                    let target = str.removedBackward(3)
                    expect(target).to(equal("ABCDEFG"))
                }
                it("引数に-3を渡した場合にABCDEFGHIJが戻ること 負の数を渡した場合は削除されずに返るテスト") {
                    let target = str.removedBackward(-3)
                    expect(target).to(equal("ABCDEFGHIJ"))
                }
            }
        }
        describe("String#withoutExtension") {
            context("対象の文字列をindex.htmlとしたとき") {
                it("indexが戻ること") {
                    let target = "index.html".withoutExtension
                    expect(target).to(equal("index"))
                }
            }
            context("対象の文字列をindexとしたとき") {
                it("indexが戻ること") {
                    let target = "index".withoutExtension
                    expect(target).to(equal("index"))
                }
            }
            context("対象の文字列をindex.min.htmlとしたとき") {
                it("index.minが戻ること") {
                    let target = "index.min.html".withoutExtension
                    expect(target).to(equal("index.min"))
                }
            }
        }
        describe("String#extension") {
            context("対象の文字列をindex.htmlとしたとき") {
                it("indexが戻ること") {
                    let target = "index.html".extension
                    expect(target).to(equal(".html"))
                }
            }
            context("対象の文字列をindexとしたとき") {
                it("indexが戻ること") {
                    let target = "index".extension
                    expect(target).to(equal(""))
                }
            }
            context("対象の文字列をindex.min.htmlとしたとき") {
                it("index.minが戻ること") {
                    let target = "index.min.html".extension
                    expect(target).to(equal(".html"))
                }
            }
        }
        describe("String#extensionWithoutDot") {
            context("対象の文字列をindex.htmlとしたとき") {
                it("indexが戻ること") {
                    let target = "index.html".extensionWithoutDot
                    expect(target).to(equal("html"))
                }
            }
            context("対象の文字列をindexとしたとき") {
                it("indexが戻ること") {
                    let target = "index".extensionWithoutDot
                    expect(target).to(equal(""))
                }
            }
            context("対象の文字列をindex.min.htmlとしたとき") {
                it("index.minが戻ること") {
                    let target = "index.min.html".extensionWithoutDot
                    expect(target).to(equal("html"))
                }
            }
        }
    }
}
