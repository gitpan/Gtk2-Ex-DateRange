use strict;
use warnings;
use Glib qw(TRUE FALSE);
use Gtk2 -init;
use Data::Dumper;
use Gtk2::Ex::DateRange;

use Gtk2::TestHelper tests => 13;

my $daterange = Gtk2::Ex::DateRange->new;
isa_ok($daterange, "Gtk2::Ex::DateRange");
my $changed = 0;
$daterange->signal_connect('changed' =>
	sub {
		$changed++;
		print Dumper "here\n";
	}
);
ok(!$daterange->get_model);

$daterange->set_model(undef);
is($changed, 1);
ok(!$daterange->get_model);

$daterange->set_model([ 'after', '1965-03-12', 'and', 'before', '1989-02-14' ]);
is($changed, 2);
ok (Dumper $daterange->get_model, Dumper [ 'after', '1965-03-12', 'and', 'before', '1989-02-14' ]);

$daterange->set_model(undef);
is($changed, 3);
ok(!$daterange->get_model);

$daterange->set_model([ 'after', '1965-03-12']);
is($changed, 4);
ok (Dumper $daterange->get_model, Dumper [ 'after', '1965-03-12']);

$daterange->set_model(undef);
is($changed, 5);
ok(!$daterange->get_model);

ok($daterange->{widget});



