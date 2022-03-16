Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE264DB9B2
	for <lists+linux-can@lfdr.de>; Wed, 16 Mar 2022 21:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358051AbiCPUuy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Mar 2022 16:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358072AbiCPUux (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Mar 2022 16:50:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1355A5BA
        for <linux-can@vger.kernel.org>; Wed, 16 Mar 2022 13:49:36 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nUaaM-0003um-Qp; Wed, 16 Mar 2022 21:49:34 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-0549-f74e-91ef-4d7d.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:549:f74e:91ef:4d7d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E14B24CBBF;
        Wed, 16 Mar 2022 20:48:50 +0000 (UTC)
Date:   Wed, 16 Mar 2022 21:48:50 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org,
        syzbot+2339c27f5c66c652843e@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/3] can: isotp: sanitize CAN ID checks in isotp_bind()
Message-ID: <20220316204850.hmro7f6huflddepj@pengutronix.de>
References: <20220316164258.54155-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6xkasy6kup6irvht"
Content-Disposition: inline
In-Reply-To: <20220316164258.54155-1-socketcan@hartkopp.net>
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


--6xkasy6kup6irvht
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.03.2022 17:42:56, Oliver Hartkopp wrote:
> Syzbot created an environment that lead to a state machine status that
> can not be reached with a compliant CAN ID address configuration.
> The provided address information consisted of CAN ID 0x6000001 and 0xC280=
01
> which both boil down to 11 bit CAN IDs 0x001 in sending and receiving.
>=20
> Sanitize the SFF/EFF CAN ID values before performing the address checks.
>=20
> Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
> Reported-by: syzbot+2339c27f5c66c652843e@syzkaller.appspotmail.com
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Added to linux-can-next/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--6xkasy6kup6irvht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIyTTAACgkQrX5LkNig
011b0Qf9G/PaRYarPka83k/g0s80PzY5ax5+czf+XVkurMHSQJu/SjwObT7zpihj
Fv3mkJ/jLOc1Husqk5DkBq/zoL+8Jv4jiqVeSaf1w4e+/NDcbFJAu6/FnVprO/j1
+OBxz2dQAMjbJ7SpDlDUqzNfDafxA41mwZ5teMAXm1X5ORYhOrPjsAM5Ajd3N06K
qtJiIftAiboVNsdFwCH/QObbCrg1WS/U53XM8v55io8kd+0pNf70LMPCMWO1itlT
Bd9T+/aS7ogRe6UdqUwpIhOp9ByoIy0CGufBK7qgNc6QAtFPybcf0Kb3+gVYofeW
vTgG7EgbmpFZ+PlXKmSwzZY8t6oFHQ==
=EjGy
-----END PGP SIGNATURE-----

--6xkasy6kup6irvht--
