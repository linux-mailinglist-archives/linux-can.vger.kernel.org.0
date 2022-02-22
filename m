Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F124BFCA8
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 16:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiBVPd1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 10:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiBVPd0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 10:33:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBADC7C13
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 07:33:00 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nMX9u-0006ks-Su; Tue, 22 Feb 2022 16:32:58 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-1557-4bd7-bf13-be70.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:1557:4bd7:bf13:be70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id EAF793A95A;
        Tue, 22 Feb 2022 15:32:57 +0000 (UTC)
Date:   Tue, 22 Feb 2022 16:32:57 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Michael Anochin <anochin@photo-meter.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: can: m_can: tcan4x5x m_can_isr do not handle tx if rx fails
Message-ID: <20220222153257.34kb6zugqxj4vdhu@pengutronix.de>
References: <93aa0ce4-8df2-bcad-237b-c6ce1bdcff0e@photo-meter.com>
 <20220222132000.xiopvrtu5fmuanbz@pengutronix.de>
 <c2651e9c-d3e7-815a-6e18-8ddffc04d3d7@photo-meter.com>
 <20220222134419.zmycnlmhrrrewggf@pengutronix.de>
 <e3504807-06fc-b6d9-3fb1-bf8d94e2b444@photo-meter.com>
 <20220222144518.j4swrtcv4rsyagem@pengutronix.de>
 <eaa035dc-d6d9-182c-5ee9-fba4012ccba1@photo-meter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hbuf4caur5g7fzpf"
Content-Disposition: inline
In-Reply-To: <eaa035dc-d6d9-182c-5ee9-fba4012ccba1@photo-meter.com>
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


--hbuf4caur5g7fzpf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.02.2022 16:11:52, Michael Anochin wrote:
> With netdev_warn() in m_can_tx_handler I found,
> that before "BUG! echo_skb N" appears,
>=20
> m_can_next_echo_skb_occupied(dev, putidx) is true with putidx=3DN-1
>=20
> [11676.933800] tcan4x5x spi4.0 can1: m_can_tx_handler m_can_tx_fifo_full =
or
> m_can_next_echo_skb_occupied, putidx=3D12
>=20
> [11676.934735] tcan4x5x spi4.0 can1: m_can_start_xmit: enter
>=20
> [11676.934744] tcan4x5x spi4.0 can1: m_can_start_xmit netif_stop_queue do=
ne
>=20
> [11676.934911] tcan4x5x spi4.0 can1: can_put_echo_skb: BUG! echo_skb 13 is
> occupied!

The tcan driver is probably not tested with more than 1 TX element.
Please use the following mram config for now:

| bosch,mram-cfg =3D <0x0 0 0 16 0 0 1 1>;

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--hbuf4caur5g7fzpf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIVAiYACgkQrX5LkNig
013f9gf/UFnjMiCC35SR7k0KFlbju6TT5TG9csJWqSKxrTEdOf0bdz+ASTPB7eF/
ckvYWbpwVLS58QD/btJS/ZkXNdlWeSyBeVidnKg9gK8XPW1N4nbL8k+omVSC7HUp
lBXvoLR+hfG/me5oK9/KzwghIGL4Lb/Yr7V8rxfsLwybXQ9j1YLk1QwUnFw5F23w
gzDebG6A5tgSc1QiMF1d7gfQL+hAGzndJnThP1g1SbdrkdDbKamEQXWrkFIwmNAl
GTvPYu+lfL283IbJkwwreCUiTXTj4Za713x1Z45VB2pcV2sWI4WmjD78Aamwogpy
NrqfmdkoYgTM8bsnvIMq5xToF/4PsA==
=6UNg
-----END PGP SIGNATURE-----

--hbuf4caur5g7fzpf--
