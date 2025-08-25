Return-Path: <linux-can+bounces-4342-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB953B337A7
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 09:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FEE17A85FC
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 07:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B4428724B;
	Mon, 25 Aug 2025 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ifr+dQfo";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="trxW5nH1"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37161288C2F
	for <linux-can@vger.kernel.org>; Mon, 25 Aug 2025 07:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756106439; cv=pass; b=gLrteaZr9rB4pUJtFloV0P0T5cJBs/Xr4rznVSKgQ9s3Qrc4FXgxB7pDZIJwwJS9DZGuENrTEgo8sgBLKZKMzl51feO2NF8dbiUCNBGN3ATrgR359XziKgT7vQC4x3LRleMaYo1fEUgWm/GSfU9UKqSRGN86dgYMoWaffRyc/yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756106439; c=relaxed/simple;
	bh=FpExrZP+KnGmQD/5DcDNE2MsH9uE++1ei+IaoE59PdY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=vFoHG+Ehg6BKvEtffUPrvEIP4faAE3HRXTaC5Q0+HHYcwf+U18L88DZAUqjCK/ULUvhGbvlMBZresMOEsyUF+Lu9JvSkrhqoWlsbO6eGZhOSj7Pof3T+qLtPDtCNz+c1PTpLQXovJS0FRTqGuwdC1aLAtkbIG3SXvxTv5eykzIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ifr+dQfo; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=trxW5nH1; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1756106249; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HWPyphMNdGkgMd1Cr6Ns4hMioqgKGjLWPm/f7b4+An3fq8TibMkq2iK4oe+mEBFmNy
    5O3Ojbi4I4eFw6dWA4NIHG6NEE0q4RWPnkYJdazC3PuPzGtktXQgImdYTGPyyGDNyEEJ
    GQ7EMMEnVmvGH6F0BKVXA4INafxFUIaokXayrZoFak6IXiaMTh87i8Fnj3r8Rn3UiLun
    tw6VaiV/Ta+P9tyASHR7qFNkgzKHRDeogj7KT4BXG62Gp+boxS/msWHBbNrbExCxnQ+r
    2YTLg5iM6bwo5VVtD2nPK43O4JRU1nGK7TajO1eMZBXSK0F+Dq5LcrKt/RpAc3Km4ioZ
    GVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1756106249;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6SyZ6S2TWQj04sN/o/0L6B1gKRY8+sqo3YFs86YZrxk=;
    b=Z3ob5CjiH8yCrL8Bq+GZ8a14xxm7QG7FqLeZypWU1idtVMV8k4PLXhjxmgLu6o1xha
    RnT27UeOeKKibWJBS2S9t3yCAhiRXYMsxFWstE2FjFodx7iKIck5l8/iwh+zafjL5oQl
    yotrGiw+XadKBCSp0F4hOGoxm3IEYGc/EX/hEGREU6KfdJv4ZmG9kAfptqhXRkufB6BC
    PK5F0s0R05wnHKwFFeZO6qgE/qGi8ZtOGqGIuxWPhGmkx/9hNP2NfGtdGb5ec5P0SxZE
    bNOPWekeE4+SCKpqBADDPRiOjTQsZLvTuWt8Yn73u1yUTGE+BukxUXaawA6lDiPkdFRc
    JYpA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1756106249;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6SyZ6S2TWQj04sN/o/0L6B1gKRY8+sqo3YFs86YZrxk=;
    b=ifr+dQfoKBsThGJ0d2I4e74NeuEU0bullil9q2ZMA8yjnrNB3R9zN0q5GQzztFDDLi
    rAjDfNaUgUZP4UCAo3CqBfePjE0oau1aLqwNCjsgCx4YhOasrK2iF9tzaRAtWtz6Wzif
    voXnB8ZdWXDefzzssEpdSj6ndf4C/J0PIr8vKtkjH79w3kSAD/DaqTDWVvUvpAU8RKHY
    kzntbg1khWrCJHTFmVsM878HaplPmG5/EjO8va0cYknrXgBzVktvLetZgWqzfeeDCL1u
    BpnZr7a3QZzSUov7G4VPEDRgnreta2+a9Gy8LQrzVdRJ/nUzg69x5rbRndqOhoXj7Z62
    29mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1756106249;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6SyZ6S2TWQj04sN/o/0L6B1gKRY8+sqo3YFs86YZrxk=;
    b=trxW5nH1DvjTTY32TAJWk3dTliEPqTKTHIplKkPATz2P+K1NbUuR3+30fVUYg7YvYW
    MbJ9OmR+359dB2BWFyDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+4xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5010::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d36117P7HSgLE
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 25 Aug 2025 09:17:28 +0200 (CEST)
Message-ID: <5db57860-05ad-4925-a9b3-18ce2d88ab0d@hartkopp.net>
Date: Mon, 25 Aug 2025 09:17:22 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: canxl: add CANXL_PMS flag
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Robert Nawrath <mbro1689@gmail.com>
References: <20250729-can_tms-v1-1-21d0195d1dd0@kernel.org>
 <64bf8703-c80c-4a96-a5ad-0efc48bf0541@hartkopp.net>
 <d2610541-ba04-4a80-b3e6-c9c75bb1a486@kernel.org>
 <a1a752e8-63ac-4a2c-998c-c88a223dd57a@hartkopp.net>
 <d73d326f-0c49-4e21-8d59-2f54e2be5f0e@kernel.org>
 <d2ce032e-cca5-4050-ae1a-6fe5f8a0b25f@hartkopp.net>
Content-Language: en-US
In-Reply-To: <d2ce032e-cca5-4050-ae1a-6fe5f8a0b25f@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24.08.25 22:24, Oliver Hartkopp wrote:

> On 21.08.25 17:47, Vincent Mailhol wrote:

>> I uploaded my current WIP here:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/linux.git/ 
>> log/?h=b4/canxl-netlink
>>
>> As you will be able to see, most of the features are here. Now, I am 
>> trying to
>> think of all the edge cases and make sure that any incorrect 
>> configuration is
>> correctly rejected.
>>
>> I am just sharing this to reassure everyone on the progress. The 
>> patches are not
>> yet ready for discussion. You can have a look if you want, but no need 
>> to do a
>> review as I am still making changes.
> 
> I upgraded my hardware test setup to 6.17-rc3 with the patches from your 
> b4/canxl-netlink branch.
> 
> Most things were easy to adapt but the netlink PWM API.
> 
> Two questions:
> 1. Why did you make the PWM values u32 as the 6 bit will always fit into 
> a u8 value?
> 
> 2. Can you share some PWM code for the iproute2 package or do I need to 
> adapt this code myself?
> 
> https://github.com/hartkopp/canxl-nl/blob/main/iproute2/0005-iplink_can- 
> canxl-add-PWM-config-support.patch
> 

Well, that was an unneeded effort as you pushed your changes just a 
short time after I adapted all my code :-/

Can you please post your changes here on the mailing list so that the 
usual development process is executed?

E.g. the CAN_CTRLMODE_RESTRIC_OP should be named to 
CAN_CTRLMODE_RESTRICTED to meet the other configuration options.

The listen-only operation mode is not named CAN_CTRLMODE_LISTENONLY_OP 
but CAN_CTRLMODE_LISTENONLY ...

Best regards,
Oliver

