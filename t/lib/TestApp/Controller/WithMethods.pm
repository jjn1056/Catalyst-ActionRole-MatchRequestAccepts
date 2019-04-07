package TestApp::Controller::WithMethods;

use Moose;
use namespace::autoclean;

BEGIN {
  extends 'Catalyst::Controller::ActionRole';
}

__PACKAGE__->config(
  action_roles => ['MatchRequestAccepts'],
);

sub root : Chained('/') PathPrefix CaptureArgs(0) {}

  ## Adds GET method action attribute                                     ---vvv
  sub text_plain : Chained('root') PathPart('') Accept('text/plain') Args(0) GET {
    my ($self, $ctx) = @_;
    $ctx->response->body('text_plain');
  }

__PACKAGE__->meta->make_immutable;

1;
