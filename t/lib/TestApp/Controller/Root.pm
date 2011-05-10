package TestApp::Controller::Root;

use Moose;
use namespace::autoclean;

BEGIN {
    extends 'Catalyst::Controller::ActionRole';
}

__PACKAGE__->config(
    namespace    => '',
    action_roles => ['MatchRequestAccepts'],
);

sub default : Path Args {
    my ($self, $ctx) = @_;
    $ctx->response->body('default');
}

sub text_plain : Path('foo') Accept('text/plain') {
    my ($self, $ctx) = @_;
    $ctx->response->body('text_plain');
}

sub text_html : Path('foo') Accept('text/html') {
    my ($self, $ctx) = @_;
    $ctx->response->body('text_html');
}

sub text_plain_or_html : Path('bar') Accept('text/plain'') Accept('text/html') {
    my ($self, $ctx) = @_;
    $ctx->response->body('text_plain_or_html');
}

sub any_method : Path('baz') {
    my ($self, $ctx) = @_;
    $ctx->response->body('any');
}

__PACKAGE__->meta->make_immutable;

1;
