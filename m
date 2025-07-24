Return-Path: <linux-can+bounces-4084-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 162D8B1015A
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5EC189BBA4
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 07:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D25205ABA;
	Thu, 24 Jul 2025 07:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBJWN3L0"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC75D20F088;
	Thu, 24 Jul 2025 07:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753340937; cv=none; b=NT0f+cNR65MgQVa02vN3PqHJm29YxNC3wMo+FK0I8W4NEDtzIh5vLC2vyjQmeYIn07dbKY/OAFY94WvS1PbRFuzxTBsbz/xIveCxnyK+li3uhDYO0oAUwvTNYyEA0pE2VCapmKO8YSlGufBqXpFNlN4c8zxLpKs/Ad4nAzX2yzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753340937; c=relaxed/simple;
	bh=AkoxQPOOiF/aQiyAC1eeSXV9ID50adMeBrnsd/bug54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PULm29OQSZ4pY41jqyCnkWm45CunH/q14kGOd5DXQNYksYx9/C9cMZouGGvQqgUgFWqmRE0aDBsazxINNNekPLeIQKRLQ8Y5Gt+HOQBj9oBr8HJkrnqNZ8vH5FdUAtgZDDBlVFKl8ak3sKsyvxTODoenUkw9TjxfalarkV5NC+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBJWN3L0; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so1175549a12.2;
        Thu, 24 Jul 2025 00:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753340934; x=1753945734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X0fBKPgNJeW4Io9I4Kt9A1Nv/rNYIz+bEppGJAXr/QE=;
        b=GBJWN3L093VgzvVlYk1L+l6zDdUq/oKmBBez6Gdugrqjmv4eDq12ThGMpxYPn72Owe
         wffJfJexF0HnVqRB/zA0HzMYEYWeGmrc4aFDwADqcW8QRFpumW4LhoOB8bR0DJykqS4u
         gWyrCwdVbS+D84PFYgwEE28ONSsnTYNbTyvyHNNt6LvBG/D2YKabzi/UKlGVCcfMn+Y8
         37GkrAwgWZEeCFywS4mxL6zTR8v+ps0Q5KWPumdVaGaW56E2HDrjk4a7zM9UFWX+aXVt
         eoFRV42QSUV+WxuS4lHkrBVlW40Nng3GmcNETEyCiBhTodcx1e9zbruBH5BHbVlnC/6s
         sL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753340934; x=1753945734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X0fBKPgNJeW4Io9I4Kt9A1Nv/rNYIz+bEppGJAXr/QE=;
        b=p4f97tJPRXtTts2uxjtinAHwT4V4YZE2t7b2XFIijRN0LYJZlTJ6+t7665ncNDERov
         Zc7JdUn2pLZJXkJkdiMDltPhNnfzxGdT3v9RCJNP6pPDLYvLgndfss02+L5CmyvhPbpn
         bywzGnKBE+P/XGgL63GQiIbdL3vVRVFlYPQ3ausm1RqMPJpQudC7D8V8exScc/G8W1MW
         Sn5PUp40vFnvlG1vn+jw1dxcgJIixsqL3VDoSSAFozQADWEk7xqzeMHSb9+EAWQ9O5xI
         uo9Pd7joxVHi9YlHCHlftnbOiFjbbFwdlC7+p0SOJJNddD3QcDPx1X9JKeDWouZ9dhG/
         kVMA==
X-Forwarded-Encrypted: i=1; AJvYcCXc42s6lNWonJ9RAxIFDehZ8x94B7L0oaJAGLeWge4KuJ3l6XkTU5d1YJS8S6lkbfIucXXLPgpNu8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi0s5yzLRtU26Cf/SHbQ2pQ0a4gj9auHwPI+xG1Eou0Esf4A9l
	PM3RZGuI9WdIJvXdij1A64a32ti3iCygOdFtopcoHONvwnfalu01VNri
X-Gm-Gg: ASbGncvujOMHZz4ulbvKLiqqXbJXijGNCYrMmSjoyUGf69U6Hdz+bO0kaG6IjwXIpbw
	NJgZfxh/ZDE2lf1JjdqB0bm63uALrKYn0y/tYMalaNy3hcCCaRp5/LDipXiOZ+HZZnhIGZS73th
	WFjZ5PmrhXhp9go6Uk1LrMBwDCJQKxXpqE4V5Q4LEv6g48DpXhtDzRM5ccBF24uEdyTC2l/fQBu
	vaULJokrbqFJI6pUkE4tBdmRIvq+1oFkiuy87u5rs0XTb/RTNXZFjHxeEbs2LAZ2+mXlhIn12g8
	kwAlERKjcqBh4U+rs6rhZiFvMReBGotbwAyD9T5zLHEZ981kVMq7IHXkt5/OdGlw7po9eLr+9ku
	to3EJ05gsD0N0oVrnZEKEMS0649l/11J8xrVzVpM+kRMGCE4AwdKfTW6UN5kP9gqQ57jgGwLsvf
	99
X-Google-Smtp-Source: AGHT+IGI3dw98r9/AX0JpcyFuQuMgWlRlrNwOU79I0/2HIfC9ukE9LVLetf8Me8u8maKdpkM5IXtqg==
X-Received: by 2002:a50:9517:0:b0:612:c4a1:1381 with SMTP id 4fb4d7f45d1cf-6149b5965abmr4330267a12.26.1753340933922;
        Thu, 24 Jul 2025 00:08:53 -0700 (PDT)
Received: from [192.168.66.199] (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-614cd0f69b5sm475377a12.21.2025.07.24.00.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 00:08:53 -0700 (PDT)
Message-ID: <a88f2cfa-69e1-400e-ad67-01ae83f3f9f6@gmail.com>
Date: Thu, 24 Jul 2025 09:08:52 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] can: kvaser_pciefd: Store device channel index
To: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org,
 Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org
References: <20250724063651.8-1-extja@kvaser.com>
 <20250724063651.8-6-extja@kvaser.com>
Content-Language: en-US
From: Jimmy Assarsson <jimmyassarsson@gmail.com>
In-Reply-To: <20250724063651.8-6-extja@kvaser.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/24/25 8:36 AM, Jimmy Assarsson wrote:
> Store device channel index in netdev.dev_port.
> 
> Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> ---
> Changes in v2:
>    - Add Fixes tag.
> 
>   drivers/net/can/kvaser_pciefd.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
> index 7153b9ea0d3d..8dcb1d1c67e4 100644
> --- a/drivers/net/can/kvaser_pciefd.c
> +++ b/drivers/net/can/kvaser_pciefd.c
> @@ -1028,6 +1028,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
>   		can->completed_tx_bytes = 0;
>   		can->bec.txerr = 0;
>   		can->bec.rxerr = 0;
> +		can->can.dev->dev_port = i;
>   
>   		init_completion(&can->start_comp);
>   		init_completion(&can->flush_comp);

Would it be better to submit this as a separate patch, or keep it within
this patch series?

Best regards,
jimmy


