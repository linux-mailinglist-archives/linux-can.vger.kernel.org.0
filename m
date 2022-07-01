Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435645630F9
	for <lists+linux-can@lfdr.de>; Fri,  1 Jul 2022 12:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiGAKGV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 1 Jul 2022 06:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiGAKGU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 1 Jul 2022 06:06:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E691A76976
        for <linux-can@vger.kernel.org>; Fri,  1 Jul 2022 03:06:18 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o7DXV-0002oK-Ea; Fri, 01 Jul 2022 12:06:17 +0200
Received: from pengutronix.de (unknown [IPv6:2a02:810a:8940:62d:705b:d536:a960:add3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A57EEA4DB8;
        Fri,  1 Jul 2022 10:06:16 +0000 (UTC)
Date:   Fri, 1 Jul 2022 12:06:15 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Wouter van Herpen <wouter.van.herpen@prodrive-technologies.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: m_can: fix netif_stop/wake_queue race condition
 between m_can_tx_handler() and m_can_isr().
Message-ID: <20220701100615.pkg4f73rf5tgwxpl@pengutronix.de>
References: <5083a7dfca89695f4359e519d8fd483900dea1f6.1656492416.git.wouter.van.herpen@prodrive-technologies.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6y6xiptoltcst7qn"
Content-Disposition: inline
In-Reply-To: <5083a7dfca89695f4359e519d8fd483900dea1f6.1656492416.git.wouter.van.herpen@prodrive-technologies.com>
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


--6y6xiptoltcst7qn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.07.2022 09:46:37, Wouter van Herpen wrote:
> m_can_tx_handler() initiates a write by calling can_put_echo_skb() and
> m_can_write() to M_CAN_TXBAR.
> After that, netif_stop_queue is called depending on the FIFO status.
>=20
> Observed with a TCAN45 controller and under high CPU load, the TCAN45
> can already generate an interrupt after the m_can_write to M_CAN_TXBAR,
> but before netif_stop_queue is executed.
> The m_can_isr() is then executed (performing a netif_wake_queue) before
> the netif_stop_queue is executed, leading to a blocking socket.
>=20
> Fix this for TX FIFO size 1, where the queue can always be stopped
> before initiating a transfer.
>=20
> Signed-off-by: Wouter van Herpen <wouter.van.herpen@prodrive-technologies=
=2Ecom>
> ---
> Possible improvement to this patch would be to predict if the next write
> would fill the FIFO, and if so, stop the queue before initiating the
> transfer. Then the race condition would also be fixed for TX buffer sizes
> larger than 1. However, I do not recognize a proper diagnostic register
> in the TCAN45 for that purpose.
>=20
> Alternatively a locking mechanism could be introduced, which I did not
> investigate further as there can be sleeps involved in the SPI writes.

Look on how the mcp251xfd does this:

https://elixir.bootlin.com/linux/latest/source/drivers/net/can/spi/mcp251xf=
d/mcp251xfd-tx.c#L178
https://elixir.bootlin.com/linux/latest/source/drivers/net/can/spi/mcp251xf=
d/mcp251xfd-tx.c#L187
https://elixir.bootlin.com/linux/latest/source/drivers/net/can/spi/mcp251xf=
d/mcp251xfd-tef.c#L251

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--6y6xiptoltcst7qn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmK+xxUACgkQrX5LkNig
010VEQf/fU0WyHw0IgTOpsp6sQ3XI3B0DNDtoMmlXLLVw1XaSa95Y/qtz+yQF2Xq
yZQ7DJnfXDwYCRS+bChhRQPA/QvM7mhy/bk6OFo/3p19XADdOF5yHuDwr4MkEgCq
YEdZhrgfJ2jhefEite6TQ4romlp5MLmFK3o2+S4xazAyhu8rTsJe3pZNRbaI/hUT
9RjVs8F8vgSsU5idYcmVqD5N6CZSFq6oZutbKzNk8tDQUOYPVKGnvxYJdX1nqpQU
nSZP4xVxfGdvODAbfQ0D5y/qDupbVqMsWwqB7dnQJ8PvikcXCACVNJhDBLqqH83z
IWi4lBYW59v79zYpTrg1dGDlNDl2Yg==
=ljD6
-----END PGP SIGNATURE-----

--6y6xiptoltcst7qn--
