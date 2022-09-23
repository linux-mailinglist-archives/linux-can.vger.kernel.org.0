Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9215E82A0
	for <lists+linux-can@lfdr.de>; Fri, 23 Sep 2022 21:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiIWTpL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 23 Sep 2022 15:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiIWTpK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 23 Sep 2022 15:45:10 -0400
Received: from libero.it (smtp-31-i2.italiaonline.it [213.209.12.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8175923FD
        for <linux-can@vger.kernel.org>; Fri, 23 Sep 2022 12:45:07 -0700 (PDT)
Received: from oxapps-36-168.iol.local ([10.101.8.214])
        by smtp-31.iol.local with ESMTPA
        id bobgousheRKx7bobgoWmnK; Fri, 23 Sep 2022 21:45:05 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1663962305; bh=iNdB6elqXub10wbVaavxaRVjsLccVXEVfxctHhgJdaY=;
        h=From;
        b=Cz8zHtZnsoI7gLxZcuu4Z8fH4K0fc0SZWTE123q03vOlpznjW/yEoxIH7kn5q2zT+
         AkuzU36FTh+K7Frc99gVs+m4ATPPkTeK51iOPs+QkwtVupBRy94vWjk+AVNCJM3KYP
         1hXnawjJf4qkgnIC2Xav9XX2MBwB1FIgwbYwFFIpV/G0DVKW2tABUNgmQMDzrEe1v7
         HVp92lDUp+vWU6TgKHac4CJZkwpDNl084tSKM3ChTzbo9543t2UC7r4KAN2QrFicNm
         GL8fMj6GJL+sXgqQyHpNkvt8FO7Zb5zzKNqxVqXM5+7/pQkV9gl9EyDvGzOoF0PVQA
         I2euP5UKN/LcQ==
X-CNFS-Analysis: v=2.4 cv=BqtYfab5 c=1 sm=1 tr=0 ts=632e0cc1 cx=a_exe
 a=3iLpBvWwvOdkg4efS1Ji/Q==:117 a=KtRsck1nP08A:10 a=IkcTkHD0fZMA:10
 a=NT8mcSYMf2YA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=XH6FHr3deXz293c3TlUA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
Date:   Fri, 23 Sep 2022 21:45:04 +0200 (CEST)
From:   dariobin@libero.it
To:     Jacob Kroon <jacob.kroon@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, wg@grandegger.com
Message-ID: <1885528784.804387.1663962304792@mail1.libero.it>
In-Reply-To: <8665ef57-17fb-dfd7-afa2-8e5bebceb617@gmail.com>
References: <15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com>
 <403e18fe-8695-cd56-38f3-0ffe3ec9e472@gmail.com>
 <36d0419b-297f-8e39-8843-051b55b8a2bb@gmail.com>
 <986401a8-5f5a-0705-82c4-4df339509e07@gmail.com>
 <556866e2-a3aa-9077-8db7-edc4ced69491@hartkopp.net>
 <f8a95bfb-b1c2-cd41-1106-ca739c438fb9@gmail.com>
 <df1d220e-bf99-1051-ca90-5bd52e6c64e7@hartkopp.net>
 <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
 <20220905155416.pgvseb6uggc67ua4@pengutronix.de>
 <8c481a4e-9493-25ae-f4d7-c12dc98bc83e@gmail.com>
 <20220923113638.tjnbuvkzdq24c4as@pengutronix.de>
 <36690382.801104.1663955706569@mail1.libero.it>
 <a162f149-58ba-24eb-474f-294b9fe78e51@gmail.com>
 <8665ef57-17fb-dfd7-afa2-8e5bebceb617@gmail.com>
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.5-Rev48
X-Originating-IP: 95.232.92.192
X-Originating-Client: open-xchange-appsuite
x-libjamsun: JyC4W26RyKz5FNryCJVFrNpNux+zBvXP
x-libjamv: nfkU8tXbqUw=
X-CMAE-Envelope: MS4xfKyOKQbqAbE2/3bdQI0R3gcLLgy33tIrC8hURlquTfvKkGvSRAGvrt1SBYiGvP1yvqSWMzR/1idHx2PHM6JJljNnOdrL7Xwac+/OjJwuEa62BC2KNUeR
 0quwqAU5pvgbFR7mib9v72qTadCdn9KbJJwoOuoUzM8hzDLR8UOf76x+URhJGtmKE/saejkxz4dmuP/sYUkQsp77CGahrJqt0EVovtwVcD1edESMBVLZRpWt
 g++I8L6h2rTEAP6LEob2BfBcwZM13AG6omvP2eLGvQfAMh63hz+qwVUkFiYfQVK3QpzpnzFUM9P6guD4iO6943EBqhsqEhG8KqtgUwYKt8k=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Jacob,

> Il 23/09/2022 21:21 Jacob Kroon <jacob.kroon@gmail.com> ha scritto:
>=20
> =20
> On 9/23/22 21:03, Jacob Kroon wrote:
> > Hi Dario,
> >=20
> > On 9/23/22 19:55, dariobin@libero.it wrote:
> >> Hi Michael,
> >>
> >>> Il 23/09/2022 13:36 Marc Kleine-Budde <mkl@pengutronix.de> ha scritto=
:
> >>>
> >>> On 16.09.2022 06:14:58, Jacob Kroon wrote:
> >>>> What I do know is that if I revert commit:
> >>>>
> >>>> "can: c_can: cache frames to operate as a true FIFO"
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3D387da6bc7a826cc6d532b1c0002b7c7513238d5f
> >>>>
> >>>> then everything looks good. I don't get any BUG messages, and the ho=
st
> >>>> has been running overnight without problems, so it seems to have fix=
ed
> >>>> the network interface lockup as well.
> >>>
> >>> Jacob, after this mail, I'll send 2 patches. One tries to disable the
> >>> cache feature for C_CAN cores, the other shuts a potential race windo=
w.
> >>
> >> About the "can: c_can: don't cache TX messages for C_CAN cores" patch:
> >> Could it make sense to change the c_can_start_xmit in this way
> >>
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (idx < c_can_get_tx_tail(tx_r=
ing))
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 cmd &=3D ~IF_COMM_TXRQST; /* Cache the message */
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (idx < c_can_get_tx_tail(tx_r=
ing)) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (priv->type =3D=3D BOSCH_D_CAN) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd &=3D ~I=
F_COMM_TXRQST; /* Cache the message */
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 } else {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netif_stop_=
queue(priv->dev);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NETD=
EV_TX_BUSY;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>
> >> without changing the c_can_get_tx_{free,busy} routines ?
> >>
> >=20
> > I can test, so you suggest only doing the above patch, or were there=20
> > other parts from Marc's patch you wanted in ?
> >
>=20
> Well I tried only the above, and the patch below
>=20
> diff --git a/drivers/net/can/c_can/c_can_main.c=20
> b/drivers/net/can/c_can/c_can_main.c
> index a7362af0babb..21d0a55ebbb3 100644
> --- a/drivers/net/can/c_can/c_can_main.c
> +++ b/drivers/net/can/c_can/c_can_main.c
> @@ -468,8 +468,14 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff=
=20
> *skb,
>   =09if (c_can_get_tx_free(tx_ring) =3D=3D 0)
>   =09=09netif_stop_queue(dev);
>=20
> -=09if (idx < c_can_get_tx_tail(tx_ring))
> -=09=09cmd &=3D ~IF_COMM_TXRQST; /* Cache the message */
> +=09if (idx < c_can_get_tx_tail(tx_ring)) {
> +=09=09if (priv->type =3D=3D BOSCH_D_CAN) {
> +=09=09=09cmd &=3D ~IF_COMM_TXRQST; /* Cache the message */
> +=09=09} else {
> +=09=09=09netif_stop_queue(priv->dev);
> +=09=09=09return NETDEV_TX_BUSY;
> +=09=09}
> +=09}
>=20
>   =09/* Store the message in the interface so we can call
>   =09 * can_put_echo_skb(). We must do this before we enable
> @@ -761,7 +767,7 @@ static void c_can_do_tx(struct net_device *dev)
>=20
>   =09tail =3D c_can_get_tx_tail(tx_ring);
>=20
> -=09if (tail =3D=3D 0) {
> +=09if (priv->type =3D=3D BOSCH_D_CAN && tail =3D=3D 0) {
>   =09=09u8 head =3D c_can_get_tx_head(tx_ring);
>=20
>   =09=09/* Start transmission for all cached messages */
>=20
>=20
> but they both seem to lockup the network.
>=20

I didn't understand if you applied two patches separately or not.
This was the only patch I had thought of. Which was similar to Marc's=20
for the interrupt part but differed in the c_can_start_xmit part.

--- a/drivers/net/can/c_can/c_can_main.c
+++ b/drivers/net/can/c_can/c_can_main.c
@@ -464,13 +464,19 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *s=
kb,
                return NETDEV_TX_BUSY;
=20
        idx =3D c_can_get_tx_head(tx_ring);
+       if (idx < c_can_get_tx_tail(tx_ring)) {
+               if (priv->type =3D=3D BOSCH_D_CAN) {
+                       cmd &=3D ~IF_COMM_TXRQST; /* Cache the message */
+               } else {
+                       netif_stop_queue(priv->dev);
+                       return NETDEV_TX_BUSY;
+               }
+       }
+
        tx_ring->head++;
        if (c_can_get_tx_free(tx_ring) =3D=3D 0)
                netif_stop_queue(dev);
=20
-       if (idx < c_can_get_tx_tail(tx_ring))
-               cmd &=3D ~IF_COMM_TXRQST; /* Cache the message */
-
        /* Store the message in the interface so we can call
         * can_put_echo_skb(). We must do this before we enable
         * transmit as we might race against do_tx().
@@ -723,7 +729,6 @@ static void c_can_do_tx(struct net_device *dev)
        struct c_can_tx_ring *tx_ring =3D &priv->tx;
        struct net_device_stats *stats =3D &dev->stats;
        u32 idx, obj, pkts =3D 0, bytes =3D 0, pend;
-       u8 tail;
=20
        if (priv->msg_obj_tx_last > 32)
                pend =3D priv->read_reg32(priv, C_CAN_INTPND3_REG);
@@ -759,15 +764,20 @@ static void c_can_do_tx(struct net_device *dev)
        stats->tx_bytes +=3D bytes;
        stats->tx_packets +=3D pkts;
=20
-       tail =3D c_can_get_tx_tail(tx_ring);
+       if (priv->type =3D=3D BOSCH_D_CAN) {
+               u8 tail;
+
+               tail =3D c_can_get_tx_tail(tx_ring);
=20
-       if (tail =3D=3D 0) {
-               u8 head =3D c_can_get_tx_head(tx_ring);
+               if (tail =3D=3D 0) {
+                       u8 head =3D c_can_get_tx_head(tx_ring);
=20
-               /* Start transmission for all cached messages */
-               for (idx =3D tail; idx < head; idx++) {
-                       obj =3D idx + priv->msg_obj_tx_first;
-                       c_can_object_put(dev, IF_NAPI, obj, IF_COMM_TXRQST)=
;
+                       /* Start transmission for all cached messages */
+                       for (idx =3D tail; idx < head; idx++) {
+                               obj =3D idx + priv->msg_obj_tx_first;
+                               c_can_object_put(dev, IF_NAPI, obj,
+                                                IF_COMM_TXRQST);
+                       }
                }
        }
 }

I changed it a little from the previous email because I noticed a problem.

Thanks and regards,
Dario

> Jacob
