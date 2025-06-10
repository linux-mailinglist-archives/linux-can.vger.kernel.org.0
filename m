Return-Path: <linux-can+bounces-3800-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F24AD3DDA
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 17:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99AEE168BCC
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 15:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F3B2367C3;
	Tue, 10 Jun 2025 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="EC83WCWq"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-72.smtpout.orange.fr [193.252.22.72])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F601EB5B;
	Tue, 10 Jun 2025 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570511; cv=none; b=RN2K58O9fnMwPjTDIEvi8ZgJqcY0Zjvd0j5tbKwU2hcpP/q938p8cA2En6mbXeFxjHUSDEG5K9g4NpH5G84Y1qtctwD1n+FDEqqMPoPQDa4uSJacJKmdmbET+oSsDkv7gB2lUQ5HlSCSfZQRzEWjSgOBwXllJpAY+RqEP1iDaPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570511; c=relaxed/simple;
	bh=DPCZKmqe6KLsdpWRELAuTfIYliurAwbzWQccF/Ay6zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxBXOMre/rvsX+7DbV6xD9ZAWdEJKLCYscmNoGsChR8Q4JkcBlKatNMGo3Bmi26glHMilKIqf5+IB85OdCoCM+YcF9UoE71na0QfgyzL+MbCzHTd6mXgH1P9VnPCSt1KiXdBw+5GYKCXOsAnw9+nztkgCCbWkQsczvV3uud43VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=EC83WCWq; arc=none smtp.client-ip=193.252.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id P1CsuQaoBVbicP1Cuu8707; Tue, 10 Jun 2025 17:48:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1749570505;
	bh=hLNYfBAm8Db4RivC9m4UtJY5EbKQApeN/nL5cCj0Ugs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=EC83WCWq0Suc7xo7F75oL6tuLJhZcGgcA6T6SjE5M2HznAFXg+53/ja2YV2L9jlm4
	 67XAJYZjzNIulLfpR9HbVmuA69kx2uRbqwRC7P4itIvQxYL7jWvnqZIqoFwUBoyCaG
	 H3MPbtXKHrbdoEz3hjUlSsEwc2yUrPfZcdlFT5dWCWJJ/0qWSWULoXHqI8jwgTD9wt
	 +88473ymjTW0O1lA5aOjECvA7xFkyKjOqMpuNk4fIXCc5bKmdofVWaX8JRwPiGBEKr
	 AfmH/5enwlcQEMJBSCx3HPKFHMg8JhbUC/Q3N0I4p387Fb8+i1cIfr4CTBAhSvUx1/
	 QTmOlFNpa0KAw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 10 Jun 2025 17:48:25 +0200
X-ME-IP: 124.33.176.97
Message-ID: <b9ea7e0e-7dd1-460b-950a-083620dd52e9@wanadoo.fr>
Date: Wed, 11 Jun 2025 00:48:09 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] net: can: mcp251x: use new GPIO line value setter
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
References: <20250610-gpiochip-set-rv-net-v1-0-35668dd1c76f@linaro.org>
 <20250610-gpiochip-set-rv-net-v1-3-35668dd1c76f@linaro.org>
 <b2f87cff-3a81-482b-bfdd-389950b7ec8e@wanadoo.fr>
 <CAMRc=MfCwz3BV15aATr_5er7wU=AmKV=Z=sHJyrjEvLwx2cMjQ@mail.gmail.com>
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
In-Reply-To: <CAMRc=MfCwz3BV15aATr_5er7wU=AmKV=Z=sHJyrjEvLwx2cMjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/06/2025 at 23:05, Bartosz Golaszewski wrote:
> On Tue, Jun 10, 2025 at 3:55 PM Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
>>
>> On 10/06/2025 at 21:37, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> struct gpio_chip now has callbacks for setting line values that return
>>> an integer, allowing to indicate failures. Convert the driver to using
>>> them.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>                                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>> This does not match the address with which you sent the patch: brgl@bgdev.pl
>>
>>> ---
>>>  drivers/net/can/spi/mcp251x.c | 16 ++++++++++------
>>>  1 file changed, 10 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
>>> index ec5c64006a16f703bc816983765584c5f3ac76e8..7545497d14b46c6388f3976c2bf7b9a99e959c1e 100644
>>> --- a/drivers/net/can/spi/mcp251x.c
>>> +++ b/drivers/net/can/spi/mcp251x.c
>>> @@ -530,8 +530,8 @@ static int mcp251x_gpio_get_multiple(struct gpio_chip *chip,
>>>       return 0;
>>>  }
>>>
>>> -static void mcp251x_gpio_set(struct gpio_chip *chip, unsigned int offset,
>>> -                          int value)
>>> +static int mcp251x_gpio_set(struct gpio_chip *chip, unsigned int offset,
>>> +                         int value)
>>>  {
>>>       struct mcp251x_priv *priv = gpiochip_get_data(chip);
>>>       u8 mask, val;
>>> @@ -545,9 +545,11 @@ static void mcp251x_gpio_set(struct gpio_chip *chip, unsigned int offset,
>>>
>>>       priv->reg_bfpctrl &= ~mask;
>>>       priv->reg_bfpctrl |= val;
>>> +
>>> +     return 0;
>>
>> mcp251x_gpio_set() calls mcp251x_write_bits() which calls mcp251x_spi_write()
>> which can fail.
>>
>> For this change to really make sense, the return value of mcp251x_spi_write()
>> should be propagated all the way around.
>>
> 
> I don't know this code so I followed the example of the rest of the
> codebase where the result of this function is never checked - even in
> functions that do return values. I didn't know the reason for this and
> so didn't want to break anything as I have no means of testing it.

The return value of mcp251x_spi_write() is used in mcp251x_hw_reset(). In other
locations, mcp251x_spi_write() is only used in functions which return void, so
obviously, the return value is not checked.

> Can you confirm that you really want the result to be checked here?

That's the point of those new gpio setters, isn't it? If we do not check the
result, I do not understand the purpose of the migration.


Yours sincerely,
Vincent Mailhol


