Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41B352659E
	for <lists+linux-can@lfdr.de>; Fri, 13 May 2022 17:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358612AbiEMPGT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 13 May 2022 11:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379612AbiEMPF5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 May 2022 11:05:57 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72212546AE
        for <linux-can@vger.kernel.org>; Fri, 13 May 2022 08:05:54 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id BD884240026
        for <linux-can@vger.kernel.org>; Fri, 13 May 2022 17:05:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1652454352; bh=o63zwI9M0PH1z4leJhrRHzGwbpNjxPmtgU/qy+rKuOw=;
        h=Date:From:Subject:To:From;
        b=Zb2f4khZUVJwV3QId43QuHO48TyXcKcPlU3QZHQh5bXd1M2YKxuR55stRchnh9+cH
         7owj++8bfG/AA7SGIHpYSLu9fZCwE/25bo5QNuOuPaVDASsUW/aUnXUjN/2EsSbOTX
         mSl8gKyjUZpnX1P1+ookGcw4exAz/B2haVpBjNF8J09eqLg8zmqfugBqLn01djJhIw
         QJo7mvsf6+8h/SXJGgqNRYt3sBVhE1xXN77DDscR5dpZVHhqLlk64R54zw55o+Kbna
         ZX5qfxXB+eoQwUZGeHojElMXBFWtta/+EwRH6wvgZT+cp2UPVtcVNHNwv8VZHz+Ymv
         Uf6l2i/kbd2ZQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L0BmJ1V5rz6tmJ
        for <linux-can@vger.kernel.org>; Fri, 13 May 2022 17:05:52 +0200 (CEST)
Message-ID: <31fba687-5642-bedc-ece7-9f8e2543978c@posteo.de>
Date:   Fri, 13 May 2022 15:05:51 +0000
MIME-Version: 1.0
From:   Patrick Menschel <menschel.p@posteo.de>
Subject: can-bcm: Best practice for dynamic data in frames?
To:     linux-can <linux-can@vger.kernel.org>
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------i9PUuayMKKSX8TiPHgLxfepP"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------i9PUuayMKKSX8TiPHgLxfepP
Content-Type: multipart/mixed; boundary="------------t5Y4VCk0KDFnj30PT2Eu0xcN";
 protected-headers="v1"
From: Patrick Menschel <menschel.p@posteo.de>
To: linux-can <linux-can@vger.kernel.org>
Message-ID: <31fba687-5642-bedc-ece7-9f8e2543978c@posteo.de>
Subject: can-bcm: Best practice for dynamic data in frames?

--------------t5Y4VCk0KDFnj30PT2Eu0xcN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

I'd like to ask about best practice to dynamically change the data bytes
of a frame that is sent via broadcast-manager, each time after it was sen=
t.

I came up with the following concept but maybe there is a more
"professional" way to do it.

1.
I set up my initial frame with valid data and send it with interval to
BCM as I do with regular cyclic transmits.
BcmOpCodes =3D TX_SETUP
BCMFlags =3D SETTIMER | STARTTIMER
=2E..


APP    BCM
 | -->  |    id 123 data 00 11 22 33 44 55 66 77


2.
I set up a can raw socket with a filter for exactly that frame id and
wait for the frame.

APP    RAW
 | <--  |    id 123 data 00 11 22 33 44 55 66 77


3.
Then I change the dynamic data, in this case a message counter in the
first byte and then update the frame in BCM.

BcmOpCodes =3D TX_SETUP
BCMFlags =3D 0
=2E..


APP    BCM
 | -->  |    id 123 data 01 11 22 33 44 55 66 77


This merry-go-around goes on as long as the application is running.
The purpose is some sort of heartbeat.


Thanks and Best Regards,
Patrick


--------------t5Y4VCk0KDFnj30PT2Eu0xcN--

--------------i9PUuayMKKSX8TiPHgLxfepP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE6VSgQlqXIUKDwAxHMeZuMM+vuE4FAmJ+c88FAwAAAAAACgkQMeZuMM+vuE5h
9w//TNE55Vkj097v4KM7aHm3UsrIMd1u6hFDNpy+ImQWixV9V81zgdX7bCZhJhCg9v+LTdPy/fx7
0qVjpmFYkqFGZu95tndmvkBOKQmOLebC0n1KlJ8DfbwX6Sw3V1Sq5/cm+++85AuHbnMCcttAeXO1
xlr+oRwhE/u+xyhlL4Z6qKdZb4JrdYGE7fhmiNgQV4TWpnmibprQJIXC1enStAGUxP19DtZNHiSV
AeKhkR7SDvvit3EQGTps1OBHxqv8N5eeVk2flr2ZS9eEt014bp3e74KbMTmLZVDEqVhMwo7BPoJ6
Qe+/DP9TT4f2ACsFDPNa0dH1D+E6InLC6QBF724VJ0Xolc3nU/LoWJqDDAyjZGXr8qdMpMNhH8SW
Ttam1hzzCqIjlhkrsHjapKfKilm99Mxv349nMRgFDur+eXFywEvxGfYh6SqU85R3Kny8aG5FfO0t
HLQOQU/2ab76Ut11FSRP57wbAkj5iOdgtfPwOBuKimfCsj4elJCbVP5CwgpBvXpbR6pbw5xjfTDx
oiPjsGRf5Hbe8mZE23mYRDjkL59n/faCDYaXdTlp2rK2ojOe+NRLGr+abFu8gPKOHjmQpIHIN9aX
O1gpifZmZR90np0/bCbKQYdPd0Uqzs2D33ldkqJ1puhZGxv24SJ3MX6St7IZJl3BOHCkzsmRJf/j
uH4=
=E7hZ
-----END PGP SIGNATURE-----

--------------i9PUuayMKKSX8TiPHgLxfepP--
