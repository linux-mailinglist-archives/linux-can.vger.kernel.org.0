Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C42562726A
	for <lists+linux-can@lfdr.de>; Sun, 13 Nov 2022 21:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiKMUGB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 13 Nov 2022 15:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiKMUGA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 13 Nov 2022 15:06:00 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3298264F2
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 12:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1668369953;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7xcS0bR9CYN9VqEwT+UOR6EHUN/ALlQpA/eknT7WwKE=;
    b=gZ12IzgFGs0dW9kmuiGKdd0LaLL1QrTdWSf3IwJtb7hTdgF0fBHMIcSRC99oG3ZXyv
    eg/JQZqmA35O9YcW8p43h9YVEpgmsgyDeo9MrDJlr7axsRDAzGx4ZkEh0BXe5tECatJD
    RAzRf2NDIyjCn2pPIaq9MwvJTBolO4QJU6ofHDgzvUZ+X30v1a2OHX26ZQEfghTlbFfm
    VU30agsO+ARgO2wYogtDbdepuZ4dS42cM+P6d0MmvCQSHUewGUtPWSkFvTvoH9p6mnIn
    K9qj9/+DR+uv+Rhd9dw0R+/4AnnQS2CS7tTCbepNEXsYEQOc960z4lwhjZog7CzQqwMK
    +w7w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytISr6hZqJAw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d104::923]
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id Dde783yADK5rlQX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 13 Nov 2022 21:05:53 +0100 (CET)
Message-ID: <ff95c43d-d620-0301-06c4-2824f4c686f6@hartkopp.net>
Date:   Sun, 13 Nov 2022 21:05:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH can-utils-dev 4/5] candump: use linux/net_tstamp.h instead
 of redefining values ourselves
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
References: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
 <20221113085321.87910-5-mailhol.vincent@wanadoo.fr>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20221113085321.87910-5-mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 13.11.22 09:53, Vincent Mailhol wrote:
> No need to redefine values when available in header.
> 
> linux/net_tstamp.h is available since Linux 2.6.30 while socket CAN
> was introduced in v2.6.25. These being old releases not being
> maintained any more for many years, dropping support is
> acceptable.
> 
> Regardless, candump already relies on some other macros defined in
> more recent kernel version (e.g. CAN_RAW_ERR_FILTER) meaning that it
> would not build on old linux kernel environments.

The patch is right but this text does not fit IMO.

We have a copy of net_tstamp.h in this repository to make sure we can 
always build the latest binaries with the latest kernel APIs even on 
older development environments/kernels.

Best regards,
Oliver

> 
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>   candump.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/candump.c b/candump.c
> index 4abd2f6..8f0ca46 100644
> --- a/candump.c
> +++ b/candump.c
> @@ -63,6 +63,7 @@
>   
>   #include <linux/can.h>
>   #include <linux/can/raw.h>
> +#include <linux/net_tstamp.h>
>   
>   #include "terminal.h"
>   #include "lib.h"
> @@ -72,10 +73,6 @@
>   #define SO_TIMESTAMPING 37
>   #endif
>   
> -/* from #include <linux/net_tstamp.h> - since Linux 2.6.30 */
> -#define SOF_TIMESTAMPING_SOFTWARE (1 << 4)
> -#define SOF_TIMESTAMPING_RX_SOFTWARE (1 << 3)
> -#define SOF_TIMESTAMPING_RAW_HARDWARE (1 << 6)
>   #define TIMESTAMPSZ 50 /* string 'absolute with date' requires max 49 bytes */
>   
>   #define MAXSOCK 16    /* max. number of CAN interfaces given on the cmdline */
