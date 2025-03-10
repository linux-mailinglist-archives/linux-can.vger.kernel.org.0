Return-Path: <linux-can+bounces-3042-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ACAA5A611
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 22:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2163A2329
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 21:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5533E1CB9F0;
	Mon, 10 Mar 2025 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="WPPOeCFj";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="74tyrDu+"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AB41BDAA0
	for <linux-can@vger.kernel.org>; Mon, 10 Mar 2025 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741641611; cv=pass; b=C6mHQvaMZ08Vv73RsMtHa5HWORjhSfWugsIcYBy+mGKMGTCJVNrlHmGaqVR3JHTLVTWzLALXz9xFihGfojQvrr5BT+/NzZwm2eF5+8zdxBywukalbjZxO0CTxkxK5hntFQpqR9+psGJBSXtJfNtW+J4t2PmDUTgcP2816E/X69M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741641611; c=relaxed/simple;
	bh=+aOl3ZHx7o148aUZOWhc/oIvz05MGQ6oHRlkTWGlq4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2eEHepdq2rgP8pl10Dt80rr0AXGIYfnsnQXPDfs2YW82QKSV+pEOua2DvVtjRnLuOtYeA/g1MxetKHUwKkQxYfbSuCw9eNVH/uuWyPXffFkkpvcqr9eAwEU2QWIwx8mHHY3MtAfnrst7CF0YB3q/sLCnLaFFR62HciTwy8RdK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=WPPOeCFj; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=74tyrDu+; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1741641244; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GMp4NVI3AwvZSuTIiA6TEuGJhJiok+7zRQ1nIllE1oR8sBaVTJ22FUhpZFMS8I/VXc
    xryoC1sXWvZfZl6XuQxw0sr+Juu6VWJ4/ybliLxsdLwWd4s+40NIgzoe+efR11Kp54Qh
    bm1F/iRiV6SDMnZ0KSqhro6MZc5i9l7GASd4lU+0QY7b2V5VMvpMHugd49io3W1GuhGd
    ZZDmLOLewo8moF84ZKTWpCtNeL9boDzFupp6OVUxlnNmClpiAumyqdKyCWNpY9QUA9+N
    eJH69ek6QOcEUy4v6zr+L8uZ2zVGA4Ctr0Twix9hhsoggrUoszdU5QcYFIUjTk+FMT+O
    XpKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1741641244;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=bk9pUCJbPmKQSFdAL0C4jIHcMwrOjx9vKWhW6zS1sdo=;
    b=ZRBt6bl4Ooo991FgfN3DCrEQOcKPiXovRhVK8Ue/vXfXr/sIq9tTmSCl5LndJIbMjk
    ryr2d/KWxntyGNvmxLjfMnvMVSJ0F+47JP0VvbUcRI8xej788ddjgPzAL90+r0W+kjsI
    36xiYfLWTZtU4eMP1jnuNho97P+fABm4VatmgfeahkAZtB9qq3cBaQCaXivjLQKK/Dko
    q9T/uzPfL4F4Ff4K0od/QjPOQD+F2vkAd1Y2nPFwjkNaf+ho9c+oxOcWWe16wqyKrohg
    Hph+S3kSLRHj/X0kowI0C41OT4htd3mAUNO9so4lHgjFoFMpzTaxLYIbaosSpFS5cb1v
    Io8g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1741641244;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=bk9pUCJbPmKQSFdAL0C4jIHcMwrOjx9vKWhW6zS1sdo=;
    b=WPPOeCFjvUNOJW6cEVbDuFYDi1NZBZx/Fi/lXtHtoyDq+nQk0b4FMtMJr5aK+qRFfW
    cIeiOtAVyIN00LBsBJSXNbPmTcsPeS5mzCRwR/UcFBi8RK1xxzT4Jtz4c2ho02UW+RFv
    bBAu0OCkyLBtix1acrvg4oyPELgtAGr7TMyrez3++gb5kI8AS4LY7bvqBfcopfsTikUA
    si4Ryo+BEgYfTEcjm7vRLLgrNgZFyR1YsfpfBRt1NUpwhpkaPbo196mB+bu1wyhtoo9f
    eRs0G/ryAZaX5kBTsnipJDKI+pJudqD7yMWiqWc4CFPbGKel0oIqe5STern2gTWlHGTq
    6Q8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1741641244;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=bk9pUCJbPmKQSFdAL0C4jIHcMwrOjx9vKWhW6zS1sdo=;
    b=74tyrDu+UOenXjzaI0BlwuDoIyggl8TdRcRGzQzu7sTWINtiXAzaoRz7xuhKzHomHk
    kAoJTOTnC7scgAZIsaCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Tt1dX0Gw=="
Received: from [192.168.90.115]
    by smtp.strato.de (RZmta 51.3.0 DYNA|AUTH)
    with ESMTPSA id K2a3e512ALE4WAd
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 10 Mar 2025 22:14:04 +0100 (CET)
Message-ID: <5db32c5c-a20c-4848-b195-e939edaf92af@hartkopp.net>
Date: Mon, 10 Mar 2025 22:13:57 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: statistics: use atomic access in hot path
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org,
 syzbot+78ce4489b812515d5e4d@syzkaller.appspotmail.com
References: <20250310143353.3242-1-socketcan@hartkopp.net>
 <CAMZ6Rq+iMQcXZ1Q7aDa0gSCqY64n6CqROk9spbbweynF59QZjQ@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6Rq+iMQcXZ1Q7aDa0gSCqY64n6CqROk9spbbweynF59QZjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10.03.25 16:04, Vincent Mailhol wrote:
> On Mon. 10 Mar 2025 à 23:34, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> In can_send() and can_receive() CAN messages and CAN filter matches are
>> counted to be visible in the CAN procfs files.
>>
>> KCSAN detected a data race within can_send() when two CAN frames have
>> been generated by a timer event writing to the same CAN netdevice at the
>> same time. Use atomic operations to access the statistics in the hot path
>> to fix the KCSAN complaint.
>>
>> Reported-by: syzbot+78ce4489b812515d5e4d@syzkaller.appspotmail.com
> 
> Maybe add a Fixes: tag?

I'm not sure about if we should provide a Fixes tag here.
The code is from the initial commit in 2008:

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/net/can/af_can.c?id=0d66548a10cbbe0ef256852d63d30603f0f73f9b

But it never created any problems and it is also not that relevant if we 
have a packet counter which is +/- 1 correct just to be displayed in the 
procfs for users that accidentally know about this feature.

If we add a Fixes tag the patch is backported to many stable kernels.
Not sure if it's worth it.

For future KCSAN tests we are safe then.

Best regards,
Oliver

> 
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> Notwithstanding of above remark:
> 
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> 
> Yours sincerely,
> Vincent Mailhol


