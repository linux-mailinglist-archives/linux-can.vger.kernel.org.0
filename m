Return-Path: <linux-can+bounces-5991-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB55CEFEA9
	for <lists+linux-can@lfdr.de>; Sat, 03 Jan 2026 13:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AC69302651A
	for <lists+linux-can@lfdr.de>; Sat,  3 Jan 2026 12:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED072737F8;
	Sat,  3 Jan 2026 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="KhBqZedV";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ma1RT0EY"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D57B1FF5F9;
	Sat,  3 Jan 2026 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767442852; cv=pass; b=dLEvmZjnPzY6Ab+dJd6heh4u9uIzYwUrjI+h0j87V3p2HeYtEN3C+5qj7PXfTwDE9V+rU99xk4yUg48tbhrR9mKqYMyvpaOztLO+JUDuldOxgF5znzVmId6d6Y+QlJY54rAOjONRR3rr5dxBsBL749GBIEtOLr3w6fnVxJCl/L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767442852; c=relaxed/simple;
	bh=E2yG9qpAqc/yVBTPBXGeGaaHgpwEVJYZbc7mY9v3vww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5B11W+JGJuinBLtKursZlHcxBUOZmX+zQDZJf8p+3ZpBQovsPtfKb1QT0FwxY9MFyy9iXLZZjSU8ihaY9q3VcuMDVy4C0PAgiT5vNYqnVEihh/96qXhlInsrOhJSJWfCKId2czHpxgCH2s+xyou63HXRMIvbydxsJaKR7G0SNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=KhBqZedV; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ma1RT0EY; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767442839; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ktY4Wp1mWWb5RWYGU1zRAYTtXwgQ8T4GVs5w7IuX7JJLw+PGIKqNxr7fekyb793l+r
    QldTg1xX7u5v8cHeEyTFrDpKyzr4t7efMgPrSVesWnPwntl3ZTloskH90zMuRgew3Mp8
    fn6jSRBYBhbIXJ8B6wwAfq9ouw4ONWG1AS/899FqvYMJvuHWzaZIlWRCrmxlsMcTKypd
    ORvA3tac8NdsSL3+0jstUZeCQjlt8R5I6vFu/Ieu6JTZXd2O4jBribYrKvqkfrSBZDXs
    jQZCejqnrOnqucjI7wVUEZBDluxjLustNRzLL/WPg7Ntw6tSx0j3tq2ius64OMIkh9UE
    2O3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767442839;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=S3lwPWHvOvbD6pJQc28NwM8aXvYUV0HGlA5QrCpwyO8=;
    b=OLZy2IO3AeMQQ1R17GIeFqjsshavTR+m7YFu1Im4ZrjrAWjB6PlAt7mz+XJvQA1lV3
    t8VfJcMSvGInkWlVI8t48Y8o7wa3n6wpadDvcv/DphKbdhc5uPJYpAlSPpkCGyEj6hjp
    kfx5cOkutydZkzcIhERlxC3SFIminhYhzPbCRXI9xamgbx1APiSw7KUqQWCfuqdt/k4x
    xlBrX16VmDyitsVNeL1EK2H+1JltaDinhbtRv0nP9kCnB5mNMsTXhXpfVfesANdPWhWq
    tdMtMUkW/s7nPki357H0jYTUenM4/FNmBT2iAyAWBsYA+5NpyhTkzKOdyWmrGBHRdg9f
    j1og==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767442839;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=S3lwPWHvOvbD6pJQc28NwM8aXvYUV0HGlA5QrCpwyO8=;
    b=KhBqZedVjCQssY9n5ohlDY7qzJPL/i4N9FPF+kSy6pjTNsKIJpFua/ilB7Ie8SnV/s
    ZRr9gUxmudMoN23Ka49Btd6oyW/DXbhxwVXEbULkQwk14+WNyszw7Q1Us3c5rAKoHteP
    POO1ypF42FNp8uamfUZD7wVZXYCepMKlte7JhfeLslT/bHYqzzqnKz3ebrh6AoBXZEVo
    SliZu/i2FCbDX+XE0xwWcdkWG4WGVUmArQmdo/CYUUuLKo6Aqzc9u1lrludJO9mhwYlA
    hJiI5fheGlGj4/UC+2S/l3tKYoc+W8zR/1Eyu/01/n20FgupO4t/QaoXl/9p88X1mfgJ
    FVtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767442839;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=S3lwPWHvOvbD6pJQc28NwM8aXvYUV0HGlA5QrCpwyO8=;
    b=ma1RT0EY8AdE2ll4GsTxBnwORwTFpCMrFcCZWrgd3e14TtOouod3LHtDH6hyPnm5rP
    pu694zTYb9G9OjJhmRBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b203CKdmPD
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 3 Jan 2026 13:20:39 +0100 (CET)
Message-ID: <63c20aae-e014-44f9-a201-99e0e7abadcb@hartkopp.net>
Date: Sat, 3 Jan 2026 13:20:34 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf, xdp] headroom - was: Re: Question about to KMSAN:
 uninit-value in can_receive
To: Jakub Kicinski <kuba@kernel.org>, Prithvi <activprithvi@gmail.com>
Cc: andrii@kernel.org, mkl@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 netdev@vger.kernel.org
References: <20251117173012.230731-1-activprithvi@gmail.com>
 <0c98b1c4-3975-4bf5-9049-9d7f10d22a6d@hartkopp.net>
 <c2cead0a-06ed-4da4-a4e4-8498908aae3e@hartkopp.net>
 <aSx++4VrGOm8zHDb@inspiron>
 <d6077d36-93ed-4a6d-9eed-42b1b22cdffb@hartkopp.net>
 <20251220173338.w7n3n4lkvxwaq6ae@inspiron>
 <01190c40-d348-4521-a2ab-3e9139cc832e@hartkopp.net>
 <20260102153611.63wipdy2meh3ovel@inspiron>
 <20260102120405.34613b68@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260102120405.34613b68@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jakub,

thanks for stepping in!

On 02.01.26 21:04, Jakub Kicinski wrote:

> You're asking the wrong person, IIUC Andrii is tangentially involved
> in XDP (via bpf links?):
> 
(..)
> 
> Without looking too deeply - XDP has historically left the new space
> uninitialized after push, expecting programs to immediately write the
> headers in that space. syzbot had run into this in the past but I can't
> find any references to past threads quickly :(

To identify Andrii I mainly looked into the code with 'git blame' that 
led to this problematic call chain:

   pskb_expand_head+0x226/0x1a60 net/core/skbuff.c:2275
   netif_skb_check_for_xdp net/core/dev.c:5081 [inline]
   netif_receive_generic_xdp net/core/dev.c:5112 [inline]
   do_xdp_generic+0x9e3/0x15a0 net/core/dev.c:5180

Having in mind that the syzkaller refers to 
6.13.0-rc7-syzkaller-00039-gc3812b15000c I wonder if we can leave this 
report as-is, as the problem might be solved in the meantime??

In any case I wonder, if we should add some code to re-check if the 
headroom of the CAN-related skbs is still consistent and not changed in 
size by other players. And maybe add some WARN_ON_ONCE() before dropping 
the skb then.

When the skb headroom is not safe to be used we need to be able to 
identify and solve it.

Best regards,
Oliver


