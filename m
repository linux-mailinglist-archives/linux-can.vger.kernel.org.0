Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D9F6C8373
	for <lists+linux-can@lfdr.de>; Fri, 24 Mar 2023 18:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCXRjL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 24 Mar 2023 13:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjCXRjK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Mar 2023 13:39:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA8CC170
        for <linux-can@vger.kernel.org>; Fri, 24 Mar 2023 10:39:09 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pflNb-00005i-Sz; Fri, 24 Mar 2023 18:39:07 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C55C019BAC6;
        Fri, 24 Mar 2023 17:39:06 +0000 (UTC)
Date:   Fri, 24 Mar 2023 18:39:05 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Quinton Cook <quinton.cook@gmail.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: J1939-22
Message-ID: <20230324173905.yrm5bpzpnyxf4bzf@pengutronix.de>
References: <CAAL29+00Rur1AWfj-gbzTo2afyYgsg-zY0B9rvgPoPaLaz8wNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rryg7e5iyxungrek"
Content-Disposition: inline
In-Reply-To: <CAAL29+00Rur1AWfj-gbzTo2afyYgsg-zY0B9rvgPoPaLaz8wNw@mail.gmail.com>
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


--rryg7e5iyxungrek
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.03.2023 09:55:58, Quinton Cook wrote:
> Hello my name is Quinton Cook. I was wondering if anyone was planning
> on implementing the new J1939-22 protocol in the linux kernel? If not
> I would love to implement it! Any help on getting started with linux
> kernel development would be greatly appreciated.

J1939-22 adds support for CAN-FD. What else are the differences to the
classical CAN J1939?

Without knowing any differences between J1939 and J1939-22, I suggest to
extend the existing J1939 support in the kernel for J1939-22.

So the first steps would be to get familiar with J1939 and it's kernel
implementation. Then discuss with some proof-of-concept patches what
needs to be modified/extended to support J1939-22.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129  |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--rryg7e5iyxungrek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmQd4DcACgkQvlAcSiqK
BOiATAgAkX8LN7Aa4sjZFWSoAxhtyizR4qETyMxvzfwYyBVWG/l7YdzxoUWNz4Xn
BHmlmgeCMdHlCTPJsJMGEbUSFCQZwHOx8njZbGKKuwA3WZ7O100FJufUZ528SpDC
S/njqip1mAaRHOO62ziUx5AXFQr/NY5DCQTzhM9VO+W3jQX2rUMVlwxWXxxncueA
k2ITlxXO5E2Lm8lukHbpZXLzmRgL9Ehw5PdsUK1B5qnf00EjZ7Go9DprKpEVkFRr
KOz4IYsJuPGDZ6NY3eR6HrJ8wNSFhzf2AnAgZxFx2lrsWXivQ+VroOi/V3497Vwe
H+mHgPOzKIo01vJtYyh4TsWW2I4JVQ==
=7cQg
-----END PGP SIGNATURE-----

--rryg7e5iyxungrek--
