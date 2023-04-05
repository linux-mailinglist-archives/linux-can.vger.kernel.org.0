Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B6F6D76A6
	for <lists+linux-can@lfdr.de>; Wed,  5 Apr 2023 10:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbjDEIRd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Apr 2023 04:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236912AbjDEIRc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Apr 2023 04:17:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6459DDF
        for <linux-can@vger.kernel.org>; Wed,  5 Apr 2023 01:17:31 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pjyKe-0003Xr-6p; Wed, 05 Apr 2023 10:17:28 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2FAFC1A7052;
        Wed,  5 Apr 2023 08:17:19 +0000 (UTC)
Date:   Wed, 5 Apr 2023 10:17:17 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, "Dae R . Jeong" <threeearcat@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [RFC PATCH v4] can: isotp: fix race between isotp_sendsmg() and
 isotp_release()
Message-ID: <20230405-repair-groggy-cc6b1b6d8d2d@pengutronix.de>
References: <20230331131935.21465-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tlig2c7qw7stiqml"
Content-Disposition: inline
In-Reply-To: <20230331131935.21465-1-socketcan@hartkopp.net>
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


--tlig2c7qw7stiqml
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31.03.2023 15:19:35, Oliver Hartkopp wrote:
> As discussed with Dae R. Jeong and Hillf Danton here [1] the sendmsg()
> function in isotp.c might get into a race condition when restoring the
> former tx.state from the old_state. This patch removes the old_state
> concept and implements a proper locking for ISOTP_IDLE transitions in
> isotp_sendmsg() inspired by a simplification idea from Hillf Danton.
> Additionally a new tx.state ISOTP_SHUTDOWN has been introduced to use
> the same locking mechanism from isotp_release() which resolves a
> potential race between isotp_sendsmg() and isotp_release().
>=20
> [1] https://lore.kernel.org/linux-can/ZB%2F93xJxq%2FBUqAgG@dragonet/
>=20
> Cc: Dae R. Jeong <threeearcat@gmail.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Nitpick: I've rephrased the commit message a bit. Please describe
imperatively what the patch does, e.g.:=20

| Remove the old_state concept and implement proper locking for the
| ISOTP_IDLE transitions in isotp_sendmsg(), inspired by a
| simplification idea from Hillf Danton.
|=20
| Introduce a new tx.state ISOTP_SHUTDOWN and use the same locking
| mechanism from isotp_release() which resolves a potential race between
| isotp_sendsmg() and isotp_release().

Applied.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--tlig2c7qw7stiqml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmQtLosACgkQvlAcSiqK
BOgjMQf/S+/LqcFK7qWglacg6xry05vvzhNGnCY/OC1FDcHE6ps8LI3UH0d5n5G7
0MAVlYmtrIjGvl/T7sHvoneXutC6dhUuFLoK3j3bjWJZItAdacwuCMZvRK6B6vPH
DkdZIKifvHJ8ng88MefJKgu26xL1Oxv8epGMKLi6EcXkpfWudOE0aDSfksWc7o9o
q27/Ox0xiwya3PGveE3HpH3LAP+nRUvIMEHRZawIRKr/8yA6Y2JBLSwDBczFpanc
Z4/YEojerS02H6RbExjRx2GkXBiWrmf3y9gTZygTAz9uwWTbrtp+RFZT7O9Ldj7W
o620verh3t9Ys10pDWVrTVjlixzaBA==
=4X4b
-----END PGP SIGNATURE-----

--tlig2c7qw7stiqml--
