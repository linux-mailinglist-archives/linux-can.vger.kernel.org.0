Return-Path: <linux-can+bounces-2923-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C75A3EE07
	for <lists+linux-can@lfdr.de>; Fri, 21 Feb 2025 09:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D37A178503
	for <lists+linux-can@lfdr.de>; Fri, 21 Feb 2025 08:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FD61E1A05;
	Fri, 21 Feb 2025 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XgP7Lodq";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="z7PFYUxg"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B110D1D89E4
	for <linux-can@vger.kernel.org>; Fri, 21 Feb 2025 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740125458; cv=pass; b=Vuqx9qIW+79tcYaYTjfGmdc/LYLQZb7rRvL/Y64Jseicp4MQIRWWy+63NPVRPGfkGT4LYAVEhmIrMdu1hd9ZMuUen5jGD6fq/QPIBUfm21SHL4NPAdsCmyCcmntzO6ULzr6oGrdm5a7uuazVs/opXJjMjrVELdyPcrDM9WjuIBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740125458; c=relaxed/simple;
	bh=e/E3zIBluCFwS4xCsDbxmd/Mnhj73Me3/URzMofkAK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ncRxv89jb/w9vNaVov1MzwaNS6aJuYVXG45LE3ge2+R26JI1XHR7vCY7xDK2hN0dSCJTNaydRnfOnShuKjUuWiznFjvbkl/scg9cOJFVDd6ZrqA3u36cF9MICzJuPxFlLuw1JBFnHWMhtJYYwtipl+r7Mda7plUThrdv7EIoEaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XgP7Lodq; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=z7PFYUxg; arc=pass smtp.client-ip=85.215.255.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1740125086; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=E+7GWcRkweZBKfdv2juv4riJ8Ajx76V/sftHJrlJiGzc+5mjkokJeJss4owxyCbaw7
    bxvsPYnYbHiHDRO1PvsQ35TpFOszW4hofWIqyglC3CHpoDkR7l4BnOy9kv9mGigWtGp9
    zuKa+5Yhc7IQ+xgZ5es7Z7KNBGxG0mqggas/bhnZk4ghOYiknrHz2jAdT26FLf5/8zB8
    lnzNV3/PV2Wd/bZe40Rnm6pzrNAV/acvVff3Wvt9J8FBI1OebatC1g04rpop8kxRVYqU
    /eBFEk2aY6fs11AXGfe4uvDuPKvKBK3Ul7QCghQ0oWs4nsF5RrLyi4KaH4KnoxP1GKlh
    lA9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1740125086;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VyimtLQTHAnmlmspqsz8tXevey4yE14Iy488EPrWYAo=;
    b=Ba7/BIwyUsqYPwezjPT/Gv/7WAg2fT0siLXPTYoCIR/6MeOdcW5YY+3wkrQG/jxG0d
    gbNkd/MLxdP6lWq0NxP+ECz5iJTcZb+YGD8EbsTSg1UtwEUjfmY/Q0zdRPIwO+YKG1vl
    u8gFULPoRKuWyPMJGKXCya+Y0jNoxfaWoKxO7zAXTvxl5Dhw4r8DfKmO8Cyz/XDMrfMr
    i7u1UlvNNw5zJTJiKzsRUj+oSi+FfyUME29/Kyo91CXDuwElJpakVCwxo/5E24ZBk75a
    yd7U6zTGjiVm6sULZ9MufHa/Ak0h/rnsAi2wd5dJLFhxs1oUP2C2BF45J3w8VtkqFZ/L
    Y8Vg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1740125086;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VyimtLQTHAnmlmspqsz8tXevey4yE14Iy488EPrWYAo=;
    b=XgP7LodqF/a5acirJIgzquemmrbuzBaKx2hhXIWtsaEj+MpZOBFyXYwUiezaQBeNk9
    Ye4tbRHe5Cse3o86hHulO7wBYyoeQczrjgwqhGJidRCG+/l6E7i9oes8ddrFdPV8d1CT
    Xbf1FQGAdBPfgcfsZL/+5g2jmaNQ0k5RNvxUAVJOtZES74zlpcmVqD9XRkwBWwgqnDnk
    9G3wn/UtG832TKU82oU4rRpADRgLudG0AoXZVZLi4cbvAnByRZCxDmliSzTjdIOhAaf1
    qGCiAA5aqXQopvtf1//w1oUNh1oBJ6l6GG3MUOpxTQ3Hzhyt5yakQGEWJOlYoFwHaiUB
    S+qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1740125086;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VyimtLQTHAnmlmspqsz8tXevey4yE14Iy488EPrWYAo=;
    b=z7PFYUxg9Br2c6+Poj2oQjj4M/v+w6Yqq7N5FjYcfHOznJGC+uBcCYYT+tHDc8MXTZ
    HZ60Lr1jhgb2PxiRsrDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.2.23 AUTH)
    with ESMTPSA id K0c06111L84jCcj
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Feb 2025 09:04:45 +0100 (CET)
Message-ID: <79891c7f-4a8b-4909-af6e-55598bf024e5@hartkopp.net>
Date: Fri, 21 Feb 2025 09:04:39 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Advancing the testing for the CAN subsystem
To: Felix Maurer <fmaurer@redhat.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Davide Caratti <dcaratti@redhat.com>,
 Filippo Storniolo <fstornio@redhat.com>
References: <0feda774-853b-42c3-8bae-5d84f7881171@redhat.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <0feda774-853b-42c3-8bae-5d84f7881171@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Felix, all,

by now I was only aware of syzbot who is sometimes showing up with some 
splats

and the Linux Test Project (LTP)

https://github.com/linux-test-project/ltp/tree/master/testcases/network/can

which e.g. provides CAN filter tests which you can also find in the 
can-tests repo.

On 20.02.25 14:03, Felix Maurer wrote:
> Hi Marc, Oliver, and linux-can community,
> 
> we are reaching out to you because we would like to advance the testing
> of the kernel CAN subsystem. We, that's Davide, Filippo and I, are
> volunteering to provide the patches for this, but would like to get your
> feedback and opinions first.

I would definitely like it and support it :-)

> We know about the can-tests repository[1] and think this is a good
> starting point for our efforts. Currently, there are two main activities
> we'd like to do:
> 
> - Promote the test cases in can-tests to become part of the kernel
> selftests: This would mainly get the tests closer to the upstream kernel
> development, both in terms of maintenance and actually running them. CI
> systems like LKFT and CKI could easily be continuously running the
> tests.

Ok. Just for my understanding: Bringing the test cases into 
tools/testing/selftests would be the enabler to run LKFT and CKI, right?

Does it have any impact or improvement for syzbot or LTP too, e.g. that 
we can also improve their test quality?

> The downside is that existing automation depending on can-tests
> (which we don't know about) would need to be modified.

I don't know about any existing automation based in can-tests either.
The reason for the can-test was mostly to document my own PoCs when 
adding new features.

I have no objections to stay with this repo as a PoC playground that 
might also help developers to get inspirations - and start something new 
with the current code base which aims to fuel the kernel selftests.

> - Extend the coverage of the tests: This could include testing for,
> e.g., vcan, vxcan, and the cangw netlink interface. But we're open to
> feedback here if you see any pressing areas.

I see no pressing areas right now. But the recently integrated CAN XL 
support might get some attention ;-)

> Like I stated in the beginning, this message should get the discussion
> started and we are looking forward to your feedback or concerns on these
> ideas.

Many thanks Felix.

Best regards,
Oliver


