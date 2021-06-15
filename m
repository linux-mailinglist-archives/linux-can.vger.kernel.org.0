Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71CC3A77CC
	for <lists+linux-can@lfdr.de>; Tue, 15 Jun 2021 09:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhFOHSG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Jun 2021 03:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhFOHSG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Jun 2021 03:18:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40695C061574
        for <linux-can@vger.kernel.org>; Tue, 15 Jun 2021 00:16:02 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lt3Il-0000Yx-AL; Tue, 15 Jun 2021 09:15:59 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:8a21:1526:9696:549])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2D8F263BC92;
        Tue, 15 Jun 2021 07:15:58 +0000 (UTC)
Date:   Tue, 15 Jun 2021 09:15:57 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: Testing two MCP2518FD's on i.MX8MM
Message-ID: <20210615071557.o7fjkleuk777otvm@pengutronix.de>
References: <CAOMZO5CwS-cO3W148YHVYFwcL3QC8oFJfeQBb+WN=QgEPU7AsQ@mail.gmail.com>
 <CAOMZO5D3suvPzaMq3Fx9LKDC9mzb-0w6i3EbQum-ozczdY-EPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h63pmb27loa6hisk"
Content-Disposition: inline
In-Reply-To: <CAOMZO5D3suvPzaMq3Fx9LKDC9mzb-0w6i3EbQum-ozczdY-EPQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--h63pmb27loa6hisk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.06.2021 12:10:19, Fabio Estevam wrote:
> I am trying to run CAN stress tests on an i.MX8MM-based board that
> has two mcp2518fd chips. I am using linux-next 20210607 and this is
> the ecspi dts:
>=20
> https://pastebin.com/raw/YVvuqAAc
>
> Then I launch the test script:
> ./cantest start
>
> This is the script content:
> https://pastebin.com/raw/hc8gKgUf
>
> The problem is that RX FIFO overflow happens:
>
> [  128.559485] mcp251xfd spi0.0 can0: RX-0: FIFO overflow.
> [  128.573478] mcp251xfd spi0.0 can0: RX-0: FIFO overflow.
> [  128.584787] mcp251xfd spi0.0 can0: RX-0: FIFO overflow.
>
> and also cansequence errors:
> # 2020-02-09 01:41:15:368 sequence CNT: 2779938, RX:      8    expected: =
 34    missing:  230    skt overfl d:    0 a:    0    delta: 230    inciden=
t: 6    seq_wrap RX: 10860     sequ_wrap_expected: 10860   overall lost: 136
> 2020-02-09 01:41:15:368 sequence CNT:      9, RX:     34    expected:   9=
    missing:   25    skt overfl d:   [  899.794388] mcp251xfd spi0.0 can0: =
RX-0: FIFO overflow.
>  0 a:    0    delta:  25    incident: 7    seq_wrap RX: 10860   [  899.80=
4780] mcp251xfd spi0.0 can0: RX-0: FIFO overflow.
>   sequ_wrap_expected: 10860   overall lost: 161
> 2020-02-09 01:41:15:370 sequence CNT:     40, RX:      9    expected:  40=
    missing:  225    skt overfl d:    0 a:    0    delta: 225    incident: =
8    seq_wrap RX: 10860     sequ_wrap_expected: 10860   overall lost: 130
> 2020-02-09 01:41:15:392 sequence CNT:    137, RX:    105    expected: 137=
    missing:  224    skt overfl d:    0 a:    0    delta: 224    incident: =
9    seq_wrap RX: 10860     sequ_wrap_expected: 10860   overall lost: 98
> 2020-02-09 01:41:15:396 sequence CNT:    137, RX:    145    expected: 137=
    missing:    8    skt overfl d:    0 a:    0    delta:   8    incident: =
10    seq_wrap RX: 10860     sequ_wrap_expected: 10860   overall lost: 106
> 2020-02-09 01:41:15:403 sequence CNT:    160, ERRORFRAME 20000004   00 01=
 00 00 00 00 00 00
> 2020-02-09 01:41:15:414 sequence CNT:    192, ERRORFRAME 20000004   00 01=
 00 00 00 00 00 00
> 2020-02-09 01:41:15:414 sequence CNT:    192, RX:    210    expected: 192=
    missing:   18    skt overfl d:    0 a:    0    delta:  18    incident: =
11    seq_wrap RX: 10860     sequ_wrap_expected: 10860   overall lost: 124
> 2020-02-09 01:41:15:416 sequence CNT:    220, RX:    222    expected: 220=
    missing:    2    skt overfl d:    0 a:    0    delta:   2    incident: =
12    seq_wrap RX: 10860     sequ_wrap_expected: 10860   overall lost: 126
>
> I have applied this series to get SPI DMA to work on i.MX8MM:
> https://patches.linaro.org/cover/417924/
>
> I have also tried SPI PIO mode instead of DMA, but it does not help.
>
> Any ideas of what can be done to improve this?

The imx SPI driver has quite some overhead, when it comes to small SPI
transfers. The mcp251fd driver performs much better with the SPI IP
cores on the raspi, which have quite good optimized drivers.

Hook up a scope to the SPI's clock and chip select lines of the imx,
you'll see the time between end of transfer until the chip select is
inactive is longer than the SPI transfer itself.

I expect most bang for the buck can be archived by adding an IRQ less
busy polling transfer mode, which kicks in below a certain SPI transfer
length.

On the mcp251xfd driver side, there is some room for optimization. The
basic idea is to reduce the number of SPI transfers by combining several
reads into one transfer. This can be done in some places.

For peak loads in CAN-2.0 mode it would be interesting to make use of
the remaining RAM for a 2nd FIFO.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--h63pmb27loa6hisk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDIU6sACgkQqclaivrt
76n3Mgf/fMW335omiI+T/06ysxsZAzgvbp1bkYkA1wckJ/kqyXmGkA28ADlJSCge
37ZcrPKSQBCxBRZ2czfRpHYV41L+UQY8+sc7w8rJ0bFx+18T0zMsckCpBWPlKLeR
lmIL7rXu8s/7ovqkhWl9kEJ9I/jPIBfu6MAijH9rwfRDLteS33u8ZXBrHUAth0uN
AePBfgCk491Iu4pU1x8464vaaXxUmmGktx6d33Cr0TKvZr+QCklfJ9Wk4B440fdW
Cl1qUihnd+nHsXXG1P4V7yh/XygMQTJAHBDPYweYSgThksMTkYjHYe9JU6vxBYbE
4TobzdsT5QBN94TVo7lPkbljaoaGDw==
=WBqo
-----END PGP SIGNATURE-----

--h63pmb27loa6hisk--
