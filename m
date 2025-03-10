Return-Path: <linux-can+bounces-3038-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BD2A590AB
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 11:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBE527A4D60
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 10:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12521223704;
	Mon, 10 Mar 2025 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="RO0vRoKG";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YghSe3s3"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7501C6F70;
	Mon, 10 Mar 2025 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741601041; cv=pass; b=ldX5jq6u+Zg9+jJUs0Etc0PIDDvzgpQeJl/ZXJ/z2a4PB/9WsVEIJfPj8/xaISRJJ4H0hIePBfCPmpHJTFue7WH+YRSQXG1D9lzKtXHgsvph84PAxB3jraQw9oATc+FRZpoNj//aJmDQhHKMo9aOUClxDQ48SxGaJ6n9z2OxXU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741601041; c=relaxed/simple;
	bh=ieVSgl1n+Y3jk7qQKxXYcWYORmovbjqs1XE5G9Qx9SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6rVbFIQwxEDi1Z/HHlYb9wDgmXGOwd2k/90U9xt3Onc3OfrYhoH/HPK4pddSR5Gfcf7XXmJeYoI/sX8nBTt6yXccdN8RagpUmxhPeGXrAuf46cIgCff8pnUJCIAmkXQSIKnsgON5fQ9OKo92W08/63TIFD6gKICG6zGLu5FUiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=RO0vRoKG; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YghSe3s3; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1741599957; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XMs/unWZqB8wrf2Nf8Y3wArQnAXgMyiADzjUEvaob3BiKLsUogNbm6FTmtX35T1CGc
    LFb00H1iaGAirPfZ5zYasMgLYFrqGjQRM7HbrgO1VC0pqC+jsDxfifHIMESaEki2u/wE
    vgZYNmwNlApAYQQB7aaJu6mU+il0yD5SPvsYQ8u4ky3hr4sHnlkAtTCVIRkxmhU+TqIE
    Rkhxswlwc16VrLs6XjTgiq39X9OXBYTydGPSUlMZbXa5QWwfGOszX3Sq7IyheXVLa4qM
    +3vfQcXI2CaqMjY6tJwb6WjPAfFMGG9niyjO31zak9dQNaoEFgCSVm3ksfhyDZNJhU22
    /rKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1741599957;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6c0rQTjE4PolH89nIKTpnQcF3fHayb1VmmI7dfoT9P4=;
    b=ZWyfp2gVUj0vKNvZGBDepWvzLiPtEc1dQUgkc8VbHnXeoyqnBB5cSvLnjTbvRdVIKT
    YWOxAzXadD/r+2UEm+mpEejiLrG600x5tc+kGX1lt/oRECp2Vg7jvJzInelsDnx9jnJC
    pRQKI4M0nDu5hADDPpbcl1E/QefohnHM43125Y7O7MArfkotzz4LZVGv1XDv6b861iNv
    /UsZAns6PWGV2nsc9/xrM8IwHfElr87ABOBkwIB99xfdS4wM7lMRbabfE5006ARtO7Z7
    och1qps9qC2WzpELaUxdeVkBO86ZxtAY0qZIhvYT+BgJiwxprqkgEas5yrjywqA6H6Pp
    xzRw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1741599957;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6c0rQTjE4PolH89nIKTpnQcF3fHayb1VmmI7dfoT9P4=;
    b=RO0vRoKG7LNeqtgRq8CgsPHMJeu2fAva5lG1cwGz4gf4Z7jYLMLupMRfd1S9Pdqbdo
    8W41P94ZFf+d9pFMFJy0HDg/HSUgsE3SjiOL69usgrFYlMsFpdRoF7M847YfUyRRiKO8
    ZGU7t5TNcftxv/OYPU62Ol8WQcSIE7iNXI7p9I+IuJxSmHF4vhv+2WHE5eG3p9uyWQdL
    lO/I4ulAVKpU4faJm6CI2hdOcQrRX6xa089LM7MwnKbse0Fy2GRTgiZGF4/nvog0kPrC
    bHF7FzjeLMHmeo9rM6KcPdp4EI5aqnc780QI6WOwGiPCcxo6AvTREIw9Ce9KJSemHVjA
    kKQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1741599957;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6c0rQTjE4PolH89nIKTpnQcF3fHayb1VmmI7dfoT9P4=;
    b=YghSe3s3dQ2MOYRGyhXD6P8gcPlIrc757HmVBsUglVPehubSDGiZOFRy3OaaLLwfDX
    PNGbXPd7tR+GhOuQ3IBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e512A9jvSaS
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 10 Mar 2025 10:45:57 +0100 (CET)
Message-ID: <f8e7f845-253b-47b7-9e09-97a580ce0e5c@hartkopp.net>
Date: Mon, 10 Mar 2025 10:45:51 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [can?] KCSAN: data-race in can_send / can_send (5)
To: Vincent Mailhol <vincent.mailhol@gmail.com>
Cc: mkl@pengutronix.de,
 syzbot <syzbot+78ce4489b812515d5e4d@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 linux-can@vger.kernel.org
References: <67cd717d.050a0220.e1a89.0006.GAE@google.com>
 <c9047828-708a-42d8-97f6-fffb7d806679@hartkopp.net>
 <CAMZ6RqKyMreMfNDmYU=tLyaEcReopmGx2VkBWPB12LLzd5o7Pg@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqKyMreMfNDmYU=tLyaEcReopmGx2VkBWPB12LLzd5o7Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10.03.25 10:29, Vincent Mailhol wrote:
> On Mon. 10 Mar 2025 at 03:59, Oliver Hartkopp <socketcan@hartkopp.net> wrote:


>>> value changed: 0x0000000000002b9d -> 0x0000000000002b9e
>>>
>>
>> Increased by '1' ...
>>
>> I assume this problem is caused by increasing the per-netdevice statistic in
>>
>> https://elixir.bootlin.com/linux/v6.13.6/source/net/can/af_can.c#L289
>>
>> pkg_stats->tx_frames++;
>> pkg_stats->tx_frames_delta++;
>>
>> We update the statistics for the device and in this specific case the
>> hrtimer fired on two CPUs resulting in a can_send() to the same netdevice.
>>
>> Do you agree with this quick analysis?
> 
> Ack. Same conclusion here.
> 
>> Isn't there some lock-less per-cpu safe statistic handling within netdev
>> we might pick for our use-case?
> 
> I see two solutions. Either we use lock_sock(skb->sk) and
> release_sock(skb->sk) or we can change the types of
> can_pkg_stats->tx_frames and can_pkg_stats->tx_frames_delta from long
> to atomic_long_t.
> 
> The atomic_long_t is the closest solution to a lock-less. But my
> preference goes to the lock_sock() which looks more natural in this
> context. And look_sock() is just a spinlock which under the hood is
> also an atomic, so no big penalty either.

When we get skbs from the netdevice (and not from user space), we do not 
have a valid sk value. It is set to zero.

See:
https://elixir.bootlin.com/linux/v6.13.6/source/net/can/raw.c#L203

And those skbs can also be forwarded by can-gw using can_send().

Therefore there is no lock_sock() without a valid sk ;-)

When 'atomic_long_t' would also fix this simple statistics handling, we 
should use that.

Best regards,
Oliver


