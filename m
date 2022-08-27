Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725DE5A3A3A
	for <lists+linux-can@lfdr.de>; Sun, 28 Aug 2022 00:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiH0WXA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 27 Aug 2022 18:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiH0WXA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 27 Aug 2022 18:23:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B93356FF
        for <linux-can@vger.kernel.org>; Sat, 27 Aug 2022 15:22:59 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oS4Cf-0007ej-5y; Sun, 28 Aug 2022 00:22:57 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 8BA12D5166;
        Sat, 27 Aug 2022 22:22:55 +0000 (UTC)
Date:   Sun, 28 Aug 2022 00:22:53 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     John Whittington <git@jbrengineering.co.uk>,
        Peter Fink <pfink@christ-es.de>,
        Christoph =?utf-8?Q?M=C3=B6hring?= <cmoehring@christ-es.de>
Subject: Re: [PATCH v3 0/2] can: gs_usb: hardware timestamp support
Message-ID: <20220827222253.2r7nydujnquubsgy@pengutronix.de>
References: <20220827221548.3291393-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a453ieb2tzysj4ff"
Content-Disposition: inline
In-Reply-To: <20220827221548.3291393-1-mkl@pengutronix.de>
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


--a453ieb2tzysj4ff
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Adding Peter and Christoph on Cc.

On 28.08.2022 00:15:46, Marc Kleine-Budde wrote:
> after noticing that the gs_usb firmware sends timestamps on the TX,
> too, I updated the driver and squashed the 2nd patch. Also added
> proper endianness handling to gs_usb_get_timestamp(). I allowed to add
> myself as Co-developed-by.

Peter, Christoph, does the CES CANext FD support timestamps? Are you
planing to add TS support?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--a453ieb2tzysj4ff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMKmToACgkQrX5LkNig
011JawgAjA40EhJ95gV0bd9F1cHNAYes58lYvkE1wLKgtW3MB53mnZy4EYFgOAgh
dciD0m6aPCp677SVp5zw7wWhY8PaF6oZWYp+xpDl349k5bQ8bl20xvZ0RXsB86/C
6e6yDkXtdUSRg41uvYQpD2py0IQCqO8HhBYzWGt+qknTOe6UOBXn++oJB8t/dA7M
5W6FGcguiPAiPx31cm2OkZ0Iws8bsKosTy03fLy73gUD6ajfxNhHpRgGXjSp5OcG
Md+amey1MTW6PDHEOWq5SsTKsWmvhnNjnhFROchzwd7SHYm4PhqKliSYg5N2BF2U
rJgk/4Ha98KYXn+mt4BWueU6wNk72A==
=hU3v
-----END PGP SIGNATURE-----

--a453ieb2tzysj4ff--
