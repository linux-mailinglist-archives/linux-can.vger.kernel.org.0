Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1A36D5873
	for <lists+linux-can@lfdr.de>; Tue,  4 Apr 2023 08:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjDDGJy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 Apr 2023 02:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbjDDGJw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Apr 2023 02:09:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78CC1BCB
        for <linux-can@vger.kernel.org>; Mon,  3 Apr 2023 23:09:51 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pjZrW-0006gr-NF; Tue, 04 Apr 2023 08:09:46 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id F34051A5DDF;
        Tue,  4 Apr 2023 06:09:39 +0000 (UTC)
Date:   Tue, 4 Apr 2023 08:09:38 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, "Dae R . Jeong" <threeearcat@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [RFC PATCH v4] can: isotp: fix race between isotp_sendsmg() and
 isotp_release()
Message-ID: <20230404-devotion-gerbil-59dd8418d4ba@pengutronix.de>
References: <20230331131935.21465-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gbb3gfdvtvxwqbro"
Content-Disposition: inline
In-Reply-To: <20230331131935.21465-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--gbb3gfdvtvxwqbro
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31.03.2023 15:19:35, Oliver Hartkopp wrote:
> As discussed with Dae R. Jeong and Hillf Danton here [1] the sendmsg()
> function in isotp.c might get into a race condition when restoring the
> former tx.state from the old_state. This patch removes the old_state
> concept and implements a proper locking for ISOTP_IDLE transitions in
> isotp_sendmsg() inspired by a simplification idea from Hillf Danton.
> Additionally a new tx.state ISOTP_SHUTDOWN has been introduced to use
> the same locking mechanism from isotp_release() which resolves a
> potential race between isotp_sendsmg() and isotp_release().
>=20
> [1] https://lore.kernel.org/linux-can/ZB%2F93xJxq%2FBUqAgG@dragonet/
>=20
> Cc: Dae R. Jeong <threeearcat@gmail.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Can you add a fixes tag?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gbb3gfdvtvxwqbro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmQrvx8ACgkQvlAcSiqK
BOjKpgf9Hva+y+/VBdmjkB/JyIU39XqwFRK8iEZuBolSFzMsGcuqBE4k564NiALg
ochMG2BkIOJJV5Knja4Yql9gQTLemT9wSoSA6TG5aw2kgjuWHxiJAA3t1R4qscY7
FDK+3D3bdGPg6gfiv3wXm9aAso49khi8Hw842JEvYVzlVNue7hf6h6eegIiXXlfb
Sp85g5Eg8gt2T3sStvoPBYJbOCm9dBSMyE5Sza2ITtIC9foGaPgaOh/WMnNBt18p
8l5LhYKbb9KA5Wxiof5ub1aqdL0E1rYHbAkqG6oXGOMeQReVSEwq1nh8yHEf5DCY
z4d7hyrtZWenLhuxy7IiOnNkoy0liA==
=AMbP
-----END PGP SIGNATURE-----

--gbb3gfdvtvxwqbro--
