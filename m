Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753935B4C90
	for <lists+linux-can@lfdr.de>; Sun, 11 Sep 2022 10:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIKIIU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 11 Sep 2022 04:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIKIIT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 11 Sep 2022 04:08:19 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FE83D5B3
        for <linux-can@vger.kernel.org>; Sun, 11 Sep 2022 01:08:18 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-345528ceb87so66388227b3.11
        for <linux-can@vger.kernel.org>; Sun, 11 Sep 2022 01:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KaqjC5yrTpOoDmXNQ90LCKljBOLWWu62YDbl5hBErVw=;
        b=3sBenh8QmaCWTpqeF94b+iAIk3RnzZYocNrPNY5ufokgaDqYFdKgy0xx2tp7EpuuVT
         71UoGHUE/7ByreptxtritNHh0SjLLh3qaHLI9GqlgYPbg1P05gcBJLxr/VUfx5wXNTA/
         K0qFz8dXf/x1RnVQrw/sEO6QtYVUV8nEyI1iRVGxXO7Kb1WubMedRzQmJ8pcYW+AC/5s
         BUaqZL3b/PdiPFHNgtrFGUT5cBPQyM6vk604lMnEniB/qnK6Y/dbLtxkQMoZzUY5abN9
         mthWRAdZMj0l50uX0ATl+zNCq1ArDMSV4tSUhH4KRCYA5x9nZ+i9BDtZKVoKMMJ8ABMj
         MSpQ==
X-Gm-Message-State: ACgBeo2HB1537dvpJu1nnPXnJg7OaAc5VggwXsu0vb4hzxEi10c5tVVf
        cuAf5KTRC+dBqjTYwDXU9PbRFYhq2wYKY+IXh6wAw5vb94U=
X-Google-Smtp-Source: AA6agR5f096zKiD2Wo8qkFIhslViVlLOurg8/d/KS6BjWQV5cohBrBM5iiYjBpj6fPTH+lw5qKpRP7poeyp+zi0eglo=
X-Received: by 2002:a81:7488:0:b0:345:16f2:e1e1 with SMTP id
 p130-20020a817488000000b0034516f2e1e1mr18145098ywc.45.1662883697538; Sun, 11
 Sep 2022 01:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220801190010.3344-1-socketcan@hartkopp.net> <27076536-8f8b-8e6a-60ac-a5bbb1bb48cd@hartkopp.net>
In-Reply-To: <27076536-8f8b-8e6a-60ac-a5bbb1bb48cd@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 11 Sep 2022 17:08:06 +0900
Message-ID: <CAMZ6RqJt-X52xOnge3VhnCgDReWw46npB7U5yqP08NjG=5ST_g@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] can: support CAN XL
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oliver,

On Wed. 31 Aug. 2022 at 20:57, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Hi Vincent,
>
> I have discussed with Marc about this patch set and after our discussion
> about len/flags he was missing an ACK from your side:
>
> https://lore.kernel.org/linux-can/247226f6-b9b5-ec47-2234-d1cc70ee6954@hartkopp.net/T/#u
>
> Are you fine with this V8 patch set now?
>
> I already created some CAN CiA p-o-c code for CAN XL segmentation:
>
> https://github.com/hartkopp/can-cia-613-3-poc
>
> When the patch set is committed and the definitions are fixed I would
> also start with some documentation.

Sorry for the delay, it was tough to find time for the final review.

