pub const TokenType = enum {
    ILLEGAL,
    EOF,

    // Identifiers + literals
    IDENT,
    INT,

    //Operators
    ASSIGN,
    PLUS,

    // Delimiters
    COMMA,
    SEMICOLON,

    LPAREN,
    RPAREN,
    LBRACE,
    RBRACE,

    FUNCTION,
    LET,
};

pub const Token = struct {
    type: TokenType,
    literal: u8,
};
