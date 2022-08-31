Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FC85A7C9D
	for <lists+linux-can@lfdr.de>; Wed, 31 Aug 2022 13:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiHaL4c (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 31 Aug 2022 07:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHaL43 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 31 Aug 2022 07:56:29 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F37D25D4
        for <linux-can@vger.kernel.org>; Wed, 31 Aug 2022 04:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1661946985;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VRWwMG0S+8PTjgXrNoxN9LPEyZuwRB3YhPekFwdpzJg=;
    b=a6/EhYX70edq8Z0dKfEU1nC3KwPK2IQs0OFP9bEz3j++f9d8pGWrtQMR2hVIjfFV9b
    Tq+kUWlaScZwZWSE/ivqlnsXcMoovsuYeyjIMg+s+fSi28PwWIIc9s9z//PrQA1EC6An
    N9lGcEKJCSj4WiaOVpG0kKql01V/DiRIomFd4i68DU4leZ2PdypptCqQVa1EWjLtwbYV
    lZCJc85FjO1TvdhmIFTq5W8uy+eFI8UDtqbC0KWHWxnigma/hXuDqIwKY4eS7CtxAX+A
    PQwGVcyCRzT+SVnF1o1UGiWaQT8+0V+cy8ynvD+ZSnlvORD50I/LsF3WEqgJ00DSG0it
    Bd8w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id Icb1b0y7VBuPSXq
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 31 Aug 2022 13:56:25 +0200 (CEST)
Message-ID: <27076536-8f8b-8e6a-60ac-a5bbb1bb48cd@hartkopp.net>
Date:   Wed, 31 Aug 2022 13:56:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v8 0/7] can: support CAN XL
Content-Language: en-US
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
References: <20220801190010.3344-1-socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20220801190010.3344-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Vincent,

I have discussed with Marc about this patch set and after our discussion 
about len/flags he was missing an ACK from your side:

https://lore.kernel.org/linux-can/247226f6-b9b5-ec47-2234-d1cc70ee6954@hartkopp.net/T/#u

Are you fine with this V8 patch set now?

I already created some CAN CiA p-o-c code for CAN XL segmentation:

https://github.com/hartkopp/can-cia-613-3-poc

When the patch set is committed and the definitions are fixed I would 
also start with some documentation.

Best regards,
Oliver

On 01.08.22 21:00, Oliver Hartkopp wrote:
> The CAN with eXtended data Length (CAN XL) is a new CAN protocol with a
> 10Mbit/s data transfer with a new physical layer transceiver (for this
> data section). CAN XL allows up to 2048 byte of payload and shares the
> arbitration principle (11 bit priority) known from Classical CAN and
> CAN FD. RTR and 29 bit identifiers are not implemented in CAN XL.
> 
> A short introdution to CAN XL can be found here:
> https://www.bosch-semiconductors.com/media/ip_modules/pdf_2/can_xl_1/canxl_intro_20210225.pdf
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
