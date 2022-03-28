Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031E24E9677
	for <lists+linux-can@lfdr.de>; Mon, 28 Mar 2022 14:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242410AbiC1MYY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Mar 2022 08:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242404AbiC1MYX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Mar 2022 08:24:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA19546662
        for <linux-can@vger.kernel.org>; Mon, 28 Mar 2022 05:22:42 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nYoOO-0002NN-CA; Mon, 28 Mar 2022 14:22:40 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-accf-b53a-6e18-7f7d.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:accf:b53a:6e18:7f7d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A937655974;
        Mon, 28 Mar 2022 12:22:39 +0000 (UTC)
Date:   Mon, 28 Mar 2022 14:22:39 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, Derek Will <derekrobertwill@gmail.com>
Subject: Re: [PATCH] can: isotp: restore accidentally removed MSG_PEEK feature
Message-ID: <20220328122239.sbp7k4pjydrld3qv@pengutronix.de>
References: <20220328113611.3691-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iw6bmilzprntqu3o"
Content-Disposition: inline
In-Reply-To: <20220328113611.3691-1-socketcan@hartkopp.net>
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


--iw6bmilzprntqu3o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.03.2022 13:36:11, Oliver Hartkopp wrote:
> In commit 42bf50a1795a ("can: isotp: support MSG_TRUNC flag when reading
> from socket") a new check for recvmsg flags has been introduced that
> only checked for the flags that are handled in isotp_recvmsg() itself.
>=20
> This accidentally removed the MSG_PEEK feature flag which is processed
> later in the call chain in __skb_try_recv_from_queue().
>=20
> Add MSG_PEEK to the set of valid flags to restore the feature.
>=20
> Fixes: 42bf50a1795a ("can: isotp: support MSG_TRUNC flag when reading fro=
m socket")
> Link: https://github.com/linux-can/can-utils/issues/347#issuecomment-1079=
554254
> From: Derek Will <derekrobertwill@gmail.com>

If this patch is from Derek Will, we need Derek's Signed-off-by [1] and
change to author information accordingly.

[1] https://elixir.bootlin.com/linux/v5.12/source/Documentation/process/sub=
mitting-patches.rst#L356

> Tested-by: Derek Will <derekrobertwill@gmail.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

If Derek replies to this mail with his S-o-b line, I'll fix the author
while applying the patch.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--iw6bmilzprntqu3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJBqIwACgkQrX5LkNig
010Lqgf/Qm2GON5pzGWUN1t68dZvcNPrStnfggk1PYglCtvaygIIX81IETjOHAdf
2aJ5bw382FQmBBGWFFYFhSLKhFi3I+xMP5tk1XZcLDdmANuV4nhhSqrBYQYXiY7D
Hpsf1D4TMEwReg12z/bkiSQ2sxOk4/aW+Y4XuCmmgoDAV1FfVMT1WPQ3/K75Ap5w
jOZMPKbB47/3hfi500RozuzO68K+sdYRq62K7zeuiBhH5iIh0+8d8Q1VFJyD9jmq
VMDxwmHtf13S3BfOmFiVMqu1K1yccvp6uGH32GT7HsncSqw1NPl4CB15kTY3o2mC
56DX57qC58/rK0mLu0nBOYaKtUIXMg==
=XQAi
-----END PGP SIGNATURE-----

--iw6bmilzprntqu3o--
