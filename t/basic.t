#!perl
use 5.006;
use strict; use warnings FATAL => 'all';
use Test::Most;
use Data::Dumper;

BEGIN {
    use_ok('Message::MongoDB') || print "Bail out!\n";
    use_ok('Message::MongoDB::Test') || print "Bail out!\n";
}

ok our $mongo = Message::MongoDB->new(), 'constructor worked';

my $test_db_name = Message::MongoDB::Test::test_db_name();
my $test_collection_name = Message::MongoDB::Test::test_collection_name();

#let's find out if MongoDB is running on localhost; if not, we need
#to just pass right away
eval {
    local $SIG{ALRM} = sub { die "alarm\n" };
    alarm 3;
    $mongo->_collection($test_db_name, $test_collection_name)
        or die "MongoDB isn't running!\n";
};
alarm 0;
if($@) {
    ok 1, 'MongoDB is not running, so we just smile and pass';
    done_testing();
    exit 0;
}

#insert
lives_ok {
    ok $mongo->message({
        mongo_db => $test_db_name,
        mongo_collection => $test_collection_name,
        mongo_method => 'insert',
        mongo_write => { a => 'b' }
    }),"Method 'insert' inserted object into collection";
} "...without error";

lives_ok {
    my $ret = $mongo->_get_documents($test_db_name,$test_collection_name);
    is $ret->[0]->{a}, 'b', "Verified object in collection";
} "...without error";

#remove the previous insert
lives_ok {
    ok $mongo->message({
        mongo_db => $test_db_name,
        mongo_collection => $test_collection_name,
        mongo_method => 'remove',
        mongo_search => { a => 'b' }
    }), "Method 'remove' removed object from collection";
} "...without error";

lives_ok {
    my $ret = $mongo->_get_documents($test_db_name,$test_collection_name);
    is @$ret, 0, "Verified object not in collection";
} "...without error";

#update
#first need to do an insert
lives_ok {
    ok $mongo->message({
        mongo_db => $test_db_name,
        mongo_collection => $test_collection_name,
        mongo_method => 'insert',
        mongo_write => { a => 'b' }
    }),"Method 'insert' inserted another object into collection";
} "...without error";

lives_ok {
    my $ret = $mongo->_get_documents($test_db_name,$test_collection_name);
    is $ret->[0]->{a}, 'b', "Verified object in collection";
} "...without error";

#now the update
lives_ok {
    ok $mongo->message({
        mongo_db => $test_db_name,
        mongo_collection => $test_collection_name,
        mongo_method => 'update',
        mongo_search => { a => 'b' },
        mongo_write => { a => 'c' },
    }), "Method 'update' updated object in collection";
} "...without error";

lives_ok {
    my $ret = $mongo->_get_documents($test_db_name,$test_collection_name);
    is $ret->[0]->{a}, 'c', "Verified updated object in collection";
} "...without error";

#find
#make sure we don't have a stray emit
is @Message::MongoDB::return_messages, 0, "Starting with zero emit messages";

lives_ok {
    ok $mongo->message({
        mongo_db => $test_db_name,
        mongo_collection => $test_collection_name,
        mongo_method => 'find',
        mongo_search => { a => 'c' },
    }), "Method 'find' found object in collection";
} "...without error";

lives_ok {
    my $ret = $mongo->_get_documents($test_db_name,$test_collection_name);
    is $ret->[0]->{a}, 'c', "Verified object still in collection";
} "...without error";

is @Message::MongoDB::return_messages, 1, "Method 'find' created 1 emit message";
is $Message::MongoDB::return_messages[0][0]->{a}, 'c', "Emit message has object";

done_testing();
