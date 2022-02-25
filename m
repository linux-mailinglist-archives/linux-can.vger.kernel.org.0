Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11C54C4B0D
	for <lists+linux-can@lfdr.de>; Fri, 25 Feb 2022 17:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243173AbiBYQnG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Feb 2022 11:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243187AbiBYQmw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Feb 2022 11:42:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687FAA66FC
        for <linux-can@vger.kernel.org>; Fri, 25 Feb 2022 08:42:20 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nNdfe-0001zA-Rf; Fri, 25 Feb 2022 17:42:18 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-c8b7-5627-f914-a39f.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:c8b7:5627:f914:a39f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 465433D83B;
        Fri, 25 Feb 2022 16:42:18 +0000 (UTC)
Date:   Fri, 25 Feb 2022 17:42:17 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Michael Anochin <anochin@photo-meter.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: m_can: m_can_isr: IR_ERR_ALL_30X
Message-ID: <20220225164217.fkmyz3krtvq7gnhw@pengutronix.de>
References: <7c5b3abc-0836-1840-a322-0c582abf9692@photo-meter.com>
 <b5066414-fb63-71af-997c-07c1c531a218@photo-meter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="74ar2rsca3gxv75u"
Content-Disposition: inline
In-Reply-To: <b5066414-fb63-71af-997c-07c1c531a218@photo-meter.com>
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


--74ar2rsca3gxv75u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.02.2022 13:20:22, Michael Anochin wrote:
> For m_can version >3.0 the correct IR_ERR_ALL_31X mask is used.

Without looking at the different register descriptions this sounds
plausible.

> If an error occurs when processing RX status flags, the TX flags are
> processed anyway.

You have basically changed the immediate "goto out_fail" to setting
"err" and doing to "goto out_fail" later. Why?

As far as I can see, the m_can_rx_peripheral() function may return an
error due to an SPI problem only. It unlikely that the TX flags handling
would work. All interrupts are disabled at the end of this function,
i.e. after goto out_fail. So the driver will not work anyways.

> I am not sure, but maybe it is better to save IR to cdev->irqstatus
> immediately before clear IR and not only by RX-Flags handling.
>=20
> As far as I have seen, cdev->irqstatus is not accessed by tx-handling,
> therefore it does not matter.
>=20
> This is my first patch, sorry if something is not right.

Thanks for your patch. There is a document on how to submit patches:
https://elixir.bootlin.com/linux/v5.12/source/Documentation/process/submitt=
ing-patches.rst

Please add your Signed-off-by to the next patch you send. See "Sign your
work" in that document.

Please improve the subject of the patch to describe what this patch
changes. The patch description could be improved and better explain why
the change is done.

This patch supposed to fix 2 different problems, please make one patch
per problem fix.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--74ar2rsca3gxv75u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIZBucACgkQrX5LkNig
0106kwgApyG2JNGOm9CTQJtOLbI+q7dZkIKlgrLrSfHPkUNtBZA77W5Go46rUgO/
VFfI4yv8f5wNiFRbhGaVZR7XuE8jkUqTRnutaGGv6eH1NfnhgUdgvfbKRRRnwtj8
MU2UOfJlexjAxVNcOW2UIfeeui4LnVVhih3UUCgaP4oGwtFihtJ9zJjHD/jsUv5a
V8+uc8g2NmM3OgnATrI/HekbzQov/jVu7Zf+FA61R4IHUtFmP1RnlKBt4fXeVYry
fs3oPonDD8uDUy13nwoLd+VEoGjHQ3bhK40rt0E+Dy2JG/C8ChiyAoeGF1CLccPr
YEHtWdkIRf8tvqp2Sjm8nJlYvguN/A==
=411q
-----END PGP SIGNATURE-----

--74ar2rsca3gxv75u--
