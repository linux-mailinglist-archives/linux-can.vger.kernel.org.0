Return-Path: <linux-can+bounces-5061-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 128B9BAB984
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 07:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B832D168CD3
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 05:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1523E2765ED;
	Tue, 30 Sep 2025 05:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVHrb7QV"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F34136658;
	Tue, 30 Sep 2025 05:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211846; cv=none; b=D10cxV68Rd0T3SnoPEng+0xqF+MAmkZoenR0bFhQP2zA6OIlttKi/PV+aIHILejiGj6i4OqCO3huISG7/VZSR479CUMyNcww7/39jvhMVMg38rmlyqagH6x5sJYpbjeny71F0pk7/gkGqlAWlSVaKyQ3k5lD0FvmdcPnza3GcRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211846; c=relaxed/simple;
	bh=FevOmcfAbtbv3ioDP617RrBm5iAG51gbMmWWWN+pG9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8gSU1TrY1epeJTLiLyYCCZ8BoPL9kUmER+ysBM/xRW1/CQkgFehmw9r0bC2Gfe4B9mytYgsXBWd1IoLw+tXZiIif5huBQ1DdMYIaqx1HaDHXvjUR7HJZCJNavnsViEzhc+yoEmm1mh3mfKCySryyYK8Grg2HUp0VgMYNh7uw64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVHrb7QV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86144C4CEF0;
	Tue, 30 Sep 2025 05:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759211845;
	bh=FevOmcfAbtbv3ioDP617RrBm5iAG51gbMmWWWN+pG9Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RVHrb7QVcR+bBCU2l+wrJ750TKEo6nHJ1W8QyYBuTSeukTM9NSwH9wU1pchZhMo/T
	 HKIJRV+RUyQSKT1MTCRFV68k6r0B86Z5CvLn3+anZ7ZVNqMe5MuK1WHQh7y3Fu6t1/
	 hLbeKDlXOqT/Im4pe/nP4ckwEXAhzo943TCMROmzAo2y3rXsXubZA41ubQrYCbLXEU
	 IyKIhZFUc1y6KuakxeIFGel7rJb2D+odbRYN5+azLNoz0Rv5F7MQDGSNl14fjKzemA
	 wdqXsym6xFzB5JiEWl+2Nu3BCyyL1ydu0+nvm8MbGW9hDOLVP1myQ3y+gGct7IMKmp
	 Vj4pwgZUW3Zng==
Message-ID: <7a2a0124-7269-40b5-a423-e4b704f51628@kernel.org>
Date: Tue, 30 Sep 2025 14:57:20 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/can/gs_usb: increase max interface to U8_MAX
To: Celeste Liu <uwu@coelacanthus.name>
Cc: Maximilian Schneider <max@schneidersoft.net>,
 Henrik Brix Andersen <henrik@brixandersen.dk>,
 Wolfgang Grandegger <wg@grandegger.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, Runcheng Lu <runcheng.lu@hpmicro.com>,
 stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250930-gs-usb-max-if-v3-1-21d97d7f1c34@coelacanthus.name>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250930-gs-usb-max-if-v3-1-21d97d7f1c34@coelacanthus.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Celeste,

Sorry, one last minute comment which I forgot in my previous message.

