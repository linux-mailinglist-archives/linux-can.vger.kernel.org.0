Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CA62A1F18
	for <lists+linux-can@lfdr.de>; Sun,  1 Nov 2020 16:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgKAPcp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 1 Nov 2020 10:32:45 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:17599 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgKAPco (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 1 Nov 2020 10:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1604244760;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=mJcsiBFUwdBu2oEaApenWWySq7fc4hxHc3/ojIlzahg=;
        b=hDHVWqqvtudH65A7tZ57vDfZ2GnjrXMBYbUeP/a/bbw/tF7Szt98hVq1kAgsE8TOQF
        UUh2Mqh2cZEDaOIzvc5l9mfQX4jhmsfW17FMbuQi5DsVJRaRnVtE3Aq0QrgawcFfx55T
        Sf4g6y4bA+I4mI+nVFugZvm0Pkf0o6kxghEFqR43Dkv23GxDVmBSm1c2PopIWWNEYTef
        iR9fR+8REDgJ2a1ekDvamOT7Tmb0eZt3IEyJuhNEH2US7wn5EQdDHQm7KVAR7r9/OXOE
        opn5g/uXYRDzLwPEKGv9p9Ed1rOyrip1qAYmZJ2entzJnVWQZayr1lUDneNkwKXDTKC3
        XeZw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR9J8xtpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.3.0 DYNA|AUTH)
        with ESMTPSA id L010bewA1FWd8Nl
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 1 Nov 2020 16:32:39 +0100 (CET)
Subject: Re: [PATCH] cangen: flush the CAN frame at each iteration
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <20201101145712.489795-1-mailhol.vincent@wanadoo.fr>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <5ecff3df-2e94-8702-3894-3fcd70364552@hartkopp.net>
Date:   Sun, 1 Nov 2020 16:32:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201101145712.489795-1-mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

- linux-kernel@vger.kernel.org
+ linux-can@vger.kernel.org

Wrong mailing list ...

On 01.11.20 15:57, Vincent Mailhol wrote:
> The variable 'frame' is declared on the stack and is reused at each
> iteration of the while loop.
> 
> If not flushed, garbage data from the previous iteration of the loop
> could remain causing unexpected behavior. This is the case in DLC
> random mode: the field frame.len8_dlc is not cleared when the dlc is
> exactly 8 and the len8_dlc value of the previous iteration will be
> sent again.

Good catch! Thanks.

> This can be observed by running 'cangen -8 can0'. Once a frame of DLC
> in the range 9..15 is generated, no more frames of DLC 8 show out in
> the log.
> 
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>   cangen.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cangen.c b/cangen.c
> index ab8122c..d7392b6 100644
> --- a/cangen.c
> +++ b/cangen.c
> @@ -384,7 +384,7 @@ int main(int argc, char **argv)
>   	}
>   
>   	while (running) {
> -		frame.flags = 0;
> +		memset(&frame, 0, sizeof(frame));

But this patch breaks everything which is not in random mode.

Analogue to frame.flags we just need to clear frame.len8_dlc

Regards,
Oliver

>   
>   		if (count && (--count == 0))
>   			running = 0;
> 
