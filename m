Return-Path: <linux-can+bounces-3842-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C90ADAAE2
	for <lists+linux-can@lfdr.de>; Mon, 16 Jun 2025 10:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1A7169C92
	for <lists+linux-can@lfdr.de>; Mon, 16 Jun 2025 08:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EDB27057D;
	Mon, 16 Jun 2025 08:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="fsYltiCq"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-13.smtpout.orange.fr [193.252.22.13])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87D81FFC6D;
	Mon, 16 Jun 2025 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750062981; cv=none; b=Wd75/xLmPsMcR38yNX59C0sQUkzjSgJWYFiwbsakYQ/+w1K8zrU+TxCCZXEa/hXtSNie5UFHdXhc1OylS8Q5ch4DgoOAJ2k2XT8aGGOjbvFO1T7lW2Usytn9b10q1+672+gLh7BpABcbyBCBudIc7ky0m190ZPqXXOHHCMNgGfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750062981; c=relaxed/simple;
	bh=utrvK5z++4pWgL/XQzh0Lgu2WUPVRlcJZdqAcKgzPW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TO0hVnBhuFaTJTCNscqenPL7vOugKiDqarc0eU0vEpcOJtVaPVDWgtttXVqP70ZFxgbuzWAmqi5MiJvwxMuaDuKh6RPw4fkEnv4QScrbaKsztJ/RnaRyDzknIO6IZuuiQxEN7tUCsbHpTjTnPfcoXUJLbS5mFTjZoTBIoMaIk80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=fsYltiCq; arc=none smtp.client-ip=193.252.22.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id R5IeuW612OV6eR5Imu85m7; Mon, 16 Jun 2025 10:34:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1750062900;
	bh=yljn2wE0jxa3Ta1cbirF7DuNbCTWHRKQYs9jILtQOYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=fsYltiCqE50Oa0GcKzBw679uxCrG9XJtgv0kp7F4MUXqm0R8UF0EXWim5Uuo5kiX6
	 UEh/FQSbHha17lgba4Cv4KclKCZGH2qFoo4SPm9yUvbpLOgNvncJU4R0s+pXIMD6d6
	 OMEqNFAIcjYwZ+AqHO9wx6hJgT4zd2iLhIlYwz0vkq6KnXk8XKDtpL1ETYHOxuhSAq
	 Ep1FK8MqIsTTUVgVtMfXXr5gc9/mSV1ppjYn3PWQIP5CnUPVRUE25Zs400PyTjDJbo
	 HpqFPuRnsGxRHaXIoUGQ9TUtgZmem8cEgWGB8vBI5ej+BXdQ2Jd7XBBAjyepJjLITi
	 iBH60L1r8VjNw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 16 Jun 2025 10:35:00 +0200
X-ME-IP: 124.33.176.97
Message-ID: <0b74cdf8-516a-4f13-928c-4d88307bf1ed@wanadoo.fr>
Date: Mon, 16 Jun 2025 17:34:38 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] net: can: mcp251x: propagate the return value of
 mcp251x_spi_write()
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
 <20250616-gpiochip-set-rv-net-v2-3-cae0b182a552@linaro.org>
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
In-Reply-To: <20250616-gpiochip-set-rv-net-v2-3-cae0b182a552@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/06/2025 at 16:24, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add an integer return value to mcp251x_write_bits() and use it to
> propagate the one returned by mcp251x_spi_write(). Return that value on
> error in the request() GPIO callback.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


Yours sincerely,
Vincent Mailhol


