Return-Path: <linux-can+bounces-4973-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E9CB9A929
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 17:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E473B8A67
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 15:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE4730DEBB;
	Wed, 24 Sep 2025 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCWtPakS"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B6F2B9A4;
	Wed, 24 Sep 2025 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727295; cv=none; b=SrUL2EWeAPEpyuJ2Nt1ldHB0aG92sebYVjdBxOT6giqz3nbh5uDWmoqypZeN29YuTwW5xXBOA2HUNOIjxB7gQYq9JZEdI+K+IUiMYI4ReP91EVNTcN1+uKBl5DT5CE1hX1otGmhxU3xj5K+L8vmWFN8RwrQH91eLqPLSb6J+QhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727295; c=relaxed/simple;
	bh=HH0jUro5XE6EWkqyLJX26nKaGAnzpfTIyHcY+pPo8BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWHvEd96y4/RgKxxzBi9zBSHswTouh/eq9e023elWaFtAi3uJ1ovLOdA+h5wQEco+iR3c1Dv9iGStnzEwYPzOIg5pQUGIBPdCZcbNpCh2CrEMmwU0Linmth94zUe/3IKuQi3ziYJcWAgUbTL4vKFL3BgeWRD4osnH3wsjCtz8jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCWtPakS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E39C4CEE7;
	Wed, 24 Sep 2025 15:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758727295;
	bh=HH0jUro5XE6EWkqyLJX26nKaGAnzpfTIyHcY+pPo8BE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DCWtPakSjOjbXo9Fd7oJEpgCbPxI1q9Olka17HmLhdNGq1W8cY8a8fxZDcA3pj7k6
	 90mD4O4Qo50m1uRkDNE/TQXXp8bSmC1TV4B/0uGNeATm9YJnU4l3TobQWjW0e7Q1oc
	 kJu34w22z8kTsbwMXaSDWspg2mL+Kpx8BUsBCW99Hn6G6ka3coqvtCnhJ4/dHUqaDr
	 QADDDl3369Ms/P2qf37FpcxX2DAn9llb8d0+XdRJRdVP7wb9gzODM7bVGIkxHZCgrP
	 fKR1MnuMSjDmgk3Al8/1K6iesPV9g/u9pZi+SdkeUReSFVXqMTnACm7+5Njie36/NW
	 pOehKnnoRFSFw==
Message-ID: <47f88563-e3aa-40ad-a362-e851f6591a3e@kernel.org>
Date: Thu, 25 Sep 2025 00:21:31 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: dev: fix out-of-bound read in can_set_default_mtu()
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, syzbot@lists.linux.dev,
 syzkaller-bugs@googlegroups.com,
 syzbot ci <syzbot+ci284feacb80736eb0@syzkaller.appspotmail.com>,
 biju.das.jz@bp.renesas.com, davem@davemloft.net, geert@glider.be,
 kernel@pengutronix.de, kuba@kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, stefan.maetje@esd.eu,
 stephane.grosjean@hms-networks.com, zhao.xichao@vivo.com
References: <68d3e6ce.a70a0220.4f78.0028.GAE@google.com>
 <20250924143644.17622-2-mailhol@kernel.org>
 <20250924-monumental-impartial-auk-719514-mkl@pengutronix.de>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250924-monumental-impartial-auk-719514-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/09/2025 at 00:13, Marc Kleine-Budde wrote:
> On 24.09.2025 23:35:44, Vincent Mailhol wrote:
>> Under normal usage, the virtual interfaces do not call can_setup(),
>> unless if trigger by a call to can_link_ops->setup().
>>
>> Patch [1] did not consider this scenario resulting in an out of bound
>> read in can_setup() when calling can_link_ops->setup() as reported by
>> syzbot ci in [2].
>>
>> Replacing netdev_priv() by safe_candev_priv() may look like a
>> potential solution at first glance but is not: can_setup() is used as
>> a callback function in alloc_netdev_mqs(). At the moment this callback
>> is called, priv is not yet fully setup and thus, safe_candev_priv()
>> would fail on physical interfaces. In other words, safe_candev_priv()
>> is solving the problem for virtual interfaces, but adding another
>> issue for physical interfaces.
>>
>> Remove the call to can_set_default_mtu() in can_setup(). Instead,
>> manually set the MTU the default CAN MTU. This decorrelates the two
>> functions, effectively removing the conflict.
>>
>> [1] can: populate the minimum and maximum MTU values
>> Link: https://lore.kernel.org/linux-can/20250923-can-fix-mtu-v3-3-581bde113f52@kernel.org/
>>
>> [2] https://lore.kernel.org/linux-can/68d3e6ce.a70a0220.4f78.0028.GAE@google.com/
>>
>> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
>> ---
>> @Marc, please squash in
>>
>>   [PATCH net-next 27/48] can: populate the minimum and maximum MTU values
> 
> I've not changed the commit message of "can: populate the minimum and
> maximum MTU values", just added the note that I've squashed this fixup
> patch.

Ack. That was my intent as well. The description remains accurate. I just wrote
the patch description to keep a record of that last minute change ;)

I saw that you just added a link to the fix at the bottom, this is all we need!

> I've created a new tag: linux-can-next-for-6.18-20250924

Thanks!


Yours sincerely,
Vincent Mailhol


