Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6372F3F4377
	for <lists+linux-can@lfdr.de>; Mon, 23 Aug 2021 04:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhHWCpt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 22 Aug 2021 22:45:49 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:44827 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhHWCpt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 22 Aug 2021 22:45:49 -0400
Received: by mail-lf1-f43.google.com with SMTP id o10so34766646lfr.11;
        Sun, 22 Aug 2021 19:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mbK/UgdvWlB0r8wPRNh0W1omuBWpyVkGhL441rjE87Q=;
        b=BBSXQR/pcKmAssFMas4tWrQq1blEV1l3FL9uhKxY8rrwcfD6HkpQxCKlc8rQH71Qn5
         87VZCN0QSy0rTixRRmTWi7WA3HXRFV+bSKcsxA1nhkwtTJnI7kdJAjp0JY5Zg+j0IjOb
         Uc2Tf58KMJzgEaCzPvxMw14ePzvvBzkcgrPE6Nh2b7bqpOhyn/KLH6nmf96XNCoUchvs
         XY+TTNd5emcJ3bCKW67Gb1SKIOrHs/NlT0j6rXc9qhXadymjjVs/hmYxcsQBsJZX5Joc
         MEqEMkEzvuBZJgh4U2FBnuegO37ndnq3rBZjOqQhmoKbba2RscDhzXBqzXnifTYuQ5c5
         9d3A==
X-Gm-Message-State: AOAM530QpUIZ9z+RgqxaCfB01/Jq8YeKJyv9N6J3VDuJJHmBuzh2Hatn
        SRH+RXFfQ17tEnTExbHYDoGo008FgjVwga9aCPA=
X-Google-Smtp-Source: ABdhPJzGhViTxU0zJAHS0NwR9ucCqmvHx/OvqAj8cNKzR0mUvSrTKmgV2ZpmjudEi0B9REQ2pIyVlnyFJ3oB62yUUDk=
X-Received: by 2002:ac2:5ec7:: with SMTP id d7mr23091487lfq.234.1629686706217;
 Sun, 22 Aug 2021 19:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210820090313.299483-1-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20210820090313.299483-1-mailhol.vincent@wanadoo.fr>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 23 Aug 2021 11:44:54 +0900
Message-ID: <CAMZ6RqKHKEf0CqvyzsK9awNEpBV7azn_EjEC=NOC_=8TBWr8NQ@mail.gmail.com>
Subject: Re: [PATCH] can: netlink: prevent incoherent can configuration in
 case of early return
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Cc:     netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Replying to myself...

