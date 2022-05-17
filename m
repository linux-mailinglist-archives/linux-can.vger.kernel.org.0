Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2572C529951
	for <lists+linux-can@lfdr.de>; Tue, 17 May 2022 08:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiEQGL3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 May 2022 02:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiEQGL2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 May 2022 02:11:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEA341FB1
        for <linux-can@vger.kernel.org>; Mon, 16 May 2022 23:11:27 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nqqQ6-0007BE-0L; Tue, 17 May 2022 08:10:58 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 69B2F7FF9C;
        Tue, 17 May 2022 06:10:52 +0000 (UTC)
Date:   Tue, 17 May 2022 08:10:51 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     wg@grandegger.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        appana.durga.rao@xilinx.com, naga.sureshkumar.relli@xilinx.com,
        michal.simek@xilinx.com, dariobin@libero.it, stefan.maetje@esd.eu,
        mailhol.vincent@wanadoo.fr, yoshihiro.shimoda.uh@renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com, uli+renesas@fpond.eu,
        linux-can@vger.kernel.org
Subject: Re: [PATCH can-next] can: move to netif_napi_add_weight()
Message-ID: <20220517061051.kukqzmfvtiyhu37g@pengutronix.de>
References: <20220517002345.1812104-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6fmzgqkiudhaddke"
Content-Disposition: inline
In-Reply-To: <20220517002345.1812104-1-kuba@kernel.org>
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


--6fmzgqkiudhaddke
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.05.2022 17:23:45, Jakub Kicinski wrote:
> We want to remove the weight argument from the basic version of
> the netif_napi_add() call. Move all the callers in drivers/net/can
> that pass a custom weight (i.e. not NAPI_POLL_WEIGHT or 64) to
> the netif_napi_add_weight() API.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Applied to linux-can-next/testing.

Tnx,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--6fmzgqkiudhaddke
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKDPGkACgkQrX5LkNig
010/vQf/ZS+2PaOJpEYjscddQONYjIx69MJM9sHFzUbNpi2CgFgoI2Y+FOqCEecL
1PXtWYdoPz+XnfMBhK3JcVVvGDg2uecNJJzFuO55tCpdGo54wneP/RDiGOhnmsoM
wmR+r+fZiB/gW3911Y4MYD/S2PGl730wHs3uRyx8UPVjL2uecrVYOJovo5ywykl9
eYzGR++cgHHEkBcBKCYBGOw414xYLKRal5pCsW2uRq2K0vspJQOKOQXlVu6zehBw
KQCbfFfT0PcCDR8CUXfrnqtRNn8NoJq66Vynm49eczrlWapiiZ4mXMHNHJJJ8fbn
abyipwYySY3MPMo4Cf42bKazOO8+aw==
=zj/+
-----END PGP SIGNATURE-----

--6fmzgqkiudhaddke--
