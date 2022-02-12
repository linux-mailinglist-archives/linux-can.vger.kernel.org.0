Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A703F4B362F
	for <lists+linux-can@lfdr.de>; Sat, 12 Feb 2022 17:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbiBLQCk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 12 Feb 2022 11:02:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236817AbiBLQCj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 12 Feb 2022 11:02:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E407240A6
        for <linux-can@vger.kernel.org>; Sat, 12 Feb 2022 08:02:36 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nIur4-0003Wh-SG; Sat, 12 Feb 2022 17:02:34 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4AAE531CED;
        Sat, 12 Feb 2022 16:02:34 +0000 (UTC)
Date:   Sat, 12 Feb 2022 17:02:30 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     netdev@vger.kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: etas_es58x: use BITS_PER_TYPE() instead of manual
 calculation
Message-ID: <20220212160230.5id2eva2uawgvkud@pengutronix.de>
References: <20220212130737.3008-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oeflrztu3cytynbi"
Content-Disposition: inline
In-Reply-To: <20220212130737.3008-1-mailhol.vincent@wanadoo.fr>
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


--oeflrztu3cytynbi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.02.2022 22:07:37, Vincent Mailhol wrote:
> The input to the GENMASK() macro was calculated by hand. Replaced it
> with a dedicated macro: BITS_PER_TYPE() which does the exact same job.
>=20
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Thanks for the patch, applied to linux-can-next/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--oeflrztu3cytynbi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIH2hQACgkQrX5LkNig
013epgf+OhbS/eaB+gisc6llAZDazPeVc/dQZlChO7n/SF9HMp97ajAIOtKw8lZ/
sTUgq7GO9cqGfiWIgjLa3diE7VSZtnevNR6fAavXcNnSSEoIeZ+rg6js7tw16Pss
3i2PZ88aHzXgkESkR8qNE7XRr/tmb3vcrKfR98Q3C0xHLTvMraOVPByx89c8P5SU
S6kdbMyFWQOvmfulpXeVu9BoRMnTMWjnXkPpL4txo5YlTeyzLMU1RKCjAScNSyvO
1/KCTtWOYnADe3DIq3NuJW1lq/gZJMaVaI925jUKce1wCU0QwLpbNJQElWEAiSa2
GiGiDp7+oeOKgVrmzR/53WnNgFk3bA==
=68HI
-----END PGP SIGNATURE-----

--oeflrztu3cytynbi--
