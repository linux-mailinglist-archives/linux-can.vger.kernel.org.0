Return-Path: <linux-can+bounces-4810-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00887B9052E
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 13:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E94507A3DB0
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 11:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338D130277E;
	Mon, 22 Sep 2025 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHYFlIrJ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086DE27F01E;
	Mon, 22 Sep 2025 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758539659; cv=none; b=iC7/jIJCfnarAaXSioxPe5Es9mWUL23cxSpXLDh5cZT1XQZrenuTO3sVM28kY+0alovk0FYOUcsopVB3ZrWHfRHMb8aTU8PcmpPo3fmp+N/9onQEcrA86eWtKS/vRQRTApAckAsg3NQUuDmxhcLDxE+EVk2qu4ZvwATJxVBvRx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758539659; c=relaxed/simple;
	bh=u4tcI81GpcDXlkJJb8q7UShzugaBkMQGQXAKdJvurIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGMng4Hi6T3sYYMrnsiwh46XizeKNLFImFPeA0tBWsp14MpPMJZReBGpxgUwugHpKfxMO8KSi6kv971pQnv1aJWjoZHuOSh+0wQyp3kuuFn3xeB6Tj4MKd7FQ0AQ5o1uoeNS1ktkqZh5Fp+v0ngD4JOcqnMfzjgsUyh0zhshY9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHYFlIrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76B3C4CEF7;
	Mon, 22 Sep 2025 11:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758539658;
	bh=u4tcI81GpcDXlkJJb8q7UShzugaBkMQGQXAKdJvurIc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cHYFlIrJqsbCeX1YcOiVlvJlpup/OFc7Mwy1a9koofui6zy9bE6MzhAYaD5F+v9RV
	 0mLP1oHoS9tAk4N8/h2rKUS9TYiGmfC5WCuHRuc8HPGVZfh2cRVRUbEGPGWjn0gG7O
	 cEFy5Ux8DdMPoUdn6OBODFTN+6yKub+JUfjub05vOhvwKtjnWp7iJvYs3RKOXe18y1
	 St1cv4OLCAC+FGm7OW1L/PhZ+M463TPkf5wR7uTRhW6D4EI5fVE44h+2lc2DQElB6C
	 FELH5BzMq8UEG3gN+73u3VQsmVw5HxwNIutI+RktfK/7uu/U0cfBKDeOZQbWsX8Om7
	 us/ka+PlqXlSg==
Message-ID: <9cfdcf56-2f47-4cfd-9fd6-2c6fa4476752@kernel.org>
Date: Mon, 22 Sep 2025 20:14:16 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/20] can: netlink: refactor
 CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org>
 <20250910-canxl-netlink-prep-v2-7-f128d4083721@kernel.org>
 <f9854748-78c1-4852-a610-e839e9c91df3@kernel.org>
 <20250922-amber-spider-of-control-90be7c-mkl@pengutronix.de>
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
In-Reply-To: <20250922-amber-spider-of-control-90be7c-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/09/2025 at 18:43, Marc Kleine-Budde wrote:
> On 20.09.2025 16:24:42, Vincent Mailhol wrote:

(...)

>> @Marc, do you think you can send your next PR to net soonish?
>>
>> I would like to rebase this series and the "rework the CAN MTU logic" series on
>> top of the MTU fix:
>>
>> https://lore.kernel.org/linux-can/20250918-can-fix-mtu-v1-0-0d1cada9393b@kernel.org/
>>
>> But to do so, I first need to wait for the MTU fix to appear on net-next and
>> there is not so much time left before the end of the development windows.
> 
> This series looks fine to me. After -rc1, please check for any
> ndo_change_mtu, because the Nuvoton CAN-FD driver will go mainline, but
> not via the net-next tree.

Thanks for the head-up!

At the moment, that driver is in Lee's tree, so I was thinking of directly
preparing the fix patch and sending it to the netdev team and Lee so that both
are aware of the upcoming conflict.

I will resend my two series in the next few days as soon as the MTU fix appears
in net-next.


Yours sincerely,
Vincent Mailhol


