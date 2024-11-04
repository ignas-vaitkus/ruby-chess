# CLI Chess

2 player CLI Chess. Has functioning en passant, castling, promoting. Moves are made using Coordinate Notation. For example, to move with the e pawn, first, write down the square it is on and then the target square separated with a hyphen - "E2-E4", e pawn moves from square E2 to square E4. To castle simply move the king to the target square "E1-C1" or "E8-G8". To promote write the piece letter in parentheses "E7-E8(Q)" or "B2-B1(N)".

## Usage

Install deps: `gem install bundler && bundle install`.  Run `bundle exec rake` to run the tests, or `bundle exec rake run` to run the program.
