Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79201577670
	for <lists+linux-can@lfdr.de>; Sun, 17 Jul 2022 15:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiGQNsN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 17 Jul 2022 09:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGQNsM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 17 Jul 2022 09:48:12 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819A2120BD
        for <linux-can@vger.kernel.org>; Sun, 17 Jul 2022 06:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658065690;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=2fseyuMa9+zMocqp/R3ujX6b3gfqPFi8oJ0bnmvACNA=;
    b=VhJar7KxJkc3qZjtyxlv/UAQvU8xAOEs1e9wNAY1VLiemwN/N/ESA+njh0chBm7GGu
    Hfx/tpEqQLXU2+g+sTZaPcQKsTMbHMfXljoWgSc7882FKfeoN29CEEotvtVOUpo8UIGO
    isRJ4R/b+poRIg8ImXMB4ptD2Uho9xmaH+diBAydDIA23z3NO6iRkPMYGX0nrU6430no
    ULwNge6kft8I6jTAuNu1TmyVuX6deOBNrn/87p3Xlw/fyzP3CwJfOfkEzEtYx9TCsAqk
    Z8aa5LDon010qUym63StjVwhNLo96HyLzzJwruE+Tt3D8rLeo/cYm61Ni0l71gt7VwyJ
    Gtbw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6HDm9B8m
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate)
    for <linux-can@vger.kernel.org>;
    Sun, 17 Jul 2022 15:48:09 +0200 (CEST)
Message-ID: <a466b119-4eeb-e215-c350-1fb44654ca4d@hartkopp.net>
Date:   Sun, 17 Jul 2022 15:48:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v3 5/5] can: raw: add CAN XL support
Content-Language: en-US
To:     linux-can <linux-can@vger.kernel.org>
References: <20220717132730.30295-1-socketcan@hartkopp.net>
 <20220717132730.30295-6-socketcan@hartkopp.net>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20220717132730.30295-6-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 17.07.22 15:27, Oliver Hartkopp wrote:
> Enable CAN_RAW sockets to read and write CAN XL frames analogue to the
> CAN FD extension (new CAN_RAW_XL_FRAMES sockopt).
> 
> A CAN XL network interface is capable to handle Classical CAN, CAN FD and
> CAN XL frames. When CAN_RAW_XL_FRAMES is enabled, the CAN_RAW socket checks
> whether the addressed CAN network interface is capable to handle the
> provided CAN frame.
> 
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>   include/uapi/linux/can/raw.h |  6 +++
>   net/can/raw.c                | 90 ++++++++++++++++++++++++++++++++----
>   2 files changed, 86 insertions(+), 10 deletions(-)
> 
> diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/raw.h
> index 3386aa81fdf2..0c55d48ae867 100644
> --- a/include/uapi/linux/can/raw.h
> +++ b/include/uapi/linux/can/raw.h
> @@ -60,8 +60,14 @@ enum {
>   	CAN_RAW_ERR_FILTER,	/* set filter for error frames       */
>   	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
>   	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
>   	CAN_RAW_FD_FRAMES,	/* allow CAN FD frames (default:off) */
>   	CAN_RAW_JOIN_FILTERS,	/* all filters must match to trigger */
> +	CAN_RAW_XL_FRAMES,	/* allow CAN XL frames (default:off) */
>   };
>   
> +/* CAN XL data transfer modes for CAN_RAW_XL_FRAMES sockopt */
> +#define CAN_RAW_XL_ENABLE (1 << 0) /* enable CAN XL frames on this socket */
> +#define CAN_RAW_XL_RX_DYN (1 << 1) /* allow truncated data[] for read() */
> +#define CAN_RAW_XL_TX_DYN (1 << 2) /* allow truncated data[] for write() */

s/allow/enable/

When CAN_RAW_XL_TX_DYN is enabled the truncated data size is enforced. 
So there is no mix of truncated/fixed CAN XL frames allowed ...

Regards,
Oliver
