Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311F8519909
	for <lists+linux-can@lfdr.de>; Wed,  4 May 2022 09:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345959AbiEDH7T (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 May 2022 03:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346013AbiEDH7R (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 May 2022 03:59:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161A91F61D
        for <linux-can@vger.kernel.org>; Wed,  4 May 2022 00:55:43 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nm9rG-0000ZG-6A; Wed, 04 May 2022 09:55:38 +0200
Received: from pengutronix.de (unknown [IPv6:2a00:20:7006:b97e:9f1f:4b52:d9dd:320a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 01CA075732;
        Wed,  4 May 2022 07:55:36 +0000 (UTC)
Date:   Wed, 4 May 2022 09:55:35 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Ondrej Ille <ondrej.ille@gmail.com>
Subject: Re: [PATCH can-next] dt-binding: can: ctucanfd: include common CAN
 controller bindings
Message-ID: <20220504075535.2jhzt53j7h7ucq7s@pengutronix.de>
References: <20220504062342.52529-1-mkl@pengutronix.de>
 <202205040937.53137.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uncpkwdes6y3l5wp"
Content-Disposition: inline
In-Reply-To: <202205040937.53137.pisa@cmp.felk.cvut.cz>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--uncpkwdes6y3l5wp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.05.2022 09:37:53, Pavel Pisa wrote:
> > Since commit
> >
> > | 1f9234401ce0 ("dt-bindings: can: add can-controller.yaml")
> >
> > there is a common CAN controller binding. Add this to the ctucanfd
> > binding.
> >
> > Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> > Cc: Ondrej Ille <ondrej.ille@gmail.com>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> if my reaction is expected then you can add my
> Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Yes, you're listed as a maintainer :) Thanks!

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--uncpkwdes6y3l5wp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJyMXUACgkQrX5LkNig
012xIwgAqq+C1nam3T23+g26Tjhb45rXb5vUKV4mg9u7qivYsX53ru+Tqa41QEkG
tOcAdCZS7VB0xYtI1kJgdiw1Q15PzA+8lXRTDY+pVDFMesTes4LoIeZdWz2z8InQ
RKnvXdY17gBaMlgkXyMAu0vB2BSnYcqWnB4IF7Uv1d9QSTOipJDh4IjNApFYfevv
MkLy0nACNs+0Iv7rZ4Xuneg7KYdfO1OKOWUYnvkHzNhpOwaLHD1tjBC7c7WkxTYI
zMQDrTULHNGGAeFmUgzTL+Zkg+gm5HfPZehw5ibh9CXqlnhE0xUCi8d+l1+S/f/4
Y/8BJr8QoISCNI5cK0y4ScVRqaMT4w==
=YwUR
-----END PGP SIGNATURE-----

--uncpkwdes6y3l5wp--
