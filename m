Return-Path: <linux-can+bounces-133-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5A382D65F
	for <lists+linux-can@lfdr.de>; Mon, 15 Jan 2024 10:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 447E7B2134B
	for <lists+linux-can@lfdr.de>; Mon, 15 Jan 2024 09:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB6BF4F6;
	Mon, 15 Jan 2024 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l3Q4DLLh"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B89F4E4
	for <linux-can@vger.kernel.org>; Mon, 15 Jan 2024 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2ac304e526so796340466b.0
        for <linux-can@vger.kernel.org>; Mon, 15 Jan 2024 01:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705312354; x=1705917154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pV7vfHddpIjdo1gvqUviCk+EZ4jPGodxukJi3Cbz8BY=;
        b=l3Q4DLLh0/X7PRCPzveA7chRq6ngkkDoOFa2/ePiLDbfGft4L0dGQilXPAjJOvGLFI
         ZkF3vvyoXYgwzRovMOJY+8FedS4B+K5iFUboBH5XODO1Tox5q5TYK4ByBQqiXO6Wn4sk
         ayYuKV4FX7zv78d+RQQn4193jKd5LO562HqMPKwtMY0pxWrDquL76c75C1eJS0KwijgU
         TNQDd0ze5TAxJuxew4VNsGauK/78kJqEWtoXLYVjS796nKeaa5Z0peMvzR5dmUZdxyMu
         pM1zY6h5i/A5Rbqmk/KvDhIWAPNksCOAbuAkHdku2NRVq2No4fyzDXQdCDSqh2u1M+ex
         u/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705312354; x=1705917154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pV7vfHddpIjdo1gvqUviCk+EZ4jPGodxukJi3Cbz8BY=;
        b=X9MKYaII/hXrCXW9Z8xmCJFjITZzZ+JHxjMXrZ96NDz/N+LfpPOKaU3FR+iULGnDc8
         u3gxMrV7HNo65GASTQnLioRnmUzsX91T6xg+T2XI4aELUDVLuveLGoUl6zrCjHaImnO1
         ad7dxmOQmYznXi+ZNc0jqa84kWiBsI5FyDJ5tJqw5YYQfqkGgFQQsCXlHpqxCNMAoFzz
         SdbDRl7Z+nW4hUdpWemwPAX/cglUPaxw4rGCD+8MudsvohOZCP6qRrhkB4+ZQyZ5bu6f
         ABX05MjYGJ1kqOrtCFXyH4dEkzk/jfOSa4dsWv7qyZYxayDkCLEQerO+tSsySEQFNeqA
         BcYA==
X-Gm-Message-State: AOJu0YxZedjqGcvYFc/3cq6bJh7rdigUIRSVLZBQ9rwFGZbuLVy7ps5F
	Ak86Q27fwJfCZN+oGa0YDSGuZU2pA3GMCg==
X-Google-Smtp-Source: AGHT+IHg4iG+SxOvbGjJMJ0Mi05uMNiQ7rB6L6vuzmWHpH8DTKCsBTCPKrMB+dvhpzz7VfL5uOZEyg==
X-Received: by 2002:a17:906:a1d1:b0:a2a:19c8:e4ef with SMTP id bx17-20020a170906a1d100b00a2a19c8e4efmr2337014ejb.141.1705312354303;
        Mon, 15 Jan 2024 01:52:34 -0800 (PST)
Received: from blmsp ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id k16-20020a170906129000b00a274f3396a0sm5149479ejb.145.2024.01.15.01.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 01:52:33 -0800 (PST)
Date: Mon, 15 Jan 2024 10:52:32 +0100
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: m_can: remove redundant check for pm_clock_support
Message-ID: <nls37vv4rj6pn5vvrjizapb23l3mikpwkh2fk7gtrpnxgiym5b@jbmlyci4q3pg>
References: <20240104235723.46931-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240104235723.46931-1-francesco@dolcini.it>

On Fri, Jan 05, 2024 at 12:57:23AM +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> m_can_clk_start() already skip starting the clock when
> clock support is disabled, remove the redundant check in
> m_can_class_register().
> 
> This also solves the imbalance with m_can_clk_stop() that is called
> afterward in the same function before the return.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Best,
Markus

> ---
> I spotted the issue while debugging some other part of the code,
> the patch is only compile-tested.
> ---
>  drivers/net/can/m_can/m_can.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 16ecc11c7f62..bd1d1626684d 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2056,11 +2056,9 @@ int m_can_class_register(struct m_can_classdev *cdev)
>  {
>  	int ret;
>  
> -	if (cdev->pm_clock_support) {
> -		ret = m_can_clk_start(cdev);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = m_can_clk_start(cdev);
> +	if (ret)
> +		return ret;
>  
>  	if (cdev->is_peripheral) {
>  		ret = can_rx_offload_add_manual(cdev->net, &cdev->offload,
> -- 
> 2.39.2
> 

