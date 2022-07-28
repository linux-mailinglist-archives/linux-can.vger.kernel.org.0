Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442C9583FF1
	for <lists+linux-can@lfdr.de>; Thu, 28 Jul 2022 15:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiG1N3I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Thu, 28 Jul 2022 09:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiG1N3H (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 28 Jul 2022 09:29:07 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348925A3F7
        for <linux-can@vger.kernel.org>; Thu, 28 Jul 2022 06:29:05 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-32269d60830so19447527b3.2
        for <linux-can@vger.kernel.org>; Thu, 28 Jul 2022 06:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RfsIh9XpAznQdJCqR37oCHZmFUEY6F7IwLwDWpzThDE=;
        b=WSDPlxOkmctpI4egA8AuMQ+H9IHSDvNdYtF/PBICZMcHvh09Le96X5nPwmX1SB/QRR
         QBjymTQ5upLmS3iIo5qdPeIHloSnsB+mtHE6t/mJwRJCtrTFxTiViR/gZAiH2FFA3fMd
         Rn5Cq7tgQbBzGI5DwJjkBrMZ/WO4QrFE2sZrfOAtiynHyMfU1qz3EusvM5EgYRmB8BFe
         va5dpNrIiMkjUbu3P1LdcOjPRAGAZ51LmYZXjP9fP6lphaO+05O4dpb0uO2pq5ExkKno
         tybOzWNSPgY67seXH9LV4xFTH4r230Ldsg8/eEcTx4JK3NIs2Rs5IFFpOXmhz/ZO7ssU
         REoA==
X-Gm-Message-State: AJIora+QmFRJkggAayGyngkOeCQLXASig9cjN34TcRBh0fPFhOtVL0jh
        QL/BfUL02Sb1R9jGgRKwFC+McWP9v6z0XdB+5CA=
X-Google-Smtp-Source: AGRyM1ups5mAL0p6h3tc7cIsWT4bF44vX0ihYOauHRrhzopB2ywVhGjbG2geZA/oAWGvvYqQQBLQ8ESbU7JBSwKUCtc=
X-Received: by 2002:a0d:dfcc:0:b0:322:f812:f379 with SMTP id
 i195-20020a0ddfcc000000b00322f812f379mr1536006ywe.172.1659014942937; Thu, 28
 Jul 2022 06:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220727101641.198847-1-mailhol.vincent@wanadoo.fr>
 <20220727101641.198847-6-mailhol.vincent@wanadoo.fr> <20220728093819.q37lzttsknqzi6a5@pengutronix.de>
In-Reply-To: <20220728093819.q37lzttsknqzi6a5@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Thu, 28 Jul 2022 22:28:51 +0900
Message-ID: <CAMZ6RqKFDpzB5L-HkJ0=gTw0vL6G7SV5bz=8dUgGpMS+OzvsOg@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] can: tree-wide: advertise software timestamping capabilities
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu. 28 juil. 2022 at 18:42, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 27.07.2022 19:16:32, Vincent Mailhol wrote:
> > Currently, some CAN drivers support hardware timestamping, some do
> > not. But userland has no method to query which features are supported
> > (aside maybe of getting RX messages and observe whether or not
> > hardware timestamps stay at zero).
> >
> > The canonical way for a network driver to advertised what kind of
> > timestamping it supports is to implement ethtool_ops::get_ts_info().
> >
> > This patch only targets the CAN drivers which *do not* support
> > hardware timestamping.  For each of those CAN drivers, implement the
> > get_ts_info() using the generic ethtool_op_get_ts_info().
> >
> > This way, userland can do:
> >
> > | $ ethtool --show-time-stamping canX
> >
> > to confirm the device timestamping capacities.
> >
> > N.B. the drivers which support hardware timestamping will be migrated
> > in separate patches.
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>
> [...]
>
> > diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
> > index 78a21ab63601..b1677588a4c8 100644
> > --- a/drivers/net/can/mscan/mscan.c
> > +++ b/drivers/net/can/mscan/mscan.c
> > @@ -676,6 +676,7 @@ struct net_device *alloc_mscandev(void)
> >       priv = netdev_priv(dev);
> >
> >       dev->netdev_ops = &mscan_netdev_ops;
> > +     dev->ethtool_ops = &mscan_ethtool_ops;
> >
> >       dev->flags |= IFF_ECHO; /* we support local echo */
>
> | drivers/net/can/mscan/mscan.c: In function ‘alloc_mscandev’:
> | drivers/net/can/mscan/mscan.c:679:29: error: ‘mscan_ethtool_ops’ undeclared (first use in this function)
> |   679 |         dev->ethtool_ops = &mscan_ethtool_ops;
> |       |                             ^~~~~~~~~~~~~~~~~
> | drivers/net/can/mscan/mscan.c:679:29: note: each undeclared identifier is reported only once for each function it appears in
>
> I'm fixing this.

Thanks for catching this.

mscan does not show up in the menuconfig by default because it
requires CONFIG_PPC. And it is not possible to add CONFIG_COMPILE_TEST
to mscan's KBUILD file because some PPC specific symbols would be
missing. So this is yet another pitfall.


Yours sincerely,
Vincent Mailhol
