Return-Path: <linux-can+bounces-2100-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8135C9D20E6
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 08:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF5DB20B7A
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 07:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAADB1482F3;
	Tue, 19 Nov 2024 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Ok1AMbMR"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3488E1384BF;
	Tue, 19 Nov 2024 07:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732002140; cv=none; b=aPe+oHKe+SgBs33BVAxX9BhKsFlfc+ajpgqAkMtUHTDzMG4o+kOkzMBhe2tvOGq1ltsyAAg1O3sQqKnUlEO+hOwoFcknUwUNklhlRD5MMMrhyYqc1LWIvB5/dueCLoDXbHR9TdFHciEZIzfyKC2gbooUN73pk5FbFugWqF3vngI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732002140; c=relaxed/simple;
	bh=+ydaP6yJPY0HON6walO83Qt137C5Xlma2G74EAqDJzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvC4K1tXSCGdrLl44ZqgiBR6Rjn5bUG4rXoExwUi1td9ZNgBXM2EtOr1IUiniB/f0QQGQAk7aPfd3K/V4aXixw8YXsWRMvOIuL8P8BAbMky4UjN+8m4YsrxaWrh2IiRgzxMSZ7DOUZjgzOVBB4ipr9ubjlQH0LA7yGGKiIzSPzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Ok1AMbMR; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id DIs2tCdnkNywhDIsAtawL3; Tue, 19 Nov 2024 08:42:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1732002129;
	bh=TKjGKLPdqYcvxBVaeWCfhrHtv6lPv0GnVL9Gr+jS2EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Ok1AMbMRMuTGTJVoeYvMqfk2YhiChyQl2M/rNhAaxyzPE6XeLxUC8+A4dA4uQXmVF
	 vIVeWA/hVbeKEawkPhmaGw/pbS2CY9rqffUU5087E8Qle+QPAdSUsxoVGBCVGiZQCo
	 dCj1JPnx+gHmOTRlhDeMq8FV4kPB7K5jGgTiLYTj6BvZzEaAxFNx21GBYcwkeH66G/
	 w9eFcaD1rdcqPdFU6Bf9TO0GentDPAsBzhGo2s2kc99bgApq49GmkG0ItO8bLaSCf7
	 LK40sylxmPVFpyTpBa7j8p++nZeaRrnhyhwmPY8TnZ4DdL7FK3M86tCqeUqD2ndx5Q
	 R4RQLimw8XWJQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Nov 2024 08:42:09 +0100
X-ME-IP: 124.33.176.97
Message-ID: <84998b1d-8b3e-4956-b7fd-323e4999dc7c@wanadoo.fr>
Date: Tue, 19 Nov 2024 16:41:57 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] can: can327: Clean up payload encoding in
 can327_handle_prompt()
To: Max Staudt <max@enpas.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241119003815.767004-1-max@enpas.org>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
In-Reply-To: <20241119003815.767004-1-max@enpas.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/11/2024 at 09:38, Max Staudt wrote:
> The hex dump encoding of outgoing payloads used snprintf() with a
> too large length of the target buffer. While the length was wrong, the
> buffer size and its filling logic were fine (sprintf() would have been
> sufficient), hence this is not security relevant.
> 
> Still, it's a good opportunity to simplify the code, and since no
> length checking is required, let's implement it with bin2hex().
> 
> Since bin2hex() outputs lowercase letters, this changes the spoken
> wire protocol with the ELM327 chip, resulting in a change in
> can327_is_valid_rx_char() because the ELM327 is set to echo the
> characters sent to it. The documentation says that this is fine, and
> I have verified the change on actual hardware.

Nice that the device accepts the lower case hexadecimals. This results
in a nice simplification.

> Finally, since the reporter's worry was that frame->len may be larger
> than 8, resulting in a buffer overflow in can327_handle_prompt()'s
> local_txbuf, a comment describes how the CAN stack prevents that. This
> is also the reason why the size passed to snprintf() was not relevant
> to preventing a buffer overflow, because there was no overflow possible
> in the first place.
> 
> Fixes: 43da2f07622f ("can: can327: CAN/ldisc driver for ELM327 based OBD-II adapters")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Tested-by: Max Staudt <max@enpas.org>
> Signed-off-by: Max Staudt <max@enpas.org>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

I left comments on the comments. If you have time, it would be wonderful
if your comment on start_xmit() could be moved to can_dev_dropped_skb()
in a separate patch.

The code is good, so if such rework is not feasible, I am happy to take
it as-is.

