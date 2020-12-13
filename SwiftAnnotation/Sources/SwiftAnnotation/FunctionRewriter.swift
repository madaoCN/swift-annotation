//
//  File.swift
//  
//
//  Created by 梁宪松 on 2020/12/12.
//

import Foundation
import SwiftSyntax

class  FuncRewriterVisitor: SyntaxRewriter {
    
    // func函数头插入内容
    private var formBeforeSource: String
    // func函数插入尾内容
    private var formAfterSource: String
    
    init(formBeforeSource: String, formAfterSource: String) {
        self.formBeforeSource = formBeforeSource
        self.formAfterSource = formAfterSource
    }

    func codeBlockItemSyntax(_ text: String) -> CodeBlockItemSyntax {
        let tree = try! SyntaxParser.parse(source: text)
        return SyntaxFactory.makeCodeBlockItem(item: tree._syntaxNode, semicolon: nil, errorTokens: nil)
    }
    
    override func visit(_ node: FunctionDeclSyntax) -> DeclSyntax {
        
        // 没有body的话直接返回
        guard var retBody = node.body else {
            return DeclSyntax(node);
        }
        
        // 获取注释内容
        if let leadingTrivia = node.leadingTrivia,
           leadingTrivia.count > 0 {
            
            // SwiftSyntax.TriviaPiece.Type
            var triviaStr = ""
            for trivia in leadingTrivia {
                var tempStr = ""
                trivia.write(to: &tempStr)
                triviaStr += tempStr
            }
            
            // 匹配注释内容
            print(triviaStr)
            if let matchRes = self.regexGetSub(pattern: "(?<=annotation:).+", str: triviaStr)?.trimmingCharacters(in: CharacterSet.whitespaces) {
                // 注释内容添加至 formBeforeSource
                
                // 替换 __format__
                self.formBeforeSource = self.formBeforeSource.replacingOccurrences(of: "__format__", with: matchRes)
                self.formAfterSource = self.formAfterSource.replacingOccurrences(of: "__format__", with: matchRes)
            }
            
        }
       
        //防止重复插入
        if let firstItem = retBody.statements.first?.description{
            if formBeforeSource.description.range(of: firstItem) != nil{
                return DeclSyntax(node);
            }
        }
        
        // body插入代码片段
        retBody.statements = retBody.statements.prepending(self.codeBlockItemSyntax(self.formBeforeSource))
        retBody.statements = retBody.statements.appending(self.codeBlockItemSyntax(self.formAfterSource))
        
        var retNode = FunctionDeclSyntax(node._syntaxNode);
        retNode?.body = retBody;
        return DeclSyntax(retNode!);
    }
    
    // #warning注解
    override func visit(_ node: PoundWarningDeclSyntax) -> DeclSyntax {
        
        return super.visit(node)
    }
}


extension FuncRewriterVisitor {
    
    func regexGetSub(pattern:String, str:String) -> String? {
        let regex = try! NSRegularExpression(pattern: pattern, options:[.caseInsensitive])
        guard let matches = regex.firstMatch(in: str, options: [], range: NSRange(str.startIndex...,in: str)) else {
            return nil
        }
        return String(str[Range(matches.range, in: str)!])
    }
}
