Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F576D5875
	for <lists+linux-can@lfdr.de>; Tue,  4 Apr 2023 08:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjDDGLA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 Apr 2023 02:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbjDDGK7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Apr 2023 02:10:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45864198A
        for <linux-can@vger.kernel.org>; Mon,  3 Apr 2023 23:10:58 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pjZsd-0006w2-Fi; Tue, 04 Apr 2023 08:10:55 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id EF7A71A5DE5;
        Tue,  4 Apr 2023 06:10:53 +0000 (UTC)
Date:   Tue, 4 Apr 2023 08:10:52 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Michal Sojka <michal.sojka@cvut.cz>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Jakub Jira <jirajak2@fel.cvut.cz>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: [PATCH v3] can: isotp: fix poll() to not report false EPOLLOUT
 events
Message-ID: <20230404-headstone-implicit-c101429f2b17@pengutronix.de>
References: <20230331125511.372783-1-michal.sojka@cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="irgy4nj5rhurt7un"
Content-Disposition: inline
In-Reply-To: <20230331125511.372783-1-michal.sojka@cvut.cz>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--irgy4nj5rhurt7un
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31.03.2023 14:55:11, Michal Sojka wrote:
> When using select/poll/epoll() with a non-blocking ISOTP socket to
> wait for when non-blocking write is possible, false EPOLLOUT event is
> sometimes returned. This can happen at least after sending a message
> which must be split to multiple CAN frames.
>=20
> The reason is that isotp_sendmsg() returns -EAGAIN when tx.state is
> not equal to ISOTP_IDLE and this behavior is not reflected in
> datagram_poll(), which is used in isotp_ops.
>=20
> This is fixed by introducing ISOTP-specific poll function, which
> suppresses the EPOLLOUT events in that case.
>=20
> Signed-off-by: Michal Sojka <michal.sojka@cvut.cz>
> Reported-by: Jakub Jira <jirajak2@fel.cvut.cz>
> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Can you add a fixes tag?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--irgy4nj5rhurt7un
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmQrv2oACgkQvlAcSiqK
BOgREgf+N+JTQ0o24LeYb3OntkpQ09kzlz/P4Hj2TqzrstYSNv3SOT9DoRytMv59
ZhvJg8frNbazs9i2iw54mrjuABy11V6t6wRLl6n6Urw1It/F38f74mmuQQKFqEiA
+Ndfk8fXcxvyInQSEt6UZewbzIsCa9r9n9xbH3usxGmWLDkvkwXMFUlHHOeuY9Z4
afsQxFY4x+EDSwQBS33OM7XcoJ6iwcnpigHkXaHdREs7ixiEGE9qXndQJy6SAtr0
hN+vG7zYuksK20QxVmPK2FYFovVVx3NBIHgtb523xzMGMrn38NTEDe5iGwp9Dbtv
8+diwLBVWzzF+thVxoJfauuJkrXkPQ==
=dB3S
-----END PGP SIGNATURE-----

--irgy4nj5rhurt7un--
