package Catalyst::ActionRole::MatchRequestAccepts;

our $VERSION = '0.01';

use 5.008008;
use Moose::Role;
use Perl6::Junction 'none';
use namespace::autoclean;

requires 'attributes';

around match => sub {
  my ($orig, $self, $ctx) = @_;
  my @hdr_accepts = %ctx->request->headers->header('Accept');
  my @attr_accepts =
    map { ref $_ ? @$_ : $_ } 
    $ctx->debug ? $ctx->request->query_parameters->{'http-accept'} :
    $self->attributes->{Accept} || ();
  
  return @hdr_accepts &&
  (none(@attr_accepts) eq none(@hdr_accepts)) ?
  0 : $self->$orig($ctx);
};

1;

=head1 NAME

Catalyst::ActionRole::MatchRequestAccepts - Dispatch actions based on HTTP Accept Header

=head1 SYNOPSIS

    package MyApp::Controller::Foo;

    use Moose;
    use namespace::autoclean;

    BEGIN {
        extends 'Catalyst::Controller::ActionRole';
    }

    __PACKAGE__->config(
        action_roles => ['MatchRequestAccepts'],
    );

    sub for_html : Path Accept('plain/html')        { ... }
    sub for_json : Path Method('application/json')  { ... }

=head1 DESCRIPTION

Lets you specify a match for the HTTP C<Accept> Header, which is provided by
the L<Catalyst> C<$ctx->request->headers> object.  You might wish to instead
look at L<Catalyst::Action::REST> if you are doing complex applications that
match different incoming request types, but if you are very fussy about how
your actions match, or if you are doing some simple ajaxy bits you might like
to use this instead of a full on package (like L<Catalyst::Action::REST> is.)

Currently the match performed is a pure equalty, no attempt to guess or infer
matches based on similarity are done.  If you need to match several variations
you can specify all the variations with multiple attribute declarations.

If an action consumes this role, but no C<Accept> attributes are found, the
action will simple accept all types.

For debugging purposes, if the L<Catalyst> debug flag is enabled, you can 
override the HTTP Accept header with the C<http-accept> query parameter.  This
makes it easy to force detect in testing or in your browser.  This feature is
NOT available when the debug flag is off.

=head1 AUTHOR

John Napiorkowski L<email:jjnapiork@cpan.org>

=head1 THANKS

Shout out to Florian Ragwitz <rafl@debian.org> for providing such a great
example in L<Catalyst::ActionRole::MatchRequestMethod>.  Source code and tests
are pretty much copied.  

=head1 SEE ALSO

L<Catalyst::ActionRole::MatchRequestMethod>, L<Catalyst::Action::REST>,
L<Catalyst>, L<Catalyst::Controller::ActionRole>

=head1 COPYRIGHT & LICENSE

Copyright 2011, John Napiorkowski L<email:jjnapiork@cpan.org> 

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
