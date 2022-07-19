Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4271357A6A2
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 20:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiGSSlI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 14:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiGSSlH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 14:41:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045505F81
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 11:41:05 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oDs9X-0000Fx-BB; Tue, 19 Jul 2022 20:41:03 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7B8CEB446E;
        Tue, 19 Jul 2022 18:41:00 +0000 (UTC)
Date:   Tue, 19 Jul 2022 20:40:59 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org,
        Anssi Hannula <anssi.hannula@bitwise.fi>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: Re: [PATCH v2 00/15] can: kvaser_usb: Various fixes
Message-ID: <20220719184059.pzqgxsgl7hw3cdne@pengutronix.de>
References: <20220708115709.232815-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ucdctedkuvfskyco"
Content-Disposition: inline
In-Reply-To: <20220708115709.232815-1-extja@kvaser.com>
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


--ucdctedkuvfskyco
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.07.2022 13:56:54, Jimmy Assarsson wrote:
> This patch series was originally posted by Anssi Hannula [1].
> Since v1 I've rebased the patches on top of commit
> b3b6df2c56d8 ("can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits")
> and replaced a couple of patches with new ones.

Jimmy, as all of these patches went through your hands, they need your
S-o-b. Can I add it while applying?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ucdctedkuvfskyco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLW+rkACgkQrX5LkNig
013DYQf8CTvGO3+lh5cFMb33l9JlAMxumjC6bvpMYhpsMekuqOLow0BWeIrGrp32
aOwhg1soDOdSrCSjUNXP5cwajVySiJyAZpoAczbgA0g0Bc401IDLG+SrPh6Lh+Pg
Ul+MsHaCGmBx5FTCcGnzoOELvtUlbD2LKDwAcqORb/1T/JZ6oaoe1inLGZVWjWD7
UPfLTpwj4KfTdQu0lhU7nSh0K3z/ZLCR0lQ1540i1HFGKTs7PA8wWvy3bAwEcK88
Cf9W8tMZpuOpT4uU4L8K7ijRVUg5fOxIPbRUo8DXlwLeakrXzREZO2ZPrkgn1EVG
uP6aaOtyac4mZxEptVVVKwjiNMVstQ==
=CUnp
-----END PGP SIGNATURE-----

--ucdctedkuvfskyco--
