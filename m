Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E91646FC4C
	for <lists+linux-can@lfdr.de>; Fri, 10 Dec 2021 09:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhLJIKP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 10 Dec 2021 03:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhLJIKP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Dec 2021 03:10:15 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDC4C061746
        for <linux-can@vger.kernel.org>; Fri, 10 Dec 2021 00:06:40 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id u22so12559923lju.7
        for <linux-can@vger.kernel.org>; Fri, 10 Dec 2021 00:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6n2ggLUO7Wphn+PMZVpLwuv+ZnMRi8Qo+3lecm2wx4w=;
        b=B4cWgv1+ZNylZ17uptVAhrmH+iPT7hYzo9LGqfSHqMgHkuev7U1DsiHa3kcF6akc+d
         h5RhP5RApTXavrhxe/XpbQ+TwTJnbb3hbZl7FmN8mALhTrO1TaVCG4GZvS7oX09o1gK4
         JzoUYHO5UDa0plOy+WxYXFAmyPX4WxgC69yKuXRrBF8kk/8+GVnCjQbCNatAW8IvI/Qy
         ElPkBdMXjl+rhIg4Z3SOZ5jOAlc29huIloCZxlr5QwnbBogHRe2GHmxMfNJkRflLJro/
         3TnlrnwIMHrIFrMvj3p8TpCHKLLPAxfTzJuiIh5A51fH7+8CN41yEEirBX6Or7QiBJk9
         P4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6n2ggLUO7Wphn+PMZVpLwuv+ZnMRi8Qo+3lecm2wx4w=;
        b=WwRpb8A9Iyczysyv3dzWGLaITzv6JOy0kgY7i+dK1EPpf1xNteoAQRpbk4Czo8qevn
         7tgcZPD5siZ20beiAaR6fS530eSJQMbbIUETKnPq9cOW52qm0c9n29J4lmbMiYjLluP8
         Sqg/a7UWkyhohhaBpNykvDssNzhCKwn09GC1Qaft9o2Ka6flbalrv6eqcoLJkWyMZmsl
         tilPMwNPFYfOFRpqLnH3tyLXcfkgjnQFNY5z5rqbfw5DCC1Aky4cvS24ZzF9+k4P6gRJ
         OZ0mZgdV2FDpwZUfIe7yvTrDYYK616F1m3V4QkIcbfbYzANJigwsUVUmiGQnpDdc0haB
         YJ1w==
X-Gm-Message-State: AOAM5317hnyBVsO+kXZM8wyh9Y5H0e8YwwNgksHkBDehf97wvi4LTytN
        o7G861me6GxYja4o0qtJ1onarPkyO9IB0J1U
X-Google-Smtp-Source: ABdhPJz3z5+6C1Qg50wKfUqSXADSCm6UQDeiuLUvjRBnAOZMo0O9CmOlIQnbzwk2P8346m9l5OCnLA==
X-Received: by 2002:a2e:a54d:: with SMTP id e13mr11047398ljn.319.1639123598388;
        Fri, 10 Dec 2021 00:06:38 -0800 (PST)
Received: from [10.0.6.3] (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id l11sm236326lfe.22.2021.12.10.00.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 00:06:38 -0800 (PST)
Subject: Re: [PATCH v6] can: kvaser_usb: make use of units.h in assignment of
 frequency
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20211210075803.343841-1-mkl@pengutronix.de>
From:   Jimmy Assarsson <extja@kvaser.com>
Message-ID: <7de7ffcd-9ba6-fac2-0c34-7e64897904c1@kvaser.com>
Date:   Fri, 10 Dec 2021 09:06:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20211210075803.343841-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2021-12-10 08:58, Marc Kleine-Budde wrote:
> From: Jimmy Assarsson <extja@kvaser.com>
> 
> Use the MEGA define plus the comment /* Hz */ when assigning
> frequencies.
> 
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hello Jimmy,
> 
> now that net/master has been merged into net-next/master, I think this
> is the remaining patch of your series. Right?
> 
> regards,
> Marc

Yes.

Thanks!
jimmy


>   drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 7 ++++---
>   drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 9 +++++----
>   2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> index dcee8dc828ec..cec36295fdc5 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> @@ -22,6 +22,7 @@
>   #include <linux/spinlock.h>
>   #include <linux/string.h>
>   #include <linux/types.h>
> +#include <linux/units.h>
>   #include <linux/usb.h>
>   
>   #include <linux/can.h>
> @@ -2040,7 +2041,7 @@ const struct kvaser_usb_dev_ops kvaser_usb_hydra_dev_ops = {
>   
>   static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_kcan = {
>   	.clock = {
> -		.freq = 80000000,
> +		.freq = 80 * MEGA /* Hz */,
>   	},
>   	.timestamp_freq = 80,
>   	.bittiming_const = &kvaser_usb_hydra_kcan_bittiming_c,
> @@ -2049,7 +2050,7 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_kcan = {
>   
>   static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_flexc = {
>   	.clock = {
> -		.freq = 24000000,
> +		.freq = 24 * MEGA /* Hz */,
>   	},
>   	.timestamp_freq = 1,
>   	.bittiming_const = &kvaser_usb_hydra_flexc_bittiming_c,
> @@ -2057,7 +2058,7 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_flexc = {
>   
>   static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_rt = {
>   	.clock = {
> -		.freq = 80000000,
> +		.freq = 80 * MEGA /* Hz */,
>   	},
>   	.timestamp_freq = 24,
>   	.bittiming_const = &kvaser_usb_hydra_rt_bittiming_c,
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> index f7af1bf5ab46..aed271d5f3bb 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> @@ -19,6 +19,7 @@
>   #include <linux/spinlock.h>
>   #include <linux/string.h>
>   #include <linux/types.h>
> +#include <linux/units.h>
>   #include <linux/usb.h>
>   
>   #include <linux/can.h>
> @@ -356,7 +357,7 @@ static const struct can_bittiming_const kvaser_usb_leaf_bittiming_const = {
>   
>   static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_8mhz = {
>   	.clock = {
> -		.freq = 8000000,
> +		.freq = 8 * MEGA /* Hz */,
>   	},
>   	.timestamp_freq = 1,
>   	.bittiming_const = &kvaser_usb_leaf_bittiming_const,
> @@ -364,7 +365,7 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_8mhz = {
>   
>   static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_16mhz = {
>   	.clock = {
> -		.freq = 16000000,
> +		.freq = 16 * MEGA /* Hz */,
>   	},
>   	.timestamp_freq = 1,
>   	.bittiming_const = &kvaser_usb_leaf_bittiming_const,
> @@ -372,7 +373,7 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_16mhz = {
>   
>   static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_24mhz = {
>   	.clock = {
> -		.freq = 24000000,
> +		.freq = 24 * MEGA /* Hz */,
>   	},
>   	.timestamp_freq = 1,
>   	.bittiming_const = &kvaser_usb_leaf_bittiming_const,
> @@ -380,7 +381,7 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_24mhz = {
>   
>   static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_32mhz = {
>   	.clock = {
> -		.freq = 32000000,
> +		.freq = 32 * MEGA /* Hz */,
>   	},
>   	.timestamp_freq = 1,
>   	.bittiming_const = &kvaser_usb_leaf_bittiming_const,
> 
