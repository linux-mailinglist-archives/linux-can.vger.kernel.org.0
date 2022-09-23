Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52F45E812E
	for <lists+linux-can@lfdr.de>; Fri, 23 Sep 2022 19:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiIWRzT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 23 Sep 2022 13:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiIWRzM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 23 Sep 2022 13:55:12 -0400
Received: from libero.it (smtp-35-i2.italiaonline.it [213.209.12.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D0DD69DE
        for <linux-can@vger.kernel.org>; Fri, 23 Sep 2022 10:55:08 -0700 (PDT)
Received: from oxapps-36-168.iol.local ([10.101.8.214])
        by smtp-35.iol.local with ESMTPA
        id bmtGoXIV750p3bmtGo8NfI; Fri, 23 Sep 2022 19:55:06 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1663955706; bh=wQCtgWl4x8GWeuI9I517VKhsmejYmt6e6g4WdE/9ZqQ=;
        h=From;
        b=A3rE44O2p787NQMralp19JCArd0aOyJl16p8rvPPu7etGYLQ0WPuYH5pPfZ0cafRv
         4tNdkll4qwEVlyM6LhIJv9EMkZ2OQU7XrRo1lI/zJGolZFQmWi0iOQr/beFnw5ceAK
         bYhw3pWiEQhRfus7wQFklfvKRoKsGwwfL1KWfTs0fDenzNYlBtsnB/KLWcQUw3ySzo
         YysTr12VpObMLeQVBN2CW+XYNPzop2DdlXKYfYsEXh0vD1KbPpAqQ/lWEpo857behS
         0rXXAb0hHSHlIrz8sDCOFMfb23VCVULyxhrbmLE5pgCiKnXoOipwzzmrBqZ8mO/Tj+
         1SqVXQ2NZXpSw==
X-CNFS-Analysis: v=2.4 cv=D5aCltdj c=1 sm=1 tr=0 ts=632df2fa cx=a_exe
 a=3iLpBvWwvOdkg4efS1Ji/Q==:117 a=KtRsck1nP08A:10 a=IkcTkHD0fZMA:10
 a=NT8mcSYMf2YA:10 a=VwQbUJbxAAAA:8 a=bGNZPXyTAAAA:8 a=bAF_0_vCazFOC95qmekA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=yL4RfsBhuEsimFDS2qtJ:22
Date:   Fri, 23 Sep 2022 19:55:06 +0200 (CEST)
From:   dariobin@libero.it
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Jacob Kroon <jacob.kroon@gmail.com>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, wg@grandegger.com
Message-ID: <36690382.801104.1663955706569@mail1.libero.it>
In-Reply-To: <20220923113638.tjnbuvkzdq24c4as@pengutronix.de>
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
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.5-Rev48
X-Originating-IP: 95.232.92.192
X-Originating-Client: open-xchange-appsuite
x-libjamsun: BRc3EBzIi25H+mkQjwGhLU3QlA+qTujH
x-libjamv: 2NL/srFTPNs=
X-CMAE-Envelope: MS4xfAx5gpfrXU6QqdkvF9GedexVZ881ld2mCGP6ZW89LXxBJW5cmoJLff1+nRlnrSB4TutCwLZnfnUGcUTlozJ/9pgcOt++V4HtwF/1qB+eHefOwDIGk2Mp
 dCo5RmY1ZM3Z6M96oHcj47kIZidYPVpjnYaye1VcwDCKkfkaETeKvt/EcB90xEZ2yDdh+JWft58Zlz940KF9U99xeQuq70TsNgRYpGIba0xhqhFLXT2qgdNY
 SP+VccN/c6r7I9lxrhS8cuZm6P73vtOOFBU6gU5U75e88jCGs6+3XlxFcaXwlgzjbD91qUcnjfuAbRY3YXi1OfZQC4/uTJ5ZSh08sclpOOw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Michael,

> Il 23/09/2022 13:36 Marc Kleine-Budde <mkl@pengutronix.de> ha scritto:
> 
>  
> On 16.09.2022 06:14:58, Jacob Kroon wrote:
> > What I do know is that if I revert commit:
> > 
> > "can: c_can: cache frames to operate as a true FIFO"
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=387da6bc7a826cc6d532b1c0002b7c7513238d5f
> > 
> > then everything looks good. I don't get any BUG messages, and the host
> > has been running overnight without problems, so it seems to have fixed
> > the network interface lockup as well.
> 
> Jacob, after this mail, I'll send 2 patches. One tries to disable the
> cache feature for C_CAN cores, the other shuts a potential race window.

About the "can: c_can: don't cache TX messages for C_CAN cores" patch:
Could it make sense to change the c_can_start_xmit in this way

-       if (idx < c_can_get_tx_tail(tx_ring))
-               cmd &= ~IF_COMM_TXRQST; /* Cache the message */
+       if (idx < c_can_get_tx_tail(tx_ring)) {
+               if (priv->type == BOSCH_D_CAN) {
+                       cmd &= ~IF_COMM_TXRQST; /* Cache the message */
+               } else {
+                       netif_stop_queue(priv->dev);
+                       return NETDEV_TX_BUSY;
+               }
+       }

without changing the c_can_get_tx_{free,busy} routines ?

Thanks and regards,
Dario

> Please test both patches, but only apply one of them at a time. :)
> 
> regards,
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
