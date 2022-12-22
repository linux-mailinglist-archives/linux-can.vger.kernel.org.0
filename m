Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CB465436C
	for <lists+linux-can@lfdr.de>; Thu, 22 Dec 2022 15:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiLVO4d (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Dec 2022 09:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiLVO4c (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Dec 2022 09:56:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787151EAD0
        for <linux-can@vger.kernel.org>; Thu, 22 Dec 2022 06:56:31 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1p8Mzl-00025u-V6; Thu, 22 Dec 2022 15:56:30 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5B7F11455D3;
        Thu, 22 Dec 2022 14:51:28 +0000 (UTC)
Date:   Thu, 22 Dec 2022 15:51:28 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stefan =?utf-8?B?QWx0aMO2ZmVy?= <Stefan.Althoefer@janztec.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: mcp251xfd: Bad message receiption
Message-ID: <20221222145128.y4j2iyngywprecoy@pengutronix.de>
References: <FR0P281MB1966273C216630B120ABB6E197E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5nckhx5cxjusyhay"
Content-Disposition: inline
In-Reply-To: <FR0P281MB1966273C216630B120ABB6E197E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--5nckhx5cxjusyhay
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.12.2022 07:44:59, Stefan Alth=C3=B6fer wrote:
> I'm using the MCP2518FD CAN controller with Rasperry PI 4 and are
> suffering from wrong data reception.
>=20
> My hardware is a Model 4 B with MCP2581 Click board(s) attached with a
> prototype (hand-made) interface PCB, as well as baseboards for a CM4
> with a single MCP2518 on it. The error occurs on both of them.

Do you get the same error if the test is only running on a single
mcp2518fd?

Do you get the same error if only a single mcp2518fd is attached to the
raspi?

> I have reduced my test case to a simple single thread self-receipt test:
>     * TX two messages
>     * Wait for RX and send out a new message on every receipt
>     * TX for messages in total

Can you share the config/scripts/... to set up the interfaces?
Can you share the test code?

> Refer to the attached PDF for some error cases.

The text in the PDF is rendered down to paths only. So not select- nor
searchable, please send plain text files for further logs.

> Last send frames are at the top of the logs. You can see that wrong
> messages appear in the RX queue, which have been successfully
> transmitted in previous test loop. The data that is actually sent out
> is correct however (checked with an external logger for some cases).

Looking at the first page, there are 2 identical lines marked in red.
The next page show 4 red lines.

So under certain load situations you see that old messages are received
twice. If I remember correctly I heard something similar from someone
else before. It occurred with a modified driver. For various reasons
that has never debugged. I think I've fixed the root cause of the
problem during the v5.18 development cycle.

> The error appeared very often (every 1..10 minutes) when I was using
> kernel raspberrypi 5.15.32-v7l+ and reduced to once in several hours
> when I switched to raspberrypi 6.0.12-v7l+. BTW I modified the
> loopback to external loopback To check for correct transmission. No
> other changes to the driver as taken from the Raspbian repository.

Can you share your kernel, including the modifications?

> I see infrequent mcp251xfd CRC read errors. I think those are due to
> the 2518 SPI errata. However they don't occur at the time when the
> wrong messages are received (refer to the PDF).
>=20
> Questions:
> - Is this a known problem?

No - it should not happen on any mainline kernel.

> - What did change from 5.15.32 to 6.0.12 to reduce the error rate?
>   Maybe this is just because of a change in execution timing?

Quite a lot: Next to probably unrelated changes (e.g. PLL support), the
workarounds for CRC errors were updated, in v5.18 multiple RX FIFOs are
used and IRQ coalescing support has been added.

> - Any suggestion how I can step further in fixing this issue.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5nckhx5cxjusyhay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmOkbuwACgkQrX5LkNig
011JKQgApMbjEdy/6ESscPmeqftEsjN2eShDty8RJwNB17bv27c4CQcpFUOG8hqO
QeMksqMlYu+LI9ncHWnPyYfySBYvxoCkA/wP1lNZP2U22Ipbb5mqI10Ak4kxtqN9
IEg0dgxgI1CsES7J8jrWXaCaE+4UaA56hlHX/T/X3sSjz16/N/IQqY5KltM20xrQ
hC+hJyId5aWjdwdktMIJCHMzngkTqAJ5jT1GV7Hj3ZduWxu6YdgtZjxmDdO0zhJz
u0l45N7cJNpFskwNw0V8pvpB4c8Gcbc1zQWvB/XWWAb6E2QBepvidtgUuevygWBx
CiA6c5M7ELV1j0EQdoNM3qW8lR6HpQ==
=1c+V
-----END PGP SIGNATURE-----

--5nckhx5cxjusyhay--
