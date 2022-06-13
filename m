Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F864549CAE
	for <lists+linux-can@lfdr.de>; Mon, 13 Jun 2022 21:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346268AbiFMTBr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 Jun 2022 15:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346060AbiFMTA4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Jun 2022 15:00:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB1499834
        for <linux-can@vger.kernel.org>; Mon, 13 Jun 2022 09:28:38 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o0mvc-0000pY-NB; Mon, 13 Jun 2022 18:28:36 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0EC0C93F4D;
        Mon, 13 Jun 2022 16:28:36 +0000 (UTC)
Date:   Mon, 13 Jun 2022 18:28:35 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Max Staudt <max@enpas.org>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: netlink: allow configuring of fixed data bit rates
 without need for do_set_data_bittiming callback
Message-ID: <20220613162835.uc3y5lzkjzzcykmn@pengutronix.de>
References: <20220613143633.4151884-1-mkl@pengutronix.de>
 <20220613173643.0092dcc0.max@enpas.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="giead4xfpt6tbaby"
Content-Disposition: inline
In-Reply-To: <20220613173643.0092dcc0.max@enpas.org>
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


--giead4xfpt6tbaby
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 13.06.2022 17:36:43, Max Staudt wrote:
> I've never used this feature, but I guess it looks good, thanks!

It's devices supporting CAN-FD. In CAN-FD you can have 2 different bit
rates. On for the arbitration (beginning of CAN frame) and a faster one
for the data of the CAN frame.

> Acked-by: Max Staudt <max@enpas.org>

Thanks,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--giead4xfpt6tbaby
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKnZbAACgkQrX5LkNig
0110Ywf/S4NGZWcX9y1v2Ib+Oa4zEr8OBl0GrU936z+qooL7coxCRW5ZSZcMuOBu
e502CcvfJMGSjI2D/0tb7Ol+x9WXQ/Otv1HGrpSTqG/ydDFMRQc9f4KMJFtWGD6X
1AP3TxUS+l6pJP0V1y6uKMGbZilJ3zNoDWd1QJIdCBfri99dxe6E3CC7mlJSzRW7
hBN7PrbDufMV49hYNU/Tg2eeWY4miupDER9Eu/Dyvyzt5/nLR0K7pnE78IPh+Vbp
As5R1kt+Vtr9kbjlzxTHqG4vkyQzwvFMTNeJLSaMYmYbjPWjamAZsYKeWXIm6Lxh
3KvqOI+Ty06M50wjkkEytbZ9H9V0gA==
=2uAU
-----END PGP SIGNATURE-----

--giead4xfpt6tbaby--
