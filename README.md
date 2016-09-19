REST KZ Client
================================

Testing config maker. Creates accounts, users, devices, conferences and callflows.

Testbed
-------

Testbed comprises two accounts cc1.kazoo and cc2.kazoo (with same realms). Each account has two users "User 1" and "User 2", with passwords user1pas and user2pas, and emails user1@cc1.kazoo and user2@cc1.kazoo. Each user has a sip device "Desk1" with login sip1 and password sip1pas1, in respective realms. Each user has a callflow assigned (1001 to User 1, 1002 to User 2). Each account has a conference owned by User 1, with 2001 callflow assigned.

Prerequisities
--------------

You need to have Perl and cpamn installed. It's possible to have local versions of both, here is how:
```sh
# install perl
curl -L https://install.perlbrew.pl | bash
source ~/perl5/perlbrew/etc/bashrc
perlbrew install perl-5.25.3
perlbrew use perl-5.25.3

# install cpanm
curl -L https://cpanmin.us | perl - App::cpanminus

```

Install
-------

```sh
cpanm Furl JSON
testbed.pl
```


