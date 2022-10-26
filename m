Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E8B60DC2F
	for <lists+linux-can@lfdr.de>; Wed, 26 Oct 2022 09:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbiJZHgd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Oct 2022 03:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiJZHgd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Oct 2022 03:36:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1316861B1C
        for <linux-can@vger.kernel.org>; Wed, 26 Oct 2022 00:36:31 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1onaxR-0006Ls-JD; Wed, 26 Oct 2022 09:36:13 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 38126109F73;
        Wed, 26 Oct 2022 07:36:10 +0000 (UTC)
Date:   Wed, 26 Oct 2022 09:36:08 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 2/3] can: rcar_canfd: Fix channel specific IRQ
 handling for RZ/G2L
Message-ID: <20221026073608.7h47b2axcayakfnn@pengutronix.de>
References: <20221025155657.1426948-1-biju.das.jz@bp.renesas.com>
 <20221025155657.1426948-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dxbcrzybrdje44e5"
Content-Disposition: inline
In-Reply-To: <20221025155657.1426948-3-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--dxbcrzybrdje44e5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.10.2022 16:56:56, Biju Das wrote:
> RZ/G2L has separate channel specific IRQs for transmit and error
> interrupt. But the IRQ handler, process the code for both channels
> even if there is no interrupt occurred on one of the channels.
>=20
> This patch fixes the issue by passing channel specific context
> parameter instead of global one for irq register and on irq handler,
> it just handles the channel which is triggered the interrupt.

Please clean up signatures of the IRQ handlers you touch, it's a little
mess. Change:

| rcar_canfd_handle_channel_tx(struct rcar_canfd_global *gpriv, u32 ch)

to:

| rcar_canfd_handle_channel_tx(struct rcar_canfd_channel *priv)

Same for:

| static void rcar_canfd_handle_channel_err(struct rcar_canfd_global *gpriv=
, u32 ch)



In a separate patch, please clean up these, too:

| static void rcar_canfd_handle_global_err(struct rcar_canfd_global *gpriv,=
 u32 ch)
| static void rcar_canfd_handle_global_receive(struct rcar_canfd_global *gp=
riv, u32 ch)
| static void rcar_canfd_channel_remove(struct rcar_canfd_global *gpriv, u3=
2 ch)

Why are 2 of the above functions called "global" as they work on a
specific channel? That can be streamlined, too.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--dxbcrzybrdje44e5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNY42YACgkQrX5LkNig
013Aowf/XjqEH3zizsFw3biOLnHEEPBF8LFUC9IGjtwtUQrNIWw5/Ocxh8iiqpeO
31P2OaSl/GGhyhAysS4/sdgx1yTm9HZG6ZfMaduhhyU3ObvAbjaiiU9rOKdDkK0u
hUSG3ADTWl6M4epdSp0KH51XQOxjGl6AICGhqw/3CttAeVkvXsPPia+tE89Gy3i9
hIHAcGqZ1mlu9ypL0wdc+8P4jjoSvPxYp+XqNcnUpjzJ+S5e1zRH7CKi5DIm/TEl
4bEUYfcrFZiUuY+Es/F5OFk2A3nbYX59QZErPvgDGblALywCAs6SrIPjCdkfScfU
Hxlxnkn7/L/x5/BtfY6N39xlwlT6BA==
=UVOm
-----END PGP SIGNATURE-----

--dxbcrzybrdje44e5--
