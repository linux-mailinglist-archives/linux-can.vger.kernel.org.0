Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15C95E7A75
	for <lists+linux-can@lfdr.de>; Fri, 23 Sep 2022 14:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIWMWK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 23 Sep 2022 08:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiIWMUg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 23 Sep 2022 08:20:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA61140190
        for <linux-can@vger.kernel.org>; Fri, 23 Sep 2022 05:11:49 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1obhWq-0008Ti-Ra; Fri, 23 Sep 2022 14:11:36 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7046DEB19D;
        Fri, 23 Sep 2022 12:11:35 +0000 (UTC)
Date:   Fri, 23 Sep 2022 14:11:34 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Shang XiaoJing <shangxiaojing@huawei.com>
Cc:     pisa@cmp.felk.cvut.cz, ondrej.ille@gmail.com, wg@grandegger.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] can: ctucanfd: Remove redundant dev_err call
Message-ID: <20220923121134.ei7mwx3pabzobvjb@pengutronix.de>
References: <20220923095835.14647-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d4wlvf4acyalrdwk"
Content-Disposition: inline
In-Reply-To: <20220923095835.14647-1-shangxiaojing@huawei.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--d4wlvf4acyalrdwk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.09.2022 17:58:35, Shang XiaoJing wrote:
> devm_ioremap_resource() prints error message in itself. Remove the
> dev_err call to avoid redundant error message.
>=20
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--d4wlvf4acyalrdwk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMtonMACgkQrX5LkNig
012oSwf/ZFm/WMBX/c3Y0HBE+RtHb2vioUsHHrlgA7UeeMXD6X0GXFKgr/D193yP
Ebp0TLyJQitMJIXR47iXVcpj0F6ErnjclVdjXt/4W4or0zvPrM/v+20VUud0LcJo
v1lXaM78Qy6wcWMBhVcnGrzFofi6JxbRX3NDAvQrJrTnP01ccdMEQtbH8YZ2CLGy
LjPlMCRJ07rRNbRMROQbomnW3ww7T8jISvhRQl+hTtPVk2NbnO5HEOOV6oGXb/rR
j1eNY9be8aWZsEGfOgLedghfEhpfgwhXeXWwB95Vytqdh7PtwcHUoIHD7LpPIurp
+sJ66frvM+AG8HELI0WCpb5ZBKq/kg==
=1ygP
-----END PGP SIGNATURE-----

--d4wlvf4acyalrdwk--
