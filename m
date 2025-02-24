Return-Path: <linux-can+bounces-2943-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F84FA422BA
	for <lists+linux-can@lfdr.de>; Mon, 24 Feb 2025 15:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C1FA7A374F
	for <lists+linux-can@lfdr.de>; Mon, 24 Feb 2025 14:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B6522339;
	Mon, 24 Feb 2025 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsTu3jw6"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0677CF16
	for <linux-can@vger.kernel.org>; Mon, 24 Feb 2025 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406639; cv=none; b=HNBBiz21j5YledXy+xdpuGvm2hL/qm+eTAnGwXY0IJQx88h9LM7QdT3HK8RArZW8O83QoC3oCbJyAMvW/jJ/q/WD7cEO3QPwou0LFnIja0c/9gqmyveZSjjYhBFeROgCPRrPjCnAgt11QFOzY4CQy7+2DKtnsD4MKqexDF/Xc1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406639; c=relaxed/simple;
	bh=N0X3QHfqSDsmZLxHufTDdD7CHMHiYH8w8MeVhrmOqjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgJ58QWaiaWLBsa0r5kbbvGmI1EXzMCGpocVFy/5crMduqKXpy4R/leeGIChtm8Gm4+ZhK0PE1UNqzCSAhk8IqlqYLFaovi94oBRC9wAtpNlfsV/DPl1UEz6QRaNWcwRIec681wHH6TvplDZxmlOTd8wcK5kBFUyPharJyuej4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YsTu3jw6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740406634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGc2LwyKDkxE48uZb5hUjxHyEdBKjqdZ9rFUSvX3lo8=;
	b=YsTu3jw6p0avg6abCb0+UrMxB7yjOqbgzEkI8DLGeOLpxf8BDpPzOb+UJuDprbGzDYWa3X
	A0BXhpG1b8oLRNtYyOh38/fiym8UcWglmEX2oKfdYQ4cZIlP20tc4BMIMsNWXcvZAtamcF
	bwy/ewIwyWwgUcHlWdaWE03qPztdOzw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-AyKv7MOEPXegx7Z8khzwzg-1; Mon, 24 Feb 2025 09:17:12 -0500
X-MC-Unique: AyKv7MOEPXegx7Z8khzwzg-1
X-Mimecast-MFC-AGG-ID: AyKv7MOEPXegx7Z8khzwzg_1740406631
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f3bac2944so1981921f8f.3
        for <linux-can@vger.kernel.org>; Mon, 24 Feb 2025 06:17:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740406631; x=1741011431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QGc2LwyKDkxE48uZb5hUjxHyEdBKjqdZ9rFUSvX3lo8=;
        b=B2kpxxZo5ZPTTjmorCttOSBFh7ULUXQlMBLobkHy0i9KdK6TSLhVDUTL8Jdwasv3Ou
         0CitD+wSnvOMnjyiz5Q6YP0uuF0v2/zERRIpjJDrRD59+mgRGG0KR9O9COZBif16E1x5
         XoXKzXA5OiGU1u7mdzM490yCU9L+W9PahBJslT2JYwV74XYWHosgqudl8SmW1L8QlbO8
         UW6chXm9hfeSgYdAmidOpZw9AUPVk9KJ1K0bEqXqCfeu6jX+VJNc/lp/85Y3oVQQp8Ax
         EIApbeurqPVdFiTKG9F4YQfJ/bNslZpzYNO+NCICanEY4+ZElBFxeC8lWzNqP0dU/7jE
         IhHA==
X-Forwarded-Encrypted: i=1; AJvYcCVWtXpJwPg+zc+k6+5B8RHoOfdjff3j8bZeyaAHCN1WX/EiBrq9AppKZA/O8kQfEb7wxGgEi1mcGhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLA0NY8WzQY3CRwnDZ7H+gzL7rbBp6VXFwkXWzaL2IpfkR5A3o
	Hl87lQXr4oh8JqTEkKjBPjrMYsepWKZB6GgjM7kdc6X+/UABUo9rymQqsm9UVohoflTRUuXm1hK
	hNZVzdhVplCCpiBzAuyJsvlJq56Vgtu8YYKT55I6GHkwE8X9snXtpzBk+dw==
X-Gm-Gg: ASbGncsOd0zmOsEDKDeCIE7nfkRPFJYJkqXtn2gJOyGOzBqOa9FUDUo0vkrmXtBr5L2
	Ekse361BnaYbB6Q6REko2qKs2NYffA5SAohzSEu+ocsxF0uKHr8brR2fAoq9ce+csPNgmxul+Lz
	/Ts8WEVSgG3WoTAgbUwfwo1wsk4UJLqkEp1bbU9dQbBboe1LM/aPIwswvpDr7a12LXkY1GxDqnv
	9AWUlBgUmFyMMatbavsOuT91/FXDKAYgvbksXHaAt2sEP5o95i9yENrlWYuUdr7j89LCN71mGT2
	GcOjj9S2vpTW1upF4YAPeZDAFqg6FXuYLvmd15iyerlgHr3Xxtj+kxXdC/A2tOSnRx8vcZ9c2cL
	o02LAEcq5EkL6Dprito1idzctFxfvU3CyezRDfKCLtRxx
X-Received: by 2002:a5d:64a7:0:b0:38f:4f25:1482 with SMTP id ffacd0b85a97d-38f6f0b1c97mr12570577f8f.42.1740406630978;
        Mon, 24 Feb 2025 06:17:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH33KPlC4KIejv47myuqJJROPBWbPDFFT3YRFDsJPZ1P8eNH/ydr+fEdUnlbGvC584VJEV6rA==
