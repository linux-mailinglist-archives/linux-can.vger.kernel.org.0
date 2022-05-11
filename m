Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F175233AF
	for <lists+linux-can@lfdr.de>; Wed, 11 May 2022 15:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbiEKNFu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 May 2022 09:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiEKNFu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 May 2022 09:05:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7247125CE
        for <linux-can@vger.kernel.org>; Wed, 11 May 2022 06:05:44 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nom29-0006Tc-Su; Wed, 11 May 2022 15:05:41 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A93A57BCDD;
        Wed, 11 May 2022 13:05:40 +0000 (UTC)
Date:   Wed, 11 May 2022 15:05:40 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Devid Antonio Filoni <devid.filoni@egluetechnologies.com>,
        kernel@pengutronix.de, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH 1/1] can: skb: add and set local_origin flag
Message-ID: <20220511130540.yowjdvzftq2jutiw@pengutronix.de>
References: <20220511121913.2696181-1-o.rempel@pengutronix.de>
 <b631b022-72d5-9160-fd13-f33c80dbbe59@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="byqmtarls5bvmvxs"
Content-Disposition: inline
In-Reply-To: <b631b022-72d5-9160-fd13-f33c80dbbe59@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--byqmtarls5bvmvxs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.05.2022 14:38:32, Oliver Hartkopp wrote:
> I'm a bit unsure why we should not stick with the simple skb->sk
> handling?

Another use where skb->sk breaks is sending CAN frames with SO_TXTIME
with the sched_etf.

I have a patched version of cangen that uses SO_TXTIME. It attaches a
time to transmit to a CAN frame when sending it. If you send 10 frames,
each 100ms after the other and then exit the program, the first CAN
frames show up as TX'ed while the others (after closing the socket) show
up as RX'ed CAN frames in candump.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--byqmtarls5bvmvxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJ7tJoACgkQrX5LkNig
010WOQgAn1qTEhHc8pkIFWfBgw5W+t+qG2osvmttQ6uBBEgBl3lTnJJL5ZhzvT68
csQmMf5ZsbCTzmFZSy//7Nrguxhq8n2ZWL8+wh3o6OorNjCknWfHh1VndzHf6CwH
ZOjVQk2kALuxQE8RXqpLUTWs9eVLoOkyB8qCffVtJyUjCt4p/i40/cQJhQ9OCHR+
H70dhRddRvqYzUZ46bgRP9nh7beUcytGsvnVeV3TqpylYn62HTr9dyVm2h7eIC6j
beS5BzSWqYK50SL8xJgnYhNN/dyhYlbeBMUh39Ex5sRe8TYk5atYPGbuP7SXhyJB
GQk1IuRxFgqnTKIK4zPmVNdsZcdLPQ==
=+1hK
-----END PGP SIGNATURE-----

--byqmtarls5bvmvxs--
