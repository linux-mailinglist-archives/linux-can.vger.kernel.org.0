Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7C94F08E7
	for <lists+linux-can@lfdr.de>; Sun,  3 Apr 2022 13:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243942AbiDCLHb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 3 Apr 2022 07:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbiDCLHb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 3 Apr 2022 07:07:31 -0400
Received: from glittertind.blackshift.org (glittertind.blackshift.org [IPv6:2a01:4f8:1c1c:29e9::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C6A33A13
        for <linux-can@vger.kernel.org>; Sun,  3 Apr 2022 04:05:36 -0700 (PDT)
Received: from bjornoya.blackshift.org (unknown [IPv6:2a03:f580:87bc:d400:dea6:32ff:feb1:177a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "bjornoya.blackshift.org", Issuer "R3" (verified OK))
        by glittertind.blackshift.org (Postfix) with ESMTPS id 30F2A4E1406;
        Sun,  3 Apr 2022 11:05:35 +0000 (UTC)
Received: from pengutronix.de (2a03-f580-87bc-d400-26f0-2eea-19ae-c646.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:26f0:2eea:19ae:c646])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B0E98592D4;
        Sun,  3 Apr 2022 11:05:34 +0000 (UTC)
Date:   Sun, 3 Apr 2022 13:05:34 +0200
From:   Marc Kleine-Budde <mkl@blackshift.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] dt-bindings: can: renesas,rcar-canfd: Document r8a77961
 support
Message-ID: <20220403110534.2k3ojnkkrsdjzimb@pengutronix.de>
References: <20220401153743.77871-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="homnncvzv5woiqde"
Content-Disposition: inline
In-Reply-To: <20220401153743.77871-1-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--homnncvzv5woiqde
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 01.04.2022 17:37:43, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Wolfram, thanks for the patch. I think usually Geert takes the renesas
DT binding patches. (If it would go via the CAN and net tree, that patch
should get a patch description, my upstream doesn't take patches
without.)

regards,
Marc

--homnncvzv5woiqde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJJf3sACgkQrX5LkNig
012GeAf+KxvdCBoJB5RagXdFZHivj24j9uaX97xq+Ckrg5LXo+TgCpr7MvOtAW/4
U4D3hnZ9l83uGz4u8vSF4FjWXLIVYyZ6dOqh1PkblqdOmFNKNchkI76yw+eIJjWq
soyratz6iDhzWoUZ4kflqnNAiN0wL1t68qHbGU/matotV11EB2V/3yWwrvin2WKn
r1MZh5axALKBFcwogTqV080doHYAgnI4qNW7tDMAtgvP9Fn1G2tHuXgYmd2z2a0J
TME7lUyDRWrt3SQNG0TgZgPmbJpQ27nofUFCGziR1o091LxCz0hYLRPa20/l+HuN
kPJcfZMwoYbL0gPeIxvqLvAmy2JR3Q==
=D6RS
-----END PGP SIGNATURE-----

--homnncvzv5woiqde--
