Return-Path: <linux-can+bounces-4766-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0C5B8C15E
	for <lists+linux-can@lfdr.de>; Sat, 20 Sep 2025 09:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75CD1585F3A
	for <lists+linux-can@lfdr.de>; Sat, 20 Sep 2025 07:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4661B23C4E3;
	Sat, 20 Sep 2025 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBNgipvy"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAC6A48;
	Sat, 20 Sep 2025 07:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758353086; cv=none; b=QmIHcBXBTXO0aGKcOkZsEON63QUqZJTiR7KncKwG67gEqFkP2FPAglZ3NRU62wQLC/iBus/jdIJPiOmdct1lZ/Vqgq9pT6NAH5pb2pTO43KgaRROWmm5o7ybRrJ1wPqaBRgsjfoRtXS/DfD46IlpXgQYEpjE1sMx1Do1TfIBTGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758353086; c=relaxed/simple;
	bh=QLLnsyzVvNtkfbU6A/JU/lOC9TqyU4vZ881IaMHqu/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pDhlmpPgLCpXAksmAonG34sE+52ZnYXWButiPrGzTVg5lWPBygKLsCudXcu/kPH0eFlpxxLKwNB0WjSubu2HT6k0GyAti9/yCVDcUBBhl2VYwPkt2UL74U+Rd8QDlYpr5bgQ8ey3Yde83x8p+zZr+RTkbauIkTj7/6CDLjpXi+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBNgipvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D31C4CEEB;
	Sat, 20 Sep 2025 07:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758353085;
	bh=QLLnsyzVvNtkfbU6A/JU/lOC9TqyU4vZ881IaMHqu/g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vBNgipvysCybuweuBCiCGsH8jpfzZIKtnx6DFMH7tZkzo8sjgeSBpV8L3KWmY2MBR
	 NPHjBCmIx6/xI4xSZbhILtq8TCadtK14TK8qxEp7ArK83TTqSnfwmPIr+DoDL06GO3
	 +Hf4aqErD9WoXm+dcap9R9eVsXgk3NL9ZiDraBcO7uDVuy29px4XUy1dLtBEaxWQ2A
	 3TJCxZlgDFs7YD4RgMpVlyK7QE7WrE9qtkhWB5UqQmgo2kd34Tdwz7lhQgRHnwsenk
	 jtAGT+4lU4nwhKC05wErIdiFQIgLNOSGBbdCvh3Tt3tAgFlIA5wPqLVaRXo6l0m0fU
	 q7wFg7rmog69g==
Message-ID: <f9854748-78c1-4852-a610-e839e9c91df3@kernel.org>
Date: Sat, 20 Sep 2025 16:24:42 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/20] can: netlink: refactor
 CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org>
 <20250910-canxl-netlink-prep-v2-7-f128d4083721@kernel.org>
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
In-Reply-To: <20250910-canxl-netlink-prep-v2-7-f128d4083721@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/09/2025 at 15:03, Vincent Mailhol wrote:
> CAN_CTRLMODE_TDC_AUTO and CAN_CTRLMODE_TDC_MANUAL are mutually
> exclusive. This means that whenever the user switches from auto to
> manual mode (or vice versa), the other flag which was set previously
> needs to be cleared.
> 
> Currently, this is handled with a masking operation. It can be done in
> a simpler manner by clearing any of the previous TDC flags before
> copying netlink attributes. The code becomes easier to understand and
> will make it easier to add the new upcoming CAN XL flags which will
> have a similar reset logic as the current TDC flags.
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
>  drivers/net/can/dev/netlink.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 274eaab10796b601d565c32f6315727a578970bb..72a82d4e9d6494771320ea035ed6f6098c0e8ce6 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -254,6 +254,10 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>  		if ((maskedflags & ctrlstatic) != ctrlstatic)
>  			return -EOPNOTSUPP;
>  
> +		/* If a top dependency flag is provided, reset all its dependencies */
> +		if (cm->mask & CAN_CTRLMODE_FD)
> +			priv->ctrlmode &= !CAN_CTRLMODE_FD_TDC_MASK;
                                          ^

This is a bug. The correct operation to unset the flag is:

		priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;

(replace the ! operator by ~).

@Marc, do you think you can send your next PR to net soonish?

I would like to rebase this series and the "rework the CAN MTU logic" series on
top of the MTU fix:

https://lore.kernel.org/linux-can/20250918-can-fix-mtu-v1-0-0d1cada9393b@kernel.org/

But to do so, I first need to wait for the MTU fix to appear on net-next and
there is not so much time left before the end of the development windows.

If the schedule is too short, let me know and I will adjust accordingly by
dropping whatever patches are in conflict.


Yours sincerely,
Vincent Mailhol


