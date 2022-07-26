Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626FE580F4D
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 10:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiGZIme (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 04:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiGZImd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 04:42:33 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB570112D
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:42:32 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2ef5380669cso134906287b3.9
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tgPlHi+iLxABsK2wH4z6sew34bXWhIi41OtcsmYm60g=;
        b=CeeU+Pm+RomVrZQ3KajM8UWCPco44jCXFpPfH8joD0Qxg0BdgKAKpvFR/FOfrBthfq
         Cl3K+jFmOKBwi1HEVfDQgrkreX+ooyS3hOnpJAPOQr+TT0yy/4hU6Djj0aQcz6VVbtoy
         p5n1eyxYtCFgMznAmMKDSi5j1D8TUyMspd6x3jyj2MZTGag+o4dbEc0iK7aX1yrrRClW
         UZgW90UeBWJssgc+DuBEhqbjqlZitaoWapYf6KBrluI1qBetb1XOPUXLz6AOZv28NyLR
         zcJkZWk6hE6zuHr83nIehcQEWXKBef7R+sbIVwU5ZQVq8d5bZfwHSEKvo0GiNQM6KKeF
         vE7g==
X-Gm-Message-State: AJIora9RtUtOTiyzQdXnQart/LWdxJXLfYuOn9dBfAs35UjhMnRahxLV
        y4XNcYy7qgAaHS+A5LbWQBsajso7BuzG0XvzQVvCN5ErCmDK3Q==
X-Google-Smtp-Source: AGRyM1sDjX0Mnx6Y+8VrgzBD3QvxUuu/MpEASFJW+rXpd/KMEGnn9ZKS3srAmQcodGIgxsnY0tRw7xXxCb+LmuLFDmk=
X-Received: by 2002:a81:9201:0:b0:31e:4ce6:8c90 with SMTP id
 j1-20020a819201000000b0031e4ce68c90mr13351469ywg.45.1658824951871; Tue, 26
 Jul 2022 01:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220725133208.432176-11-mailhol.vincent@wanadoo.fr> <CABGWkvoqkETb0H-UWhwPCk1eMwQC2ExfKUXm25Mv4R5g0kjb+Q@mail.gmail.com>
In-Reply-To: <CABGWkvoqkETb0H-UWhwPCk1eMwQC2ExfKUXm25Mv4R5g0kjb+Q@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 26 Jul 2022 17:42:20 +0900
Message-ID: <CAMZ6Rq+Wd412aFSiuLsjPE=aT0UQVNqp9FEZCEkjdU71hVWR0Q@mail.gmail.com>
Subject: Re: [PATCH v1 10/24] can: tree-wide: implement ethtool_ops::get_drvinfo()
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Max Staudt <max@enpas.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Dario,

On Tue. 26 Jul. 2022 at 16:41, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
> Hi Vincent,
>
> On Mon, Jul 25, 2022 at 3:32 PM Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
> >
> > For all CAN drivers, implement the get_drvinfo() function.
> >
> > After this patch, it is now possible to retrieve basic information by
> > doing:
> >
> > | $ ethtool -i canX
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> >  drivers/net/can/at91_can.c                       | 12 ++++++++++++
> >  drivers/net/can/c_can/c_can_main.c               | 12 ++++++++++++
> >  drivers/net/can/can327.c                         | 11 +++++++++++
> >  drivers/net/can/cc770/cc770.c                    | 12 ++++++++++++
> >  drivers/net/can/ctucanfd/ctucanfd_base.c         | 12 ++++++++++++
> >  drivers/net/can/flexcan/flexcan-core.c           | 12 ++++++++++++
> >  drivers/net/can/grcan.c                          | 12 ++++++++++++
> >  drivers/net/can/ifi_canfd/ifi_canfd.c            | 12 ++++++++++++
> >  drivers/net/can/janz-ican3.c                     | 12 ++++++++++++
> >  drivers/net/can/kvaser_pciefd.c                  | 12 ++++++++++++
> >  drivers/net/can/m_can/m_can.c                    | 12 ++++++++++++
> >  drivers/net/can/mscan/mscan.c                    |  1 +
> >  drivers/net/can/pch_can.c                        | 12 ++++++++++++
> >  drivers/net/can/peak_canfd/peak_canfd.c          | 12 ++++++++++++
> >  drivers/net/can/rcar/rcar_can.c                  | 12 ++++++++++++
> >  drivers/net/can/rcar/rcar_canfd.c                | 12 ++++++++++++
> >  drivers/net/can/sja1000/sja1000.c                | 12 ++++++++++++
> >  drivers/net/can/slcan/slcan-core.c               | 12 ++++++++++++
> >  drivers/net/can/softing/softing_main.c           | 12 ++++++++++++
> >  drivers/net/can/spi/hi311x.c                     | 12 ++++++++++++
> >  drivers/net/can/spi/mcp251x.c                    | 12 ++++++++++++
> >  drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c   | 12 ++++++++++++
> >  drivers/net/can/sun4i_can.c                      | 12 ++++++++++++
> >  drivers/net/can/ti_hecc.c                        | 12 ++++++++++++
> >  drivers/net/can/usb/ems_usb.c                    | 12 ++++++++++++
> >  drivers/net/can/usb/esd_usb.c                    | 12 ++++++++++++
> >  drivers/net/can/usb/etas_es58x/es58x_core.c      | 12 ++++++++++++
> >  drivers/net/can/usb/gs_usb.c                     |  8 ++++++++
> >  drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 12 ++++++++++++
> >  drivers/net/can/usb/mcba_usb.c                   | 12 ++++++++++++
> >  drivers/net/can/usb/peak_usb/pcan_usb_core.c     |  6 ++++++
> >  drivers/net/can/usb/peak_usb/pcan_usb_core.h     |  2 ++
> >  drivers/net/can/usb/peak_usb/pcan_usb_fd.c       |  1 +
> >  drivers/net/can/usb/peak_usb/pcan_usb_pro.c      |  1 +
> >  drivers/net/can/usb/ucan.c                       | 12 ++++++++++++
> >  drivers/net/can/usb/usb_8dev.c                   | 12 ++++++++++++
> >  drivers/net/can/vcan.c                           | 12 ++++++++++++
> >  drivers/net/can/vxcan.c                          | 12 ++++++++++++
> >  drivers/net/can/xilinx_can.c                     | 12 ++++++++++++
> >  39 files changed, 414 insertions(+)

(...)

> > diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
> > index d1562f9474c9..1b86001c85f8 100644
> > --- a/drivers/net/can/slcan/slcan-core.c
> > +++ b/drivers/net/can/slcan/slcan-core.c
> > @@ -46,6 +46,7 @@
> >  #include <linux/string.h>
> >  #include <linux/tty.h>
> >  #include <linux/errno.h>
> > +#include <linux/ethtool.h>
> >  #include <linux/netdevice.h>
> >  #include <linux/skbuff.h>
> >  #include <linux/rtnetlink.h>
> > @@ -790,6 +791,16 @@ static const struct net_device_ops slc_netdev_ops = {
> >         .ndo_change_mtu         = slcan_change_mtu,
> >  };
> >
> > +static void slcan_get_drvinfo(struct net_device *netdev,
> > +                             struct ethtool_drvinfo *drvinfo)
> > +{
> > +       strscpy(drvinfo->driver, DRV_NAME, sizeof(drvinfo->driver));
> > +}
> > +
>
> Please put the function inside the slcan-ethtool.c.
>
> > +static const struct ethtool_ops slcan_ethtool_ops = {
> > +       .get_drvinfo = slcan_get_drvinfo,
> > +};
> > +
>
> slcan_ethtool_ops is is already defined in slcan-ethtool.c
>
> >  /******************************************
> >   *  Routines looking at TTY side.
> >   ******************************************/
> > @@ -869,6 +880,7 @@ static struct slcan *slc_alloc(void)
> >
> >         snprintf(dev->name, sizeof(dev->name), DRV_NAME "%d", i);
> >         dev->netdev_ops = &slc_netdev_ops;
> > +       dev->ethtool_ops = &slcan_ethtool_ops;
> >         dev->base_addr  = i;
> >         slcan_set_ethtool_ops(dev);
>
> It already sets dev->ethtool_ops.

Indeed. I did not realise this. I was looking for an assignment on
dev->ethtool_ops and missed the call to slcan_set_ethtool_ops().

I am not convinced by the slcan_set_ethtool_ops(). It introduces a
function call for no specific reasons. Instead, I am thinking to just
export slcan_ethtool_ops like that:


diff --git a/drivers/net/can/slcan/slcan-core.c
b/drivers/net/can/slcan/slcan-core.c
index d4dbeb849432..c98567c711ae 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -868,8 +868,8 @@ static struct slcan *slc_alloc(void)

        snprintf(dev->name, sizeof(dev->name), "slcan%d", i);
        dev->netdev_ops = &slc_netdev_ops;
+       dev->ethtool_ops = &slcan_ethtool_ops;
        dev->base_addr  = i;
-       slcan_set_ethtool_ops(dev);
        sl = netdev_priv(dev);

        /* Initialize channel control data */
diff --git a/drivers/net/can/slcan/slcan-ethtool.c
b/drivers/net/can/slcan/slcan-ethtool.c
index bf0afdc4e49d..328ae1fb065b 100644
--- a/drivers/net/can/slcan/slcan-ethtool.c
+++ b/drivers/net/can/slcan/slcan-ethtool.c
@@ -52,14 +52,9 @@ static int slcan_get_sset_count(struct net_device
*netdev, int sset)
        }
 }

-static const struct ethtool_ops slcan_ethtool_ops = {
+const struct ethtool_ops slcan_ethtool_ops = {
        .get_strings = slcan_get_strings,
        .get_priv_flags = slcan_get_priv_flags,
        .set_priv_flags = slcan_set_priv_flags,
        .get_sset_count = slcan_get_sset_count,
 };
-
-void slcan_set_ethtool_ops(struct net_device *netdev)
-{
-       netdev->ethtool_ops = &slcan_ethtool_ops;
-}
diff --git a/drivers/net/can/slcan/slcan.h b/drivers/net/can/slcan/slcan.h
index d463c8d99e22..85cedf856db3 100644
--- a/drivers/net/can/slcan/slcan.h
+++ b/drivers/net/can/slcan/slcan.h
@@ -13,6 +13,7 @@

 bool slcan_err_rst_on_open(struct net_device *ndev);
 int slcan_enable_err_rst_on_open(struct net_device *ndev, bool on);
-void slcan_set_ethtool_ops(struct net_device *ndev);
+
+extern const struct ethtool_ops slcan_ethtool_ops;

 #endif /* _SLCAN_H */



Does it make sense?


Yours sincerely,
Vincent Mailhol
