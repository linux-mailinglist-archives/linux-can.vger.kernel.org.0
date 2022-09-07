Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532155AFFD8
	for <lists+linux-can@lfdr.de>; Wed,  7 Sep 2022 11:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiIGJE6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Sep 2022 05:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiIGJE5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Sep 2022 05:04:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9203AE5B
        for <linux-can@vger.kernel.org>; Wed,  7 Sep 2022 02:04:57 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oVqzI-0002zc-4l; Wed, 07 Sep 2022 11:04:48 +0200
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:4f89:9809:42f0:f1dc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1AA30DC52B;
        Wed,  7 Sep 2022 09:04:47 +0000 (UTC)
Date:   Wed, 7 Sep 2022 11:04:46 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     john@jbrengineering.co.uk
Cc:     linux-can@vger.kernel.org,
        John Whittington <git@jbrengineering.co.uk>
Subject: Re: [PATCH v3 0/2] can: gs_usb: hardware timestamp support
Message-ID: <20220907090446.r77d4bcfuqjsosii@pengutronix.de>
References: <20220827221548.3291393-1-mkl@pengutronix.de>
 <MyXI-Jx_HXvD27BZVEPozG9rRz0c-D4T73FwD7ilsKm9Keh1iUCYzO5mSisRm6LWa74OUxp22EJnguo3jE7VmjHZpXnZPYs7Y7hEU6p6LZM=@jbrengineering.co.uk>
 <20220905161309.ezcrba5x5vbrle47@pengutronix.de>
 <KLPjJ1XQVpVHMIl6lpZGPQNiHF1zmycOdfawTJ-t8fWSyg07npszgk0QUck3kbeJ6iRz_kgHDrLyuLng5dil3HnC93SQsGRv08nU-si_fqk=@jbrengineering.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gnzkiqlk2mvcivve"
Content-Disposition: inline
In-Reply-To: <KLPjJ1XQVpVHMIl6lpZGPQNiHF1zmycOdfawTJ-t8fWSyg07npszgk0QUck3kbeJ6iRz_kgHDrLyuLng5dil3HnC93SQsGRv08nU-si_fqk=@jbrengineering.co.uk>
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


--gnzkiqlk2mvcivve
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.09.2022 07:13:02, john@jbrengineering.co.uk wrote:
> Yes, I have tested the v3 patch with candleLight_fw (c19f3a). `candump -H=
` works
> as intended and I have actually used it in anger so to speak, debugging a=
 timing
> tolerance issue with a CAN node.

\o/ Have you found your issue?
=20
> I've also confirmed that `ethtool --show-time-stamping can0` returns the =
correct
> timestamping info for both devices which do and don't include the
> `GS_CAN_FEATURE_HW_TIMESTAMP` flag. Also that devices without that flag c=
ontinue
> to operate as before with the SocketCAN tools.

Thanks for testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--gnzkiqlk2mvcivve
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMYXqsACgkQrX5LkNig
012eUQf/evHrtCEBIzqBjzSUm0SsyS3Fw3IgH1RygPCgJir5QapMoLPSWMRJ+QIW
xA1C4xyPj+JGLkRn0kUdWGyZbVYSHSIBAPEnammSO1+pOKFMlm52egKch6SIWX5P
bkAjtwFSiPC+hXSSXo5JIHKu6PztYdHuKcZA90LCOkWnqJL4+2Ko68gKW/y3OQRv
/DIpRPNFtzkgSqV8HJHqhV4Xa517CopbNM8qUvNPTh3LyPMfAX0qLhKjaZaF4lwc
bbLj8i+lvJlGpXm8jXiWTseltq9mJxQoByGwFRO67gkTgEJHx33/fOhxrd/FYHy3
uetDz+kHRIMtyyyrwSA8fnRKhlFDaQ==
=prcn
-----END PGP SIGNATURE-----

--gnzkiqlk2mvcivve--
