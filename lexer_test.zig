const TokenType = @import("./token/token.zig").TokenType;
const Lexer = @import("./lexer/lexer.zig");
const std = @import("std");
const testing = std.testing;
const expect = std.testing.expect;

test "Next Token" {
    const input = "=+(){},;";

    const expectedObj = struct {
        expectedType: TokenType,
        expectedLiteral: u32,
    };

    const tests = [_]expectedObj{
        expectedObj{ .expectedType = TokenType.ASSIGN, .expectedLiteral = '=' },
        expectedObj{ .expectedType = TokenType.PLUS, .expectedLiteral = '+' },
        expectedObj{ .expectedType = TokenType.LPAREN, .expectedLiteral = '(' },
        expectedObj{ .expectedType = TokenType.RPAREN, .expectedLiteral = ')' },
        expectedObj{ .expectedType = TokenType.LBRACE, .expectedLiteral = '{' },
        expectedObj{ .expectedType = TokenType.RBRACE, .expectedLiteral = '}' },
        expectedObj{ .expectedType = TokenType.COMMA, .expectedLiteral = ',' },
        expectedObj{ .expectedType = TokenType.SEMICOLON, .expectedLiteral = ';' },
        expectedObj{ .expectedType = TokenType.EOF, .expectedLiteral = 0 },
    };

    var l = Lexer.New(input);
    for (tests) |testObj| {
        const token = Lexer.NextToken(&l);
        // std.debug.print("expected type {} \n", .{testObj});
        // std.debug.print("actual type {} \n", .{token});
        try testing.expectEqual(testObj.expectedType, token.type);
        try testing.expectEqual(testObj.expectedLiteral, token.literal);
    }
}
