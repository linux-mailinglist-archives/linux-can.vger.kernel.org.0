Return-Path: <linux-can+bounces-6053-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FA4D06504
	for <lists+linux-can@lfdr.de>; Thu, 08 Jan 2026 22:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBA7130196BF
	for <lists+linux-can@lfdr.de>; Thu,  8 Jan 2026 21:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170AE338932;
	Thu,  8 Jan 2026 21:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DrQoZSZn";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="kAu15dTX"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D5E33769F
	for <linux-can@vger.kernel.org>; Thu,  8 Jan 2026 21:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767907657; cv=pass; b=phqS/WLbMBMDKGjhTZlb0rKSEj8qI9xH9sToBwoXiSaAChntcAiFqoZARs3MnMPxZL5e0hW3QMMBy8WvYnjazk+zNxdCcy0qvGstt55L9ZT/CQT7mDzEIv224eFCpBxzUYX+RRrMjvRMm5QivjkkdUus6cE8ff97LUG7dgviTpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767907657; c=relaxed/simple;
	bh=izntjT0jC45jSsiZwrNMZz9/ShHvk6xBY+WpMme40fI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbdpZJsPLMksdeS41foHsIDy4VENIN1xtvyVNwiqJQtA4dIkHtlrgOo0RGWYmngTCdfMRPWC49cvyJUQ3+i4fOdr61Qou3uXhHMY3DH68TYD9hH68pW8xf6wHSTZ5p19xzj5wzLk+/ZHz+09Auw8xiO6RPl7U5ph8J1Wco2RT/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=DrQoZSZn; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=kAu15dTX; arc=pass smtp.client-ip=85.215.255.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767907467; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JYQCEpbxw/GjkjZj0fBfJZqdMG3n3acxJSgIII+s8SDfHCnn+5C23rxLis3l5NqZNh
    pVOK2qiCkAJTDSHPxJF9VW0Hke1xGqv3RFVUccblhlzzapruWdSZVNg7rNPIZDfYx2WO
    5MiGsUgv7kM4nWfaN9Ts2d0VIWb6Vwb2Eycf1Ng73AkhmpYIw8rahgk5Uo8jHJwJmXYf
    J2pLACHDI9onzmqbnNHSKZbHLFxlMC7h1rm0DDg4S3tKpG0q/mRhCEz1RD/3Kt7zOZT1
    +IlqFROWjZSQJDwnhNavvtLOx8je/2KzjWRZGehHwTWfMka1h9hxnzUEoYoUInHLWp9G
    zcIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767907467;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9hHmROW4gpSWev55Qb/+RvItutRBD35cmV6U+2YaOjg=;
    b=qgSSDXNpLkD+sanidCLIWOVU11dC3dh05y1MyaJL+EDkfFS393sIIQfGY/Egmo19wP
    zYymnjdGM4CrWGQzEnxrMhBjAqElVlzee1lWlpjV8Y32isBXgh87e/Y/0n4lBxI44DTw
    O5MDyt3aMA5gDuH7nk2RMGPlw60+1LzYLh9BJdnzqkfpsCLd7+qoAlvzRxbXTHTtJOKC
    UkJRDNKX47jWUd+kVxoVVnLTlOWrZbDcuG3r/8lu14PPfE5kobYtB4IFaGpr3Fsf8jeN
    CMW9bzYG8Aqsb1DHq2F9Ubl37OrCWjzAL80mNQYZ0F216uz45WBp61UEJeORKPBoxPkL
    NaGg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767907467;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9hHmROW4gpSWev55Qb/+RvItutRBD35cmV6U+2YaOjg=;
    b=DrQoZSZnZIjhQHlWRPpfgx3U1EOZHpeTltxIlZ4mvbj0ru21dtdheyJfzPlXsMzb3K
    D8MvAORt+l9OV8nbrlmeixI0/0pH/ORetWT/QYhze8o8Y/BlsQkx7SeBWr5R1qEDXW8w
    4H9NdHnhO2QjXIEFRLZYQj8aMTmzZkhq8DLuMcYahVV3cVfchVw9pBBSgCJRxSPAd0LA
    m3GhNEt6v0VRBIEtxs4I3FxPjUy3KfamoqfH7E/a1DH7tmc2JL9VxYFZb8+os4Zbe3P8
    9Nl09bzbKZYZaJLQa6wNkRGYDugFlmwoAh0Wm0+KCfKd+8yrV3RBD+FrWxGfEVWiQFOu
    +sEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767907467;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9hHmROW4gpSWev55Qb/+RvItutRBD35cmV6U+2YaOjg=;
    b=kAu15dTXvwiY2f/I7LDvRmfnlkxcAkFEOtCeYey3DaSUyQ6zYNzV3rqcWUzsAhnieM
    VginulBaYOD7ogMQqUCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b208LORL1c
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 8 Jan 2026 22:24:27 +0100 (CET)
Message-ID: <f7396b0c-44d5-4d5d-b571-0126e0cd078a@hartkopp.net>
Date: Thu, 8 Jan 2026 22:24:21 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC can-next 2/5] can: move can_iif from private headroom to
 struct sk_buff
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>
References: <20260108160716.101883-1-socketcan@hartkopp.net>
 <20260108160716.101883-2-socketcan@hartkopp.net>
 <20260108122516.221e9bc0@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260108122516.221e9bc0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jakub,

On 08.01.26 21:25, Jakub Kicinski wrote:
> On Thu,  8 Jan 2026 17:07:13 +0100 Oliver Hartkopp wrote:
>>   	union {
>> -		__be16		inner_protocol;
>> -		__u8		inner_ipproto;
>> -	};
>> +		/* protocols with encapsulation */
>> +		struct {
>> +			union {
>> +				__be16	inner_protocol;
>> +				__u8	inner_ipproto;
>> +			};
>>   
>> -	__u16			inner_transport_header;
>> -	__u16			inner_network_header;
>> -	__u16			inner_mac_header;
>> +			__u16	inner_transport_header;
>> +			__u16	inner_network_header;
>> +			__u16	inner_mac_header;
>> +		};
>> +		/* protocols without encapsulation */
>> +		struct {
>> +			int	can_iif;
>> +		};
>> +	};
> 
> I won't accept this patch but it's a matter of taste so maybe you can
> convince another of the netdev maintainers to take this.

The patch set was only for the quick discussion and would need some more 
documentation and commit message extensions anyway (including CC'ing 
additional maintainers).

As it is a CAN specific topic it would go upstream via linux-can ML and 
the CAN maintainer Marc (see CC). So we can discuss and finalize it here.

In the end I feel pretty good about using the inner-protocol space. 
We'll keep you in CC about this.

Many thanks for your valuable feedback and best regards,
Oliver