X-Received: by 2002:a5d:64a7:0:b0:38f:4f25:1482 with SMTP id ffacd0b85a97d-38f6f0b1c97mr12570547f8f.42.1740406630532;
        Mon, 24 Feb 2025 06:17:10 -0800 (PST)
Received: from ?IPV6:2003:cc:9f32:6bf1:ca16:f6b0:a8c9:60d5? (p200300cc9f326bf1ca16f6b0a8c960d5.dip0.t-ipconnect.de. [2003:cc:9f32:6bf1:ca16:f6b0:a8c9:60d5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d8f1csm32195926f8f.69.2025.02.24.06.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 06:17:10 -0800 (PST)
Message-ID: <face3939-a260-47b9-bd1f-ea68b377f783@redhat.com>
Date: Mon, 24 Feb 2025 15:17:08 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Advancing the testing for the CAN subsystem
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Davide Caratti <dcaratti@redhat.com>,
 Filippo Storniolo <fstornio@redhat.com>
References: <0feda774-853b-42c3-8bae-5d84f7881171@redhat.com>
 <79891c7f-4a8b-4909-af6e-55598bf024e5@hartkopp.net>
Content-Language: en-US
From: Felix Maurer <fmaurer@redhat.com>
In-Reply-To: <79891c7f-4a8b-4909-af6e-55598bf024e5@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Oliver, all,

On 21.02.25 09:04, Oliver Hartkopp wrote:
> Hi Felix, all,
> 
> by now I was only aware of syzbot who is sometimes showing up with some
> splats
> 
> and the Linux Test Project (LTP)
> 
> https://github.com/linux-test-project/ltp/tree/master/testcases/network/can
> 
> which e.g. provides CAN filter tests which you can also find in the can-
> tests repo.
> 
> On 20.02.25 14:03, Felix Maurer wrote:
>> Hi Marc, Oliver, and linux-can community,
>>
>> we are reaching out to you because we would like to advance the testing
>> of the kernel CAN subsystem. We, that's Davide, Filippo and I, are
>> volunteering to provide the patches for this, but would like to get your
>> feedback and opinions first.
> 
> I would definitely like it and support it :-)

Great to hear :-)

>> We know about the can-tests repository[1] and think this is a good
>> starting point for our efforts. Currently, there are two main activities
>> we'd like to do:
>>
>> - Promote the test cases in can-tests to become part of the kernel
>> selftests: This would mainly get the tests closer to the upstream kernel
>> development, both in terms of maintenance and actually running them. CI
>> systems like LKFT and CKI could easily be continuously running the
>> tests.
> 
> Ok. Just for my understanding: Bringing the test cases into tools/
> testing/selftests would be the enabler to run LKFT and CKI, right?

It's not strictly necessary to have the test cases in
tools/testing/selftests to run them in LKFT and CKI, but it makes
running them much simpler. The selftests are already built in most
kernel CIs and often automatically run. In contrast, an external repo
would require to define a test case for each CI system.

> Does it have any impact or improvement for syzbot or LTP too, e.g. that
> we can also improve their test quality?

I don't think this would automatically improve syzbot or LTP.

As far as I know, LTP doesn't run the kernel selftests. It would rather
be an alternative place for the tests if they should (for some reason)
be separate from the kernel tree. But imho, bringing the test cases
closer to the kernel is a good thing. It makes sure the test cases match
the kernel version and makes them easy to discover and run for contributors.

syzbot is unrelated to other test cases. It relies on it's own
definitions to fuzz the kernel. For networking, there are two different
approaches to these definitions:

1) the definition of the syscall interfaces for a subsystem, e.g., in
[2] for CAN which I think is where the current sysbot splats are coming
from. New syscalls, options, etc. would need to be added there to extend
coverage, which should be the matter of a pull request. I only took a
quick look so I can't say for sure what might be missing here, but I
didn't see a mention of the cangw netlink interface and ISOTP there.
syzcaller might be able to discover bugs there as well by fuzzing
syscalls in general, but it of course works way better when there is a
definition of the interface available.

2) For all protocols over Ethernet, syzkaller can do external network
fuzzing [3]. With that, the network stack is fuzzed from the "outside"
by sending it packets as if they were coming from another machine,
guided by definitions of the protocols, similar to the syscall
definitions. I think it's a long shot to enable similar testing for CAN
and not something I would aim for in the near future.

[2]:
https://github.com/google/syzkaller/blob/master/sys/linux/socket_can.txt
[3]:
https://github.com/google/syzkaller/blob/master/docs/linux/external_fuzzing_network.md

>> The downside is that existing automation depending on can-tests
>> (which we don't know about) would need to be modified.
> 
> I don't know about any existing automation based in can-tests either.
> The reason for the can-test was mostly to document my own PoCs when
> adding new features.
> 
> I have no objections to stay with this repo as a PoC playground that
> might also help developers to get inspirations - and start something new
> with the current code base which aims to fuel the kernel selftests.

Okay, that's good to know can-tests is mostly PoCs for new features. It
can stay around of course, I know other subsystems have similar repos
(xdp for example). I'd add a note though that the selftests exist for
already merged features.

>> - Extend the coverage of the tests: This could include testing for,
>> e.g., vcan, vxcan, and the cangw netlink interface. But we're open to
>> feedback here if you see any pressing areas.
> 
> I see no pressing areas right now. But the recently integrated CAN XL
> support might get some attention ;-)

Alright, I'll keep that in the back of my head :-)

Thanks,
   Felix


