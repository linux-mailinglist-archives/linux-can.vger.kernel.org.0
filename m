Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0DD547794
	for <lists+linux-can@lfdr.de>; Sat, 11 Jun 2022 22:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiFKUti (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 11 Jun 2022 16:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiFKUth (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 11 Jun 2022 16:49:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA64731371
        for <linux-can@vger.kernel.org>; Sat, 11 Jun 2022 13:49:36 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o0835-0005kG-E0; Sat, 11 Jun 2022 22:49:35 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 725F892FE9;
        Sat, 11 Jun 2022 20:49:34 +0000 (UTC)
Date:   Sat, 11 Jun 2022 22:49:33 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 0/2] can: etas_es58x: cleanups on struct es58x_device
Message-ID: <20220611204933.ztf3tuwr72mowutr@pengutronix.de>
References: <20220611162037.1507-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="35fdasoia5asrz2r"
Content-Disposition: inline
In-Reply-To: <20220611162037.1507-1-mailhol.vincent@wanadoo.fr>
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


--35fdasoia5asrz2r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.06.2022 01:20:35, Vincent Mailhol wrote:
> This series contains two clean up patches toward struct es58x_device
> of the CAN etas_es58x driver. The first one removes the field
> rx_max_packet_size which value can actually be retrieved from the
> helper function usb_maxpacket(). The second one fixes the signedness
> of the TX and RX pipes.
>=20
> No functional changes.

Applied to linux-can-next/testing.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--35fdasoia5asrz2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKk/9sACgkQrX5LkNig
011BcQf9H6Y7Nba+v8y5LOeF13X7eS1vQxt1Wk6bV/t7XnfANhkhdjzBH6dCaMu3
WuPat3HzETAQqaVDCTlY1tN736nfhoTjPfz+qEN21owTQl86GTc4oZzRJbGNNHWx
i2L06YqbwgUTBijR7DGaooAmqooHOX+/kxqHRWHZ1mPNKyn6uTe+JPgICAb4UMD1
/OWkCnvpMVtHSnB/Pn7OCdRyMRMiZXA3O16koyhoGWSI2+SRG4ihNDPqlP6eJvGC
B5J4/b8LEo0ZY2bhjWKcYEFFVa7rmyirQVmaI5/xTE9HI8109EUPB7zVXlv0Ggqe
6ySsueKKzkAUERsNt3CcyyQdzRpzKQ==
=FGYU
-----END PGP SIGNATURE-----

--35fdasoia5asrz2r--
