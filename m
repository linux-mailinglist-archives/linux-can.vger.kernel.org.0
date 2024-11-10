Return-Path: <linux-can+bounces-1920-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CA99C32C3
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 15:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064201C209BC
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 14:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B7B2233A;
	Sun, 10 Nov 2024 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qSp17F09"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C620D2FA;
	Sun, 10 Nov 2024 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731248355; cv=none; b=KgZcS02bIuxlY0AQ6wFuZhxCKMEXMl/LkswW5XpKRVJJIH4MKWFE87Pi8l21piTtRP0rYEkGpjBLXr3dlRapXWqp24uGxrawIdR8mQCdcDP5aq0rfX/6Cr0au+wSNq2R2uTXBqwuAmD6YCpv1jEK/7ikuYCfzy1PRy6sRrQTZEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731248355; c=relaxed/simple;
	bh=A15GK6oBtzujOcY6O3nLHxGUewal/vs1xqbVRbPVoV8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=JBWqvZlpBcazIyaWctE/OOddO5WOYElOVZKJ4/9RxTNs/X3KJNnkYHsl/Hp/BNjCsrJhqxlRkqwtiW/xbEWHXVOL2tgVlKqUyNE4mp69FXNFC98Zhh6qFn9BJoYxOeD/DrRdKM9S5tteEu8cgvW4sFCdzZHs/HEUxUhODUtUsXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=qSp17F09; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731248294; x=1731853094; i=markus.elfring@web.de;
	bh=A15GK6oBtzujOcY6O3nLHxGUewal/vs1xqbVRbPVoV8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qSp17F09WfwRfJvCnf/7qwvkIDgLqD+7ePKpIpQ8FjlgypZ3p7y9WPsbVqoIVzDk
	 J4L1Euz1Y9gpArCV7X1izo2PVN4CeExJ9ihRuj+Xez1YpIYj60dLW+eR2pR+V5v1B
	 nRGpMKxgEL/9Vsy/OTiYgtdIk/0yMlwwZZOF7Nu7tvR5rFpZ16ukNNR+9XuvzgWYf
	 s2KkH6sb8EmXMtGcfl9UTwI652wA5wt9R99ghpyuM+PUJp3nAfHm/TeYBal/EzU+S
	 aFzLrNViKkcxR+NBAotAs/ceoeJR8zuHe+yvHNzjIcFd4t0stXvO65Ot+XqNh2yV2
	 k/+XEtIOKi9cDvSAcQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M28SB-1tCcoB1COH-00EqVy; Sun, 10
 Nov 2024 15:18:14 +0100
Message-ID: <60300a57-aaaa-4e9d-8a44-ee2b3c197ea4@web.de>
Date: Sun, 10 Nov 2024 15:18:06 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org,
 linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 UNGLinuxDriver@microchip.com, bcm-kernel-feedback-list@broadcom.com,
 Andrew Lunn <andrew@lunn.ch>, Chandrasekar Ramakrishnan
 <rcsekar@samsung.com>, Chris Snook <chris.snook@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Doug Berger <opendmb@gmail.com>,
 Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Jakub Kicinski <kuba@kernel.org>, Kurt Kanzenbach <kurt@linutronix.de>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Vladimir Oltean <olteanv@gmail.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Simon Horman <horms@kernel.org>
References: <20241109233641.8313-1-rosenp@gmail.com>
Subject: Re: [PATCH] net: modernize ioremap in probe
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241109233641.8313-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ONLWgX5Z+nK1YwOVREIImDYLzQ+s/3MBv2ELUVucMab+65YLRTz
 v0xLXJ0ydx4plkVjtGwOcZsO0gHGHNzk+U6bq6XzSHVdBCD8/4ZJ200jAvt2g5vEMMSPN3A
 JaWhzzml1DI1rQIH3pSSy1DqYyi0iZlgA8cKt/0S80zw6tns5TgjZXC00I9Szm37mWz0xZm
 jHSz0DAaR7v2OwzutSdIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8F2WX9DLYa8=;Jrra2U+D7HiN9J1mk3lQt9mLfrO
 mwfQhq6Vb5LyIIlVL9w6w9jU+cB8StAQHyJgXzrk97qUywcj2azWv4uz6HVX0onc6fkp7tVq9
 SgV9D/SUJwu6Eyef0/8xSut7zmH6by3iEz966MTXlq/iAkQ+3vTcfxFalLuQW2JFyfav2X3B0
 Oe9a/GfHQ1yaeXR47XF/dkv2ytHApSxS4VeDh182kAlJ+BA7h8xVTrMCzj2GAN4ioDsD5LMXa
 9gD+QtTVeD1KO2ElruAmI8ZwfpkRTT8eD1Kbmy00IXgu/Uc+clv4FL7V1YlSI2SrLdHS3LWSU
 CAl09VlXiwxyILc3M55zHpdOFcbP/0zZTppuB2WFMJAKcUd6hMzrsYRSpcGGRRSJPpwjBg3pl
 G0B5uiQxcVYu32R9whb1vBJuRoTGsrXtvVkOZLaBGj/nFRHWodBwTuYyUjBUPkvP3a3V4+ec8
 Pd4JOx+SdFArIX/2DRB0vm3HTfk36X40dFXZQEGXuBqkoD0JDrshqRx6QCnNga1jqL/MrzBxo
 tUrhiMUGukODhFjOGJLMh249TlO8fzntJQSniW8otzxh4xxR0D1SgoHYXTc+/mmIAbVD95Y3x
 XhuN0ol4lKKi28YFlLida4iwudna1sg39Xk97GGuSYpCGZO9HYU7wBcMkcVONgjQUw8uJyRiX
 pdMpyy7mRo6F3vfpQEPUeyrtowEph6XDbhSlebaV9Kigh45AjAYtPYFg/i0Xa4NkhLSu0aYom
 doMoMe7DzMAKFhkyFpHKplfMPEvTwL6JWKVAudjy907rxqZIMo1Ed89lGImM6INN/Mh1IJRMV
 /Esj3OddtzZHv/iVxbbYfE4w==

> resource aquisition and ioremap can be performed in one step.

Will another imperative wording become helpful for an improved change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.12-rc6#n94

Regards,
Markus

