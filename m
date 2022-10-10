Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4965F985A
	for <lists+linux-can@lfdr.de>; Mon, 10 Oct 2022 08:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiJJGaO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Oct 2022 02:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiJJGaN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Oct 2022 02:30:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD7C4D265
        for <linux-can@vger.kernel.org>; Sun,  9 Oct 2022 23:30:11 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ohmIj-0003h4-V6; Mon, 10 Oct 2022 08:30:10 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 01188F8263;
        Mon, 10 Oct 2022 06:30:08 +0000 (UTC)
Date:   Mon, 10 Oct 2022 08:30:05 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jeroen Hofstee <jhofstee@victronenergy.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH 0/6] can: gs_usb: new features: GS_CAN_FEATURE_GET_STATE,
 GS_CAN_FEATURE_BERR_REPORTING
Message-ID: <20221010063005.ub6m3hfmqwxt5k34@pengutronix.de>
References: <20221006162452.200322-1-mkl@pengutronix.de>
 <20221006162823.2rj7e63xg3li7fi6@pengutronix.de>
 <5bd818e1-3573-080a-d15a-b94594c183e1@victronenergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qp4f5ippows2gu4e"
Content-Disposition: inline
In-Reply-To: <5bd818e1-3573-080a-d15a-b94594c183e1@victronenergy.com>
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


--qp4f5ippows2gu4e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.10.2022 20:59:43, Jeroen Hofstee wrote:
> > Jeroen, can I add your Signed-off-by for the patches?

> Yes I wrote this, intended for linux, strictly speaking
> Signed-off-by: Jeroen Hofstee <jeroen@myspectrum.nl>
> or
> Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>

Thanks, I've used the victronenergy.com address, it matches the author.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--qp4f5ippows2gu4e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNDu+kACgkQrX5LkNig
012+EQf+L/iaInW/yH9yBXNaabWSPI2VyMBYNwkZ9+9cEVy8cwseCZYIKqE+KC5H
F8oPpUID6Jw3o+GxJOGl6pF2YtVrIkEWXl9F0dVfkY2CxQh+Va/Osm9WZbangbGV
Dqm8L9JORGi31tywSbEMYUlT8116KPe2K0S57CtVCENcMmOi2L2K9t2MGwPES5hG
Wii1ph3Dvyvt+EebOU9i7Q3A6UGIlLLLUkvXZYC/ET+4SaH0aOg+mFMCC7QG68ro
CtAJ8+GPO4EdTzIep43ExSsnHDdI6jXNJ0O7yGdZsRm1llxrYuwNYviNq7MBoB3/
IKKaZUbbnvkaHL3Bo8oV2VKZwnAEYw==
=GxK1
-----END PGP SIGNATURE-----

--qp4f5ippows2gu4e--
