Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695C36134D8
	for <lists+linux-can@lfdr.de>; Mon, 31 Oct 2022 12:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiJaLrA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 31 Oct 2022 07:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiJaLqq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 31 Oct 2022 07:46:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02B8EE18
        for <linux-can@vger.kernel.org>; Mon, 31 Oct 2022 04:46:36 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1opTFS-0004LE-Fi; Mon, 31 Oct 2022 12:46:34 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:3c2a:13d:f861:4564])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D4CED10F0D4;
        Mon, 31 Oct 2022 11:46:33 +0000 (UTC)
Date:   Mon, 31 Oct 2022 12:46:28 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-can@vger.kernel.org
Subject: Re: [linux-next:master] BUILD REGRESSION
 fd8dab197cca2746e1fcd399a218eec5164726d4
Message-ID: <20221031114628.zxddr74xeevvudei@pengutronix.de>
References: <635c09d2.Uo03FEcDk/bchhMt%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x6dpljnwhrczhbdv"
Content-Disposition: inline
In-Reply-To: <635c09d2.Uo03FEcDk/bchhMt%lkp@intel.com>
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


--x6dpljnwhrczhbdv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29.10.2022 00:56:50, kernel test robot wrote:
> Unverified Error/Warning (likely false positive, please contact us if int=
erested):
>=20
> drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c:555:6: warning: Redundan=
t initialization for 'err'. The initialized value is overwritten before it =
is read. [redundantInitialization]

Addressed with: https://lore.kernel.org/20221031114513.81214-1-mkl@pengutro=
nix.de

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--x6dpljnwhrczhbdv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNftZEACgkQrX5LkNig
0108fgf/UQnWUf3Egte8dhInKt9c4MstddoLvgAXcv6Pl5DpVsYgsLcyJHSk9vJj
Yg5DqrHtu8K3uzo3550p2Nqgacku5ncXeoOyOjJWgK0mMRbE8kZjYu+2E1RbOS3p
t/RUhCcIrwL8IiK5woSIFjqpXcvNmnvl6csZ40ZUEUz2V8J5RJJl/5UlxjuPf2ZR
5zqcnizNdp61nagJ4+SXa4DfviIMmdKqoZC6wNQ6ehQteEohjK6cLMxjgoOSNAMj
Kuo/Fz9aWpIhcuSLTWtTd9AOhVPAdPxVUhvdjVLCyeCpBwi85xfTUQ1Hy1LkZQLX
YqZqi4l90ELCBKGP+o3u7PdhlpqnRg==
=7IiC
-----END PGP SIGNATURE-----

--x6dpljnwhrczhbdv--
