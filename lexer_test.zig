const Token = @import("./token/token.zig");
const Lexer = @import("./lexer/lexer.zig");
const std = @import("std");
const expect = std.testing.expect;

test "Next Token" {
    const input = "=(){},;";

    const expectedObj = struct {
        expectedType: Token.TokenType,
        expectedLiteral: []const u8,
    };

    const tests = [_]expectedObj{
        expectedObj{ .expectedType = Token.TokenType.ASSIGN, .expectedLiteral = "=" },
    };

    const l = Lexer.Lexer.New(input);

    for (tests) |testObj| {
        const token = l.NextToken();

        try expect(token.TokenType == testObj.expectedType);
        try expect(token.Literal == testObj.expectedLiteral);
    }
}
