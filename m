Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBBD6329EA
	for <lists+linux-can@lfdr.de>; Mon, 21 Nov 2022 17:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiKUQpj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Nov 2022 11:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiKUQpi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Nov 2022 11:45:38 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E529515734
        for <linux-can@vger.kernel.org>; Mon, 21 Nov 2022 08:45:36 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 53A1A24002A
        for <linux-can@vger.kernel.org>; Mon, 21 Nov 2022 17:45:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1669049135; bh=YrRzO40NwP5jZdql+ojM/Z6w96Y3wHkF36YteAu5TiM=;
        h=Date:To:Cc:From:Subject:From;
        b=LraqiBJUb8dmgEAoE/aEqk7+HAZGQRyu/mm8bxORPcmnNRZpJj7FXwcMSvjn6PuTF
         nMbGDSlst/6pv3UkVaMevymZ4hPH67fpobFxt+9j1cT7oGeMbPq6vDRDRdvqnpl6MR
         0dtppDyNeh3AObc62yY50jkmBfhMZJNrQOTZLZ4M/zP4I4wX6f2zwKkEzspjFBa06y
         +btnJ/egz4NmEPlb/vr6/qahe1HKZMAhuyLexNj5/w/8yysAA9IzQsxdpce5Lv82dO
         2W/31c7sFMx/5KBv8612r1auiGQFy3sriF7RFDzcgh+z9hOPxgCpaPk2oUjzeilehF
         0lxxcaPU/nsvg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4NGCtk3NPYz6tqw;
        Mon, 21 Nov 2022 17:45:34 +0100 (CET)
Message-ID: <40200c08-552e-e6b3-c5c7-f5ee8a4b839c@posteo.de>
Date:   Mon, 21 Nov 2022 16:45:33 +0000
MIME-Version: 1.0
To:     Marvin Ludersdorfer <marvin.ludersdorfer@dintec.solutions>
References: <FR2P281MB165556E4F729AC3CDB50F6F69F0A9@FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM>
 <FR2P281MB165503FACCD9894C353ED4CE9F0A9@FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM>
 <49ce15b4-feaf-a519-9172-d0f59a9285ed@gmail.com>
Content-Language: de-DE
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Andre Naujoks <nautsch2@gmail.com>
From:   Patrick Menschel <menschel.p@posteo.de>
Subject: Re: Problem receiving > 8 byte UDS response when using istpsend
In-Reply-To: <49ce15b4-feaf-a519-9172-d0f59a9285ed@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------H2O0yheSQQsKTlvrtf8yD02Q"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------H2O0yheSQQsKTlvrtf8yD02Q
Content-Type: multipart/mixed; boundary="------------ws2xzyzOjJsoGCrYcxSMsJ1H";
 protected-headers="v1"
From: Patrick Menschel <menschel.p@posteo.de>
To: Marvin Ludersdorfer <marvin.ludersdorfer@dintec.solutions>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 Andre Naujoks <nautsch2@gmail.com>
Message-ID: <40200c08-552e-e6b3-c5c7-f5ee8a4b839c@posteo.de>
Subject: Re: Problem receiving > 8 byte UDS response when using istpsend
References: <FR2P281MB165556E4F729AC3CDB50F6F69F0A9@FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM>
 <FR2P281MB165503FACCD9894C353ED4CE9F0A9@FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM>
 <49ce15b4-feaf-a519-9172-d0f59a9285ed@gmail.com>
In-Reply-To: <49ce15b4-feaf-a519-9172-d0f59a9285ed@gmail.com>

--------------ws2xzyzOjJsoGCrYcxSMsJ1H
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

QW0gMjEuMTEuMjIgdW0gMTc6MTEgc2NocmllYiBBbmRyZSBOYXVqb2tzOg0KPiBBbSAyMS4x
MS4yMiB1bSAxMzowOCBzY2hyaWViIE1hcnZpbiBMdWRlcnNkb3JmZXI6DQo+Pg0KPj4gSW4g
YW5vdGhlciB0ZXJtaW5hbCwgSSBydW4gZWNobyAyMiBGMSA5NSB8IGlzb3Rwc2VuZCAtcyAw
MDAwMDY4MCAtZCANCj4+IDAwMDAwNzgwIGNhbjAgLXAgMHgwMA0KDQpUeXBpY2FsIGVycm9y
LA0KDQpleGNoYW5nZSAtcyBhbmQgLWQNCg0KaXNvdHByZWN2IHdvcmtzIHRoZSBvdGhlciB3
YXkgYXJvdW5kLg0KDQotLQ0KUGF0cmljaw0K

--------------ws2xzyzOjJsoGCrYcxSMsJ1H--

--------------H2O0yheSQQsKTlvrtf8yD02Q
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE6VSgQlqXIUKDwAxHMeZuMM+vuE4FAmN7qy0FAwAAAAAACgkQMeZuMM+vuE4i
OA/+KT04NxdXg98hTwmNrEk5DQ947pOkyR154vO4bPskBALnhwTaGk0+3mx0B1swRyXyD2tM5Buy
Al8wH8S3XVmudCidZVgY3yELdzaU7pKDkV648AsGRmCDYfhRTZ3cG8ThJT+2XZK2320VybdxHJ1Q
tAo9TNIBNdWR3ZU0C5pyqmzRd0qevhxY1vxvQgZFp7cqrGXBORGkSiJvM4DeMmsq1JXJbfzhve9n
C/l+KA13R0J4+CXw0cetuWEGMh0wa3awdUAtN5gEjkoJb7FaZczrkTMCr/wK4DsHna17EkkCRzMN
EW3CubNtEWF3RRsUMG2HgUlRxUgGVH9tkvHYuLq+GiVj1zOydfpdWlYZdCKE16eNZsySbh/kf0yd
Xsxt6hGkyx0aqretCmQekq0c6nsPGIJuu8e/aOZWjmyf8NIiXNmnn26mqnXUW1YFM5UwHYd163/d
TTIBziJAaGIKAtpedHd2HJw67yncPZ+T5x6icKpgxh+v8tlrHq95ZnBGgGxRZIBJ+lAVT2UHFTP0
UgTuozdwd/zMHpdgEJexAy5S6eLWSHnpqKEBHrar7KcU/XaJZdAGalbbaaNkoOE9YzRFNR6L92/f
qiD8h3q6ikbBFxsPH+41c5mZoA9GR/eGSZ9OBAVpN5+r8+/Tsq0XIk2dkORjI1DDHI5O5N8vKe+k
jUo=
=Qe+j
-----END PGP SIGNATURE-----

--------------H2O0yheSQQsKTlvrtf8yD02Q--
