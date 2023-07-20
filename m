Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D8675AD4E
	for <lists+linux-can@lfdr.de>; Thu, 20 Jul 2023 13:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjGTLrh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 20 Jul 2023 07:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjGTLrg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 20 Jul 2023 07:47:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF584189
        for <linux-can@vger.kernel.org>; Thu, 20 Jul 2023 04:47:34 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qMS7r-0003Lv-EV; Thu, 20 Jul 2023 13:47:19 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 90C721F62F9;
        Thu, 20 Jul 2023 11:47:17 +0000 (UTC)
Date:   Thu, 20 Jul 2023 13:47:16 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Eric Dumazet <edumazet@google.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-can@vger.kernel.org, eric.dumazet@gmail.com,
        syzbot <syzkaller@googlegroups.com>,
        Ziyang Xuan <william.xuanziyang@huawei.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        stable@vger.kernel.org
Subject: Re: [PATCH net] can: raw: fix lockdep issue in raw_release()
Message-ID: <20230720-relieving-gullible-d92198ce1312-mkl@pengutronix.de>
References: <20230720114438.172434-1-edumazet@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="njycenkbtazb4qqm"
Content-Disposition: inline
In-Reply-To: <20230720114438.172434-1-edumazet@google.com>
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


--njycenkbtazb4qqm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.07.2023 11:44:38, Eric Dumazet wrote:
> syzbot complained about a lockdep issue [1]
>=20
> Since raw_bind() and raw_setsockopt() first get RTNL
> before locking the socket, we must adopt the same order in raw_release()

Applied to linux-can/testing

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--njycenkbtazb4qqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS5HsIACgkQvlAcSiqK
BOgbsQf/fzzFkg4HORKC5uMObiQtPyNKnugJmoGdXNXkoP+mjmQCdTMnsEpi7sG4
0lVqhMlKzvnevlRWDjS6pm3m5UJ1cXQij7C9GbRRGgmuWxGE/9Oh72O7MZ+uVGlC
zlESkZywfZng14Ap/eMg/XxBbWVCUVof5ecq9LSOVIXZegk/QGSsepfwPse6CfDb
iX6RZg94eezZC69HTYclKVfs+EDX1T6LukLRU+yEovtaQur/G2dnhrWYZ8p4GQbt
+L0nCfAv5oCJu+AFbImgEqcVOztyrk24LCQxoId+RyhjNOybzYEb0T8pojC3gAki
gWC7xPrwrmRNpUFrTC2SbNvbnjnvtg==
=zByJ
-----END PGP SIGNATURE-----

--njycenkbtazb4qqm--
