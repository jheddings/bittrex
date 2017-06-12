package APIKEY;

use Config::Simple;
use File::Basename qw(dirname);
use Cwd qw(abs_path);

# used by tests to load an API key from a nearby config file and return a tuple
# containing the key and secret.  returns undef if the keyfile is not present
# or the key cannot be found for any reason.
sub load {
  my $dirname = dirname(__FILE__);
  my $keyfile = abs_path("$dirname/apikey.cfg");

  # TODO better error handling if the file cannot be parsed or params are missing

  my $cfg = new Config::Simple($keyfile);
  my $key = $cfg->param('key');
  my $secret = $cfg->param('secret');

  return ($key, $secret);
}

1;  ## EOM
