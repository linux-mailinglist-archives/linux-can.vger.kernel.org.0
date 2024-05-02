Return-Path: <linux-can+bounces-528-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9AF8B9673
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 10:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83731C20EF4
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 08:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E641F61C;
	Thu,  2 May 2024 08:30:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B05E1F17B;
	Thu,  2 May 2024 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714638635; cv=none; b=Zd/XatN94UIY+9b1TQMVnpPNYKr+kbE/Z93ndAfmJ9Hen5v4gue68OPqUfl3B7LfYrLk6iEhRlp6jXwRXht0EUhR7W5no3EnHRk0w5/DTxrxGXidFndtRTYuL4qYAmBIYmYnD8J/VJ7E8wlEeNTzfWsZQWQm86T7CZDOf018/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714638635; c=relaxed/simple;
	bh=JhvLdeIFoIVobHMRld9FPEDzk017zSxjlF1PyrnK4bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PlNAjh/kql4bKQxNNziLG6sl6i5+g1iAvCEdhzT8jQDKm3745AiksJlf1AWiiGdM2h18N9w9hbSskh8PT3wzItnRMQq4P4EAhTRfU3V8UHOeupy9RXuG5MGR2hjE4mXYHTpyXMhNYzZKgfeMUO3dzP0w1eNtGDLdxOZZN+ZY980=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5708d8beec6so9369707a12.0;
        Thu, 02 May 2024 01:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714638632; x=1715243432;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nqDs8aP0Ox7FEuplQ3aDuJPLYaqPbB8MPDq15KMt80=;
        b=KnFnEZTnxge0JcClWo9FIxRDdZryAwBCn2ECjBa6knwjpk3v6cdlj7qcUvQf/wQnsM
         oD+CwsoL89FsS/5c9LkpcXsQVtr9/8IG8J6lBrbj+lQmzN1f1zthOzR9TuUex5FENzAi
         FQ1nt0yyBZdow/yOLrNXh2C63nDMe+l8IQ0OKH1jiKmjW7YX2UfRzB4c0+InX0KbbJA1
         LVel8akwiZc+8xan+YjuVMaQWdBq2RcYyq0WmboRXPj0XYN7rfRVSwlQV78fgLtToMBY
         BcDH7treO99w9N2iB20nn/Lgp0AXtrD2nWXDUcfMT73zPIUiYrU/rgJT36wc+NpczrWv
         uZEg==
X-Forwarded-Encrypted: i=1; AJvYcCUaQ1bS+qJAvC7wYntdtimizjgpe51KbsrYlhqCMsCXJLvD6P2Ekl/DQSlzgV80ychGFw3SukUdygpmqgxwdgtozmSTxJ5Cb1OfHHXJSSQNin+pq+jpg/mTOwfCMyyGARgLfyvNvhPIs9qUqyKUckAEDMI7dc8fZs5jdXE2fxZQgth7N2KzQ03AmmFo58HPSXSjnKq2/VfP+RVMtbxPGMO0eiB9RuNsDW+Q3p1YdyVxs+yJZux6//g9
X-Gm-Message-State: AOJu0Yx44ahGYI4QO3vP8iCTtaA+OR4I9AKYp+pkhnTmSeoOY2M97CDp
	YL7L3w6hIQlm6M/GL+W/m08Lw5DYeTMbg+cti2AvClaTvsKHUXL5
X-Google-Smtp-Source: AGHT+IEETnj/81l1N+gAbN1FKpJVqKnmVUPZ1k8ir7VsptrXf1wp0M49h4+sRvcM5Outr3PjKIV7SQ==
X-Received: by 2002:a50:9ee2:0:b0:56d:fb36:c388 with SMTP id a89-20020a509ee2000000b0056dfb36c388mr1429740edf.9.1714638631645;
        Thu, 02 May 2024 01:30:31 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id q12-20020a50c34c000000b00572459a4ffesm275430edb.56.2024.05.02.01.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 01:30:30 -0700 (PDT)
Message-ID: <acf0251e-41b9-410d-a663-ff6c34d2bc3e@kernel.org>
Date: Thu, 2 May 2024 10:30:29 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] HID: hexLIN: Add support for USB LIN bus adapter
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
 <20240502075534.882628-3-christoph.fritz@hexdev.de>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240502075534.882628-3-christoph.fritz@hexdev.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02. 05. 24, 9:55, Christoph Fritz wrote:
