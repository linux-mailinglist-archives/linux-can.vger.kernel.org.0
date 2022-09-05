Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2055AD733
	for <lists+linux-can@lfdr.de>; Mon,  5 Sep 2022 18:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiIEQNV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 5 Sep 2022 12:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiIEQNT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Sep 2022 12:13:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109315464F
        for <linux-can@vger.kernel.org>; Mon,  5 Sep 2022 09:13:19 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oVEik-0007C3-Az; Mon, 05 Sep 2022 18:13:10 +0200
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:b4c0:a600:5e68:1e31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A87A1DAE5E;
        Mon,  5 Sep 2022 16:13:09 +0000 (UTC)
Date:   Mon, 5 Sep 2022 18:13:09 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     john@jbrengineering.co.uk
Cc:     linux-can@vger.kernel.org,
        John Whittington <git@jbrengineering.co.uk>
Subject: Re: [PATCH v3 0/2] can: gs_usb: hardware timestamp support
Message-ID: <20220905161309.ezcrba5x5vbrle47@pengutronix.de>
References: <20220827221548.3291393-1-mkl@pengutronix.de>
 <MyXI-Jx_HXvD27BZVEPozG9rRz0c-D4T73FwD7ilsKm9Keh1iUCYzO5mSisRm6LWa74OUxp22EJnguo3jE7VmjHZpXnZPYs7Y7hEU6p6LZM=@jbrengineering.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sxoyzejymavbkmf3"
Content-Disposition: inline
In-Reply-To: <MyXI-Jx_HXvD27BZVEPozG9rRz0c-D4T73FwD7ilsKm9Keh1iUCYzO5mSisRm6LWa74OUxp22EJnguo3jE7VmjHZpXnZPYs7Y7hEU6p6LZM=@jbrengineering.co.uk>
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


--sxoyzejymavbkmf3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29.08.2022 13:25:00, john@jbrengineering.co.uk wrote:
> Thanks for the support on this. I was following the threads but away
> so unable to make changes. With the patch now squashed and your
> updates, it looks like no further input is required from me on this.

Can you test the v3 patch?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--sxoyzejymavbkmf3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMWIBIACgkQrX5LkNig
013KUAf+PytCJhNRngbs6bTOaz53dBVRgNGM1ZFlNa3LIYc+rvQhPnq+kYgznwBC
FrRp6zHYGzKyQV9+unf+xG23W3AsfyXbtZUVzq6LhJOs2cAoDLdu5ek6XtER2ZXF
BuGVbkPP/8sZuYdtLNSK8YUaaibnSEnf5QGSUKomWt52EykU4AtKZKr7ONPTAAaG
MPPaBNQi4ERnMbhOabha4lkuA1z4Y4H419++Z84FntDo4vLV6dtj2Eo12kNjG6oS
TKEFA5VtJC7fl3XHwGR7VYs3SDjWVnLHxZ4/9bl8Ff2kdLu8JuFZslAkgWrtNzjT
QohIntAUWb7d2VEClSE/TP4bMp+fjg==
=JrNP
-----END PGP SIGNATURE-----

--sxoyzejymavbkmf3--
