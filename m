Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D604ED503
	for <lists+linux-can@lfdr.de>; Thu, 31 Mar 2022 09:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiCaHvz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 31 Mar 2022 03:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiCaHvy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 31 Mar 2022 03:51:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC1F1C114
        for <linux-can@vger.kernel.org>; Thu, 31 Mar 2022 00:50:06 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nZpZE-00017q-EW; Thu, 31 Mar 2022 09:50:04 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-ffcf-bd2e-518f-8dbf.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:ffcf:bd2e:518f:8dbf])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5F92B5793F;
        Thu, 31 Mar 2022 07:50:03 +0000 (UTC)
Date:   Thu, 31 Mar 2022 09:50:02 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Derek Will <derekrobertwill@gmail.com>, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: isotp: restore accidentally removed MSG_PEEK feature
Message-ID: <20220331075002.6qbx76gfsgne634p@pengutronix.de>
References: <20220328113611.3691-1-socketcan@hartkopp.net>
 <20220328122239.sbp7k4pjydrld3qv@pengutronix.de>
 <769900da-73e9-759e-345c-6f29483f5a3d@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u6yq4oke4zwoqmlb"
Content-Disposition: inline
In-Reply-To: <769900da-73e9-759e-345c-6f29483f5a3d@hartkopp.net>
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


--u6yq4oke4zwoqmlb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31.03.2022 08:28:54, Oliver Hartkopp wrote:
> > > Fixes: 42bf50a1795a ("can: isotp: support MSG_TRUNC flag when reading=
 from socket")
> > > Link: https://github.com/linux-can/can-utils/issues/347#issuecomment-=
1079554254
> > > From: Derek Will <derekrobertwill@gmail.com>
> >=20
> > If this patch is from Derek Will, we need Derek's Signed-off-by [1] and
> > change to author information accordingly.
> >=20
> > [1] https://elixir.bootlin.com/linux/v5.12/source/Documentation/process=
/submitting-patches.rst#L356
> >=20
> > > Tested-by: Derek Will <derekrobertwill@gmail.com>
> > > Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> >=20
> > If Derek replies to this mail with his S-o-b line, I'll fix the author
> > while applying the patch.
>=20
> Although I would have liked Derek to show up as author of the patch
> (because of he found the issue) he has not been reacting for some time
> now.
>=20
> Therefore I would suggest to take the authorship (I wrote the commit
> message anyway) and tag Derek with Reported/Suggested?/Tested-by if
> you do not want to wait to push the other pending patches to Jakub.

I've changed it to all 3: Reported/Suggested/Tested-by. :)

| commit e382fea8ae54f5bb62869c6b69b33993d43adeca
| Author: Oliver Hartkopp <socketcan@hartkopp.net>
| Date:   Mon Mar 28 13:36:11 2022 +0200
|=20
|     can: isotp: restore accidentally removed MSG_PEEK feature
|    =20
|     In commit 42bf50a1795a ("can: isotp: support MSG_TRUNC flag when
|     reading from socket") a new check for recvmsg flags has been
|     introduced that only checked for the flags that are handled in
|     isotp_recvmsg() itself.
|    =20
|     This accidentally removed the MSG_PEEK feature flag which is processed
|     later in the call chain in __skb_try_recv_from_queue().
|    =20
|     Add MSG_PEEK to the set of valid flags to restore the feature.
|    =20
|     Fixes: 42bf50a1795a ("can: isotp: support MSG_TRUNC flag when reading=
 from socket")
|     Link: https://github.com/linux-can/can-utils/issues/347#issuecomment-=
1079554254
|     Link: https://lore.kernel.org/all/20220328113611.3691-1-socketcan@har=
tkopp.net
|     Reported-by: Derek Will <derekrobertwill@gmail.com>
|     Suggested-by: Derek Will <derekrobertwill@gmail.com>
|     Tested-by: Derek Will <derekrobertwill@gmail.com>
|     Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
|     Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Writing a pull request after this mail.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--u6yq4oke4zwoqmlb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJFXSgACgkQrX5LkNig
012pbwf8Dq1gbTJfs5ApztoRzXIMs/ZtOqCPc/prOi99tTmQ/9ISdSsXOBxqizep
YmSXn4fNrC4kOy8wZAM2Yj/ZURO0EsQ/yiQw2RLMkfuoF3VL3C/CKiwsmk5WzeQa
w/VRqObtrBtRR0H3+3VRYiP0i3O5QSG+qBGAabVpgFxe0PlzJDxGXlRKJ0mB2dwy
EAI+LQO2T+wGiH2ePhDBPN172qaDj+RrzKq30Jusf9RP/VXZNocv7/4K+k+IOmQJ
WeClD5iiJu15lZDpRA2zzLkdxvIkFnmXo1hSl3PudzYzkHngUGdb0FFDaZ610ADl
PppDrMqAf1lFV82MiePh9YTKsoAV5A==
=02/d
-----END PGP SIGNATURE-----

--u6yq4oke4zwoqmlb--
