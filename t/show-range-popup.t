use strict;
use warnings;
use Glib qw(TRUE FALSE);
use Gtk2 -init;
use Data::Dumper;
use Gtk2::Ex::DateRange;

use Gtk2::TestHelper tests => 1;

my $daterange = Gtk2::Ex::DateRange->new;
isa_ok($daterange, "Gtk2::Ex::DateRange");
$daterange->set_model([ 'after', '1965-03-12', 'and', 'before', '1989-02-14' ]);
$daterange->signal_connect('changed' =>
	sub {
		print Dumper $daterange->get_model;
	}
);

my $label = Gtk2::Label->new('Click-Here');
my $labelbox = _add_button_press($label);
my $popup = $daterange->attach_popup_to($label);
$labelbox->signal_connect('button-press-event' => 
	sub {
		$popup->show;
	}
);
my $window = Gtk2::Window->new;
$window->signal_connect('destroy' => sub { Gtk2->main_quit });
my $hbox = Gtk2::HBox->new (FALSE);
$hbox->pack_start (Gtk2::Label->new, TRUE, TRUE, 0); 
$hbox->pack_start ($labelbox, TRUE, TRUE, 0); 
$hbox->pack_start (Gtk2::Label->new, TRUE, TRUE, 0); 

my $vbox = Gtk2::VBox->new (FALSE);
$vbox->pack_start ($hbox, FALSE, FALSE, 0); 	
$vbox->pack_start (Gtk2::Label->new, TRUE, TRUE, 0); 

$window->add($vbox);
$window->set_default_size(300, 400);
$window->show_all;

sub _add_button_press {
	my ($widget) = @_;
	my $eventbox = Gtk2::EventBox->new;
	$eventbox->add ($widget);
	$eventbox->add_events (['button-press-mask']);
	return $eventbox;
}
