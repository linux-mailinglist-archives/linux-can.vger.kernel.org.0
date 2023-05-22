Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F202F70B789
	for <lists+linux-can@lfdr.de>; Mon, 22 May 2023 10:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjEVIX3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 May 2023 04:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjEVIX2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 May 2023 04:23:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5F2B4
        for <linux-can@vger.kernel.org>; Mon, 22 May 2023 01:23:27 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1q10pB-00017O-7G; Mon, 22 May 2023 10:23:25 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 768AB1C96D4;
        Mon, 22 May 2023 08:23:24 +0000 (UTC)
Date:   Mon, 22 May 2023 10:23:23 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     git@cookiesoft.de
Cc:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        Marcel Hellwig <mhellwig@mut-group.com>
Subject: Re: [PATCH] can: dev: add transceiver capabilities to xilinx_can
Message-ID: <20230522-profanity-bacon-6058996b62a5-mkl@pengutronix.de>
References: <20230417085204.179268-1-git@cookiesoft.de>
 <831053285.870396.1684740257842@office.mailbox.org>
 <20230522-oak-pushiness-5c3148a5bd6c-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ug73qsroyenanzmt"
Content-Disposition: inline
In-Reply-To: <20230522-oak-pushiness-5c3148a5bd6c-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
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


--ug73qsroyenanzmt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.05.2023 10:00:32, Marc Kleine-Budde wrote:
> On 22.05.2023 09:24:17, git@cookiesoft.de wrote:
> > Hey everyone,
> >=20
> > is there anything I can do to get this merged?
> > Is there anything missing?
>=20
> Looks good, while applying I'v moved the phy_power_off() after the
> pm_runtime_put() to make it symmetric with respect to xcan_open().

Also fixed that warning:

| drivers/net/can/xilinx_can.c:220: warning: Function parameter or member '=
transceiver' not described in 'xcan_priv'

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ug73qsroyenanzmt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRrJnkACgkQvlAcSiqK
BOh2QggAjMclbqsKw4F+N46GUUlIX9iQiIAMqOgPvcH90UUyB6Fhu0O5DG21pOs4
mAS5cotu/Dvlrr4mbkQYBKnMGYbGmZSMIsBRLB6IlvUWblrjBPXHyp9dSoT08rl6
D222WkywxLlRlS4mi3vTeSaD2Wm+NB5rHIMv0p8gXDFanH7/ShvlsfgcTigR7B9o
x1iH7IYlKfaIiG1VFVoFjamdXhWjzQoBu0nQjXsbYDqpM3O5TCwn/bvpHhhMR0/l
WoeTxTyfGslYGniTKvSMM5DpQUcB5mbQEwa7oNSnpImanUygUam1eoG+BxneGJTb
dUwcEXm8ZtRy5hPj8iLyTpUbYWQjwA==
=7dOL
-----END PGP SIGNATURE-----

--ug73qsroyenanzmt--