> On 01.08.22 21:00, Oliver Hartkopp wrote:
> > The CAN with eXtended data Length (CAN XL) is a new CAN protocol with a
> > 10Mbit/s data transfer with a new physical layer transceiver (for this
> > data section). CAN XL allows up to 2048 byte of payload and shares the
> > arbitration principle (11 bit priority) known from Classical CAN and
> > CAN FD. RTR and 29 bit identifiers are not implemented in CAN XL.
> >
> > A short introdution to CAN XL can be found here:
> > https://www.bosch-semiconductors.com/media/ip_modules/pdf_2/can_xl_1/canxl_intro_20210225.pdf
> >
> > V2: Major rework after discussion and feedback on Linux-CAN ML
> >
> > - rework of struct canxl_frame
> > - CANXL_XLF flag is now the switch between CAN XL and CAN/CANFD
> > - variable length in r/w operations for CAN XL frames
> > - write CAN XL frame to raw socket enforces size <-> canxl_frame.len sync
> >
> > V3: Fix length for CAN XL frames inside the sk_buff
> >
> > - extend the CAN_RAW sockopt to handle fixed/truncated read/write operations
> >
> > V4: Fix patch 5 (can: raw: add CAN XL support)
> >
> > - fix return value (move 'err = -EINVAL' in raw_sendmsg())
> > - add CAN XL frame handling in can_rcv()
> > - change comment for CAN_RAW_XL_[RT]X_DYN definition (allow -> enable)
> >
> > V5: Remove CAN_RAW_XL_[RT]X_DYN definition again
> >
> > - CAN_RAW_XL_[RT]X_DYN (truncated data) feature is now enabled by default
> > - use CANXL_MIN_DLEN instead of '1' in canxl_frame definition
> > - add missing 'err = -EINVAL' initialization in raw_sendmsg())
> >
> > V6:
> >
> > - rework an separate skb identification and length helpers
> > - add CANFD_FDF flag in all CAN FD frame structures
> > - simplify patches for infrastructure and raw sockets
> > - add vxcan support in virtual CAN interface patch
> >
> > V7:
> >
> > - fixed indention as remarked by Marc
> > - set CANFD_FDF flag when detecting CAN FD frames generated by PF_PACKET
> > - Allow to use variable CAN XL MTU sizes to enforce real time requirements
> >    on CAN XL segments (e.g. to support of CAN CiA segmentation concept)
> >
> > V8:
> >
> > - fixed typo as remarked by Vincent
> > - rebased to latest can-next/net-next tree
> >
> > Oliver Hartkopp (7):
> >    can: skb: unify skb CAN frame identification helpers
> >    can: skb: add skb CAN frame data length helpers
> >    can: set CANFD_FDF flag in all CAN FD frame structures
> >    can: canxl: introduce CAN XL data structure

As pointed out in the past, I still prefer to make canxl_fame::data a
flexible array (data[]) instead of specifying the maximum length (i.e.
data[CANXL_MAX_DLEN]). But as no one else manifested any objections on
the mailing, I conclude that the majority is either fine with the
data[CANXL_MAX_DLEN] or indifferent. Thus, I will acknowledge this
patch despite having a different personal opinion on the topic.

> >    can: canxl: update CAN infrastructure for CAN XL frames
> >    can: dev: add CAN XL support to virtual CAN
> >    can: raw: add CAN XL support

I send two additional comments for patches 3 and 5. Those two last
comments being minor ones, I let you directly handle those. With that
said:

Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

(valid for the full series, you can directly add this to the v9).

> >   drivers/net/can/ctucanfd/ctucanfd_base.c |   1 -
> >   drivers/net/can/dev/rx-offload.c         |   2 +-
> >   drivers/net/can/dev/skb.c                | 113 ++++++++++++++++-------
> >   drivers/net/can/vcan.c                   |  12 +--
> >   drivers/net/can/vxcan.c                  |   8 +-
> >   include/linux/can/dev.h                  |   5 +
> >   include/linux/can/skb.h                  |  57 +++++++++++-
> >   include/uapi/linux/can.h                 |  55 ++++++++++-
> >   include/uapi/linux/can/raw.h             |   1 +
> >   include/uapi/linux/if_ether.h            |   1 +
> >   net/can/af_can.c                         |  76 ++++++++-------
> >   net/can/bcm.c                            |   9 +-
> >   net/can/gw.c                             |   4 +-
> >   net/can/isotp.c                          |   2 +-
> >   net/can/j1939/main.c                     |   4 +
> >   net/can/raw.c                            |  55 ++++++++---
> >   16 files changed, 299 insertions(+), 106 deletions(-)

Yours sincerely,
Vincent Mailhol
