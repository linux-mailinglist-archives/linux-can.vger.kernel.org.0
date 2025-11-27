Return-Path: <linux-can+bounces-5753-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A08E9C90197
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 21:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 958B34E23B4
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 20:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4017530FC1D;
	Thu, 27 Nov 2025 20:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="I0+2QFxT";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="RbuEyvV+"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004191CD15;
	Thu, 27 Nov 2025 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764274546; cv=pass; b=W668S6PdDL6OCWRow4sk1BUEbzGgK1owXaeMT9MQlf4f4ZqfqjzJ/CRXCIljDToncBAmciYba4jECzNjPr/wJOCFxO+xKaaYsEh46YPT8byyPhqK/MaR+MqHH1QPGES7+1ccfdOZnnis/FqeyMZ0LE4FnYRLP5kfK1xp2Van5VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764274546; c=relaxed/simple;
	bh=rteFh4zYJ4GK1ePf9M+zRr6I/wACPwRc5IzJOH2w36Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M04LmRE30a1lTcyxwJaDZQvFVWjlB9OSI1pniumU2GCi6StmmjmfzYorhyCqyOydCRdC9zMfXMul3QPqP4I28/ZWKyEOGIomtXGg9fpenC6+nv7WKP66hiR0boIEZ9dZUJloXBvyH2UHgShoyycrUUJ2NZ7QJ8UIqBUlqnJ6tIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=I0+2QFxT; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=RbuEyvV+; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764274532; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hfrVY6ZWUq4KPRWIpKil2Ze9zz9n1+JLjgQX6pHZZzMmGddCk8x/ZGmTBe0GZrdfHw
    41A0pItKK6FCVkcX4H+EOs3AQ9cOOaO0RkfiTj58jmhc+yhop0B6QeB0dRf1LSUKIsE6
    t1oaSyfJ7hsmAysjl1w0AaSo83FZYX6w2e5Zh9+fCr9myHHtfWtYfw7dbabab6KDXgBK
    WK6tMUFLF8tvl1Nb0SmD0gHff5QdJRg9hWKJljcFkOioidv3XS5vOvTGSiYlxozhA4h0
    VWad+Q8ZB9Nn0syjWT5T7UmVG14LWAiMJrm+mznY8MmEx0i4/YoneHofiDfm22uNWZ3f
    wLJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764274532;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9RfwFVpHQaf2bghREdzjmrL4fxEb4Qkh9ApTinaY7Fc=;
    b=GFUSVvdJUb+4ojhRESQLEgfX+6mzugAnNVrvEqjJxgZl0g03QDKVKA0t+f2zoZsdtZ
    McAtfqGJFMAMIicG0NYiJb5RSj1xnAVXsGYM14T0DwHIIRPE1vyQsA9jsuGU+W8h2zGy
    IfWeLRAqbaBvQBEgZqijEOQxy90vi/gAdLeFTM2Jcr8Tqi1BuhgMSlM+UNxyVnDNeE1h
    ZewzGpvISNQnDbqo1hegMfDcucujpifgWPNUQtZe5IX8h88APmvfmKEaRHl63FCFwPhH
    yH4pL34rvEzvl6UFacs63YcvjdsD3xaLNR3iKvk1C/yzmPGXThAc8ZdTHiWU3dWndS5m
    ns5Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764274532;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9RfwFVpHQaf2bghREdzjmrL4fxEb4Qkh9ApTinaY7Fc=;
    b=I0+2QFxT9nlWWX8sXGPFM/ngGXQFcBhFrioe+L+ocxNZGpi34SEIt84LyjPyCRW9nG
    NgL3l+EnRYjwz+BKNhj/hgyQEY+YAbof9/nOvG7I+dLdsrdFHtWbzhjyPY9D6UNVuVpE
    u1mxougHtsaZrKObrJqmZCFDbfTo4X26CmhFkGGshFtPQwUJW3KhP9NvyWYlsq8rVfXs
    dW9knUFqM/EUtkykXHvS+zQYPx3D8mWLUiakV4so61GXdC82ammj5mwkKjRkmdlzHGYZ
    txZfovKgrmnKZ89yErAzkdY98OmoEjxYvbbdSnumChCCmlhiSFdk3BOVGFeYulFo+Fiu
    3lyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764274532;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9RfwFVpHQaf2bghREdzjmrL4fxEb4Qkh9ApTinaY7Fc=;
    b=RbuEyvV+QIEWaoqXnOzXNS91g42LGpIWeF/I0p0D3K0QsE275ovlDAbU6hi+L17p2O
    ZLXHwJCb/sjehc+7IgCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ARKFWd6O
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 27 Nov 2025 21:15:32 +0100 (CET)
Message-ID: <68694081-b2db-42e3-8ff8-cb44a65492a5@hartkopp.net>
Date: Thu, 27 Nov 2025 21:15:25 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 16/27] can: raw: instantly reject unsupported CAN
 frames
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de
References: <20251126120106.154635-1-mkl@pengutronix.de>
 <20251126120106.154635-17-mkl@pengutronix.de>
 <CAMZ6RqL_nGszwoLPXn1Li8op-ox4k3Hs6p=Hw6+w0W=DTtobPw@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqL_nGszwoLPXn1Li8op-ox4k3Hs6p=Hw6+w0W=DTtobPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Vincent,

On 27.11.25 20:49, Vincent Mailhol wrote:
> On Wed. 26 Nov. 2025 at 13:01, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>> From: Oliver Hartkopp <socketcan@hartkopp.net>

>> +static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
>> +                                     struct net_device *dev)
>> +{
>> +       struct can_priv *priv = safe_candev_priv(dev);
> 
> Sorry for coming back to you too late after the series is already
> merged in net-next.
> 
> This dependency on safe_candev_priv() can break the kernel build.
> Indeed, when building the kernel with:
> 
>    CONFIG_CAN_RAW=y
> 
> and with CONFIG_CAN_DEV not set (or built as module) below build error occurs:
> 
>    ld: vmlinux.o: in function `raw_sendmsg':
>    raw.c:(.text+0x101ac4b): undefined reference to `safe_candev_priv'
> 
> This is because, under the current design, the CAN network layer is
> not supposed to depend on the CAN devices layer.
> 
> I do not have a fix for this, nor do I have time to work on such a
> fix. All I can do for the moment is escalate the issue (but it is just
> a matter of time before some build bot from linux-next would report
> the same issue).

Good point.

Indeed I always tried to decouple the layers as good as possible.
But with the new CAN XL features the MTU checks came to an end.
At least the virtual CAN is always selected by every distribution when 
CONFIG_CAN is enabled.

Although it is not a real-world problem, I'll post a patch for it.

Many thanks,
Oliver



