Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5192F7B7CE3
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 12:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241906AbjJDKNw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 06:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjJDKNv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 06:13:51 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D649783
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 03:13:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qnysy-0005WL-1Y; Wed, 04 Oct 2023 12:13:44 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qnysx-00B0SV-3j; Wed, 04 Oct 2023 12:13:43 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C7F0D22ECDF;
        Wed,  4 Oct 2023 10:13:42 +0000 (UTC)
Date:   Wed, 4 Oct 2023 12:13:42 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Lukas Magel <lukas.magel@posteo.net>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Michal Sojka <michal.sojka@cvut.cz>,
        Maxime Jayat <maxime.jayat@mobile-devices.fr>,
        linux-can@vger.kernel.org
Subject: Re: [PATCH v2] can: isotp: isotp_sendmsg(): fix TX state detection
 and wait behavior
Message-ID: <20231004-darkened-jester-c049c715c9f5-mkl@pengutronix.de>
References: <20230827092205.7908-1-lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bruo25rcuorsdy3t"
Content-Disposition: inline
In-Reply-To: <20230827092205.7908-1-lukas.magel@posteo.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--bruo25rcuorsdy3t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27.08.2023 09:22:05, Lukas Magel wrote:
> With patch [1], isotp_poll was updated to also queue the poller in the
> so->wait queue, which is used for send state changes. Since the queue
> now also contains polling tasks that are not interested in sending, the
> queue fill state can no longer be used as an indication of send
> readiness. As a consequence, nonblocking writes can lead to a race and
> lock-up of the socket if there is a second task polling the socket in
> parallel.
>=20
> With this patch, isotp_sendmsg does not consult wq_has_sleepers but
> instead tries to atomically set so->tx.state and waits on so->wait if it
> is unable to do so. This behavior is in alignment with isotp_poll, which
> also checks so->tx.state to determine send readiness.
>=20
> V2:
> - Revert direct exit to goto err_event_drop
>=20
> [1] https://lore.kernel.org/all/20230331125511.372783-1-michal.sojka@cvut=
=2Ecz
>=20
> Reported-by: Maxime Jayat <maxime.jayat@mobile-devices.fr>
> Closes: https://lore.kernel.org/linux-can/11328958-453f-447f-9af8-3b5824d=
fb041@munic.io/
> Signed-off-by: Lukas Magel <lukas.magel@posteo.net>

Applied to linux-can/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--bruo25rcuorsdy3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUdOtMACgkQvlAcSiqK
BOh+uAf9GFXEgQdFdozkb18rUEDe3l/JOvomZCSbkFVcdDhilDeIh3IZOxmLun6V
qjeF1+XdpOOdb6V2dNfQcbQy9RqsSAkTJqxfPUFQyph2rzgx9zA2g06tNOTbejZF
F8ouFhBdJniv/uR3LVKXZyTNTAWHZgVCQcfPvPSCoorhWsMezV862v6PXYcu4jj+
q3MmPNJebtjg5rT94l4fZSWQSSyt8PbWjL8AmWKUkMUL43JfJ8uNP1GHrXOcNARt
NVXGW7SSgfC/BQCDxgsJUUSmZ+J0FOIgXjzs0pt5OJ2TwnjbRvoQSNvyQVbgYARy
yRvSJmK5DEQHL9COB3iIPScKC9St5g==
=YN8m
-----END PGP SIGNATURE-----

--bruo25rcuorsdy3t--
