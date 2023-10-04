Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29F67B7CF5
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 12:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242062AbjJDKUD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 06:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjJDKUC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 06:20:02 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CEC95
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 03:19:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qnyz0-0006XK-Ag; Wed, 04 Oct 2023 12:19:58 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qnyyz-00B0Wk-Qn; Wed, 04 Oct 2023 12:19:57 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 8A83E22ED03;
        Wed,  4 Oct 2023 10:19:57 +0000 (UTC)
Date:   Wed, 4 Oct 2023 12:19:57 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] can: etas_es58x: clean-up of new GCC W=1 and old
 checkpath warnings
Message-ID: <20231004-reviving-gating-fa9007908834-mkl@pengutronix.de>
References: <20230924110914.183898-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jewqgv47a52ecjul"
Content-Disposition: inline
In-Reply-To: <20230924110914.183898-1-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--jewqgv47a52ecjul
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.09.2023 20:06:46, Vincent Mailhol wrote:
> The kernel recently added new warnings, one of which triggers a known
> false positive on the etas_es58x module. In an effort to keep
> es58x_etas free of any W=3D12 (excluding those produced by foreign
> headers), add a workaround to silence it.
>=20
> While at it, this series also fix a checkpatch warning which I knew
> existed for a long time but was too lazy to tackle.

Applied to linux-can-next/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jewqgv47a52ecjul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUdPEoACgkQvlAcSiqK
BOjBGwgApJRHmx/+0Kaje12HRp0bV6cRuare29p79RYm6uxkLTaPxnOQxilPNhtu
HfqrrKgKQUESyICXMTWNFmLDy8vnfXsSajNwPhSfVlZGuJqXGOG16WE/A8shyfVz
tnwhPoXV6FndQHAp4i0s62B/Wiax5AumT5JyMiS9O42txKKJh+xAD2ITWYQbrIDY
meK6Z+AipZFe0eFLvhRManZE8G/vok5WPs2Z5drmNlAy31lgR2tWCqWuxIh3QFiO
/tMW4/Il4MJFtLP7pkX2Kh4zRGZahstWdj25G+ojZUkyWWosilJs7GZ5/Un2saz2
CiUcgZqiRinQLbDt4BPSd1n+wMGJ3w==
=ptyl
-----END PGP SIGNATURE-----

--jewqgv47a52ecjul--
