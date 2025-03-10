Return-Path: <linux-can+bounces-3040-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6E4A597E5
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 15:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2315A16291B
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 14:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA9717C91;
	Mon, 10 Mar 2025 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YEFpp0qM";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="3yK3NQ5h"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64C122B8D2;
	Mon, 10 Mar 2025 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617588; cv=pass; b=hJXNgLsUb666Fv8Hu6Rwae4P+/bNgkryaVqv3zTkXorAKWiwyJiCOZTvAKiGlcR4WxN3znYdPY5lZNFPqZ6TUGNwzoS2S1rR08yrHW9KV+YsCT/7eDxEpFluPJM4m8n56QvVgjBiqeNdgiATZ6jHtJi+uK7okk7MkQjLJBe9+l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617588; c=relaxed/simple;
	bh=8symuAPDwRCaaKmhal/zQ72Owp+udrHEgPUBOc97ZdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWgLosEVY5jY9QABi2mhHt1vZvy2Pckd1JCsr20XHBp2TfmLEkOU7qMcia6aun1YEnG9/VVjUOTt8b5Chii+FpEb+Zy5JTAaQMMwgky6y9lhmdxOngO0ySABH7jRkEUZqR5/2m0H0SB4A3SnapE8x7rrXpOMsdbBwf1AbTFaJjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YEFpp0qM; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=3yK3NQ5h; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1741617394; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=W3lvnjgE4IPBcxuYpH/QkMqZbgy22tRZIIBAJwo5P6sRf/3NsBTOcaz80879lHai+S
    nwVWDRnyEMfa8U4B2Ks/crFYbkgQfBu7mPhrB2VJ1h180SbYRny2+u0wJ3Xg++Dq2AJ1
    jxc1y9b04Ct4TQmf7DmXi6kb8gF/NuNFqJEiqTlSoTpFZ43bMI2nXinKazA6/TduTa+A
    l0Yur+g7CNiMEPTwUzi7ZSQIaJOf2BJrW6lGcPVPNjzWUhwzxpM37IHfsI0J4QOZ9yeB
    xD74mwV5fWu6fKNl7nDDyHnyDLIOrH6fIrllWPEcEL/zjQZM2NdGN42MGcJjnd+7bs4m
    P/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1741617394;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4qxJYB0h1z/05W0c+7TAMG0e87lLkV/5Jm4DbEm/z3g=;
    b=mewMVaVPcrOHP9NuMn4UF+hqbSbYFtBUMocFO15WD1MwIgQrbCU27YbNQT4tPMkwvY
    Zzl5T5o5e0pSYMT5e8fv+01EUzUfRF6wIS21JZMoa0SioGBXZsxAs2feedji2MSySECz
    vcp1tcSzH/yc7C1PQZdSUdymU5uLJ4HU6OSOmGu2Z0MB0sJ/tnTn8Rvl5mSlHsik7rU6
    Li+uS05lXsnNVTvbz/3kHr1oHRHiKH4RbAvV0oZgn4RYqybbHIzkOSqxSZfoKaEZeH4h
    F2cZClp0soh29ayTbygtMr+/mgnh+0RKYQMU6wBPrQMpRgVHOwRY5UcMDOZSsn11NIOt
    JUGQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1741617394;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4qxJYB0h1z/05W0c+7TAMG0e87lLkV/5Jm4DbEm/z3g=;
    b=YEFpp0qMUV14DeIkzecxYVBt1WpRq0N155SFbK+oDREc9GTyH2UOSu2mdsJPz/QgyV
    XxiciUgcjGAmS5YzZolR/HzCjkwvibfvJk4THe6uTx87RlNWJYzqHa6XDWxCbDXUKfU3
    Eu1U1S67TMQ67uEMro+40UWjj53ywSWigBtUH+vqJqYUvxdfj1G+7fZ+jrYKeV5iB4jw
    V9mnWfpwZ4nznNw0uGvhJsdi4t0Pv+Kb4HPjgj/dyqrXoQs/4Rw8hfWt0h88NWUaO0Bk
    SCq8jys2jkS9OZ9isKWbtn3PiuQj4rP5PX9xy+frpvK1nDg5Y+AQCs91LUFgFbBVgaKh
    0x1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1741617394;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4qxJYB0h1z/05W0c+7TAMG0e87lLkV/5Jm4DbEm/z3g=;
    b=3yK3NQ5heAejcEMIXUOwR+R51jUbW7LP8WBmrd6QqyxKc60RTdOzuoYCLYnpvn8ouV
    p816AbO2K8q4HR+Ww0Bg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e512AEaXUkE
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 10 Mar 2025 15:36:33 +0100 (CET)
Message-ID: <b7cb5a2f-29a8-4174-8b0e-c9cbf7349531@hartkopp.net>
Date: Mon, 10 Mar 2025 15:36:28 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [can?] KCSAN: data-race in can_send / can_send (5)
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, mkl@pengutronix.de
Cc: syzbot <syzbot+78ce4489b812515d5e4d@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 linux-can@vger.kernel.org
References: <67cd717d.050a0220.e1a89.0006.GAE@google.com>
 <c9047828-708a-42d8-97f6-fffb7d806679@hartkopp.net>
 <CAMZ6RqKyMreMfNDmYU=tLyaEcReopmGx2VkBWPB12LLzd5o7Pg@mail.gmail.com>
 <f8e7f845-253b-47b7-9e09-97a580ce0e5c@hartkopp.net>
 <CAMZ6RqKga=f=Xd33GF1zPwmiearrz3mg+ZiryVbJD_RE5MGjKA@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqKga=f=Xd33GF1zPwmiearrz3mg+ZiryVbJD_RE5MGjKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent, Marc,

I sent a patch to be reviewed:
https://lore.kernel.org/linux-can/20250310143353.3242-1-socketcan@hartkopp.net/T/#u

I've also tested this patch without any new issues.

Best regards,
Oliver

On 10.03.25 10:55, Vincent Mailhol wrote:
> On Mon. 10 Mar 2025 at 18:46, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> On 10.03.25 10:29, Vincent Mailhol wrote:
>>> On Mon. 10 Mar 2025 at 03:59, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> 
> (...)
> 
>>>> Isn't there some lock-less per-cpu safe statistic handling within netdev
>>>> we might pick for our use-case?
>>>
>>> I see two solutions. Either we use lock_sock(skb->sk) and
>>> release_sock(skb->sk) or we can change the types of
>>> can_pkg_stats->tx_frames and can_pkg_stats->tx_frames_delta from long
>>> to atomic_long_t.
>>>
>>> The atomic_long_t is the closest solution to a lock-less. But my
>>> preference goes to the lock_sock() which looks more natural in this
>>> context. And look_sock() is just a spinlock which under the hood is
>>> also an atomic, so no big penalty either.
>>
>> When we get skbs from the netdevice (and not from user space), we do not
>> have a valid sk value. It is set to zero.
>>
>> See:
>> https://elixir.bootlin.com/linux/v6.13.6/source/net/can/raw.c#L203
>>
>> And those skbs can also be forwarded by can-gw using can_send().
>>
>> Therefore there is no lock_sock() without a valid sk ;-)
>>
>> When 'atomic_long_t' would also fix this simple statistics handling, we
>> should use that.
> 
> I see, Thanks for the explanation. Then atomic_long_t seems the best
> (and easiest).


