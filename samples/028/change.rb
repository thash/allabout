expect { a += 1 }.to change { a }.by(1)
expect { a += 3 }.to change { a }.from(2)
expect { a += 3 }.to change { a }.by_at_least(2)
