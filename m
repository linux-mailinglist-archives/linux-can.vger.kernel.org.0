Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B655B392A21
	for <lists+linux-can@lfdr.de>; Thu, 27 May 2021 10:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbhE0I4C (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 27 May 2021 04:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbhE0I4C (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 27 May 2021 04:56:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C43C061574
        for <linux-can@vger.kernel.org>; Thu, 27 May 2021 01:54:29 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lmBmd-0004Tr-B2; Thu, 27 May 2021 10:54:27 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:137d:9230:74b5:d207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 6825C62D616;
        Thu, 27 May 2021 08:54:26 +0000 (UTC)
Date:   Thu, 27 May 2021 10:54:25 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: Re: [PATCH] can: raw: fix TX CAN frames show up as RX'ed ones
Message-ID: <20210527085425.cxmc4hsecyrdmcob@pengutronix.de>
References: <20210510182038.1528631-1-mkl@pengutronix.de>
 <DB8PR04MB6795656CDFC5D021E9FA7D19E6239@DB8PR04MB6795.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u5oigndbso4mt2w2"
Content-Disposition: inline
In-Reply-To: <DB8PR04MB6795656CDFC5D021E9FA7D19E6239@DB8PR04MB6795.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--u5oigndbso4mt2w2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27.05.2021 07:17:22, Joakim Zhang wrote:
> I have not seen this patch in linux-can repo, what the status? Thanks.

I still want to test the patch with network namespaces. I think I'll do
this now.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--u5oigndbso4mt2w2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCvXj4ACgkQqclaivrt
76nfSwgAmAFqyNmS8LhkB+TyZqZxomFsk6xBX2/joiGNaLH8AdEeZsm6TPkVBJzc
4eu5cRzE5UcRPFtO2oUUBK338iAVaIsT0hzxSCnm5RuBDgNalnk2C6dshXwqH1oH
HaNhCacY6hgxZzSeBt/3DuGAmlvVOLqckGCIsiTF6UuTYAIVhPTyWbv5+w1fLF1B
oJ6uqe7gcLQ5aiPemAyJ3uj6qoLyUtRTORrKR3Mv9Lcvjz1mYWN847zYfV2EoJ6n
jChEOMgmd4C7rG0sfCuwatNWTkucvVcXwrFuqIl5GOp2L5EwAQddWwtEBmFcvRqz
6AtNqojvbLRSZ8K87XphZrh+D0SuPA==
=EPhn
-----END PGP SIGNATURE-----

--u5oigndbso4mt2w2--
