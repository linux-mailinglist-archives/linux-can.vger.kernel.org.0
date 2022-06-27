Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5509C55D31E
	for <lists+linux-can@lfdr.de>; Tue, 28 Jun 2022 15:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbiF0OOW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 27 Jun 2022 10:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbiF0OOT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 27 Jun 2022 10:14:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C3313EBB
        for <linux-can@vger.kernel.org>; Mon, 27 Jun 2022 07:14:14 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o5pVD-00046Y-0U; Mon, 27 Jun 2022 16:14:11 +0200
Received: from pengutronix.de (p200300ea0f22910007affeaf77f41373.dip0.t-ipconnect.de [IPv6:2003:ea:f22:9100:7af:feaf:77f4:1373])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 11937A0400;
        Mon, 27 Jun 2022 14:14:09 +0000 (UTC)
Date:   Mon, 27 Jun 2022 16:14:08 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     gregkh@linuxfoundation.org, davem@davemloft.net, kuba@kernel.org
Cc:     max@enpas.org, linux-can <linux-can@vger.kernel.org>
Subject: Re: patch "tty: Add N_CAN327 line discipline ID for ELM327 based CAN
 driver" added to tty-linus
Message-ID: <20220627141408.rdquaslehydluas6@pengutronix.de>
References: <1656338186201221@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mokldsfjb6nuc7ln"
Content-Disposition: inline
In-Reply-To: <1656338186201221@kroah.com>
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


--mokldsfjb6nuc7ln
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg, David and Jakub,

On 27.06.2022 15:56:26, gregkh@linuxfoundation.org wrote:
> This is a note to let you know that I've just added the patch titled
>=20
>     tty: Add N_CAN327 line discipline ID for ELM327 based CAN driver
>=20
> to my tty git tree which can be found at
>     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
> in the tty-linus branch.
>=20
> The patch will show up in the next release of the linux-next tree
> (usually sometime within the next 24 hours during the week.)
>=20
> The patch will hopefully also be merged in Linus's tree for the
> next -rc kernel release.

This means this patch will go mainline with v5.20, right? The earliest
this hits net-next/master will be after that, so the net-next for v5.21.

Is there a way to get this into net-next/master earlier? As Max has a
CAN driver depending on the new line discipline ID added in this patch.

Just wanted to ask, I'll stop whining now ;).

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--mokldsfjb6nuc7ln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmK5uy0ACgkQrX5LkNig
013L8wf/S9jWf1JC+AiSGqDaAYQkX1BoAHMH6CRKdYWaxY8ldF2x9UBBbpoW9rJS
QbOf0RpI2TlYgduhItGTJ4BnyamGzdEo7DSAbH1jHPjkfWKhGgGsMcBpq8FfsU6X
ejQGt+ZFGQ3yheBoZXZRDCYeh0fASxGQ507DtyBo4AWdJVRUMDmKsTJXf7Ro0yAF
coUKl1+u4M3zvZxGwZwwQ2ugrRh4rlWyA9IlN/kgADfbpmy2fN1MdymoK9SZcQzm
eP7cQXgPlAkyv0DlkUrKRtAYXi0G/C7j5km1Rl+vgmGxtmlhfAiCHsg40IHL9vVr
AcEb2TfulGdQsbar319IqoxcUTqhPQ==
=qfzq
-----END PGP SIGNATURE-----

--mokldsfjb6nuc7ln--