> ---
>  drivers/net/can/can327.c | 46 ++++++++++++++++++++++++++++------------
>  1 file changed, 33 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
> index 24af63961030..3ae7b4eb6ca5 100644
> --- a/drivers/net/can/can327.c
> +++ b/drivers/net/can/can327.c
> @@ -18,6 +18,7 @@
>  #include <linux/bitops.h>
>  #include <linux/ctype.h>
>  #include <linux/errno.h>
> +#include <linux/hex.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/lockdep.h>
> @@ -622,17 +623,14 @@ static void can327_handle_prompt(struct can327 *elm)
>  			 */
>  			snprintf(local_txbuf, sizeof(local_txbuf), "ATRTR\r");
>  		} else {
> -			/* Send a regular CAN data frame */
> -			int i;
> -
> -			for (i = 0; i < frame->len; i++) {
> -				snprintf(&local_txbuf[2 * i],
> -					 sizeof(local_txbuf), "%02X",
> -					 frame->data[i]);
> -			}
> -
> -			snprintf(&local_txbuf[2 * i], sizeof(local_txbuf),
> -				 "\r");
> +			/* Send a regular CAN data frame.
> +			 *
> +			 * frame->len is guaranteed to be <= 8. Please refer
> +			 * to the comment in can327_netdev_start_xmit().
> +			 */

Nitpick, could be less verbose, e.g.:

  /* frame->len <= 8 enforced in can327_netdev_start_xmit() */

> +			bin2hex(local_txbuf, frame->data, frame->len);
> +			local_txbuf[2 * frame->len] = '\r';
> +			local_txbuf[2 * frame->len + 1] = '\0';
>  		}
>  
>  		elm->drop_next_line = 1;
> @@ -815,6 +813,26 @@ static netdev_tx_t can327_netdev_start_xmit(struct sk_buff *skb,
>  	struct can327 *elm = netdev_priv(dev);
>  	struct can_frame *frame = (struct can_frame *)skb->data;
>  
> +	/* Why this driver can rely on frame->len <= 8:
> +	 *
> +	 * While can_dev_dropped_skb() sanity checks the skb to contain a
> +	 * CAN 2.0, CAN FD, or other CAN frame type supported by the CAN
> +	 * stack, it does not restrict these types of CAN frames.
> +	 *
> +	 * Instead, this driver is guaranteed to receive only classic CAN 2.0
> +	 * frames, with frame->len <= 8, by a chain of checks around the CAN
> +	 * device's MTU (as of v6.12):
> +	 *
> +	 *  - can_changelink() sets the CAN device's MTU to CAN_MTU since we
> +	 *    don't advertise CAN_CTRLMODE_FD support in ctrlmode_supported.
> +	 *  - can_send() then refuses to pass any skb that exceeds CAN_MTU.
> +	 *  - Since CAN_MTU is the smallest currently (v6.12) supported CAN
> +	 *    MTU, it is clear that we are dealing with an ETH_P_CAN frame.
> +	 *  - All ETH_P_CAN (classic CAN 2.0) frames have frame->len <= 8,
> +	 *    as enforced by a call to can_is_can_skb() in can_send().
> +	 *  - Thus for all CAN frames reaching this function, frame->len <= 8.
> +	 */

Actually, none of this is really specific to your can327 driver.

While this is a valuable piece of information, I would rather like to
see this added as a kdoc comment on top of can_dev_dropped_skb(). That
function already has a one line documentation, but maybe it deserves a
longer paragraph?

One of the key point is that the userland is able to bypass the CAN_RAW
layer (or any other CAN layers) by sending AF_PACKET. In which case, the
packet directly reaches the driver without any prior sanitization. So it
is critical to highlight that drivers must call can_dev_dropped_skb() at
the top of their start_xmit() function, typically to avoid buffer
overflows because of an out of band frame->len.

>  	if (can_dev_dropped_skb(dev, skb))
>  		return NETDEV_TX_OK;
>  
> @@ -871,8 +889,10 @@ static bool can327_is_valid_rx_char(u8 c)
>  		['H'] = true, true, true, true, true, true, true,
>  		['O'] = true, true, true, true, true, true, true,
>  		['V'] = true, true, true, true, true,
> -		['a'] = true,
> -		['b'] = true,
> +		/* Note: c-f are needed only if outgoing CAN payloads are
> +		 * sent as lowercase hex dumps instead of uppercase.
> +		 */
> +		['a'] = true, true, true, true, true, true,
>  		['v'] = true,
>  		[CAN327_DUMMY_CHAR] = true,
>  	};

Yours sincerely,
Vincent Mailhol