> This patch introduces driver support for the hexLIN USB LIN bus adapter,
> enabling LIN communication over USB for both controller and responder
> modes. The driver interfaces with the CAN_LIN framework for userland
> connectivity.
> 
> For more details on the adapter, visit: https://hexdev.de/hexlin/
> 
> Tested-by: Andreas Lauser <andreas.lauser@mercedes-benz.com>
> Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
...
> --- /dev/null
> +++ b/drivers/hid/hid-hexdev-hexlin.c
> @@ -0,0 +1,630 @@
...
> +static int hexlin_stop(struct lin_device *ldev)
> +{
> +	struct hid_device *hdev = to_hid_device(ldev->dev);
> +	struct hexlin_priv_data *priv = hid_get_drvdata(hdev);
> +
> +	hid_hw_close(hdev);
> +
> +	priv->is_error = true;
> +	complete(&priv->wait_in_report);
> +
> +	mutex_lock(&priv->tx_lock);
> +	mutex_unlock(&priv->tx_lock);

This is a weird way to implement a completion. It looks like you need 
another one.

> +	return 0;
> +}
...> +static int hexlin_probe(struct hid_device *hdev,
> +			const struct hid_device_id *id)
> +{
> +	struct hexlin_priv_data *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(&hdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->hid_dev = hdev;
> +	hid_set_drvdata(hdev, priv);
> +
> +	mutex_init(&priv->tx_lock);
> +
> +	ret = hid_parse(hdev);
> +	if (ret) {
> +		hid_err(hdev, "hid parse failed with %d\n", ret);
> +		goto fail_and_free;
> +	}
> +
> +	ret = hid_hw_start(hdev, HID_CONNECT_DRIVER);
> +	if (ret) {
> +		hid_err(hdev, "hid hw start failed with %d\n", ret);
> +		goto fail_and_stop;
> +	}
> +
> +	ret = hid_hw_open(hdev);
> +	if (ret) {
> +		hid_err(hdev, "hid hw open failed with %d\n", ret);
> +		goto fail_and_close;
> +	}
> +
> +	init_completion(&priv->wait_in_report);
> +
> +	hid_device_io_start(hdev);
> +
> +	ret = init_hw(priv);
> +	if (ret)
> +		goto fail_and_close;
> +
> +	priv->ldev = register_lin(&hdev->dev, &hexlin_ldo);
> +	if (IS_ERR_OR_NULL(priv->ldev)) {
> +		ret = PTR_ERR(priv->ldev);
> +		goto fail_and_close;
> +	}
> +
> +	hid_hw_close(hdev);
> +
> +	hid_info(hdev, "hexLIN (fw-version: %u) probed\n", priv->fw_version);
> +
> +	return 0;
> +
> +fail_and_close:
> +	hid_hw_close(hdev);
> +fail_and_stop:
> +	hid_hw_stop(hdev);
> +fail_and_free:
> +	mutex_destroy(&priv->tx_lock);
> +	return ret;
> +}
> +
> +static void hexlin_remove(struct hid_device *hdev)
> +{
> +	struct hexlin_priv_data *priv = hid_get_drvdata(hdev);
> +
> +	unregister_lin(priv->ldev);
> +	hid_hw_stop(hdev);
> +	mutex_destroy(&priv->tx_lock);

It is unusual to destroy a mutex. Why do you do that?

> +}
...
> +static int __init hexlin_init(void)
> +{
> +	return hid_register_driver(&hexlin_driver);
> +}
> +
> +static void __exit hexlin_exit(void)
> +{
> +	hid_unregister_driver(&hexlin_driver);
> +}



> +
> +/*
> + * When compiled into the kernel, initialize after the hid bus.
> + */
> +late_initcall(hexlin_init);

Hmm, why not module_init() then? (And module_hid_driver().)

> +module_exit(hexlin_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Christoph Fritz <christoph.fritz@hexdev.de>");
> +MODULE_DESCRIPTION("LIN bus driver for hexLIN USB adapter");

thanks,
-- 
js
suse labs


