Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CB058D8DD
	for <lists+linux-can@lfdr.de>; Tue,  9 Aug 2022 14:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242943AbiHIMpp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Aug 2022 08:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243263AbiHIMpo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Aug 2022 08:45:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE96BB1F4
        for <linux-can@vger.kernel.org>; Tue,  9 Aug 2022 05:45:43 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oLOcA-0005Hn-FD; Tue, 09 Aug 2022 14:45:42 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B515DC5D9B;
        Tue,  9 Aug 2022 12:45:41 +0000 (UTC)
Date:   Tue, 9 Aug 2022 14:45:40 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Magnus Aagaard =?utf-8?B?U8O4cmVuc2Vu?= <mas@csselectronics.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: Debugging dropped/missing frames in the network layer
Message-ID: <20220809124540.777p5lykbndyja6v@pengutronix.de>
References: <e396bfcd-aca2-fef8-a25d-e6e4b61e7d70@csselectronics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dfcovdmrfsaxz3px"
Content-Disposition: inline
In-Reply-To: <e396bfcd-aca2-fef8-a25d-e6e4b61e7d70@csselectronics.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--dfcovdmrfsaxz3px
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.08.2022 14:30:43, Magnus Aagaard S=C3=B8rensen wrote:
> I am working with an out-of-tree kernel driver which maps LIN messages vi=
a a
> UART onto the CAN networking stack, to allow for using the regular CAN to=
ols
> to also work with LIN messages (The driver in question is sllin,
> https://github.com/lin-bus/linux-lin/, based on slcan from what I
> understand).

FYI: in net-next/main the slcan driver has undergone a major cleanup.

> During use, I see a lot of frames missing from the output. From debugging
> the module, I can see that the kernel module receive the messages as
> expected, but they never show up in user space using candump. I can trace
> the messages in the module to the hand-off to the networking stack via a
> netif_rx call.
>=20
> Are there any additional handles in the networking/CAN stack to show me
> where the missing frames are being discarded before reaching user space, =
or
> which could otherwise help me narrow down the origin of this issue? The
> frames are transmitted from a custom/third party device at 19200 kbps and
> with 100 ms spacing.

Try running candump with -d.

| -d     (monitor dropped CAN frames)

> Hardware on the Linux side is a Raspberry Pi 4 running kernel 5.15.56 in =
64
> bit mode.

Marc
--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--dfcovdmrfsaxz3px
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLyVvEACgkQrX5LkNig
013lXQf+PhhUC5K3vZnKaJobSFQ3qXa5b1l81pbc86evlJWGnA/Da+4O+Xjew6O5
aG850AdbBw7v9RbVzhMepkoa3G96UmULe9ASPLqYdWPXbpl0p4Qwzq6b8As3fGp9
QK3gjh6EBxA4pprw1H+RhPKyHl5mUB9+u5M0eJRn0dr7d2gKlY7MbF5TElUZWEkg
iQRY/0rtrXcAu+ywMzOzVuD6lRXtIsaHmifggV18pYuUvTgtTNrtcXpDWF1knk3s
zYJ6RCz6IQqU5NtesK4eGK2J6zO5rzgKJ9j3QYUohq3wyGFqM7Zsr44uFr26EJXB
NCgYC052E7bNcAOOg4+2QxFIQyU1lg==
=52A2
-----END PGP SIGNATURE-----

--dfcovdmrfsaxz3px--
