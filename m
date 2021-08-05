Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8959A3E140F
	for <lists+linux-can@lfdr.de>; Thu,  5 Aug 2021 13:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239100AbhHELqW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Aug 2021 07:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbhHELqW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Aug 2021 07:46:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74756C061765
        for <linux-can@vger.kernel.org>; Thu,  5 Aug 2021 04:46:08 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mBbp8-0002P3-T5
        for linux-can@vger.kernel.org; Thu, 05 Aug 2021 13:46:06 +0200
Received: from pengutronix.de (unknown [IPv6:2a02:810a:8940:aa0:68e7:ca3:e3f1:364e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0FC53661366
        for <linux-can@vger.kernel.org>; Thu,  5 Aug 2021 11:46:05 +0000 (UTC)
Date:   Thu, 5 Aug 2021 13:45:12 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Angelo Dureghello <angelo@kernel-space.org>,
        lkp@intel.com, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [linux-next:master 2764/5318] drivers/net/can/flexcan.c:666
 flexcan_clks_enable() error: uninitialized symbol 'err'.
Message-ID: <20210805114509.rjcptwrjscm257cd@pengutronix.de>
References: <202108050850.IaTFXHsB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wgyx5enqg7gdfhza"
Content-Disposition: inline
In-Reply-To: <202108050850.IaTFXHsB-lkp@intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--wgyx5enqg7gdfhza
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.08.2021 14:22:24, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.g=
it master
> head:   2f73937c9aa561e2082839bc1a8efaac75d6e244
> commit: d9cead75b1c66b4660b4f87ff339234042d7c6a5 [2764/5318] can: flexcan=
: add mcf5441x support
> config: h8300-randconfig-m031-20210804 (attached as .config)
> compiler: h8300-linux-gcc (GCC) 10.3.0
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> smatch warnings:
> drivers/net/can/flexcan.c:666 flexcan_clks_enable() error: uninitialized =
symbol 'err'.
>=20
> vim +/err +666 drivers/net/can/flexcan.c
>=20
> ca10989632d882 Aisheng Dong             2018-11-30  650  static int flexc=
an_clks_enable(const struct flexcan_priv *priv)
> ca10989632d882 Aisheng Dong             2018-11-30  651  {
> ca10989632d882 Aisheng Dong             2018-11-30  652  	int err;
> ca10989632d882 Aisheng Dong             2018-11-30  653 =20
> d9cead75b1c66b Angelo Dureghello        2021-07-02  654  	if (priv->clk_i=
pg) {
> ca10989632d882 Aisheng Dong             2018-11-30  655  		err =3D clk_pr=
epare_enable(priv->clk_ipg);
> ca10989632d882 Aisheng Dong             2018-11-30  656  		if (err)
> ca10989632d882 Aisheng Dong             2018-11-30  657  			return err;
> d9cead75b1c66b Angelo Dureghello        2021-07-02  658  	}
> ca10989632d882 Aisheng Dong             2018-11-30  659 =20
> d9cead75b1c66b Angelo Dureghello        2021-07-02  660  	if (priv->clk_p=
er) {
> ca10989632d882 Aisheng Dong             2018-11-30  661  		err =3D clk_pr=
epare_enable(priv->clk_per);
> ca10989632d882 Aisheng Dong             2018-11-30  662  		if (err)
> ca10989632d882 Aisheng Dong             2018-11-30  663  			clk_disable_u=
nprepare(priv->clk_ipg);
> d9cead75b1c66b Angelo Dureghello        2021-07-02  664  	}
>=20
> Smatch is complaining that both priv->clk_ipg and priv->clk_per can be
> false...  Probably impossible in real life.

Fixed in net-next with:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/=
?id=3D3362666972137724496984b4db2b06071aca4b69

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--wgyx5enqg7gdfhza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmELz0MACgkQqclaivrt
76mOvQf+J0GudeKmydLd9RZIl+QyPatfQOWaL6Mtn4vzWkiDRT21htRQYaiiwHrs
wlzpviaepz5UkXeTFvF0b01EaveK6vcFkEsXXtek8WZEF1uNh/Eh14tbia++DkHN
Jz0XMbbwnIen7YF96wuD3181Zi5a94pGj/vVLzUcmJSOJs6rnnYXxL8CYQhKhB+q
c1Bf+7l6avUZLdCEKNTzMXAGHr61TWnGGQcmCqE/Vw2NfOuzY20N3F9WODcm1jjP
N8wcAL1nkveh8+qgQBsc0fVwBwUqkuc4uheJEdfIBieZB0aHpJLjz9P7WrRKUvSF
zgRaiRwvhQBpqZSaTPbysvaq4nx40A==
=tsMf
-----END PGP SIGNATURE-----

--wgyx5enqg7gdfhza--
