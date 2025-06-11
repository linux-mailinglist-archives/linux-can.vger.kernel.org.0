Return-Path: <linux-can+bounces-3809-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A33CAD56C4
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 15:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC8D160C7B
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 13:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9B2286413;
	Wed, 11 Jun 2025 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="M17/FgXi"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-70.smtpout.orange.fr [193.252.22.70])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FFF78F43;
	Wed, 11 Jun 2025 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647908; cv=none; b=VPLRzMXhA97VVIbiNxcqyVGdrEAlzvyU6bPgPj8GktQ6DRGq2Zh69QjF/hOaUr/n9NP6z0VIqgNwxjUwhk1Vi5KPwuFbNkVVMC39u/RSls+KM2EnYAXR9t8Olvx07P8rpBqvlP3WPJkA0CN0JvilaS4HiBosneom5F3TFZ6zu3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647908; c=relaxed/simple;
	bh=3ImL6HcMMuEnuKo/YZNjhvWD+k67FXIGpUec8YR+upk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJrT9Ziax3zyhhsWFsXm7xvSSn0zSXf2DH4pTYFdPJavb9r2/q0Qc9r/j2wJq6SJzqf+RwVPbFL7r4qu2+Rwoz1ao3roMDXifIhz6A1Nw1tc80qsjgDOwglmfrunRavrBxeVcX+JU9KuUIYONgclQPCxmRJq/4fY/+pZUAlzJuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=M17/FgXi; arc=none smtp.client-ip=193.252.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id PLK1uaf7zSZTqPLK3uQEoa; Wed, 11 Jun 2025 15:17:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1749647827;
	bh=gPwsajLBsNL8XA7/sk2C74g5jjpD7PSQHxW65bPJTD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=M17/FgXiTcdr7lS6G03JsO24EzLrPAbSaLdpabOS8KSO9ZEXvCwjxVSLQlhclwiey
	 GU56llktfNWO77AIbtJnO0IAiggrUGmaiUzv8Xmkw2DgB0RpdGc07IBsV0w1nsbXu8
	 fAXtlPWEo57EiI6hAVY6AQFCCwfdJ6BzRYW0kgC5C3yIIN6W5eFA9Fc3JLan2k8kHc
	 egUAG7bVTwa/EvSd4aaAKk/s2n6UNuFr5HTZgzxV3+RLRh3GYkYM20NYmhzLtOoyO6
	 HW0Pw9zzC3ok64XoPrHLF5ogesxujWXldaMR0SeWUqXPPz9UoJXWYF/7kr4W1ygWPl
	 fGi2IavEa67Cw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 11 Jun 2025 15:17:07 +0200
X-ME-IP: 124.33.176.97
Message-ID: <e252f15f-ea80-4969-b754-82da5f9a7f56@wanadoo.fr>
Date: Wed, 11 Jun 2025 22:16:52 +0900
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
 <b9ea7e0e-7dd1-460b-950a-083620dd52e9@wanadoo.fr>
 <CAMRc=Mf4qupdJEm9mWPF3-B3hprn6AvP7Po2=aQYbaSvFf8OeA@mail.gmail.com>
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
In-Reply-To: <CAMRc=Mf4qupdJEm9mWPF3-B3hprn6AvP7Po2=aQYbaSvFf8OeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/06/2025 at 01:05, Bartosz Golaszewski wrote:
> On Tue, Jun 10, 2025 at 5:48 PM Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
>>
>> On 10/06/2025 at 23:05, Bartosz Golaszewski wrote:
>>> On Tue, Jun 10, 2025 at 3:55 PM Vincent Mailhol
>>> <mailhol.vincent@wanadoo.fr> wrote:
>>>>
>>>> On 10/06/2025 at 21:37, Bartosz Golaszewski wrote:
>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>
>>>>> struct gpio_chip now has callbacks for setting line values that return
>>>>> an integer, allowing to indicate failures. Convert the driver to using
>>>>> them.
>>>>>
>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>                                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>
>>>> This does not match the address with which you sent the patch: brgl@bgdev.pl
>>>>
>>>>> ---
>>>>>  drivers/net/can/spi/mcp251x.c | 16 ++++++++++------
>>>>>  1 file changed, 10 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
>>>>> index ec5c64006a16f703bc816983765584c5f3ac76e8..7545497d14b46c6388f3976c2bf7b9a99e959c1e 100644
>>>>> --- a/drivers/net/can/spi/mcp251x.c
>>>>> +++ b/drivers/net/can/spi/mcp251x.c
>>>>> @@ -530,8 +530,8 @@ static int mcp251x_gpio_get_multiple(struct gpio_chip *chip,
>>>>>       return 0;
>>>>>  }
>>>>>
>>>>> -static void mcp251x_gpio_set(struct gpio_chip *chip, unsigned int offset,
>>>>> -                          int value)
>>>>> +static int mcp251x_gpio_set(struct gpio_chip *chip, unsigned int offset,
>>>>> +                         int value)
>>>>>  {
>>>>>       struct mcp251x_priv *priv = gpiochip_get_data(chip);
>>>>>       u8 mask, val;
>>>>> @@ -545,9 +545,11 @@ static void mcp251x_gpio_set(struct gpio_chip *chip, unsigned int offset,
>>>>>
>>>>>       priv->reg_bfpctrl &= ~mask;
>>>>>       priv->reg_bfpctrl |= val;
>>>>> +
>>>>> +     return 0;
>>>>
>>>> mcp251x_gpio_set() calls mcp251x_write_bits() which calls mcp251x_spi_write()
>>>> which can fail.
>>>>
>>>> For this change to really make sense, the return value of mcp251x_spi_write()
>>>> should be propagated all the way around.
>>>>
>>>
>>> I don't know this code so I followed the example of the rest of the
>>> codebase where the result of this function is never checked - even in
>>> functions that do return values. I didn't know the reason for this and
>>> so didn't want to break anything as I have no means of testing it.
>>
>> The return value of mcp251x_spi_write() is used in mcp251x_hw_reset(). In other
>> locations, mcp251x_spi_write() is only used in functions which return void, so
>> obviously, the return value is not checked.
>>
> 
> Wait, after a second look GPIO callbacks (including those that return
> a value like request()) use mcp251x_write_bits() which has no return
> value.

Yes. Read again my first message:

  mcp251x_gpio_set() calls mcp251x_write_bits() which calls mcp251x_spi_write()
  which can fail.

My point is that the grand father can fail.

> It probably should propagate what mcp251x_spi_write() returns

Exactly what I asked for :)

> but that's material for a different series.

Why? Are you going to do this other series?

If the answer is no, then please just do it here. Propagating the error in
mcp251x_write_bits() is a three line change. Am I asking for too much?

> The goal of this one is to
> use the new setters treewide and drop the old ones from struct
> gpio_chip.

Yours sincerely,
Vincent Mailhol

