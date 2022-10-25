Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D29560CD83
	for <lists+linux-can@lfdr.de>; Tue, 25 Oct 2022 15:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbiJYNb1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 25 Oct 2022 09:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbiJYNbL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Oct 2022 09:31:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46284EE0A2
        for <linux-can@vger.kernel.org>; Tue, 25 Oct 2022 06:30:59 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1onK1A-00020H-UP; Tue, 25 Oct 2022 15:30:56 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3392610980A;
        Tue, 25 Oct 2022 13:30:56 +0000 (UTC)
Date:   Tue, 25 Oct 2022 15:30:53 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Lukas Magel <lukas.magel@posteo.net>
Cc:     linux-can@vger.kernel.org,
        Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 6/7] can: peak_usb: export PCAN user device ID as sysfs
 device attribute
Message-ID: <20221025133053.s5c3ikcg4y6pzqqz@pengutronix.de>
References: <20221022213535.8495-1-lukas.magel@posteo.net>
 <20221022213535.8495-7-lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l2rktqu4t3zxvnm6"
Content-Disposition: inline
In-Reply-To: <20221022213535.8495-7-lukas.magel@posteo.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--l2rktqu4t3zxvnm6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.10.2022 21:35:34, Lukas Magel wrote:
> This patch exports the user device ID as a sysfs attribute. This allows
> users to easily read the ID and to write udev rules that can match against
> the ID.
>=20
> Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Nitpick: your S-o-b should be the last one.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--l2rktqu4t3zxvnm6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNX5QsACgkQrX5LkNig
011sEwf/S/SILDsUzhIdcWgE3hmUCJTZjRj871RG6QZlY7nJRS1TBffXFwDSqjf9
MCn2iXIE8olL4104yBKC3+daBiqWhfr6+bEeDRpNMMwc15yhyO6e+CGEsnceWzqb
INnTRBRqMX79n7MhJIDZs7D45QTNztuZ/aXt2TjMZ8ZJlSqEuNOCLGTpEO7lWjDr
c/PFDARHpP+oKBtirI6MME0p6mQf1KW4R5U/36B+10d8+ZAe60JyXdqRTRw6kIVw
ERShJHiP+Wg3jR+qQkHc5O+mZm3ymAYnUQ6tsg6RxcZEl/xY9iJlIvPJkK6XhRFk
8ZozE/BkOJQEpRJi5y5lD5bM6AsBtQ==
=6kJH
-----END PGP SIGNATURE-----

--l2rktqu4t3zxvnm6--
