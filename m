Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C31590DFA
	for <lists+linux-can@lfdr.de>; Fri, 12 Aug 2022 11:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiHLJUD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 Aug 2022 05:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiHLJUC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 12 Aug 2022 05:20:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AF3A8302
        for <linux-can@vger.kernel.org>; Fri, 12 Aug 2022 02:20:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oMQpj-0003US-8F; Fri, 12 Aug 2022 11:19:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oMQpg-003I5o-83; Fri, 12 Aug 2022 11:19:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oMQph-00BCtN-FC; Fri, 12 Aug 2022 11:19:57 +0200
Date:   Fri, 12 Aug 2022 11:19:57 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH can v2] can: flexcan: flexcan_mailbox_read() fix return
 value for drop = true
Message-ID: <20220812091957.ojlmw7m6xlk5bymy@pengutronix.de>
References: <20220811094254.1864367-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="crujm2wa5db2ki4h"
Content-Disposition: inline
In-Reply-To: <20220811094254.1864367-1-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
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


--crujm2wa5db2ki4h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Aug 11, 2022 at 11:42:54AM +0200, Marc Kleine-Budde wrote:
> The following happened on an i.MX25 using flexcan with many packets on
> the bus:
>=20
> The rx-offload queue reached a length more than skb_queue_len_max. In
> can_rx_offload_offload_one() the drop variable was set to true which
> made the call to .mailbox_read() (here: flexcan_mailbox_read()) to
> _always_ return ERR_PTR(-ENOBUFS) and drop the rx'ed CAN frame. So
> can_rx_offload_offload_one() returned ERR_PTR(-ENOBUFS), too.
>=20
> can_rx_offload_irq_offload_fifo() looks as follows:
>=20
> | 	while (1) {
> | 		skb =3D can_rx_offload_offload_one(offload, 0);
> | 		if (IS_ERR(skb))
> | 			continue;
> | 		if (!skb)
> | 			break;
> | 		...
> | 	}
>=20
> The flexcan driver wrongly always returns ERR_PTR(-ENOBUFS) if drop is
> requested, even if there is no CAN frame pending. As the i.MX25 is a
> single core CPU, while the rx-offload processing is active, there is
> no thread to process packets from the offload queue. So the queue
> doesn't get any shorter and this results is a tight loop.
>=20
> Instead of always returning ERR_PTR(-ENOBUFS) if drop is requested,
> return NULL if no CAN frame is pending.
>=20
> Fixes: 4e9c9484b085 ("can: rx-offload: Prepare for CAN FD support")
> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

That change fixes the problem I saw.

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks for your followup!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--crujm2wa5db2ki4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmL2GzoACgkQwfwUeK3K
7AkZigf+KXn8kdH94L3AHpc+k35E31zX8X29/Ekbe9X0tkybUMvp35cWG/Oq2Djj
Lm5J9loAwwzFLIkceVwQH3kk2LbbaIX1qhojaJw5XKaCb8WgU/IxWlu7f1C8QFaU
rgJkGA7DQojupQsp/zRhLCb6kPEtG0j7u3Ppw5tgWkUM8o5b/QuCjcqnJB0n1/be
PihkzrGb0AH8U6H24qij+yfc+Vn+iWW41KJm27Rg8Su5kLMBXkRWfXlRCrH6/vIr
GVmlD4GJOEjKzyfqrkrRlqveSa3JLvRuJxh8u0FsM2nUaGpTr1/XE5otqOQM5OHW
bIMlz32G4sx/OLFD1GORw2uhV/5Hyg==
=RlF0
-----END PGP SIGNATURE-----

--crujm2wa5db2ki4h--
