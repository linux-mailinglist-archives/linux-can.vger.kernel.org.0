Return-Path: <linux-can+bounces-5509-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C301C73BF9
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 12:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87387342624
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 11:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD3732ED44;
	Thu, 20 Nov 2025 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XZmv6c9a";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="wIB/nj7u"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97C831BCB8
	for <linux-can@vger.kernel.org>; Thu, 20 Nov 2025 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763638075; cv=pass; b=r+X2/1+dUXLimatp/5s/hMa8ve759Yx5jF0U4id0rHCZBlMJODmeareIyQKbFfKvZUk+BdP6kGIQnVOVw2IbMBMNUWvttul/mvtfP3NvTpTZgliWTbxKCoafu2Sw3FC+LXD5eapNZAZUc/iu4L+LG8UzKmE5M6cX20338sXwnQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763638075; c=relaxed/simple;
	bh=dwWs/w26arYhmOo2d7QNaO1r4LLIDSKCOM/e18GurGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eSz5C3Zkq42TGzfowgyErEnSH7b8THnDpNqDTklgqBQlnGKCsEsk6BL6Fsqsbbn1PdQ4gEUvWYv0Dlyj0LkC4h9dohzdqIGL5Iodscx6NZDcHMfaOQVg9sqlqsWcsqXgbDqkuEO39UhtE0KyG55yrYSoDMnCwxTixGRjv4giQUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XZmv6c9a; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=wIB/nj7u; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763638064; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gwrRAQcwNQpwgSfxCpgz788xByzhiuCUDVhQxr0sPA/H9/g1tUhMSpjALR2F8QyyT9
    mypkgdkM85G+VqDZorQ3qi7PVPNLIOPVwrQwHPR36teowMpAIaThfDxBvlltp77EbwuH
    kqOMihBbnW7k0TF9KOX585wOtKNQJjlO4sRPHD/Fd9IyQPLbXaLir4pDhMl+Xpg1pZHJ
    KCOMrDoJYpnBTmrx1FzjbZl8AqMPgk62epknqSZ6l+qs1UriHCh1QDKI+M44mcQ4alIE
    oUO62YZDRuAiUJAw7MaKEEC4SmZwEzJFwehwaQkkSIBrfSpvdC8bNBrEq1rDlxhAOFuJ
    r8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763638064;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=XeYbiREzbMEuUyIpP2PM4l1E9cVTji0BU3Djdk2nMkU=;
    b=aFYuUPBm/6c3+EA4mTWHbbtNnMNqGa1QOPRn9WoVtw6nBL7wqp+/48JyjDXMLVpQ7q
    4Xg+DoD9xEtjHVEtRa4zu1M4VzvMDjnN0W2okwc7kcVBmxaiua/AiQquG5h0cgWBJKVm
    13cETVhw7tRbK0ykXaF/+IZcp+fI2NfCcZWhLBNz/+vp+YFS3i9GpEptHc68q48ZPiPW
    P5Zj4yZEAIJqcfJrGdprSPK8lemZY03LYhdLUHXA0YODFj4lu78oU9B8TxlTFYJZ0Tg9
    a1mwqtCAnSGjZL/YxPfhwmXGln0R2mqj9h/Nv0j7/ClJ2iEMouBQ5ahDXvga83HvVUa+
    +3SA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763638064;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=XeYbiREzbMEuUyIpP2PM4l1E9cVTji0BU3Djdk2nMkU=;
    b=XZmv6c9ai0roMmvLxHk7X3SjWEMeXYglr1FORE+mUdyTg+/u51FqVCupv0XBFY2JNC
    a54kRzX9aOupL7Bpc+kUDMBJS4NWKmNtiuOL+v9psCymZPOmEwwdZvDGinMco932blRB
    sVNSUkyRIdCQ6vdMribpccfnFQX8WzawBvuYsyykG9r5Vs5DPOuCYJoDYy/D6b7qTH+5
    h1K4Hlgw4p0QOKCygTWUs7vMDPBjaClOz3qIIBG66qChhmZ+fL1PGbijoOtfVY4diTtN
    ppj1ms5p3teLrRG+YiH8NQ7mh71AY6mXm/Dzir6yCdjKGycxZvMBbFzSe+3FJETHthTy
    00Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763638064;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=XeYbiREzbMEuUyIpP2PM4l1E9cVTji0BU3Djdk2nMkU=;
    b=wIB/nj7udLp+LIQE3c4V4OtF1uyROH/iO1lCgnXielUIwSj/kVZFCyiH8p3NU3fv9B
    J12xBMS1GFZGX7xBzyDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AKBRh6bY
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 20 Nov 2025 12:27:43 +0100 (CET)
Message-ID: <f9141c09-76ba-41ff-b971-6e05e4941b5d@hartkopp.net>
Date: Thu, 20 Nov 2025 12:27:43 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Mainlining of [canxl v2 00/15] CAN XL support for review (full
 series)
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 linux-can@vger.kernel.org
References: <20251115163740.7875-1-socketcan@hartkopp.net>
 <cedee756-ae5b-456c-96b0-9263177a647a@hartkopp.net>
 <20251119-hypersonic-mamba-of-abundance-0c3f95-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251119-hypersonic-mamba-of-abundance-0c3f95-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19.11.25 22:08, Marc Kleine-Budde wrote:
> On 19.11.2025 19:17:05, Oliver Hartkopp wrote:
>> Hello Marc/Vincent/Stéphane!
>>
>> We are right before Linux 6.18-rc7 and I would like to have the CAN XL
>> support ready for the 6.19 merge window.
>>
>> Unfortunately the reaction time and feedback from Vincent is currently very
>> intermittent. This is no criticism but risky for catching the 6.19 merge
>> window.
>>
>> This v2 patch set is feature complete and tested.
>>
>> Finalized discussions (code complete in v2 patch set and tested):
>> - make RESTRICTED a normal ctrlmode_supported option
>> - make TMS a normal ctrlmode_supported option
>> - omit CAN_CTRLMODE_XL_ERR_SIGNAL in netlink API
>>
>> Open discussions / review results:
>> - not removing "const" in can_update_sample_point()
>> - have the ctrlmode names in ip feedback messages capitalized
>> - increase the resolution to two decimal places in can_calc_bittiming()
>> - can_calc_pwm() has no return value (kernel test robot report)
>>
>> The latter are tiny fixes and beautifications that potentially can also be
>> done after the merge window.
>>
>> Therefore I would propose to mainline the current v2 patch set right now and
>> see what we can improve until the merge window closes.
>>
>> @Vincent: If you are currently busy I can offer to work on the open points
>> for you. So it would just be a review-job for you and I would send a v3
>> patch set until Friday (latest).
> 
> It's probably a week or so until the last PR to net-next.

Ok.

> For the next iteration of the series, please include you S-o-b,
> otherwise I cannot take it.

I'll send a V3 patch series with the fixes and correct S-o-b tags.
One of my patches needs some better description too.

So Vincent can see the results and we can discuss on that new basis.

Many thanks!
Oliver



