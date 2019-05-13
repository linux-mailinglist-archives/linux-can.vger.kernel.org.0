Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6EE71B661
	for <lists+linux-can@lfdr.de>; Mon, 13 May 2019 14:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfEMMuQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 May 2019 08:50:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41591 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730001AbfEMMuQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 May 2019 08:50:16 -0400
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1hQAPD-0003th-Qq; Mon, 13 May 2019 14:50:11 +0200
Subject: Re: [PATCH] j1939: transport: seed retry timeout for (E)TP sessions
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     kernel@pengutronix.de, linux-can@vger.kernel.org,
        robin@protonic.nl, david@protonic.nl
References: <20190513124427.30997-1-o.rempel@pengutronix.de>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <304363b3-ff27-f28d-43e6-20a4facd6729@pengutronix.de>
Date:   Mon, 13 May 2019 14:50:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513124427.30997-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi folks!

what do think about this change? Are there better ways to solve it?
This issue is easy to reproduce if I send 2 (E)TPs in parallel. For example:

jcat -i /test_100k can0:0x80 :0x90,0x13400 &
jcat -i /test_100k can0:0x80 :0x91,0x12300 &

With this change, even 4 parallel ETPs work fine.

On 13.05.19 14:44, Oleksij Rempel wrote:
> If retry timeout is equal for all systems and/or sockets, it will
> collide at some point. In this case, one sender will always have
> a chance to send some thing and make the CAN queue full, the other
> one will always get -ENOBUS response.
> Even if we would implement a scheduler for local system, we can't solve
> same problem for multiple identical systems on same bus.
> 
> Since the protocol has no other way to avoid this kind of collisions,
> we can use random number for retry timer and reduce probability of
> colliding retries.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>   net/can/j1939/transport.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index f469d9e131c7..978f2e194f32 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -116,7 +116,6 @@ enum j1939_xtp_abort {
>   };
>   
>   static unsigned int j1939_tp_block = 255;
> -static unsigned int j1939_tp_retry_ms = 20;
>   static unsigned int j1939_tp_packet_delay;
>   static unsigned int j1939_tp_padding = 1;
>   
> @@ -873,8 +872,12 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
>   	int ret;
>   
>   	ret = j1939_tp_txnext(session);
> -	if (ret < 0)
> -		j1939_tp_schedule_txtimer(session, j1939_tp_retry_ms ?: 20);
> +	if (ret < 0) {
> +		u32 random = get_random_u32();
> +
> +		j1939_tp_schedule_txtimer(session, 10 + (random & 0xf));
> +
> +	}
>   	j1939_session_put(session);
>   
>   	return HRTIMER_NORESTART;
> 

Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
