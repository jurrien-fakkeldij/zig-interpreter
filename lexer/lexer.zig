const Token = @import("../token/token.zig");

pub const Lexer = struct {
    input: []const u8,
    position: u16,
    readPosition: u16,
    ch: u8,

    pub fn New(input: []const u8) *Lexer {
        const lexer = &Lexer{ .input = input };
        lexer.readChar();
        return lexer;
    }

    pub fn readChar(self: Lexer) void {
        if (self.readPosition >= self.input.len) {
            self.ch = 0;
        } else {
            self.ch = self.input[self.readPosition];
        }

        self.position = self.readPosition;
        self.readPosition += 1;
    }

    pub fn NextToken(self: Lexer) Token.Token {
        return switch (self.ch) {
            '=' => newToken(Token.TokenType.ASSIGN, self.ch),
            else => unreachable,
        };
    }

    fn newToken(tokenType: Token.TokenType, ch: u8) Token.Token {
        return Token.Token{ .type = tokenType, .literal = ch };
    }
};
