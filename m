Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E45E5F6BE0
	for <lists+linux-can@lfdr.de>; Thu,  6 Oct 2022 18:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJFQg6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 Oct 2022 12:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiJFQg5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Oct 2022 12:36:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64B6CE981
        for <linux-can@vger.kernel.org>; Thu,  6 Oct 2022 09:36:56 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ogTrj-0004Z3-7j; Thu, 06 Oct 2022 18:36:55 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7B3B4F6690;
        Thu,  6 Oct 2022 16:36:54 +0000 (UTC)
Date:   Thu, 6 Oct 2022 18:36:50 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: Re: [PATCH 4/6] can: gs_usb: add ability to enable / disable berr
 rerporting
Message-ID: <20221006163650.b6n2g44kl5d3ptq4@pengutronix.de>
References: <20221006162452.200322-1-mkl@pengutronix.de>
 <20221006162452.200322-5-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="egsvtd64nhe5azux"
Content-Disposition: inline
In-Reply-To: <20221006162452.200322-5-mkl@pengutronix.de>
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


--egsvtd64nhe5azux
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.10.2022 18:24:50, Marc Kleine-Budde wrote:
> From: Jeroen Hofstee <jhofstee@victronenergy.com>
>=20
> The open source firmware candleLight report bus errors
> unconditionally. This adds support to enable / disable bus error
> reporting with the standard netlink property.

I haven't checked the candleLight firmware, yet.

If the unmodified firmware sends bus errors per default and we introduce
BERR_REPORTING as suggested in this patch, we have to modify the default
behavior for bus errors: By default the firmware will not send bus
errors, but only if GS_CAN_MODE_BERR_REPORTING is requested during
open().

I'm not sure if we want to change the default behavior of the
firmware....To work around this backwards compatibility issue we can
explicitly turn BERR reporting on or off during open via
GS_CAN_MODE_BERR_REPORTING_ON or GS_CAN_MODE_BERR_REPORTING_OFF.

What do you think?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--egsvtd64nhe5azux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmM/BCAACgkQrX5LkNig
011/+wf+PUTERvps8d7fqQWT97MCzMMBnyFiuTG5q+KAbrI5hm64JS3p7i5G49X6
V1Awu89Iqxt4S4GhqkG7FBoKiB19Bi9IRmUnMtwcVznO4CFyd5esQxmdOJ+PCDNO
fCpozJv60OkKRk6IkOfrlhSk4v9O/65cYOnDCWGQ1xvP21K0sK8knL67jKVosNMS
yr8x8V8bAwuW6OOhfX55zDsFiZWim5fQIfQ8uZA8+Mwc72o7uRSd2wxH+X0bFULD
Eb24puY/CAfAEE/8BUZVvW4j+H57is8FY4FqfATuY7B+wavpp0Q5KxuYfRLUH/tt
Bv0K8GBoaV0BdTXkXTo/CAQ5S+BUng==
=DyX4
-----END PGP SIGNATURE-----

--egsvtd64nhe5azux--
