Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10782FAB3A
	for <lists+linux-can@lfdr.de>; Mon, 18 Jan 2021 21:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394271AbhARURn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 18 Jan 2021 15:17:43 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:21562 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437992AbhARURa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 18 Jan 2021 15:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1611000864;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=mriw4STFgYCfxuLXyFMVmuv6EyEtOUxw2EZrB4Lb7aY=;
        b=Pn0s+aH81aiL+we1r3obs/iVgBOh0FMeE+pADlfOhjWPl/Gzi5Wy6VVAiDVgGKY3fC
        y2gitXKkO0RdO6UIoUxrmdhxY3urZVpk+UFmXd0gFNGgowci28wCz+NnlPbx4S7WDwBc
        5isFRvXAeg21K2NGkrq7g2wuhaSv/t0duttf19GUXnBhO+1W1jg7ZMRaU7prWd3FqiuR
        errjgdp+25DAopxL2w0tEaMvFROdykAYWBMExR6MGmtqBEGJrGsrZShi/f8gDVyf2Um2
        n19R3c6NqGIPXAokVUHacjclPpkrSt310Zv76NdpOX4/PMkZxQqSokCvp4Vm83fgJUtp
        lBQw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMGX8h6k0QL"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id k075acx0IKENe40
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 18 Jan 2021 21:14:23 +0100 (CET)
Subject: Re: [PATCH v2] can: length: can_fd_len2dlc(): make legnth calculation
 readable again
To:     Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
References: <20210117224047.1993737-1-mkl@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <1a8e8226-3cd1-ad3d-1ed2-96031acc26c7@hartkopp.net>
Date:   Mon, 18 Jan 2021 21:14:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210117224047.1993737-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thanks Marc!

[PATCH v2] can: length: can_fd_len2dlc(): make legnth calculation 
readable again

legnth -> length?

;-)

I've sent a V3 which also adds a BUILD_BUG_ON() to make sure that the 
table has the correct size at build time.

Would that make sense to you?

Regards,
Oliver


On 17.01.21 23:40, Marc Kleine-Budde wrote:
> In commit 652562e5ff06 ("can: length: can_fd_len2dlc(): simplify length
> calculcation") the readability of the code degraded and became more error
> prone. To counteract this, partially convert that patch and replace open coded
> values (of the original code) with proper defines.
> 
> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
> Fixes: 652562e5ff06 ("can: length: can_fd_len2dlc(): simplify length calculcation")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> changes since v1:
> - fix macro name (CANFD_MAX_LEN -> CANFD_MAX_DLEN)
> 
>   drivers/net/can/dev/length.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/dev/length.c b/drivers/net/can/dev/length.c
> index d35c4e82314d..f0d7cc969c1f 100644
> --- a/drivers/net/can/dev/length.c
> +++ b/drivers/net/can/dev/length.c
> @@ -27,12 +27,14 @@ static const u8 len2dlc[] = {
>   	13, 13, 13, 13, 13, 13, 13, 13,	/* 25 - 32 */
>   	14, 14, 14, 14, 14, 14, 14, 14,	/* 33 - 40 */
>   	14, 14, 14, 14, 14, 14, 14, 14,	/* 41 - 48 */
> +	15, 15, 15, 15, 15, 15, 15, 15,	/* 49 - 56 */
> +	15, 15, 15, 15, 15, 15, 15, 15	/* 57 - 64 */
>   };
>   
>   /* map the sanitized data length to an appropriate data length code */
>   u8 can_fd_len2dlc(u8 len)
>   {
> -	if (len >= ARRAY_SIZE(len2dlc))
> +	if (unlikely(len > CANFD_MAX_DLEN))
>   		return CANFD_MAX_DLC;
>   
>   	return len2dlc[len];
> 
