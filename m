Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A92D6D74E5
	for <lists+linux-can@lfdr.de>; Wed,  5 Apr 2023 09:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbjDEHAX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Apr 2023 03:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237063AbjDEHAW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Apr 2023 03:00:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E165210E
        for <linux-can@vger.kernel.org>; Wed,  5 Apr 2023 00:00:20 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pjx7y-0001a2-QE; Wed, 05 Apr 2023 09:00:18 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 55E3E1A6FB0;
        Wed,  5 Apr 2023 07:00:17 +0000 (UTC)
Date:   Wed, 5 Apr 2023 09:00:16 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>
Subject: Re: [PATCH] can: isotp: use sock_recv_cmsgs() to get SOCK_RXQ_OVFL
 infos
Message-ID: <20230405-untruth-friend-f367baa235a9@pengutronix.de>
References: <20230330170248.62342-1-socketcan@hartkopp.net>
 <3ebe8125-d950-65f2-8a5c-24156e0ae10a@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6efrbcafcm4fptdv"
Content-Disposition: inline
In-Reply-To: <3ebe8125-d950-65f2-8a5c-24156e0ae10a@hartkopp.net>
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


--6efrbcafcm4fptdv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.04.2023 14:56:42, Oliver Hartkopp wrote:
> Hi Marc,
>=20
> can you please apply this one too?
> I was using it to detect the poll receive buffer error.

Applied. Was on my list, but it came with a fixes tag, so I don't have
to ask for one. :)

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6efrbcafcm4fptdv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmQtHH0ACgkQvlAcSiqK
BOiuxgf/anezT210dVIW7mzuh2Kxc9yanKgMlJ3I+za29nWZI0LwsXa6rfb1J/CB
e3i0LkYoQQmmHIaEXw0JSKM6V9u9zOtfSoYdMHh8hoiqxQDaVjtVCFl16rwyUZ6O
avNn0CDXXxB19mNMTjcZ8WKbuYjavTHemhvMNVxJp8V3oUaygo5cAhyCGAzFf5q3
0Y9SgT9xWVQhbha0JdGsr9jTaUMqxpq/QLURRZtqWdnC7n2M45jXj0XNULvh3WP2
czEUIE6eN7QrazALt8HIxbKQ0YpC71v+gSyjXtvv2XZW5N0CC9txNgjXhYvQFm9D
TL2znVNkFjeO9QwyPSdQ0NwZy6mBKg==
=LHmt
-----END PGP SIGNATURE-----

--6efrbcafcm4fptdv--
