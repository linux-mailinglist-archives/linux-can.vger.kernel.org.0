Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A314F932E
	for <lists+linux-can@lfdr.de>; Fri,  8 Apr 2022 12:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiDHKns (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Apr 2022 06:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbiDHKnq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Apr 2022 06:43:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EDA31CF34
        for <linux-can@vger.kernel.org>; Fri,  8 Apr 2022 03:41:41 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ncm3g-0005YX-EF; Fri, 08 Apr 2022 12:41:40 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-9b8b-dab7-394c-98e8.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:9b8b:dab7:394c:98e8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CA1ED5E686;
        Fri,  8 Apr 2022 10:41:39 +0000 (UTC)
Date:   Fri, 8 Apr 2022 12:41:39 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Wouter van Herpen <wouter.van.herpen@prodrive-technologies.com>
Cc:     Marc Kleine-Budde <mkl@blackshift.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: PROBLEM: tcan4x5x nINT stays asserted under high RX/TX interrupt
 load
Message-ID: <20220408104139.n4mmqdeidraad2oc@pengutronix.de>
References: <AM0PR02MB592368F53A7BEA4154D24A87EAE09@AM0PR02MB5923.eurprd02.prod.outlook.com>
 <20220403105730.fnurim5vnnuxb7s5@pengutronix.de>
 <AM0PR02MB59236CF6507DD614F60D078FEAE49@AM0PR02MB5923.eurprd02.prod.outlook.com>
 <20220405120959.qwtmcafby2jjxc26@pengutronix.de>
 <AM0PR02MB59238FFE89994FBA392A33E6EAE99@AM0PR02MB5923.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4tf7jtpvx2sevg4q"
Content-Disposition: inline
In-Reply-To: <AM0PR02MB59238FFE89994FBA392A33E6EAE99@AM0PR02MB5923.eurprd02.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--4tf7jtpvx2sevg4q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.04.2022 10:29:38, Wouter van Herpen wrote:
> > Feel free to send the patch against v5.4.24, please mention this in the=
 patch itself to avoid confusion.
>=20
> For completeness, I submitted a patch on 05-04-2022 with subject:
> [PATCH] can: m_can: m_can_isr(): disable mcan interrupts during tefn hand=
ling

What's the Message-ID?

> (I noticed the patch is not listed on the archive mirror and I'm not
> sure if this is because it needs processing or if I did not submit
> correctly)

Can you re-send the patch, adding me on Cc?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--4tf7jtpvx2sevg4q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJQEWAACgkQrX5LkNig
010PFgf/d/tUKwkI51htGBlnci5sVmJEUSUSNLQyzzuDuyuWGdgc429keGPN6NJW
GoWYclc7dCHqZtzoQQRHUSLgW9YC3QgBfSM/S6u6ywXWNUSsj5e+Ya7iyfy3bP/n
moW4i6S2IDjS5CBSHjdjtIbSn6WxFkAC3FIVqDajoL9eamPoZ4RULJG3u17w8ubC
3EMaKYZQ/lupzl/Gd7duv5YK+c22Gd1E1P/AWGUrpJHWEJknOAtEAOGB1g3lsQqh
zXlDCTcGcJFZjrhXZvhV/vNgpxxIK3Du1KpFUEa1ifSLPFm2KkqB4jwyBU7mwAJL
b0imVuilSpncivtvIBX8S0bR4MTXtg==
=1fiO
-----END PGP SIGNATURE-----

--4tf7jtpvx2sevg4q--
