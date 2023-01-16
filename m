Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F45466D1A8
	for <lists+linux-can@lfdr.de>; Mon, 16 Jan 2023 23:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbjAPWRV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 16 Jan 2023 17:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbjAPWQb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 16 Jan 2023 17:16:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004AA25E0A
        for <linux-can@vger.kernel.org>; Mon, 16 Jan 2023 14:16:14 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pHXlu-0000Px-BC; Mon, 16 Jan 2023 23:16:06 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:8359:bf47:e3ab:940b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B6C3215923D;
        Mon, 16 Jan 2023 22:16:04 +0000 (UTC)
Date:   Mon, 16 Jan 2023 23:15:59 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stefan =?utf-8?B?QWx0aMO2ZmVy?= <Stefan.Althoefer@janztec.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        "kernel@pengutroniux.de" <kernel@pengutroniux.de>
Subject: Re: AW: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Message-ID: <20230116221559.nx6syqwnjmumwily@pengutronix.de>
References: <20230111222042.1139027-1-mkl@pengutronix.de>
 <FR0P281MB1966455B1F0ED61EBCE5702097C19@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5mkifrcdzpzzrqwu"
Content-Disposition: inline
In-Reply-To: <FR0P281MB1966455B1F0ED61EBCE5702097C19@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
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


--5mkifrcdzpzzrqwu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.01.2023 19:49:18, Stefan Alth=C3=B6fer wrote:
> > With the help of Thomas we found out that the chip has a time window
> > after receiving a CAN frame where the RX FIFO STA register content
> > is not read correctly.
>=20
> Does the workaround assume that most of the messages in the fifo are
> old (already read) content?

Before this change the driver used to read the RX FIFO head from the
chip (it points to the index that is written to next by the driver).
Then all CAN frames between the FIFO tail and head index are read from
the chip's RAM, pushed into the networking stack and finally marked as
read in the chip.

The driver 100% trusts the FIFO head read from the chip, in the bad case
it 1) pushed old messages into the networking stack and 2) confuses the
chip with marking "too many" messages as read. The rest are follow up
errors.


With the patch the driver still reads the RX FIFO head, but calculates
the number of RX'ed CAN frames waiting in the FIFO. (That is the
difference between the FIFO head and tail, plus taking wraparounds and
the FIFO full and empty bits into account.) The driver reads the waiting
CAN frames from the chip's RAM, and iterates over them.

In the good case the timestamps of the messages are always increasing.
(Again taking wraparounds and long pauses between messages into
account.)

In the bad case the driver encounters a timestamp that is older than the
last successfully received one, it assumes due to the erratum. The RX
FIFO head was read as too big, resulting in too many read messages. The
processing is stopped.

The driver still trusts that the RX messages are filled in FIFO manner
into the ring-buffer in the RAM. As soon as an old messages is
encountered, the driver assumes it has read too far and only "old"
messages will follow.

Thomas did some test on a =C2=B5C, where the RX FIFO head index in read 2x =
in
a row. With the right timing the 1st head index is broken, while the 2nd
read shows correct data again.

In both the good and bad case now the driver's FIFO head and tail are
updated with the successful processed messages. These number of messages
are marked as read in the chip.

> What happens if there is mostly new (not yet read) content in the
> fifo? Suppose a slow host or coalescing. Can the temporarily incorrect
> RX FIFO STA register point to one of those (ahead of next-to-read)?

Let me explain how I understood you scenario:
- there are 4 messages pending
- the driver reads the FIFO head, read hit by erratum
- driver thinks it has to read 8 messages
- the host is slow and on the CAN bus 2 new messages arrive
- on the chip a 4+2=3D6 messages pending
- the driver reads 8 messages from the chip
- the driver iterates over the 8 messages
- the timestamp of message 6 is newer than message 7
- the driver stops processing after message 6
- 6 messages are marked are read in the chip
- with the next RX-IRQ the next loop begins...
  note: the next message that is processed is message 7
  because we stopped processing after 6 in the previous loop

> Wouldn't we drop messages or cause a deadlock then?

The driver doesn't "step over" old messages in the FIFO, it stops
processing, finishes, and waits for the next RX-IRQ to come.

Hope that makes it a bit clearer,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5mkifrcdzpzzrqwu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmPFzJsACgkQrX5LkNig
01249AgAtPqfWkX39aNjrVT6BA9qMH5n5YXjqR4hrb5wUR16CQdpVotywzteT3Pg
Ln7C9vCe8ilGk294ZfubmunyIWUPwaE2i0GNXGGhoOhzsMPjCWwJieOl3dtuwd7n
fjZbRoaIMoFilLWycEL2Lx4vn4DcYdTPxcOsuVfdIpeehrjF58i6a7uN6Uqazm8J
+XhCKMW7SxvBdH2Bu446rikWNig6aS77uTmAKmoh5096aUsfq7BWDfH8ZwckjCIj
22DtYPQ+GXaITB8d3i0GNFcXhOtryHSy0xhEPLIVoYaLcCiujz3cVA8TUKNrCA38
cPjDHb+C7h1ZTjqiJG4B0wMO33yoeA==
=SmVx
-----END PGP SIGNATURE-----

--5mkifrcdzpzzrqwu--
