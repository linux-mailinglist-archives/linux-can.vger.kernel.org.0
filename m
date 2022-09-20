Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15095BEDEF
	for <lists+linux-can@lfdr.de>; Tue, 20 Sep 2022 21:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiITTj0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Sep 2022 15:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiITTjY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Sep 2022 15:39:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8707647D
        for <linux-can@vger.kernel.org>; Tue, 20 Sep 2022 12:39:23 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oaj5V-0000Lm-Jh; Tue, 20 Sep 2022 21:39:21 +0200
Received: from pengutronix.de (hardanger-2.fritz.box [IPv6:2a03:f580:87bc:d400:2544:bef8:ba12:489b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3FB68E7BFF;
        Tue, 20 Sep 2022 19:39:20 +0000 (UTC)
Date:   Tue, 20 Sep 2022 21:39:20 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org,
        Anssi Hannula <anssi.hannula@bitwise.fi>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: Re: [PATCH v4 00/15] can: kvaser_usb: Various fixes
Message-ID: <20220920193920.eigcy2rl4cmjxxr2@pengutronix.de>
References: <20220903182344.139-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4gztlqy7v5434khg"
Content-Disposition: inline
In-Reply-To: <20220903182344.139-1-extja@kvaser.com>
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


--4gztlqy7v5434khg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.09.2022 20:23:29, Jimmy Assarsson wrote:
> This patch series was originally posted by Anssi Hannula [1].
> In v2 I rebased and updated some of the patches [2].

One of the net subsystem maintainers wasn't happy with the patch series,
he requested:

On 20.09.2022 12:22:46, Jakub Kicinski wrote:
>> These are large patches which don't clearly justify the classification
>> as a fix. Patches 6 and 8 for example leave me asking "what does this
>> fix?" It's good to report errors, but the absence of error reporting
>> is not necessarily a bug worthy of stable.
>>=20
>> Can we get the commit messages beefed up?

Note: As your patches were part of a bigger series the patch numbers are
as following:

| [PATCH net 05/17] can: kvaser_usb: Fix possible completions during init_c=
ompletion
| [PATCH net 06/17] can: kvaser_usb: kvaser_usb_leaf: Get capabilities from=
 device
| [PATCH net 07/17] can: kvaser_usb: kvaser_usb_leaf: Rename {leaf,usbcan}_=
cmd_error_event to {leaf,usbcan}_cmd_can_error_event
| [PATCH net 08/17] can: kvaser_usb: kvaser_usb_leaf: Handle CMD_ERROR_EVENT
| [PATCH net 09/17] can: kvaser_usb_leaf: Set Warning state even without bu=
s errors

Can you distill the absolute minimum patches the fix (serious) bugs and
re-post them with stable on Cc. The other patches should go via can-next
to net-next. Post them in a separate series. If they depend on the
fixes, please mention that in the cover letter. I can take the as soon
as the net tree is merged back to net-next.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--4gztlqy7v5434khg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMqFuUACgkQrX5LkNig
013opgf/VgHefDixsMkwOsCLgWDAWJ7v8aqqm//m1ONog6TN+H3CLvEvAYKTI/ef
ycLghIj66/9I7EoDpMvBxhdGph3pr8QPdOTJ5GTzcsQ/ROmjZ7uJOAd/6JeqtIN6
Gg5hRs3BBhWkev74aVE5ZvIc7Pr+Cq2Cii8ZM9KXFrGXu3UHfBg8ClQx4GDQ4gjN
1Hf+uajIqW+vbpEaTZIOqew+wgwmpfIJz5SxYbgoj4B+Cxc4W5wXt6HH+OjVK3uE
/SLBwIxS62KlK6tZUEVXRt4AMHU1QAbWrfj5bbjZplJ7AkdFBl6LPa44IbnyShba
ySRVR2Lp02A2NCVIsSKq/pPMJoVEVw==
=aYra
-----END PGP SIGNATURE-----

--4gztlqy7v5434khg--
