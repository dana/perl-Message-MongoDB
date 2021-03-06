# NAME

Message::MongoDB - Message-oriented interface to MongoDB

# VERSION

Version 0.1

# SYNOPSIS

    use Message::MongoDB;

    my $mongo = Message::MongoDB->new();

    $mongo->message({
        mongo_db => 'my_db',
        mongo_collection => 'my_collection',
        mongo_method => 'insert',
        mongo_write => { a => 'b' },
    });

    $mongo->message({
        mongo_db => 'my_db',
        mongo_collection => 'my_collection',
        mongo_method => 'find',
        mongo_search => { },
    });

    #the emit method will be called with an array reference that contains
    #{a => 'b'}

# SUBROUTINES/METHODS

## new

    my $mongo = Message::MongoDB->new();

Nothing too interesting at this point.

## message

    $mongo->message({
        mongo_db => 'my_db',
        mongo_collection => 'my_collection',
        mongo_method => 'insert',
        mongo_write => { a => 'b' },
    });

Execute the specified mongo\_method on the specified mongo\_db and
mongo\_collection.

- message (first positional, required)
    - mongo\_db (required)

        Scalar referencing the mongo database to operate on.

    - mongo\_collection (required)

        Scalar referencing the mongo collection to operate on.

    - mongo\_method (required)

        Scalar indicating the mongo method to run.  One of

        - find

            Requires `mongo_search`

        - insert

            Requires `mongo_write`

        - update

            Requires `mongo_search` and `mongo_write`

        - remove

            Requires `mongo_search`

    - mongo\_search

        MongoDB search criteria.

            { a => 'b', c => { '$gt' => 99 } }

    - mongo\_write

        MongoDB 'write' criteria, for update and insert.

            { a => 'b', x => [1,2,3] }  #for insert

            { a => 'b', c => { '$set' => 100 } }  #for update

## auth

This returns the authentication bits necessary to talk to the desired
MongoDB.

Defaults to all defaults; localhost and port 27017.  Over-ride as
necessary.

## emit

    $merge->emit(%args)

This method is designed to be over-ridden; the default implementation simply
adds the outbound message, which is an ARRAY reference of HASHrefs
which represents the MongoDB result set, to the package global
@Message::MongoDB::return\_messages

# AUTHOR

Dana M. Diederich, `<diederich at gmail.com>`

# BUGS

Please report any bugs or feature requests to `bug-message-mongodb at rt.cpan.org`, or through
the web interface at [http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Message-MongoDB](http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Message-MongoDB).  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

# SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Message::MongoDB

You can also look for information at:

- Report bugs and feature requests here

    [https://github.com/dana/perl-Message-MongoDB/issues](https://github.com/dana/perl-Message-MongoDB/issues)

- AnnoCPAN: Annotated CPAN documentation

    [http://annocpan.org/dist/Message-MongoDB](http://annocpan.org/dist/Message-MongoDB)

- CPAN Ratings

    [http://cpanratings.perl.org/d/Message-MongoDB](http://cpanratings.perl.org/d/Message-MongoDB)

- Search CPAN

    [https://metacpan.org/module/Message::MongoDB](https://metacpan.org/module/Message::MongoDB)

# ACKNOWLEDGEMENTS

# LICENSE AND COPYRIGHT

Copyright 2013 Dana M. Diederich.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

[http://www.perlfoundation.org/artistic\_license\_2\_0](http://www.perlfoundation.org/artistic_license_2_0)

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
