Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57635736399
	for <lists+linux-can@lfdr.de>; Tue, 20 Jun 2023 08:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjFTGcK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Jun 2023 02:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFTGcJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Jun 2023 02:32:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7EE127
        for <linux-can@vger.kernel.org>; Mon, 19 Jun 2023 23:32:04 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qBUuD-0002zi-5i; Tue, 20 Jun 2023 08:31:57 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 669BE1DD5DE;
        Tue, 20 Jun 2023 06:31:56 +0000 (UTC)
Date:   Tue, 20 Jun 2023 08:31:54 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 2/2] can: ti_hecc: fix coding style
Message-ID: <20230620-spoiler-willfully-fe2954517979-mkl@pengutronix.de>
References: <20230619131058.198769-1-mkl@pengutronix.de>
 <20230619131058.198769-3-mkl@pengutronix.de>
 <c7472c24-9e16-7c2d-f5f6-a24b0fc5e5fa@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ampkijvy7sofjrjw"
Content-Disposition: inline
In-Reply-To: <c7472c24-9e16-7c2d-f5f6-a24b0fc5e5fa@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ampkijvy7sofjrjw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.06.2023 20:55:28, Oliver Hartkopp wrote:
>=20
>=20
> On 19.06.23 15:10, Marc Kleine-Budde wrote:
> > This patch aligns code to match open parenthesis.
> >=20
> > Fixes: eb38c2053b67 ("can: rx-offload: rename can_rx_offload_queue_sort=
ed() -> can_rx_offload_queue_timestamp()")
>=20
> Does it really make sense to add a "Fixes:" tag for editorial stuff?

Yes, why not. I like keeping track if things. Also the
process/maintainer-netdev.rst says:

| - for fixes the ``Fixes:`` tag is required, regardless of the tree =20

> Will this potentially trigger the stable guys?

If it does, it should be a big warning that they take too many patches.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ampkijvy7sofjrjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSRR9gACgkQvlAcSiqK
BOgJyAf/ejI/XBcznLWv1At/h/G/rqE6SVC9GXjJuxKLicOaWt8zoVmcwwbJTo0b
nsxKtW+hSYx4/Kf/OF+A3SthTWZFXZQq7fNBN+dZOZLofUrc/nG/21ZWauHP5o+U
serPUfLGpCSy4K1rmL1n7Sb+Xl/ewhaQ56GGxPgNslF4+uD4gaqBNUVINm5YtsVk
qLCOG542gdXt/iCKNK0wPtDCqfaaEPhFhIz88GQuVsiAsWO5ZSK6p7+paOpfaEnv
rP3/mF81jUSLNOrJz2PE+tEHri5o6iGS0MP9JVowk88XZLLxbr0jM7dg4jhqR0O1
ITrhiZcvxWdSS+143YRrWk7BpCuMYA==
=EdaZ
-----END PGP SIGNATURE-----

--ampkijvy7sofjrjw--
