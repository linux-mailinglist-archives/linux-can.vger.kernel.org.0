Return-Path: <linux-can+bounces-4882-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EE5B94B1F
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FF13ABFB2
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD84311C0C;
	Tue, 23 Sep 2025 07:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQXKRbJn"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A6931985E;
	Tue, 23 Sep 2025 07:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758611084; cv=none; b=nn1U+xlImAlzidVdpF0g/assHPmyZ0dga5unSNE6xCfBcbek/v/aARPvQrDUai21TRh5NeFmMdSm0KDsY1I/3ZCHyXWN6/AkwuCWZmAao4xXp/zSrhR+qu/p29q7iLXPWExAQ1GcpDFClELt0BUsR63kHm9Mb10ty/cpsyhmy8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758611084; c=relaxed/simple;
	bh=SAj2JDGdBOudCi5ktyNIUJ+f4ekf1Bg5F5+I4mHetv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vwx8JMChy5Yi35imBzC7oaqvLWXd1fSSCojssjFlCtsDI6YRhwx9DgjZPsFaVTErhhCTl5leDTs3P4nSHrZwVW7mxSXNR5UiAtmspdH3+FOANbuZEG6pKapaxKr6vuMDelOlJf7UwjocxxdhUtpBf1m62izxmErwjLRXT1UgUPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQXKRbJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A0EC4CEF5;
	Tue, 23 Sep 2025 07:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758611084;
	bh=SAj2JDGdBOudCi5ktyNIUJ+f4ekf1Bg5F5+I4mHetv8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NQXKRbJnYyEeYkKAYjblcMdBEfXoFpxV39UHJfPJsiNL52OVGQ84/gAKBx28wbyOk
	 IILmMuTzWorqZ4AkCiGX3AbFqcbhUL/PH3TvtYk0TSTpBOfhz0XfplbxtJWyJR/tUt
	 wfzq8MNO5Dw9s4US0PbCwbiOzKQN4uqTS72PFPAv7Vc2E6YoarPdYRfUUzFZhs0V1V
	 ZpWj+wfABjEXtSJJf4Zre8WIfq70011zNA4dZB5orPu+hw6ABANlTG6pMXnNrGLK0p
	 DbrmeHUMxagkB9yOsZJYlOqpsG8YGVz4DYgXzfmXIrc17yK3apFJ5cdy6tq250HKyD
	 zNVnknwIAbgUA==
Message-ID: <2528d3d7-2807-4ef6-8269-5e20de57cc41@kernel.org>
Date: Tue, 23 Sep 2025 16:04:41 +0900
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
 <9cfdcf56-2f47-4cfd-9fd6-2c6fa4476752@kernel.org>
 <20250922-rational-mastodon-of-sufficiency-6b49f1-mkl@pengutronix.de>
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
In-Reply-To: <20250922-rational-mastodon-of-sufficiency-6b49f1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/09/2025 at 22:06, Marc Kleine-Budde a écrit :
> On 22.09.2025 20:14:16, Vincent Mailhol wrote:

(...)

>> I will resend my two series in the next few days as soon as the MTU fix appears
>> in net-next.
> 
> I don't know how much time we have between the merge of net into
> net-next and the acceptance of the last PR by the network team for the
> next merge window. We will see.

With the pull request to net/main being delayed, I decided to finally remove the
patch which was in conflict and send the rest:

https://lore.kernel.org/linux-can/20250923-can-fix-mtu-v3-0-581bde113f52@kernel.org/

and:

https://lore.kernel.org/linux-can/20250923-canxl-netlink-prep-v4-0-e720d28f66fe@kernel.org/

These are my last two series for this development window (to be applied in order).

Also, sorry for the noise when sending those twice.


Yours sincerely,
Vincent Mailhol


