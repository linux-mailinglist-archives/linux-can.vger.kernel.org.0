Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59D15F6BC4
	for <lists+linux-can@lfdr.de>; Thu,  6 Oct 2022 18:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiJFQ2b (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 Oct 2022 12:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiJFQ23 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Oct 2022 12:28:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DAD7EFF4
        for <linux-can@vger.kernel.org>; Thu,  6 Oct 2022 09:28:27 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ogTjW-0003dW-7O; Thu, 06 Oct 2022 18:28:26 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 74659F667D;
        Thu,  6 Oct 2022 16:28:25 +0000 (UTC)
Date:   Thu, 6 Oct 2022 18:28:23 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: Re: [PATCH 0/6] can: gs_usb: new features: GS_CAN_FEATURE_GET_STATE,
 GS_CAN_FEATURE_BERR_REPORTING
Message-ID: <20221006162823.2rj7e63xg3li7fi6@pengutronix.de>
References: <20221006162452.200322-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="exgvasa6tta7hxdv"
Content-Disposition: inline
In-Reply-To: <20221006162452.200322-1-mkl@pengutronix.de>
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


--exgvasa6tta7hxdv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.10.2022 18:24:46, Marc Kleine-Budde wrote:
> Hello,
>=20
> this series consists of a few clean up patches by me and Jeroen
> Hofstee patches that adds 2 new features (GS_CAN_FEATURE_GET_STATE,
> GS_CAN_FEATURE_BERR_REPORTING). These patches are based on the
> venus-5.19.4-gsusb branch of his Linux tree.
>=20
> | https://github.com/jhofstee/linux/tree/venus-5.19.4-gsusb
>=20
> Changes since venus-5.19.4-gsusb:
> - fixed 2nd parameter of usb_control_msg_recv()

See:
https://github.com/jhofstee/linux/commit/6757d45f74b7e408cf3054cd4acf668830=
51c03d

> - rebased to current net-next/main
> - renumbered the FEATURE, MODE and BREQ bits, as termination support
>   landed mainline first
> - split GS_CAN_FEATURE_GET_STATE patch into documentation and
>   implementation part
> - added Not-Signed-off-by: tag, as these patches are not Signed-off yet

Jeroen, can I add your Signed-off-by for the patches?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--exgvasa6tta7hxdv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmM/AiMACgkQrX5LkNig
011flgf8DRtXid+uzumWOlzV5M8Zi9uPpNu9No37PhA9distkOpjg5L+PlqpK1n9
0m6KVSeoy5RCbPw4ec8CK44ZnLRypAolQwXL87GvQSi6EUWTmqcW/jsjiKL5+6VL
SU5fULY9xou6q53iZPC3kmU3ggU59gr62Wdbe5bQFwDhl4it/a5wDR8emfBOAALQ
8w7YcdCrmbQSbn/WTbOC7fCGot/EXKBbrG73nScimQIKV9uqpuP9H+PZTdaCaXGI
Y3DunC5iJcPYEbDv+zlmuliKdDOf5SSoPcsReFsUezVASk/EDWSl0jMlGbWuZr7m
AxYoPm8Gb9ISjTS+N3TLzqTkQ+AhLw==
=gZIf
-----END PGP SIGNATURE-----

--exgvasa6tta7hxdv--
