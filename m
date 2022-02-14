Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54644B5CD9
	for <lists+linux-can@lfdr.de>; Mon, 14 Feb 2022 22:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiBNV36 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Feb 2022 16:29:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiBNV34 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Feb 2022 16:29:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E9712865F
        for <linux-can@vger.kernel.org>; Mon, 14 Feb 2022 13:29:48 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nJiun-0000Oc-Kv; Mon, 14 Feb 2022 22:29:45 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E66B5332F9;
        Mon, 14 Feb 2022 21:29:44 +0000 (UTC)
Date:   Mon, 14 Feb 2022 22:29:41 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Ico Glass <can@zevv.nl>
Cc:     linux-can@vger.kernel.org
Subject: Re: lack of bus-off recovery in slcan driver
Message-ID: <20220214212941.bcjd7mvwjzn24gkz@pengutronix.de>
References: <164485717170.1363325.15056183544396793343@mdoos>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6xlexoi5q6knnrci"
Content-Disposition: inline
In-Reply-To: <164485717170.1363325.15056183544396793343@mdoos>
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


--6xlexoi5q6knnrci
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.02.2022 17:46:11, Ico Glass wrote:
> One of our customers uses the lawicel CANUSB can interface with the
> slcan driver, and we have noticed that in some tests where we introduce
> electrical errors to the bus the driver becomes unresponse, being no long=
er
> able to either send or receive any CAN frames. Reattaching the interface
> seems to mitigate the error.
>=20
> The suspicion is that the interface drops into bus-off mode; the serial
> protocol documentation of the CAN interface talks about an 'F' command
> for querying status bits, but it seems that the slcan driver does not
> implement this and has no knowledge of the interface is in a defunct
> state.
>=20
> `ip restart` or `ip restart-ms` both seem to be not implemented for this
> driver unfortunately:
>=20
>    RTNETLINK answers: Operation not supported
>=20
> Is there a clean programmatic method for detecting and recovering from
> error states using the slcan driver? Is this CANUSB interface a good
> choice to use in production, or should we consider it "hobby quality"
> only?

See github for the discussion:

https://github.com/linux-can/can-utils/issues/344

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--6xlexoi5q6knnrci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIKycIACgkQrX5LkNig
011W9Qf/StKFsxXORr45KDD6jGFXpf/q6FxAfEUIdqjeQb7bzKyiU+vh8gOSEPpA
7I9Y+9xCGGLC3Trh/lqgyfEvbF2SKz9pKPSvDs+ffshpD02KU5jSYSnrcmDKkzXS
bdzUVOX5T1off6ymvgiozL71iG55FxuRomGkGYAmp1Ay2uRomlMfzA5Op435PW4O
LHB8L2MddFCreglPCyPXA1KXCieap8mg6GESR2mwbUhqFl1yressSulvXIaBtYpL
rEOTTsyc1VM3CbV1weFzc+mVINsOdMkFHf2EYINqKdjqArI7aC/yZKM05tqF0psm
T5U0DvqaS+s3IHWoCXFYKW0Wj2fzRw==
=GfXT
-----END PGP SIGNATURE-----

--6xlexoi5q6knnrci--
