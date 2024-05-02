Return-Path: <linux-can+bounces-529-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9FA8B969F
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 10:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16D91F2277F
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 08:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3346544;
	Thu,  2 May 2024 08:44:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634B146447;
	Thu,  2 May 2024 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639492; cv=none; b=hKQrfl81ECkt9px9UfiB+mpfO3uxGvlHn9up4/dWXbD7vk5zD37itlTFu1F1VC+nyHlUfue63u6/j5s65KHOI37fAagw2mdpqDWMIsYjBUnsN/oUTUXW14LzI3K8MADFa+Rc2IW5oN/iwtCs5chNdhLmJBJ2EOFWAhKszzg5g0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639492; c=relaxed/simple;
	bh=+NLHBhZRBYI95WFHsn7dVOTxgbFKRVWzxhhF4X4AOvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJwL1D3IddKAuNbc1dNiNPZ/qE0gHB/uS6LoXjl2rMSKAsuOiVoly5xQanxulYgamaMFhP6k5lIZ+cEHkaDCxXRQ3qLc3l+EEMfyLQOOyAOjs6pU9Tgzeh8sExZD7Jh5J7woD+098wK/+Omj9I+9Ky99fFbRdQjG71a5LYeX0h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a5878caeb9eso924482966b.1;
        Thu, 02 May 2024 01:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714639489; x=1715244289;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyUR0PVRexJrQieSgPDu+6a93eOrFLP5eQgOtFYkWn8=;
        b=ecsThdGuNOLYxc8lH3dYQ55JZ/L7tWzauZoEt1ebJpmzgXLGviz1AIUMbml/osslLN
         Dk5KQlcnGHO8f0nbwx8/FXtdYKF6fAkD+ixb/KQnjbfoPl9eehzjuRL3YATZR7yh0BFb
         KgH2hGAShJYSTgY1sh/zqzuhwl7Ns5EjOhGcGOj4x0tC9boF44HEMPTJW/5cyMg+gjPv
         1sL8ETHFg+TfBlmUnfPgcg1JfUwYjfxN9X0uUsQHyLiiH0Dl52lz4xTD3ghyK8Uzpzlq
         EUlIymIRxADrXEeJuDWGGwOhawuzR/qTciP0cWqEK7NKyFQ2O06a7RGr5qMnTEI+UBxO
         7L0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4wJSvC3ldYbQR7jBrvaKVegBqYLtjaa12U7W+dmXFIbFVU5QwY1GOn0mog7sYpPCJYhmQvJDPfjc1YxOhViCjmrYeHZWjkHj0krkn0/I5ML1MB/gL/N9W0RFUh7sYgp0plWH2EYFDIC1wikPvtUCxgXiLxdd4pkploTt2lI8i9lPFaAIbBCAMczfQSAHQqur2OhuOI/vb/FfO2a2a8HJVKVnLkrrOMvUYZd+srP59EIXfz/m0TDR1
X-Gm-Message-State: AOJu0YxojFuaS3dbOZsi9nHnXKfy7pBdD7dB4DvsrL8YFEkYIE9AEEeO
	ROtZrjYHy8uNSVA0FpfeAbLROLP3Bb+FWUYXK4h+FgLJOtJ0Eh+y
X-Google-Smtp-Source: AGHT+IGEQIirZ0qBejPyDoJk4QL6GI0vA+1pbCVirhPev7LTDbO1LHmOhOOg/ZWB8jg0YyHzdfb4SA==
X-Received: by 2002:a17:906:340f:b0:a58:e789:8eb7 with SMTP id c15-20020a170906340f00b00a58e7898eb7mr2958300ejb.74.1714639488468;
        Thu, 02 May 2024 01:44:48 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id og20-20020a1709071dd400b00a5970e88670sm198140ejc.176.2024.05.02.01.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 01:44:47 -0700 (PDT)
Message-ID: <6ae3c1af-4368-4a3e-bfb5-366080048dac@kernel.org>
Date: Thu, 2 May 2024 10:44:46 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] can: Add support for serdev LIN adapters
To: Christoph Fritz <christoph.fritz@hexdev.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Reichel <sre@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: Andreas Lauser <andreas.lauser@mercedes-benz.com>,
 Jonathan Corbet <corbet@lwn.net>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-input@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20240502075534.882628-1-christoph.fritz@hexdev.de>
 <20240502075534.882628-8-christoph.fritz@hexdev.de>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240502075534.882628-8-christoph.fritz@hexdev.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02. 05. 24, 9:55, Christoph Fritz wrote:
> This commit introduces LIN-Bus support for UART devices equipped with
> LIN transceivers, utilizing the Serial Device Bus (serdev) interface.
> 
> For more details on an adapter, visit: https://hexdev.de/hexlin#tty
...
> --- /dev/null
> +++ b/drivers/net/can/lin-serdev.c
> @@ -0,0 +1,514 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (C) 2024 hexDEV GmbH - https://hexdev.de */
> +
> +#include <linux/module.h>
> +#include <linux/wait.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/kernel.h>

