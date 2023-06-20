Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD0B736D72
	for <lists+linux-can@lfdr.de>; Tue, 20 Jun 2023 15:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjFTNgq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Jun 2023 09:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjFTNgn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Jun 2023 09:36:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B08F1B6
        for <linux-can@vger.kernel.org>; Tue, 20 Jun 2023 06:36:43 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qBbXF-0003XX-HV; Tue, 20 Jun 2023 15:36:41 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0266A1DDB80;
        Tue, 20 Jun 2023 13:36:41 +0000 (UTC)
Date:   Tue, 20 Jun 2023 15:36:40 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: [can-next] can: uapi: move CAN_RAW_FILTER_MAX definition to raw.h
Message-ID: <20230620-donator-playing-ee9653c50469-mkl@pengutronix.de>
References: <20230609121051.9631-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gdnf7cguo2vpw7xe"
Content-Disposition: inline
In-Reply-To: <20230609121051.9631-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
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


--gdnf7cguo2vpw7xe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.06.2023 14:10:51, Oliver Hartkopp wrote:
> CAN_RAW_FILTER_MAX is only relevant for CAN_RAW sockets and used in
> linux/can/raw.c or in userspace applications that include the raw.h
> file anyway.

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gdnf7cguo2vpw7xe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSRq2YACgkQvlAcSiqK
BOgpaggAhjdhtnhLU/zn/HnoDdMnAD+LFxZgWFohjrrcckP7MyoQO2Scujs4RSEC
VRyZ8+Ab59i733WFmtF33JeGu+nqSEI4YiWsEENPdUH43SFNjU68Ea3wRglafxh4
KCle6/SY1lvQdeWkHpt2k9UFv4ovaANeQ0nBweJNQWAnxecGw+AceHXqNkfhz/CT
FnroJ/keVe0kbsx1WieZarb0kUMucvLcat4s2jxtyn17HWZkacSmTFD6qMF9v+Vb
ve6MqaZVvq0rGczTfx4gi4u1BL4ObgqQyiV1ZCjF4bAf8p01Omp6bsWE3jZD2fFy
pNxNgGKAujyECgtP/nfD4vV7wmm7UA==
=7A9t
-----END PGP SIGNATURE-----

--gdnf7cguo2vpw7xe--
