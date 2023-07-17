Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A78755CDE
	for <lists+linux-can@lfdr.de>; Mon, 17 Jul 2023 09:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjGQH2C (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jul 2023 03:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjGQH1w (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jul 2023 03:27:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7359EF7
        for <linux-can@vger.kernel.org>; Mon, 17 Jul 2023 00:27:51 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLIdq-0003Wv-Tk; Mon, 17 Jul 2023 09:27:34 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 92AB91F30B5;
        Mon, 17 Jul 2023 07:27:29 +0000 (UTC)
Date:   Mon, 17 Jul 2023 09:27:29 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Ziyang Xuan <william.xuanziyang@huawei.com>
Cc:     socketcan@hartkopp.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp
Subject: Re: [PATCH net v3] can: raw: fix receiver memory leak
Message-ID: <20230717-clubhouse-swinger-8f0fa23b0628-mkl@pengutronix.de>
References: <20230711011737.1969582-1-william.xuanziyang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ojxgshmorshevosu"
Content-Disposition: inline
In-Reply-To: <20230711011737.1969582-1-william.xuanziyang@huawei.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
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


--ojxgshmorshevosu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.07.2023 09:17:37, Ziyang Xuan wrote:
> Got kmemleak errors with the following ltp can_filter testcase:
>=20
> for ((i=3D1; i<=3D100; i++))
> do
>         ./can_filter &
>         sleep 0.1
> done
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [<00000000db4a4943>] can_rx_register+0x147/0x360 [can]
> [<00000000a289549d>] raw_setsockopt+0x5ef/0x853 [can_raw]
> [<000000006d3d9ebd>] __sys_setsockopt+0x173/0x2c0
> [<00000000407dbfec>] __x64_sys_setsockopt+0x61/0x70
> [<00000000fd468496>] do_syscall_64+0x33/0x40
> [<00000000b7e47d51>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
>=20
> It's a bug in the concurrent scenario of unregister_netdevice_many()
> and raw_release() as following:
>=20
>              cpu0                                        cpu1
> unregister_netdevice_many(can_dev)
>   unlist_netdevice(can_dev) // dev_get_by_index() return NULL after this
>   net_set_todo(can_dev)
> 						raw_release(can_socket)
> 						  dev =3D dev_get_by_index(, ro->ifindex); // dev =3D=3D NULL
> 						  if (dev) { // receivers in dev_rcv_lists not free because dev is =
NULL
> 						    raw_disable_allfilters(, dev, );
> 						    dev_put(dev);
> 						  }
> 						  ...
> 						  ro->bound =3D 0;
> 						  ...
>=20
> call_netdevice_notifiers(NETDEV_UNREGISTER, )
>   raw_notify(, NETDEV_UNREGISTER, )
>     if (ro->bound) // invalid because ro->bound has been set 0
>       raw_disable_allfilters(, dev, ); // receivers in dev_rcv_lists will=
 never be freed
>=20
> Add a net_device pointer member in struct raw_sock to record bound can_de=
v,
> and use rtnl_lock to serialize raw_socket members between raw_bind(), raw=
_release(),
> raw_setsockopt() and raw_notify(). Use ro->dev to decide whether to free =
receivers in
> dev_rcv_lists.
>=20
> Fixes: 8d0caedb7596 ("can: bcm/raw/isotp: use per module netdevice notifi=
er")
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Added to linux-can/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ojxgshmorshevosu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS07V4ACgkQvlAcSiqK
BOiH/wf/c73w58tgmGiIfjLFoGiiA+8LIIccexne2gLAqwRhGHz/g8Dcbj8986p/
FUlNDpUirAoOqgRZhPuypBYCxE500IzNLHrlCprMCr3XnEOSkPf/Y+AGNC8z0JBb
hsAyASJJnr/P5QLPT3eZ/+m/mmXPNi6noet+udwujANMd8RpOxrsVaLZ7a3UGVnY
4CHxUAcr95FNm/Q+lYaOZ2L1ljtmqatsFqrJPktySes7pu1SrFv0/V5dyA/hcVu3
++DhiqX7oroIYsDz/Ei8W7Z0+z9wWr+BmP3C6ZIIZzK0GBCKS/P/XHqCYEsVXlV8
fkYIUTDubtsEY5FN8E0kYb1q4wpUfQ==
=3ymX
-----END PGP SIGNATURE-----

--ojxgshmorshevosu--
