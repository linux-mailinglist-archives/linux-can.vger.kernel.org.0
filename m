Return-Path: <linux-can+bounces-5055-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EF0BAAEA8
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 03:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463BD18986C8
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 01:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B38B19FA93;
	Tue, 30 Sep 2025 01:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLFUpLC4"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AA454654;
	Tue, 30 Sep 2025 01:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759196987; cv=none; b=OlEFoBijmuwgQj6eBmSMRkcRVXnallU2CGed4n1mPC/pL/jCqEdEZgq5gAZ4Xh7hZmH0AQLMTqH2Gy70lafDXu8GCOCYOZPYnAALw1z+9/SdTEohHDPdmA5YrlQDwlg+h9TWAIGWsU6t0cIz/D0Ynx2tHvetrVKnHGU/mvLAkCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759196987; c=relaxed/simple;
	bh=5DWDovaZ/kYcbmtsLR5w4gN0CKRv0IvrEFhAaV3B16c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V72KgAWJBzZdQ9bcpKUvfDa3i5AIEZDQmGIV3Xo0hl3+qAudmaF8e7jxPXqEBQpukqI5FT4aNJ6juDDLfu9ekAolM5/XfjSBHPJ4Bpz4eAj1jg9N4vopdcjT/sEZtN+20sih4HpkOJKP4de3pZwb1xoT7vfRZfNa71bRFQfevTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLFUpLC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5791AC4CEF4;
	Tue, 30 Sep 2025 01:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759196986;
	bh=5DWDovaZ/kYcbmtsLR5w4gN0CKRv0IvrEFhAaV3B16c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TLFUpLC4ry8Fi5dwh9Qlk/iiiYf8L7Ig8kPxCBPsKZ9Fr5QLs4z/H0f9HN+WZf4oi
	 DVRqkRIGz3hk5RvlspAY2hU4GFrHxGTItxHM9dL6dIx+eBVk6QyzXXXzFWmiBXHF8x
	 BW7TOEKioyZzi29V7yjGst25aZEH8dhOHkCKIO5Ogf9der7QTssiF3oj+cxDN+b8Lx
	 ok1hVqQFoQehdO26stfr4LmThPM2EVHZ1aQOX8RwMSIY4v/yDNJ/q4ik+3InJ6W2L2
	 1HqgZnKIE8k7cBxJmoWjedC64CyJ87XZ3KfuwShVpiS31ILndYw3uNLZ9TsZLqxzrd
	 98CAy2g0wX5cQ==
Message-ID: <69a0a8fa-854c-4498-a0cb-6176d8d7dd98@kernel.org>
Date: Mon, 29 Sep 2025 23:52:41 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/can/gs_usb: increase max interface to 255
To: Celeste Liu <uwu@coelacanthus.name>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Maximilian Schneider <max@schneidersoft.net>,
 Henrik Brix Andersen <henrik@brixandersen.dk>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, Runcheng Lu <runcheng.lu@hpmicro.com>
References: <20250929-gs-usb-max-if-v1-1-e41b5c09133a@coelacanthus.name>
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
In-Reply-To: <20250929-gs-usb-max-if-v1-1-e41b5c09133a@coelacanthus.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Celeste,

Thank you for your patch. Here are my comments.

On 9/29/25 8:10 PM, Celeste Liu wrote:
> This issue was found by Runcheng Lu when develop HSCanT USB to CAN FD
> converter[1]. The original developers may have only 3 intefaces device to
> test so they write 3 here and wait for future change.
> 
> During the HSCanT development, we actually used 4 interfaces, so the
> limitation of 3 is not enough now. But just increase one is not
> future-proofed. Since the channel type in gs_host_frame is u8, use 255
> as max interface number should be safe.
> 
> [1]: https://github.com/cherry-embedded/HSCanT-hardware
> 
> Reported-by: Runcheng Lu <runcheng.lu@hpmicro.com>

If you have any links where Runcheng reported the issue, you can add it here as:

  Closes: <URL to the bug report>

(Ignore if such message does not exist).

Also add a Fixes tag so that the fix can be backported to stable.

> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
> ---
>  drivers/net/can/usb/gs_usb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index c9482d6e947b0c7b033dc4f0c35f5b111e1bfd92..35fc257c19e57c1f33e03e7c86ea908d22400254 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -290,9 +290,9 @@ struct gs_host_frame {
>  #define GS_NAPI_WEIGHT 32
>  
>  /* Maximum number of interfaces the driver supports per device.
> - * Current hardware only supports 3 interfaces. The future may vary.
> + * The channel number type of gs_host_frame is u8, so max interfaces can be 255.
>   */
> -#define GS_MAX_INTF 3
> +#define GS_MAX_INTF 255

After doing this, you are left with an array of 255 pointers in struct gs_usb
(which represents 2 kilobytes of memory on a 64 bits machine). You also have two
loops iterating from 0 to 255. This is a bit of a waste of both space and
processing power.

It is better to use a flexible array member, like this:

-----8<-----
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index c9482d6e947b..459a956ac0d9 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -324,7 +324,6 @@ struct gs_can {

 /* usb interface struct */
 struct gs_usb {
-       struct gs_can *canch[GS_MAX_INTF];
        struct usb_anchor rx_submitted;
        struct usb_device *udev;

@@ -336,9 +335,11 @@ struct gs_usb {

        unsigned int hf_size_rx;
        u8 active_channels;
+       u8 channel_cnt;

        unsigned int pipe_in;
        unsigned int pipe_out;
+       struct gs_can *canch[] __counted_by(channel_cnt);
 };

 /* 'allocate' a tx context.
----->8-----

Then all the instances of GS_MAX_INTF are replaced by gs_usb->channel_cnt except
from the check on dfconf.icount which can be replaced by a:

  type_max(typeof(gs_usb->channel_cnt))


Yours sincerely,
Vincent Mailhol


