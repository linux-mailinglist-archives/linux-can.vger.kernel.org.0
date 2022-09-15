Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB685B93DD
	for <lists+linux-can@lfdr.de>; Thu, 15 Sep 2022 07:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiIOFOA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 15 Sep 2022 01:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiIOFN7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 15 Sep 2022 01:13:59 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032FC7C74D
        for <linux-can@vger.kernel.org>; Wed, 14 Sep 2022 22:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1663218835;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=deZxvFPiYyFFHHZs45jrUfVAF4V3glzAUV0J4ALbs80=;
    b=Z05jMO9pjcEQQB0cCNRHS2wU9SaET+wagWQFJRXu7DrZHHwKvNTRluN2f5jmrZF/wN
    3jJZCozQ107eeHTjcq4HmITMB7+oEYIntJcmjwb8pF0gymIrfKMRcHsyrv0SF4yVyD1H
    x2hkLZQRaEMU51/2qzuNNe24LlTGebO256IMfq0sVQu4qgH8q0ti6IwKzbQyrPvXafYy
    HZ259ejJRVyo44GDEUzh9uV/hWSMfLr/vpxdiiY0C6CRaMfZaZoB8HqUf7gZjij5SJ5K
    ox2bF1CcbxExMvIyCGX8cx0fzb9hFm/1uXkmAqcuTNErZFkNhlECnbZ6c+h8AzDMKib0
    w5aw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytISr6hZqJAw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d104::923]
    by smtp.strato.de (RZmta 48.1.0 AUTH)
    with ESMTPSA id d25a93y8F5DtBQV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 15 Sep 2022 07:13:55 +0200 (CEST)
Message-ID: <85091fff-f8c6-efc5-eb40-17166e8734fe@hartkopp.net>
Date:   Thu, 15 Sep 2022 07:13:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v9 0/7] can: support CAN XL
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
References: <20220912170725.120748-1-socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20220912170725.120748-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

since we missed the 6.0 merge window end of July there has been no 
functional change to this patch set.

We are now at 6.0-rc5 again and I would like to extend the CI/test and 
usage coverage in net-next and other linux-next trees for these changes.

Can you please upstream this patch set when there are no more remarks 
from your side either?

Many thanks,
Oliver

On 12.09.22 19:07, Oliver Hartkopp wrote:
> The CAN with eXtended data Length (CAN XL) is a new CAN protocol with a
> 10Mbit/s data transfer with a new physical layer transceiver (for this
> data section). CAN XL allows up to 2048 byte of payload and shares the
> arbitration principle (11 bit priority) known from Classical CAN and
> CAN FD. RTR and 29 bit identifiers are not implemented in CAN XL.
> 
> A short introdution to CAN XL can be found here:
> https://www.can-cia.org/can-knowledge/can/can-xl/
> https://github.com/linux-can/can-doc/blob/master/presentations/CAN-XL-Intro.pdf
> 
> V2: Major rework after discussion and feedback on Linux-CAN ML
> 
> - rework of struct canxl_frame
> - CANXL_XLF flag is now the switch between CAN XL and CAN/CANFD
> - variable length in r/w operations for CAN XL frames
> - write CAN XL frame to raw socket enforces size <-> canxl_frame.len sync
> 
> V3: Fix length for CAN XL frames inside the sk_buff
> 
> - extend the CAN_RAW sockopt to handle fixed/truncated read/write operations
> 
> V4: Fix patch 5 (can: raw: add CAN XL support)
> 
> - fix return value (move 'err = -EINVAL' in raw_sendmsg())
> - add CAN XL frame handling in can_rcv()
> - change comment for CAN_RAW_XL_[RT]X_DYN definition (allow -> enable)
> 
> V5: Remove CAN_RAW_XL_[RT]X_DYN definition again
> 
> - CAN_RAW_XL_[RT]X_DYN (truncated data) feature is now enabled by default
> - use CANXL_MIN_DLEN instead of '1' in canxl_frame definition
> - add missing 'err = -EINVAL' initialization in raw_sendmsg())
> 
> V6:
> 
> - rework an separate skb identification and length helpers
> - add CANFD_FDF flag in all CAN FD frame structures
> - simplify patches for infrastructure and raw sockets
> - add vxcan support in virtual CAN interface patch
> 
> V7:
> 
> - fixed indention as remarked by Marc
> - set CANFD_FDF flag when detecting CAN FD frames generated by PF_PACKET
> - Allow to use variable CAN XL MTU sizes to enforce real time requirements
>    on CAN XL segments (e.g. to support of CAN CiA segmentation concept)
> 
> V8:
> 
> - fixed typo as remarked by Vincent
> - rebased to latest can-next/net-next tree
> 
> V9:
> 
> - rebased to latest can-next/net-next tree
> - updated and extended public available CAN XL documenatation in cover letter
> - renamed struct canxl_frame variable cfx to cxl as suggested by Vincent
> - Added Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr> tag
> 
> Oliver Hartkopp (7):
>    can: skb: unify skb CAN frame identification helpers
>    can: skb: add skb CAN frame data length helpers
>    can: set CANFD_FDF flag in all CAN FD frame structures
>    can: canxl: introduce CAN XL data structure
>    can: canxl: update CAN infrastructure for CAN XL frames
>    can: dev: add CAN XL support to virtual CAN
>    can: raw: add CAN XL support
> 
>   drivers/net/can/ctucanfd/ctucanfd_base.c |   1 -
>   drivers/net/can/dev/rx-offload.c         |   2 +-
>   drivers/net/can/dev/skb.c                | 113 ++++++++++++++++-------
>   drivers/net/can/vcan.c                   |  12 +--
>   drivers/net/can/vxcan.c                  |   8 +-
>   include/linux/can/dev.h                  |   5 +
>   include/linux/can/skb.h                  |  57 +++++++++++-
>   include/uapi/linux/can.h                 |  55 ++++++++++-
>   include/uapi/linux/can/raw.h             |   1 +
>   include/uapi/linux/if_ether.h            |   1 +
>   net/can/af_can.c                         |  76 ++++++++-------
>   net/can/bcm.c                            |   9 +-
>   net/can/gw.c                             |   4 +-
>   net/can/isotp.c                          |   2 +-
>   net/can/j1939/main.c                     |   4 +
>   net/can/raw.c                            |  55 ++++++++---
>   16 files changed, 299 insertions(+), 106 deletions(-)
> 
