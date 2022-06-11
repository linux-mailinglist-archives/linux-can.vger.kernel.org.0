Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E8C547626
	for <lists+linux-can@lfdr.de>; Sat, 11 Jun 2022 17:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbiFKPfw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 11 Jun 2022 11:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiFKPfw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 11 Jun 2022 11:35:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2172D1E9
        for <linux-can@vger.kernel.org>; Sat, 11 Jun 2022 08:35:51 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o039O-0001JK-Rk; Sat, 11 Jun 2022 17:35:46 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3AA0992ED7;
        Sat, 11 Jun 2022 15:35:44 +0000 (UTC)
Date:   Sat, 11 Jun 2022 17:35:43 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Rhett Aultman <rhett.aultman@samsara.com>
Cc:     linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH v3 2/2] can: gs_usb: fix DMA memory leak on close
Message-ID: <20220611153543.s5enriuu7jcllz3t@pengutronix.de>
References: <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-3-rhett.aultman@samsara.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hi6pkmgcqwwmrcnm"
Content-Disposition: inline
In-Reply-To: <20220610213335.3077375-3-rhett.aultman@samsara.com>
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


--hi6pkmgcqwwmrcnm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.06.2022 17:33:37, Rhett Aultman wrote:
> The gs_usb driver allocates DMA memory with usb_alloc_coherent() in
> gs_can_open() and then keeps this memory in an URB, with the expectation
> that the memory will be freed when the URB is killed in gs_can_close().
> Memory allocated with usb_alloc_coherent() cannot be freed in this way
> and must be freed using usb_free_coherent() instead.  This means that
> repeated cycles of calling gs_can_open() and gs_can_close() will lead to
> a memory leak.
>=20
> Historically, drivers have handled this by keeping an array of pointers
> to their DMA rx buffers and explicitly freeing them.  For an example of
> this technique used in the esd_usb2 driver, see here:
> https://www.spinics.net/lists/linux-can/msg08203.html

Better reference the commit or use a link to lore.kernel.org:

928150fad41b ("can: esd_usb2: fix memory leak")
https://lore.kernel.org/all/b31b096926dcb35998ad0271aac4b51770ca7cc8.162740=
4470.git.paskripkin@gmail.com/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--hi6pkmgcqwwmrcnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKktk0ACgkQrX5LkNig
013iPgf+LMfQSYoArwNlpoyEgxJXyudAkq8MlL//mMN64hARNLyWG/rsnsKJk/1U
0T/Pi3nei/Nnl7z7wPl08aNK036CSOeKgdWUgnwS4FFa4jwJ/HXrR0CVO9ofzKhC
qOWeDeJvlII2dAabBobC0lafi7mL+hRwyWTEZ43yvhLScfOReDVlZhxPisEw1GMN
HmeadFqeBx+BwpDvnphcZh4dYNuOoSikTp27t2j3BQ8/H11CiWj0y5QZXE4ev80Y
sP72J93IgxhJYZ/e6AT747OWOF07HWHY5XHrcGnA4j5Nv94OFWB7YOaRHqajk8Wa
RXr/xbJqs5Qm6wCBVcgbhQy/21jXSQ==
=KREi
-----END PGP SIGNATURE-----

--hi6pkmgcqwwmrcnm--
