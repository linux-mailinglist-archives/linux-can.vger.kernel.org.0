Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6943E2A1F95
	for <lists+linux-can@lfdr.de>; Sun,  1 Nov 2020 17:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgKAQnq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 1 Nov 2020 11:43:46 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:10343 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgKAQnq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 1 Nov 2020 11:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1604249024;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=5xgXla2sRitxoHPtSBAuaYF/yXcdQFwvOYqZCdSv3Kk=;
        b=EjDWFwlDRE/96ldoGs08kmuJvLX4YeHvIP07vUr3gcCXMZw5DGctDOdjRNYJMi5FaH
        zNKwy0eCirV2j0a74FWyBuXymLOQJeQLIImk+hIbhl6i4+pWiShTqTHhKIqCeAnwsSZ+
        ShyPfL0kJ8HXM0O0IgWQIh+XwHKUZj+KushAmtMxlRt6D9NXiQgs3SCUT+wLBeF4gUQl
        vdOJ65SA/D6eJ1IotI3QAQWRZFfA/PJ/Tks6VQP79Y3KSjgkrwmf+EvUx/C3KNJznjUl
        /SZ75SXQO1Lqx+Ba3u1/4GExlSlekkxhgzAbTEMoeSEPlXsRslvfRi4EBFUE4myBD4YK
        pbmg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR/J8ttpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.177]
        by smtp.strato.de (RZmta 47.3.0 DYNA|AUTH)
        with ESMTPSA id L010bewA1Ghh8Sh
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 1 Nov 2020 17:43:43 +0100 (CET)
Subject: Re: [PATCH v2] cangen: flush the CAN frame at each iteration
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
References: <20201101162613.503055-1-mailhol.vincent@wanadoo.fr>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <1c6faad5-97c0-7bd3-9dca-f9e97480c051@hartkopp.net>
Date:   Sun, 1 Nov 2020 17:43:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201101162613.503055-1-mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

You probably missed this reply ;-)

https://lore.kernel.org/linux-can/2ef6fb30-9fa8-99ee-39f7-e39bfb06f06c@hartkopp.net/


On 01.11.20 17:26, Vincent Mailhol wrote:
> The variable 'frame' is declared on the stack and is reused at each
> iteration of the while loop.
> 
> If not flushed, garbage data from the previous iteration of the loop
> could remain causing unexpected behavior. This is the case in DLC
> random mode: the field frame.len8_dlc is not cleared when the dlc is
> exactly 8 and the len8_dlc value of the previous iteration will be
> sent again.
> 
> This can be observed by running 'cangen -8 can0'. Once a frame of DLC
> in the range 9..15 is generated, no more frames of DLC 8 show out in
> the log.
> 
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> --
> 
> Changes in v2: v1 was dumb and broke everything which was not in
> random mode.  Just clear the len8_dlc.
> 
> ---
>   cangen.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/cangen.c b/cangen.c
> index ab8122c..14887c8 100644
> --- a/cangen.c
> +++ b/cangen.c
> @@ -171,7 +171,7 @@ int main(int argc, char **argv)
>   	struct pollfd fds;
>   
>   	struct sockaddr_can addr;
> -	static struct canfd_frame frame;
> +	static struct canfd_frame frame = { 0 };
>   	int nbytes;
>   	int i;
>   	struct ifreq ifr;
> @@ -418,16 +418,16 @@ int main(int argc, char **argv)
>   			if (canfd)
>   				frame.len = can_dlc2len(random() & 0xF);
>   			else {
> +				struct can_frame *ccf = (struct can_frame *)&frame;
> +
>   				frame.len = random() & 0xF;
> +				ccf->len8_dlc = 0;
>   
>   				if (frame.len > CAN_MAX_DLEN) {
> -					if (len8_dlc) {
> -						struct can_frame *ccf = (struct can_frame *)&frame;
> -
> +					if (len8_dlc)
>   						/* generate Classic CAN len8 DLCs */
>   						ccf->len8_dlc = frame.len;
> -					}
> -					frame.len = 8; /* for about 50% of the frames */
> +					frame.len = CAN_MAX_DLEN; /* for about 50% of the frames */
>   				}
>   			}
>   		}
> 
