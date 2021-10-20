Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883A8434A19
	for <lists+linux-can@lfdr.de>; Wed, 20 Oct 2021 13:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhJTLgy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 20 Oct 2021 07:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTLgy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 20 Oct 2021 07:36:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0427C06161C
        for <linux-can@vger.kernel.org>; Wed, 20 Oct 2021 04:34:39 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1md9rg-0000VX-8J; Wed, 20 Oct 2021 13:34:36 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-a434-44ca-405c-0d71.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:a434:44ca:405c:d71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0BCF9698EB1;
        Wed, 20 Oct 2021 11:34:34 +0000 (UTC)
Date:   Wed, 20 Oct 2021 13:34:33 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, Matej Vasilevski <vasilmat@fel.cvut.cz>,
        Michal Simek <michal.simek@xilinx.com>,
        Martin =?utf-8?B?SmXFmcOhYmVr?= <martin.jerabek01@gmail.com>
Subject: Re: Query for status of timestamping for XCAN driver and possible
 project
Message-ID: <20211020113433.cjyypx7obla2n2pb@pengutronix.de>
References: <202110201317.50743.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aoojy6ykwqwxztau"
Content-Disposition: inline
In-Reply-To: <202110201317.50743.pisa@cmp.felk.cvut.cz>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--aoojy6ykwqwxztau
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.10.2021 13:17:50, Pavel Pisa wrote:
> Hello Oliver and Marc,
>=20
> our student, Matej Vasilevski, has chosen to continue
> on CAN latency tester which we done for Oliver years
> ago.
>=20
> We want to continue on the CAN-BENCH project started
> by Martin Jerabek
>=20
>   https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top/-/wikis/home
>=20
>   https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top/-/wikis/upl=
oads/56b4d27d8f81ae390fc98bdce803398f/F3-BP-2016-Jerabek-Martin-Jerabek-the=
sis-2016.pd
>=20
> We want to use XCAN on Xilinx Zynq 7010 with timestamping
> in the first iteration, then switch to our CTU CAN FD core
> and add timestamping to its driver.
>=20
> Is there some more recent attempt to add timestamping
> to XCAN driver than that original work of Martin Jerabek?
>=20
> Is there some suggestion which driver is the right
> example to implement timestamping now?

I recently added HW timestamp support to the mcp251xfd driver. It makes
use of the timecounter + cyclecounter helpers. These take care of wrap
arounds and conversion of the timer value to nanoseconds.

https://elixir.bootlin.com/linux/v5.14/source/drivers/net/can/spi/mcp251xfd=
/mcp251xfd-timestamp.c

A worker is setup to regularly read the free running time stamp register
to deal with the wrap around. You probably don't need this, if you have
a 64 bit timestamp register.

If your hardware directly provides 64 bit timestamp in ns or =C2=B5s, you
don't even need the timecounter/cyclecounter.

To set the HW timestamp on the skb, it's

| mcp251xfd_skb_set_timestamp()

with timestamp provided by the CAN core that's done on RX and
TX-completion.

> Our intention is to implement feature in state ready
> for mainlining and we hope that with your feedback
> we succeed this time.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--aoojy6ykwqwxztau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmFv/sYACgkQqclaivrt
76nXaAf5AVEYR6yERFb8sbFpLwCI9ZqBLsRXGrLg0q9GJ0JDz2u2trTZh1iuRcjA
B0HsQhol0AogKC8xCkjdalTa1bTrZ8AUzS3oU89MioFceMw8YCHg0VK+1i4Pulgm
M0Xm1cMxwfv4Nr6K3XbRQVKax5ECbo7I6Op1JenixvGextS7IXH7O0Ygz4RcqoFq
FTSQ+KJOgcdQraDp0B9+126XnaQdG/MUbi1oSJevqzBt+cww5SCBjNYT8xKHI9rp
6amZiROMPUlC6l2E89d2HuzEqlRysenLEEK2Yn/Wwrp5yCTM5LBxlNeq2652Z5Ph
qn+atGShVU5gO/JkP7RfrTpygavrYw==
=RM7g
-----END PGP SIGNATURE-----

--aoojy6ykwqwxztau--
