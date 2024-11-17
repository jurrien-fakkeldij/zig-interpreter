const TokenType = @import("../token/token.zig").TokenType;
const Token = @import("../token/token.zig").Token;
const std = @import("std");

pub const Lexer = struct {
    input: []const u8,
    position: u16,
    readPosition: u16,
    ch: u8,
};

pub fn readChar(lexer: *Lexer) void {
    if (lexer.readPosition >= lexer.input.len) {
        lexer.ch = 0;
    } else {
        lexer.ch = lexer.input[lexer.readPosition];
    }

    lexer.position = lexer.readPosition;
    lexer.readPosition += 1;
}

pub fn NextToken(lexer: *Lexer) Token {
    const tok = switch (lexer.ch) {
        '=' => newToken(TokenType.ASSIGN, lexer.ch),
        '+' => newToken(TokenType.PLUS, lexer.ch),
        '(' => newToken(TokenType.LPAREN, lexer.ch),
        ')' => newToken(TokenType.RPAREN, lexer.ch),
        '{' => newToken(TokenType.LBRACE, lexer.ch),
        '}' => newToken(TokenType.RBRACE, lexer.ch),
        ',' => newToken(TokenType.COMMA, lexer.ch),
        ';' => newToken(TokenType.SEMICOLON, lexer.ch),
        0 => newToken(TokenType.EOF, lexer.ch),
        else => {
            std.debug.print("Could not map character {c} from {s}\n", .{ lexer.ch, lexer.input });
            unreachable;
        },
    };

    readChar(lexer);
    return tok;
}

fn newToken(tokenType: TokenType, ch: u8) Token {
    return Token{ .type = tokenType, .literal = ch };
}

pub fn New(input: []const u8) Lexer {
    var lexer = Lexer{ .input = input, .position = 0, .readPosition = 0, .ch = 0 };
    readChar(&lexer);
    return lexer;
}