What do you need kernel.h for? You should explicitly require what you 
need (you apparently do), so kernel.h should not be needed.

> +#include <net/lin.h>
> +#include <linux/of.h>
> +#include <linux/serdev.h>
> +#include <linux/slab.h>
> +#include <linux/kfifo.h>
> +#include <linux/workqueue.h>
> +#include <linux/tty.h>

Might be eaier to maintain if you sort them.

> +#define LINSER_SAMPLES_PER_CHAR		10
> +#define LINSER_TX_BUFFER_SIZE		11
> +#define LINSER_RX_FIFO_SIZE		256
> +#define LINSER_PARSE_BUFFER		24
> +
> +struct linser_rx {
> +	u8 data;
> +	u8 flag;
> +};
> +
> +enum linser_rx_status {
> +	NEED_MORE = -1,
> +	MODE_OK = 0,
> +	NEED_FORCE,
> +};
> +
> +struct linser_priv {
> +	struct lin_device *lin_dev;
> +	struct serdev_device *serdev;
> +	DECLARE_KFIFO_PTR(rx_fifo, struct linser_rx);
> +	struct delayed_work rx_work;
> +	ulong break_usleep_min;
> +	ulong break_usleep_max;
> +	ulong post_break_usleep_min;
> +	ulong post_break_usleep_max;
> +	ulong force_timeout_jfs;

The same as for uint :)

> +	struct lin_responder_answer respond_answ[LIN_NUM_IDS];
> +	struct mutex resp_lock; /* protects respond_answ */
> +	bool is_stopped;
> +};
...
> +static void linser_derive_timings(struct linser_priv *priv, u16 bitrate)
> +{
> +	unsigned long break_baud = (bitrate * 2) / 3;
> +	unsigned long timeout_us;
> +

Are those 1000000UL USEC_PER_SEC?

> +	priv->break_usleep_min = (1000000UL * LINSER_SAMPLES_PER_CHAR) /
> +				 break_baud;
> +	priv->break_usleep_max = priv->break_usleep_min + 50;
> +	priv->post_break_usleep_min = (1000000UL * 1 /* 1 bit */) / break_baud;
> +	priv->post_break_usleep_max = priv->post_break_usleep_min + 30;
> +
> +	timeout_us = DIV_ROUND_CLOSEST(1000000UL * 256 /* bit */, bitrate);
> +	priv->force_timeout_jfs = usecs_to_jiffies(timeout_us);
> +}
...
> +static bool linser_tx_frame_as_responder(struct linser_priv *priv, u8 id)
> +{
> +	struct lin_responder_answer *answ = &priv->respond_answ[id];
> +	struct serdev_device *serdev = priv->serdev;
> +	u8 buf[LINSER_TX_BUFFER_SIZE];
> +	u8 checksum, count, n;
> +	ssize_t write_len;
> +
> +	mutex_lock(&priv->resp_lock);
> +
> +	if (!answ->is_active)
> +		goto unlock_and_exit_false;
> +
> +	if (answ->is_event_frame) {
> +		struct lin_responder_answer *e_answ;
> +
> +		e_answ = &priv->respond_answ[answ->event_associated_id];
> +		n = min(e_answ->lf.len, LIN_MAX_DLEN);
> +		if (memcmp(answ->lf.data, e_answ->lf.data, n) != 0) {
> +			memcpy(answ->lf.data, e_answ->lf.data, n);
> +			checksum = lin_get_checksum(LIN_FORM_PID(answ->lf.lin_id),
> +						    n, e_answ->lf.data,
> +						    answ->lf.checksum_mode);
> +			answ = e_answ;
> +		} else {
> +			goto unlock_and_exit_false;

Can't you simply use guard(mutex) above and avoid the error-prone 
gotos/cleanup completely?

> +		}
> +	} else {
> +		checksum = answ->lf.checksum;
> +	}
> +
> +	count = min(answ->lf.len, LIN_MAX_DLEN);
> +	memcpy(&buf[0], answ->lf.data, count);
> +	buf[count] = checksum;
> +
> +	mutex_unlock(&priv->resp_lock);
> +
> +	write_len = serdev_device_write(serdev, buf, count + 1, 0);
> +	if (write_len < count + 1)
> +		return false;
> +
> +	serdev_device_wait_until_sent(serdev, 0);
> +
> +	return true;
> +
> +unlock_and_exit_false:
> +	mutex_unlock(&priv->resp_lock);
> +	return false;
> +}
> +
> +static void linser_pop_fifo(struct linser_priv *priv, size_t n)
> +{
> +	struct serdev_device *serdev = priv->serdev;
> +	struct linser_rx dummy;
> +	size_t ret, i;
> +
> +	for (i = 0; i < n; i++) {
> +		ret = kfifo_out(&priv->rx_fifo, &dummy, 1);

Does kfifo_skip() not work for records? (I added it recently for serial.)

> +		if (ret != 1) {
> +			dev_err(&serdev->dev, "Failed to pop from FIFO\n");
> +			break;
> +		}
> +	}
> +}


thanks,
-- 
js
suse labs


