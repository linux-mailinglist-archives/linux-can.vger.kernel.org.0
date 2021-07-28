Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FE03D89A4
	for <lists+linux-can@lfdr.de>; Wed, 28 Jul 2021 10:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbhG1ITZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Jul 2021 04:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbhG1ITI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Jul 2021 04:19:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CCDC0613D3
        for <linux-can@vger.kernel.org>; Wed, 28 Jul 2021 01:19:01 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m8emG-0004CS-3B; Wed, 28 Jul 2021 10:18:56 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:7213:487e:ab4f:842a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E17DA659FEA;
        Wed, 28 Jul 2021 08:18:54 +0000 (UTC)
Date:   Wed, 28 Jul 2021 10:18:54 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Angelo Dureghello <angelo@kernel-space.org>,
        kbuild-all@lists.01.org, linux-can@vger.kernel.org
Subject: Re: [mkl-can-next:testing 45/46] drivers/net/can/flexcan.c:666:2:
 warning: Undefined or garbage value returned to caller
 [clang-analyzer-core.uninitialized.UndefReturn]
Message-ID: <20210728081854.i6qv3epufar6vrbj@pengutronix.de>
References: <202107271336.3E6TbTmM-lkp@intel.com>
 <123e9e3f-69e3-661b-d02c-d6b5bf89604b@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rtxayyqxpwo6pc4i"
Content-Disposition: inline
In-Reply-To: <123e9e3f-69e3-661b-d02c-d6b5bf89604b@intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--rtxayyqxpwo6pc4i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.07.2021 08:31:19, kernel test robot wrote:
> > > drivers/net/can/flexcan.c:666:2: warning: Undefined or garbage value =
returned to caller [clang-analyzer-core.uninitialized.UndefReturn]
>            return err;
>            ^

Fixed, thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--rtxayyqxpwo6pc4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmEBEusACgkQqclaivrt
76k3GAgAn1d8SvDLvxMIX5+di+7suQbE8YJk1Y1YjuwwuWsHRUyl5P8sCuXEC6LT
9s+engphtAGchuZLnBLqGWx1469TiYuCfHnZQ9NXdCfvwjfzbkvb++13hz5uhuTq
sbWQgAJG37d1xip68Z/PiECB9Thc6U3H4XIeN++pzt/Z4bOWqI8GRALTNPhIYhYH
Juvk0zVzp/GJy7g9jg9wFw8EZcH+WeorJ1L3aoZVazAh5VvICzoLYANVNS3OamJh
Jkf7Rlqq+Gypk/yI9Ar/s4DQe5vtmWZqGXeKU8YwJToBg2HieRNTFJL+3Ee8Jvah
HsiKl/3dch1H7cMyylmatT52MLejkA==
=P2At
-----END PGP SIGNATURE-----

--rtxayyqxpwo6pc4i--
