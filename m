Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DDB5822AF
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 11:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiG0JFa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 05:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiG0JF2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 05:05:28 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9C143306
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 02:05:27 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id z132so10369483yba.3
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 02:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFBMfGT4OltIzhibguDimQkyPHoLX7DJYDR7NOt+V68=;
        b=cagpsW9Pjoa024QUv2tipgqRc6xD6BXjdgmoaWGrb10NUY8cJbc7fWIngnszwCmH4T
         KT1jIGvL3kqeW8LZyKqfJodeeOi9O4uBdykrhdvNMs2J2YVA07V+D1q6t+nmpnrjnkjn
         78beI3RmkCQZ66dY0fPJLNdNBwnNsSQNh0KmTGm9gUiEs9GOwUyjVI4MmI6f6HkQCtvn
         t4fcZ7T/vdp5rROG0DIZJN70/3p1Zca3aIiU3rKkhwtxyqmAl+6xFfgxj6M3SlwOonWm
         3QgTtdpHsdtCSuaQ56oXN8z17ec/cyrQuogKaX+uWdYaHnTSZq3EoUx6l5eC5afMtACo
         uzwg==
X-Gm-Message-State: AJIora/Pyjo6IiCd+gX/VWjNpjwWL9raBpX6Kp4Zu2pgKRLnRb3PujpX
        WHGnynvWl9JWv3O5/fsu4jDP43BdWPQE8HXRVf9ZLDzAqSpM6Q==
X-Google-Smtp-Source: AGRyM1tTinQ9W57ugwf7E469xeCl7eoRxDujqD1sTJ13Jjv4MzrH6ulU3oO1k0Sd5fLJ8yjOVYFZU1xYxYvZpiHR86Y=
X-Received: by 2002:a25:3789:0:b0:671:6d58:f242 with SMTP id
 e131-20020a253789000000b006716d58f242mr6611063yba.142.1658912726362; Wed, 27
 Jul 2022 02:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220725133208.432176-11-mailhol.vincent@wanadoo.fr> <CABGWkvoqkETb0H-UWhwPCk1eMwQC2ExfKUXm25Mv4R5g0kjb+Q@mail.gmail.com>
 <CAMZ6Rq+Wd412aFSiuLsjPE=aT0UQVNqp9FEZCEkjdU71hVWR0Q@mail.gmail.com>
 <CABGWkvqA5p=h7fHabH4iKoppvrypedonEnLnohgm0j+Nm-70NA@mail.gmail.com>
 <CAMZ6RqLhPHzv_zdPsE2QHOD7RgxYEu+ttWJXgjNFkE5h-8z4DQ@mail.gmail.com> <20220727081933.yufxemvws3haj22y@pengutronix.de>
In-Reply-To: <20220727081933.yufxemvws3haj22y@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 27 Jul 2022 18:05:15 +0900
Message-ID: <CAMZ6RqKpV0_xhj=n5tE0Cm3+s00dR6LbvTWXsT3Y=r5wiFp9wA@mail.gmail.com>
Subject: Re: [PATCH v1 10/24] can: tree-wide: implement ethtool_ops::get_drvinfo()
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-can@vger.kernel.org,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Max Staudt <max@enpas.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 27 Jul. 2022 at 17:20, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 26.07.2022 18:59:18, Vincent MAILHOL wrote:
> > > > Does it make sense?
> > >
> > > I have already used this scheme in the c_can driver. I used this
> > > scheme because I saw that it was used a lot
> > > (git grep set_ethtool_ops) in the kernel.
> >
> > | $ git grep "void .*_set_ethtool_ops.*;" | wc -l
> > | 46
> > | $ git grep "extern const struct ethtool_ops" | wc -l
> > | 43
> >
> > I did not know it was a good practice, but you are right, both schemes
> > are roughly as popular (with yours slightly more popular by a small
> > margin).
> >
> > > By doing so you can define
> > > slcan_ethtool_ops as a static variable
> > > and if possible I prefer to export functions rather than data. But it
> > > can be a matter of taste.
> >
> > My taste is to export the data (to remove a function call), but as the
> > maintainer, your opinion should prevail here.
>
> I think with exporting the data instead of the function, the resulting
> module will be a bit smaller. As we don't use LTO by default there's no
> optimization between object files. The size of the resulting modules can
> be checked with:

Yes, the additional function call goes with additional assembly
instruction. I did not mention it but this goes in pairs.

> | ./scripts/bloat-o-meter old.o new.o

$ ./scripts/bloat-o-meter drivers/net/can/slcan/slcan.old.o
drivers/net/can/slcan/slcan.o
add/remove: 0/1 grow/shrink: 1/0 up/down: 15/-29 (-14)
Function                                     old     new   delta
slcan_open                                  1010    1025     +15
slcan_set_ethtool_ops                         29       -     -29
Total: Before=11115, After=11101, chg -0.13%

slcan.old.o is the current one which uses the set_ethtool_ops()
function, the slcan.o exports the structure instead.

It saves 14 bytes (and a function call).

> > And thanks for the explanation.
> >
> > I will also fix those two drivers:
> >
> > | $ git grep "void .*_set_ethtool_ops.*;" drivers/net/can/
> > | drivers/net/can/c_can/c_can.h:void c_can_set_ethtool_ops(struct
> > net_device *dev);
> > | drivers/net/can/flexcan/flexcan.h:void
> > flexcan_set_ethtool_ops(struct net_device *dev);
>
> In the mcp251xfd driver there is mcp251xfd_ethtool_init(). This function
> sets the ethtool_ops, but also initializes the parameters that can be
> configured by ethtool (ring layout and coalescing) to default values.

Yes, also the mcp251xfd is already fixed in v3.

> Other drivers that have a dedicated function that assigns ethtool_ops
> only can be optimized IMHO.

Yes, but this is not related to the timestamp series. So if I do it, I
will do it separately (and I do not commit that I will do it).


Yours sincerely,
Vincent Mailhol
