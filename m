Return-Path: <linux-can+bounces-3843-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4926ADAC17
	for <lists+linux-can@lfdr.de>; Mon, 16 Jun 2025 11:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB221891357
	for <lists+linux-can@lfdr.de>; Mon, 16 Jun 2025 09:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD3E273D7A;
	Mon, 16 Jun 2025 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="OEyRP9xW"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-18.smtpout.orange.fr [193.252.22.18])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCAC272E6D;
	Mon, 16 Jun 2025 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750066697; cv=none; b=qdr4sJP+gETMoTRCW7T5n8f5aYylNeqT2uTAIBWVeUnwVUmRUooN/Vw2pGlO+2skWtcdi8hfhgekvNSQNIqVQ1gCclbwxWxBqtbObUAQgbfx0AlwLn+/FERXbC+An8BNH5nlILY0PyEKueVUpH44sa1Z6w0q211550Y6JOUDPTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750066697; c=relaxed/simple;
	bh=eFWpLJrvSktG6hsikqM/vAYb5SGJiAG2EBNlsdvsk8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BalvZG5STdPG7O5ZIegrv11Il2UVMiPmFsDXa7HBvLLdLF7GYygPsrQKwxJY/urUIIItVrkhhP16fIYJOTSouS9Di+w9tVUXw9s6Hx2oQv/al82GlJ0NJqjLO8T2vD30gmywoFeMYqmRlrXmhb1RjMGSzSWPSwlTQFK3TpaO4fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=OEyRP9xW; arc=none smtp.client-ip=193.252.22.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id R6GpufzEh5CROR6GquoLPE; Mon, 16 Jun 2025 11:37:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1750066622;
	bh=H3wLlyw8govUof7jzDiaEVO+xcofIEdKMOe3pzartzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=OEyRP9xW44ewXUweqboT5llf1e4621CPOiXfomOMnuGe8fCHddB6LBFiu0TwHmzM8
	 UyaZ98d7nUFc0r4kYXFoXtVhIrtlUKhu6bLcLYankmzdni5YPm0/2BFsCac+G63mpC
	 9CuKPxZmibBTRc2xNF8C8DMSTxr2C68HL3zGXVXEIGodQQJ+FnPGx+n6uZk7YGF3s7
	 kppAgo078Os2kmioe2fqN1jPOl75ZwDfY0rx6+n36e6m1K1i0TCDtYQzu4zlSQWysy
	 Nf80YeuBgis4QeSasjiSFXk+oIl7siJqJxsD+T7+yvrm5FxlQEWtFxFF3ARhNlClp3
	 krHPbjPpzjBMA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 16 Jun 2025 11:37:02 +0200
X-ME-IP: 124.33.176.97
Message-ID: <1716571a-664b-4b14-b94c-f76303766ec0@wanadoo.fr>
Date: Mon, 16 Jun 2025 18:36:51 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] net: can: mcp251x: use new GPIO line value setter
 callbacks
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-can@vger.kernel.org,
 linux-arm-msm@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 "Chester A. Unal" <chester.a.unal@arinc9.com>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
References: <20250616-gpiochip-set-rv-net-v2-0-cae0b182a552@linaro.org>
 <20250616-gpiochip-set-rv-net-v2-4-cae0b182a552@linaro.org>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250616-gpiochip-set-rv-net-v2-4-cae0b182a552@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/06/2025 at 16:24, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


Yours sincerely,
Vincent Mailhol


