Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CED96D7502
	for <lists+linux-can@lfdr.de>; Wed,  5 Apr 2023 09:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbjDEHJX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Apr 2023 03:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbjDEHJW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Apr 2023 03:09:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEC526B8
        for <linux-can@vger.kernel.org>; Wed,  5 Apr 2023 00:09:21 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pjxGg-0002Td-4G; Wed, 05 Apr 2023 09:09:18 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 581431A6FBE;
        Wed,  5 Apr 2023 07:09:16 +0000 (UTC)
Date:   Wed, 5 Apr 2023 09:09:15 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Michal Sojka <michal.sojka@cvut.cz>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Jakub Jira <jirajak2@fel.cvut.cz>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: [PATCH v3] can: isotp: fix poll() to not report false EPOLLOUT
 events
Message-ID: <20230405-duckling-atrocious-be18c9fb7477@pengutronix.de>
References: <20230331125511.372783-1-michal.sojka@cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q7tf6lotqiooopsz"
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


--q7tf6lotqiooopsz
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

Applied.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--q7tf6lotqiooopsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmQtHpgACgkQvlAcSiqK
BOjLzAgAiN2PrjnendILRHRoemSZsl22Wbe2R1KNyyI2HImUfsG5vmn5PoiJAimm
CPi5OF4oANK45YinFNqndhGRp46qAYRtoarnYaEhiCiLgvmsKmMUuOukR8XfA/T9
Saht3Z7wwYuW0m3SRKc0YVbO5w5LJzrF4I75Sktglz8LAy50v2yj8A39M+qSiZDo
eoWPgAUuMfaEO06nQBVwxYLKW6fBWVkay90QY94TNiIw+HCo17Zlv30eIuEMELXw
5+ZdUXI2/JXYio2qcY6GeLV1oK4rZ6y9ExdexH8q1DwTHUNoJkZLK+o43/SIsR1w
7LmgKfh4zGYl3FGlVg9uKh7iTHospQ==
=IRfP
-----END PGP SIGNATURE-----

--q7tf6lotqiooopsz--
