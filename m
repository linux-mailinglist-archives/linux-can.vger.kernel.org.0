Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECC25910DC
	for <lists+linux-can@lfdr.de>; Fri, 12 Aug 2022 14:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbiHLMiC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 Aug 2022 08:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237772AbiHLMiB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 12 Aug 2022 08:38:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4E6AB1B2
        for <linux-can@vger.kernel.org>; Fri, 12 Aug 2022 05:37:59 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oMTvG-0004TN-Up; Fri, 12 Aug 2022 14:37:55 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5443FC833D;
        Fri, 12 Aug 2022 12:37:50 +0000 (UTC)
Date:   Fri, 12 Aug 2022 14:37:49 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     David Boles <me@davidbol.es>
Cc:     Tom Evans <thomasaevans@optusnet.com.au>,
        linux-can@vger.kernel.org, s.grosjean@peak-system.com
Subject: Re: PCAN and SocketCAN Questions
Message-ID: <20220812123749.zqqn4kico5zai5ql@pengutronix.de>
References: <CAMgOUGpGEUQgLgAQmYbn-UdWXCkC7kRqdhW-mfg=e2gq9QfqRQ@mail.gmail.com>
 <20220810074530.or6oecnm7obmm7rh@pengutronix.de>
 <CAMgOUGoKHJnA5KLBE5_txgEBnC6LU3zNKkok7QEiMcrwQc0TvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uc7lci2eihtt2bxn"
Content-Disposition: inline
In-Reply-To: <CAMgOUGoKHJnA5KLBE5_txgEBnC6LU3zNKkok7QEiMcrwQc0TvA@mail.gmail.com>
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


--uc7lci2eihtt2bxn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.08.2022 13:17:47, David Boles wrote:
> Thank you Marc and Tom for your suggestions! I have a few follow-ups:

I'm missing Tom's mail, seems it didn't make it to the mailing list.

> # Question 1: Silently losing received frames if the socket isn't read
> from frequently enough
>=20
> > See candump's "-d" command line option.
>=20
> Unfortunately it seems like this is happening at the layer of
> individual sockets. Candump was already printing out messages that I
> was "losing", and adding the -d flag doesn't affect its printout
> (presumably since from its perspective, they haven't been dropped).

See the code that the "-d" command line options activates :)

| https://github.com/linux-can/can-utils/blob/master/candump.c#L650

=2E.. and add this to your app.

> > Run your program at a lower NICE value

You can try to receive several CAN frames with recvmmsg().

> Good idea!
>=20
> > Make the queue as big as you can.

I the socket drops CAN frames, this means there's not enough CPU time
for your app to receive them all. You should look at your system and
find out where the CPU time is lost.

> Yep, that's what I'm currently doing. It's probably an acceptable
> solution though not ideal; I'd like to be able to detect this
> happening and fail noisily.
>=20
> # Question 2: Behavior of one-shot and presume-ack
>=20
> It sounds like one-shot doesn't retry in the event of other problems
> (like losing arbitration) so that isn't what I want. It sounds like
> presume-ack is what I wanted but is only supported by very few
> devices, so I probably don't want to use it either.
>=20
> # New: Question 4
>=20
> I think the right course of action is to detect (either via
> looped-back frames or maybe error frames, or something else) that my
> transceiver is the only one on the bus and to stop sending messages
> temporarily. I'd like to avoid sending excessively stale frames (e.g.
> if a new transceiver joins the bus five minutes later, it shouldn't
> receive a five minute old frame from me) and from my testing with
> PCAN-USB dongles they seem to try resending a frame endlessly.

We currently don't have an API for stopping/aborting CAN frames, the
only thing you can do is ifdown/ifup the interface.

> I'd
> also like to avoid missing receiving frames transmitted by any new
> transceivers on the bus. Is there any universal/reliable API for
> clearing all transmit buffers for an interface, down to the device
> itself, without affecting its ability to receive frames?

No - currently there's only the down/up method.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--uc7lci2eihtt2bxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmL2SZoACgkQrX5LkNig
012E5Qf/QNkZKYav2May0jtF+6CPQQ6MWnZo5DiyqAVrbHCwniDY7alciB0yH48F
i9p2E9PCcgcWk9TJZnsK9ztCvI9sXxiarTkV/de1bGOUuzoSpjKONClpzERKNaP8
4+S460y8JTcOfT6tJvNyujo4slkp77ehuQ94JIqucWT4Yc8Vx2LMQibTEVLnLW3u
4ogAr1MiKejTJ4ya7avGBhi8/ZapNfipwEyky7D0K5qedwa/8MLgy2I4Kqx+2kOj
tr+nthr0GQ/h8E2M6YHa0fG6GVPQEjOp33xMgnB1v2yPWB1IOecdJ9sUGGQjF0YS
FowQm6rBpeLOxEyk17HWywj7wVF2HA==
=B+N8
-----END PGP SIGNATURE-----

--uc7lci2eihtt2bxn--