On Fri. 20 Aug 2021 at 18:03, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
> struct can_priv has a set of flags (can_priv::ctrlmode) which are
> correlated with the other field of the structure. In can_changelink(),
> those flags are set first and copied to can_priv. If the function has
> to return early, for example due to an out of range value provided by
> the user, then the global configuration might become incoherent.
>
> Example: the user provides an out of range dbitrate (e.g. 20
> Mbps). The command fails (-EINVAL), however the FD flag was already
> set resulting in a configuration where FD is on but the databittiming
> parameters are empty.
>
> Illustration of above example:
>
> | $ ip link set can0 type can bitrate 500000 dbitrate 20000000 fd on
> | RTNETLINK answers: Invalid argument
> | $ ip --details link show can0
> | 1: can0: <NOARP,ECHO> mtu 72 qdisc noop state DOWN mode DEFAULT group default qlen 10
> |     link/can  promiscuity 0 minmtu 0 maxmtu 0
> |     can <FD> state STOPPED restart-ms 0
>            ^^ FD flag is set without any of the databittiming parameters...
> |         bitrate 500000 sample-point 0.875
> |         tq 12 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 1
> |         ES582.1/ES584.1: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp-inc 1
> |         ES582.1/ES584.1: dtseg1 2..32 dtseg2 1..16 dsjw 1..8 dbrp 1..32 dbrp-inc 1
> |         clock 80000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
>
> To prevent this from happening, we do a local copy of can_priv, work
> on it, an copy it at the very end of the function (i.e. only if all
> previous checks succeeded).
>
> Once this done, there is no more need to have a temporary variable for
> a specific parameter. As such, the bittiming and data bittiming (bt
> and dbt) are directly written to the temporary priv variable.
>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> Hi Marc,
>
> Do you think this need a "Fixes" tag?
> If yes, feel free to add this line to the patch:
>
> Fixes: 9859ccd2c8be ("can: introduce the data bitrate configuration for CAN FD")
> ---
>  drivers/net/can/dev/netlink.c | 86 ++++++++++++++++++-----------------
>  1 file changed, 45 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 80425636049d..6a14c51a058b 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -58,14 +58,20 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>                           struct nlattr *data[],
>                           struct netlink_ext_ack *extack)
>  {
> -       struct can_priv *priv = netdev_priv(dev);
> +       /* Work on a local copy of priv to prevent inconsistent value
> +        * in case of early return. net/core/rtnetlink.c has a global
> +        * mutex so static declaration is OK
> +        */
> +       static struct can_priv priv;
>         int err;
>
>         /* We need synchronization with dev->stop() */
>         ASSERT_RTNL();
>
> +       memcpy(&priv, netdev_priv(dev), sizeof(priv));
> +
>         if (data[IFLA_CAN_BITTIMING]) {
> -               struct can_bittiming bt;
> +               struct can_bittiming *bt = &priv.bittiming;
>
>                 /* Do not allow changing bittiming while running */
>                 if (dev->flags & IFF_UP)
> @@ -76,28 +82,26 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>                  * directly via do_set_bitrate(). Bail out if neither
>                  * is given.
>                  */
> -               if (!priv->bittiming_const && !priv->do_set_bittiming)
> +               if (!priv.bittiming_const && !priv.do_set_bittiming)
>                         return -EOPNOTSUPP;
>
> -               memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
> -               err = can_get_bittiming(dev, &bt,
> -                                       priv->bittiming_const,
> -                                       priv->bitrate_const,
> -                                       priv->bitrate_const_cnt);
> +               memcpy(bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(*bt));
> +               err = can_get_bittiming(dev, bt,
> +                                       priv.bittiming_const,
> +                                       priv.bitrate_const,
> +                                       priv.bitrate_const_cnt);
>                 if (err)
>                         return err;
>
> -               if (priv->bitrate_max && bt.bitrate > priv->bitrate_max) {
> +               if (priv.bitrate_max && bt->bitrate > priv.bitrate_max) {
>                         netdev_err(dev, "arbitration bitrate surpasses transceiver capabilities of %d bps\n",
> -                                  priv->bitrate_max);
> +                                  priv.bitrate_max);
>                         return -EINVAL;
>                 }
>
> -               memcpy(&priv->bittiming, &bt, sizeof(bt));
> -
> -               if (priv->do_set_bittiming) {
> +               if (priv.do_set_bittiming) {
>                         /* Finally, set the bit-timing registers */
> -                       err = priv->do_set_bittiming(dev);
> +                       err = priv.do_set_bittiming(dev);
>                         if (err)
>                                 return err;
>                 }
> @@ -112,11 +116,11 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>                 if (dev->flags & IFF_UP)
>                         return -EBUSY;
>                 cm = nla_data(data[IFLA_CAN_CTRLMODE]);
> -               ctrlstatic = priv->ctrlmode_static;
> +               ctrlstatic = priv.ctrlmode_static;
>                 maskedflags = cm->flags & cm->mask;
>
>                 /* check whether provided bits are allowed to be passed */
> -               if (maskedflags & ~(priv->ctrlmode_supported | ctrlstatic))
> +               if (maskedflags & ~(priv.ctrlmode_supported | ctrlstatic))
>                         return -EOPNOTSUPP;
>
>                 /* do not check for static fd-non-iso if 'fd' is disabled */
> @@ -128,16 +132,16 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>                         return -EOPNOTSUPP;
>
>                 /* clear bits to be modified and copy the flag values */
> -               priv->ctrlmode &= ~cm->mask;
> -               priv->ctrlmode |= maskedflags;
> +               priv.ctrlmode &= ~cm->mask;
> +               priv.ctrlmode |= maskedflags;
>
>                 /* CAN_CTRLMODE_FD can only be set when driver supports FD */
> -               if (priv->ctrlmode & CAN_CTRLMODE_FD) {
> +               if (priv.ctrlmode & CAN_CTRLMODE_FD) {
>                         dev->mtu = CANFD_MTU;
>                 } else {
>                         dev->mtu = CAN_MTU;
> -                       memset(&priv->data_bittiming, 0,
> -                              sizeof(priv->data_bittiming));
> +                       memset(&priv.data_bittiming, 0,
> +                              sizeof(priv.data_bittiming));
>                 }
>         }
>
> @@ -145,7 +149,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>                 /* Do not allow changing restart delay while running */
>                 if (dev->flags & IFF_UP)
>                         return -EBUSY;
> -               priv->restart_ms = nla_get_u32(data[IFLA_CAN_RESTART_MS]);
> +               priv.restart_ms = nla_get_u32(data[IFLA_CAN_RESTART_MS]);
>         }
>
>         if (data[IFLA_CAN_RESTART]) {
> @@ -158,7 +162,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>         }
>
>         if (data[IFLA_CAN_DATA_BITTIMING]) {
> -               struct can_bittiming dbt;
> +               struct can_bittiming *dbt = &priv.data_bittiming;
>
>                 /* Do not allow changing bittiming while running */
>                 if (dev->flags & IFF_UP)
> @@ -169,31 +173,29 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>                  * directly via do_set_bitrate(). Bail out if neither
>                  * is given.
>                  */
> -               if (!priv->data_bittiming_const && !priv->do_set_data_bittiming)
> +               if (!priv.data_bittiming_const && !priv.do_set_data_bittiming)
>                         return -EOPNOTSUPP;
>
> -               memcpy(&dbt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
> -                      sizeof(dbt));
> -               err = can_get_bittiming(dev, &dbt,
> -                                       priv->data_bittiming_const,
> -                                       priv->data_bitrate_const,
> -                                       priv->data_bitrate_const_cnt);
> +               memcpy(dbt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
> +                      sizeof(*dbt));
> +               err = can_get_bittiming(dev, dbt,
> +                                       priv.data_bittiming_const,
> +                                       priv.data_bitrate_const,
> +                                       priv.data_bitrate_const_cnt);
>                 if (err)
>                         return err;
>
> -               if (priv->bitrate_max && dbt.bitrate > priv->bitrate_max) {
> +               if (priv.bitrate_max && dbt->bitrate > priv.bitrate_max) {
>                         netdev_err(dev, "canfd data bitrate surpasses transceiver capabilities of %d bps\n",
> -                                  priv->bitrate_max);
> +                                  priv.bitrate_max);
>                         return -EINVAL;
>                 }
>
> -               memcpy(&priv->data_bittiming, &dbt, sizeof(dbt));
> -
>                 can_calc_tdco(dev);

can_calc_tdco() retrieves can_priv from the network device and
directly writes its changes to it. I will send a v2 in which I
will change the prototype of can_calc_tdco() so that the changes
are written to the temporary priv instead.

> -               if (priv->do_set_data_bittiming) {
> +               if (priv.do_set_data_bittiming) {
>                         /* Finally, set the bit-timing registers */
> -                       err = priv->do_set_data_bittiming(dev);
> +                       err = priv.do_set_data_bittiming(dev);
>                         if (err)
>                                 return err;
>                 }
> @@ -201,28 +203,30 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>
>         if (data[IFLA_CAN_TERMINATION]) {
>                 const u16 termval = nla_get_u16(data[IFLA_CAN_TERMINATION]);
> -               const unsigned int num_term = priv->termination_const_cnt;
> +               const unsigned int num_term = priv.termination_const_cnt;
>                 unsigned int i;
>
> -               if (!priv->do_set_termination)
> +               if (!priv.do_set_termination)
>                         return -EOPNOTSUPP;
>
>                 /* check whether given value is supported by the interface */
>                 for (i = 0; i < num_term; i++) {
> -                       if (termval == priv->termination_const[i])
> +                       if (termval == priv.termination_const[i])
>                                 break;
>                 }
>                 if (i >= num_term)
>                         return -EINVAL;
>
>                 /* Finally, set the termination value */
> -               err = priv->do_set_termination(dev, termval);
> +               err = priv.do_set_termination(dev, termval);
>                 if (err)
>                         return err;
>
> -               priv->termination = termval;
> +               priv.termination = termval;
>         }
>
> +       memcpy(netdev_priv(dev), &priv, sizeof(priv));
> +
>         return 0;
>  }

Yours sincerely,
Vincent Mailhol
