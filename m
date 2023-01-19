Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFEC6737D2
	for <lists+linux-can@lfdr.de>; Thu, 19 Jan 2023 13:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjASMDY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Jan 2023 07:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjASMCh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 07:02:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277D06F32B
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 04:02:30 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pITce-00011N-Fb; Thu, 19 Jan 2023 13:02:24 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:7961:17f5:9ae5:1a41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C03BA15D277;
        Thu, 19 Jan 2023 12:02:23 +0000 (UTC)
Date:   Thu, 19 Jan 2023 13:02:15 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stefan =?utf-8?B?QWx0aMO2ZmVy?= <Stefan.Althoefer@janztec.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>, kernel@pengutronix.de
Subject: Re: AW: AW: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Message-ID: <20230119120215.lizvewk5326332qy@pengutronix.de>
References: <20230111222042.1139027-1-mkl@pengutronix.de>
 <FR0P281MB1966455B1F0ED61EBCE5702097C19@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <20230116221559.nx6syqwnjmumwily@pengutronix.de>
 <FR0P281MB1966DE37CB113260C5EF1F8C97C49@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oqk7qpz7awniinrq"
Content-Disposition: inline
In-Reply-To: <FR0P281MB1966DE37CB113260C5EF1F8C97C49@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--oqk7qpz7awniinrq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.01.2023 07:47:44, Stefan Alth=C3=B6fer wrote:
> > Before this change the driver used to read the RX FIFO head from the ch=
ip
> > (it points to the index that is **written** to next by the driver).
>
> Read?

Doh, it should read:

it points to the index that is written to next by the *chip*.

> My concern was about such a situation
>
>       3     1   2
> --------------------
> N|N|O|O|O|0|N|N|N|N|
> --------------------

What's the meaning of 'N', 'O' and '0' (zero)?

> Correct fifo head is [1]. What are the potential false reads?
> Is it possible that a false read of fifo head will point to [2].
>
> In cases that I have seen it had pointed to older messages always
> e.g. [3].

|     4 3     1   2
| --------------------
| N|N|O|O|O|O|N|N|N|N|
| --------------------

If N means new, and O means old (I've replaced the 0 by O), then the
correct head would be [4]. That's the index the chip will write the next
RX'ed CAN frame. The chip's tail index would point to [1]. That means
all CAN frames between [1] (including) and [4] (excluding) are new and
must be read.

If the driver reads a wrong FIFO head, there are 2 possibilities:
a) driver reads FIFO head [2]
   - all frames between [1] (including) and [2] excluding are read and
     pushed into the networking stack (denoted by [R]):

|     4 3     1   2
| --------------------
| N|N|O|O|O|O|N|N|N|N|
| --------------------
|             R R

   - 2 frames are marked as read, the chip's tail pointer will advance
     from [1] to [2].

|     4 3     1   2
| --------------------
| N|N|O|O|O|O|O|O|N|N|
| --------------------
|

   - the RX interrupt stays active, as the RX FIFO is not empty
   - the usual RX IRQ handling takes place and the rest of the CAN
     frames are read.

|     4 3     1   2
| --------------------
| O|O|O|O|O|O|O|O|O|O|
| --------------------
|

   - the chip's tail index is correct [4]
   - the erratum results in a higher latency, as the driver could
     have handled 4 RX CAN frames in one burst instead of 2.

b) driver reads FIFO head [3]

   - all frames between [1] (including) end of FIFO are read and
     pushed into the networking stack (denoted by [R]):

|     4 3     1   2
| --------------------
| N|N|O|O|O|O|N|N|N|N|
| --------------------
|             R R R R

   - 4 frames are marked as read, the chip's tail pointer will advance
     from [1] to [5].

| 5   4 3     1   2
| --------------------
| N|N|O|O|O|O|O|O|O|O|
| --------------------
|

   - all frames between [5] (including) end [3] (excluding) are read

| 5   4 3     1   2
| --------------------
| N|N|O|O|O|O|O|O|O|O|
| --------------------
| R R R

   - during the iteration the driver sees an old timestamp for the 3rd
     CAN frame and stops processing there
   - although 3 CAN frames have been read from the FIFO, only 2 have
     been processes and pushed to the networking stack
   - 2 frames are marked as read, the chip's tail index will advance
     from [5] to [4].

| 5   4 3     1   2
| --------------------
| O|O|O|O|O|O|O|O|O|O|
| --------------------
|

   - the chip's tail index is correct [4]
   - the overhead due to the erratum was the longer SPI read of the last
     CAN RX frame and the additional processing time (which is probably
     neglectable compared to the SPI overhead).

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--oqk7qpz7awniinrq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmPJMUQACgkQrX5LkNig
010sSggAhjrsp8tu7VYZXJa4zi7mHl+6ZoGNig/VuCCMMpe9tbZC27gE/a1+1qie
9vJkaXqfhLk/o8Vn8xXRvlwi5hpaaH0tbA9LW9dLUOYpDPm6OianUcwkNoyuuDaM
5hA+mgVnMUk1QnqKGJhmjb8CS5XIFpEin/PDrf7GeOhiA0uBE1/TUK+iNTkdaTT1
BN0byxjCUQ8dB306lh9E9DNH/gbIgvnxxJlXeoLSFNJ2PbRFLfVUsWuSI4BGF+42
K3VxYbyeyEZWo6bkdgXCXIePU1HCO9OIUdVWSSNXbtP0QMUdFcs8f/Bba0Ig1Xnu
jvr+qnM/EvL3LdgTV1rYYIs1N5CAkg==
=oPzB
-----END PGP SIGNATURE-----

--oqk7qpz7awniinrq--