On 9/30/25 12:06 PM, Celeste Liu wrote:
> This issue was found by Runcheng Lu when develop HSCanT USB to CAN FD
> converter[1]. The original developers may have only 3 intefaces device to
> test so they write 3 here and wait for future change.
> 
> During the HSCanT development, we actually used 4 interfaces, so the
> limitation of 3 is not enough now. But just increase one is not
> future-proofed. Since the channel type in gs_host_frame is u8, just
> increase interface number limit to max size of u8 safely.
> 
> [1]: https://github.com/cherry-embedded/HSCanT-hardware
> 
> Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
> Reported-by: Runcheng Lu <runcheng.lu@hpmicro.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
> ---
> Changes in v3:
> - Cc stable should in patch instead of cover letter.
> - Link to v2: https://lore.kernel.org/r/20250930-gs-usb-max-if-v2-1-2cf9a44e6861@coelacanthus.name
> 
> Changes in v2:
> - Use flexible array member instead of fixed array.
> - Link to v1: https://lore.kernel.org/r/20250929-gs-usb-max-if-v1-1-e41b5c09133a@coelacanthus.name
> ---
>  drivers/net/can/usb/gs_usb.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index c9482d6e947b0c7b033dc4f0c35f5b111e1bfd92..69b068c8fa8fbab42337e2b0a3d0860ac678c792 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -289,11 +289,6 @@ struct gs_host_frame {
>  #define GS_MAX_RX_URBS 30
>  #define GS_NAPI_WEIGHT 32
>  
> -/* Maximum number of interfaces the driver supports per device.
> - * Current hardware only supports 3 interfaces. The future may vary.
> - */
> -#define GS_MAX_INTF 3
> -
>  struct gs_tx_context {
>  	struct gs_can *dev;
>  	unsigned int echo_id;
> @@ -324,7 +319,6 @@ struct gs_can {
>  
>  /* usb interface struct */
>  struct gs_usb {
> -	struct gs_can *canch[GS_MAX_INTF];
>  	struct usb_anchor rx_submitted;
>  	struct usb_device *udev;
>  
> @@ -336,9 +330,11 @@ struct gs_usb {
>  
>  	unsigned int hf_size_rx;
>  	u8 active_channels;
> +	u8 channel_cnt;
>  
>  	unsigned int pipe_in;
>  	unsigned int pipe_out;
> +	struct gs_can *canch[] __counted_by(channel_cnt);
>  };
>  
>  /* 'allocate' a tx context.
> @@ -599,7 +595,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>  	}
>  
>  	/* device reports out of range channel id */
> -	if (hf->channel >= GS_MAX_INTF)
> +	if (hf->channel >= parent->channel_cnt)
>  		goto device_detach;
>  
>  	dev = parent->canch[hf->channel];
> @@ -699,7 +695,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>  	/* USB failure take down all interfaces */
>  	if (rc == -ENODEV) {
>  device_detach:
> -		for (rc = 0; rc < GS_MAX_INTF; rc++) {
> +		for (rc = 0; rc < parent->channel_cnt; rc++) {
>  			if (parent->canch[rc])
>  				netif_device_detach(parent->canch[rc]->netdev);
>  		}
> @@ -1460,17 +1456,19 @@ static int gs_usb_probe(struct usb_interface *intf,
>  	icount = dconf.icount + 1;
>  	dev_info(&intf->dev, "Configuring for %u interfaces\n", icount);
>  
> -	if (icount > GS_MAX_INTF) {
> +	if (icount > type_max(typeof(parent->channel_cnt))) {
                              ^^^^^^
If you send a v4 to fix the typo, can you also remove this typeof()?

It used to be required, but this is not the case anymore since commit
bd1ebf2467f9 ("overflow: Allow non-type arg to type_max() and type_min()").

(my Reviewed-by tag is still valid).

>  		dev_err(&intf->dev,
>  			"Driver cannot handle more that %u CAN interfaces\n",
> -			GS_MAX_INTF);
> +			type_max(typeof(parent->channel_cnt)));
                                 ^^^^^^
same

>  		return -EINVAL;
>  	}
>  
> -	parent = kzalloc(sizeof(*parent), GFP_KERNEL);
> +	parent = kzalloc(struct_size(parent, canch, icount), GFP_KERNEL);
>  	if (!parent)
>  		return -ENOMEM;
>  
> +	parent->channel_cnt = icount;
> +
>  	init_usb_anchor(&parent->rx_submitted);
>  
>  	usb_set_intfdata(intf, parent);
> @@ -1531,7 +1529,7 @@ static void gs_usb_disconnect(struct usb_interface *intf)
>  		return;
>  	}
>  
> -	for (i = 0; i < GS_MAX_INTF; i++)
> +	for (i = 0; i < parent->channel_cnt; i++)
>  		if (parent->canch[i])
>  			gs_destroy_candev(parent->canch[i]);


-- 
Yours sincerely,
Vincent Mailhol


