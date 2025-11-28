Return-Path: <linux-can+bounces-5764-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B38D3C925E8
	for <lists+linux-can@lfdr.de>; Fri, 28 Nov 2025 15:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 984E54E13D0
	for <lists+linux-can@lfdr.de>; Fri, 28 Nov 2025 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B04627EFE3;
	Fri, 28 Nov 2025 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="o26WZO/B";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="OjTHfHHu"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7B727B336;
	Fri, 28 Nov 2025 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764341483; cv=pass; b=DsIcNDxrAen+1b0jDv2C/0uPyAk89fxP4Oak1+tjo0sqAFSJ1NOyL7olP9Qpz2WS9ZRLN8G9JIIoQY1wSKlmeSsckboew1IR/aSflg0vG7CoWju4FOMKanIcm6Axbo66WTBoeRSbZxe+8klmffwz6SNLWG3GzDTG+ol8z1+H7/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764341483; c=relaxed/simple;
	bh=3FShlcCg+Pr5j1E+pNyuVtI7M+H2N+PyiCSx+4YrszU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+eQ9d1C/cNbiJ+Od8W8pviCadofbHd4Hv6I5rFhM6cIIA6PazCzOC5+V/sqQU+iHCxIuk1Xq+MNV55ZbUJyAPv28zSk7jzKuHNoM9cbbte/WkdMnfKt0ApnejV1sgy5jlmlbO8Y6u5yIpNfed93zrx/TrLKLvbaImOd2SV1pfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=o26WZO/B; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=OjTHfHHu; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764341459; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gxZxGw/cEC3+v+h3QzmWxGwrK7RNLt/UbFnOpaiVhMsGExiNxlJPIroYlHNv46R466
    rIyamhf3ek+BDmlJDECHLGYpQcTQwPBYZtHmfoH3EKh5psA7kYhvo27P4MO9Ugv3SveT
    hBdvmyP/wV05EBSjDN/ei8FD8GI1n5vM3LTrrXg/SfS1GCDlkrz/q7koNkA91xwhrgfQ
    3XbTG046NF8G0kTjpx1sRkbRj6abKQKZt5FS5lQ4evPiXGlmSPfFsoB+P++A0XZzuhNL
    SgLT7rYKdu5GNr8fOFt8FTKX5h77FjDTZH1n4DOPytAFeRj34sBJ4UdnHVPdm8r5Xvjh
    LmFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764341459;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VlyUY3+VdrFQqkZ6djdBbXTEwwj2zJnGsCTpqBJE/OE=;
    b=kVFpWQ0h4Fs17+p4IMkYaHtmSOpgW5X98sQmXp0jGfb/8h3Dw5OHEeO83oXEIuOtM1
    /sUNChrt/DsuM2ZPZMoLFPSyfYiG8liWc+Uz9zmFQDsI2nhspNUzEwbBy0hzfIl+Maog
    AnwYr6G5FCDJAS5p/4uir5YIc9wxYk+A9P/MwQlp/pUKfg7qiw7rh9lXSo1JShcmH/FP
    e24UqDhN/y5uT5syBv6SHxuSRxEDQhxj+Fs1y4+mwHNZ7l00KPMOJDfp6bRHwRIu80fg
    L10gXnUa++rWTmxjZXhHMRtAqE2LibI4Tbu31SDcL+X+t1OkIjaXJzzGN3PFQNyRi01Y
    Bbyg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764341459;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VlyUY3+VdrFQqkZ6djdBbXTEwwj2zJnGsCTpqBJE/OE=;
    b=o26WZO/BzzvPxf7j70tgHPlD7GS1Rmc/9GcW9FlvCP4DjXaQW7FPVRsgzyjsJcwtiD
    Lj52+JQm8qxiSU0br2wy8Dtk75CNhi2PtZrw13mEOcIS9A312SSfNjgf4XTW5KR/EJXW
    H3LCxbyXwY/RyfsPEy+pE6CrZirhZfwjjIoKCXdIP86kFzsByKsk8gzIBD7obDaInQFW
    QPkPhi0doD0YQHYUeUG9Hu6oeVahBfKM5ohmAp57ewRjrRO+EkoFOqX6HOfS5B5trArQ
    ZNJzqgIEi38RoNG2G1gTSU/eDJAxSOxKGlqIq+GPzP0MsJkTh/kVrotnujObbsvSwKk6
    Ahmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764341459;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VlyUY3+VdrFQqkZ6djdBbXTEwwj2zJnGsCTpqBJE/OE=;
    b=OjTHfHHuzZcONW07PsXFo5c1sDpTRDgxm+4FAP1BEHc/Iw2/pQDwCgbGsRAxP4zrgZ
    i1fCiq67ENwvq8Uw5cDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ASEoxg6U
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 28 Nov 2025 15:50:59 +0100 (CET)
Message-ID: <1cc79929-ec7b-4d34-8cf3-25132da77e64@hartkopp.net>
Date: Fri, 28 Nov 2025 15:50:52 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [can-next] can: Kconfig: select CAN driver infrastructure by
 default
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, kernel@pengutronix.de, Vincent Mailhol <mailhol@kernel.org>
References: <20251128100803.65707-1-socketcan@hartkopp.net>
 <20251128-terrestrial-gainful-goose-0723b2-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251128-terrestrial-gainful-goose-0723b2-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28.11.25 15:43, Marc Kleine-Budde wrote:
> On 28.11.2025 11:08:03, Oliver Hartkopp wrote:
>> The CAN bus support enabled with CONFIG_CAN provides a socket-based
>> access to CAN interfaces. With the introduction of the latest CAN protocol
>> CAN XL additional configuration status information needs to be exposed to
>> the network layer than formerly provided by standard Linux network drivers.
>>
>> This requires the CAN driver infrastructure to be selected by default.
>> As the CAN network layer can only operate on CAN interfaces anyway all
>> distributions and common default configs enable at least one CAN driver.
>>
>> So selecting CONFIG_CAN_DEV when CONFIG_CAN is selected by the user has
>> no effect on established configurations but solves potential build issues
>> when CONFIG_CAN[_XXX]=y is set together with CANFIG_CAN_DEV=m
>>
>> Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
>> Reported-by: Vincent Mailhol <mailhol@kernel.org>
>> Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> I think we take this, at least for now. But I'll remove my Suggested-by,
> which was a leftover from v3.

Sure?

I remember you suggested some Kconfig magic :-D

Ok, this patch has not so much magic inside ... but it is tested!

Best regards,
Oliver


