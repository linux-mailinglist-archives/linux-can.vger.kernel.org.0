Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5267D688392
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 16:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbjBBP7R (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 10:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjBBP7D (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 10:59:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BE125E1F
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 07:58:04 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pNbXp-0004O6-6U; Thu, 02 Feb 2023 16:30:37 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:fff9:bfd9:c514:9ad9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7FC9316D765;
        Thu,  2 Feb 2023 15:30:36 +0000 (UTC)
Date:   Thu, 2 Feb 2023 16:30:28 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Cc:     linux-can@vger.kernel.org, vincent.mailhol@gmail.com,
        wg@grandegger.com
Subject: Re: [PATCH v2 0/8] can: ems_pci: Add support for CPC-PCIe v3
Message-ID: <20230202153028.kqcbisgyjic2abif@pengutronix.de>
References: <20230120112616.6071-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="voptpjanv76hqbtm"
Content-Disposition: inline
In-Reply-To: <20230120112616.6071-1-uttenthaler@ems-wuensche.com>
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


--voptpjanv76hqbtm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.01.2023 12:26:08, Gerhard Uttenthaler wrote:
> The CPC-PCIe v3 uses an Asix AX99100 instead of the discontinued=20
> PLX PCI9030 bridge chip. This patch series adds support for this=20
> card version and cleans some code styling issues.

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--voptpjanv76hqbtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmPb1xAACgkQvlAcSiqK
BOjpOAf/QIKKNb3ZyPwNH1dWddZIjFXEDMuR/BZm/WegYmky4iOv5b7ZPrkUjXgV
zEFgfw6pvaOr557CVu5mKini9l00J56OUtEIxho9V7pFQ5U/5qKfWZ4LBJWi6mW0
ChWad8P1JaGjU1NwTzwBoGvg406VShkqiy+gmsIX/zeJEPXKn+tPxWLhwSn5hNiU
O2SQgNymyaHCjXJlB8R2PwfukjHr6dDO2Kenev1kFt/oup+ug+7GBwaUNvBS/YD6
XMHM0lHfLohM4pP/ufm7C3VYwSZnfZZAFPQf8X/CUKKzH1Z5kW6xARx8D+9bgcrM
mrXa9MItl9c8E0iYvo38bDrLFOrAgA==
=VVWn
-----END PGP SIGNATURE-----

--voptpjanv76hqbtm--
