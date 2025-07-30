Return-Path: <linux-can+bounces-4188-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C23B16275
	for <lists+linux-can@lfdr.de>; Wed, 30 Jul 2025 16:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6D61897F0A
	for <lists+linux-can@lfdr.de>; Wed, 30 Jul 2025 14:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2DB2C3264;
	Wed, 30 Jul 2025 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvQdZvMO"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74876298987;
	Wed, 30 Jul 2025 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884958; cv=none; b=PFu1Zli0KEBq375VXYsIbIoUaT8tkJGDUv/dk00HXGuyoj2SL3dwj2sVzIOVzLaIqRejc2c5SNe8njIN+zKQCupVRgcAk3RZAj9FwpOU+AkEdEnsRa+y3tI5lqMrd6oX2W3cGQBMgP0vzIOYXIzmRPCTtdA2PRYDrbwAEA2k/Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884958; c=relaxed/simple;
	bh=n0Gc0UiBtbHXgOJ/tDRF+P1I8EiZ4v+MUQaIDf3f3N8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJPCBEMV3ztQ03Wb5wEjnjTNtNtRa6tRLW+UVk8jLvlHpfF28bNum5zuZQY9Ar6hM3WHc4WNTXHCosmVfQXmZ4q9l4XTQD4hSroQI3gbZ1SQSriF1N3ivHd+Kq+FDOsmu84i+JLy06Ar5wotSeDPyUWMCUWXkdpymOpOXtdYbb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvQdZvMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06038C4CEE3;
	Wed, 30 Jul 2025 14:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753884957;
	bh=n0Gc0UiBtbHXgOJ/tDRF+P1I8EiZ4v+MUQaIDf3f3N8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mvQdZvMO9/3KaFf+ruxFCqUUwJI+f6CqIeJzPhZQD8BxMkcHlDQGvQAKaKghQr110
	 NviDQfMLhxpTl4oXi0JVEsckRFDvsxk64Wz6O+RlYGg+r4qgYlw13u3GL8k/Qfrv+y
	 /EFSJPtVyJZXkJSqzXhOaUAUdce1MhFoALadDjZJpbofgZbkc+1T+xPCBAfRXL59aB
	 TPP3d3PCTjClyaL26jHm2DgJXOW6u9/ZVarE9zotu3A+WVn21v3U7Q2gjrymkZtkNP
	 AanIwf2m2RGelAub5lfYgdO0w/Y9BaTdaQXZ8FwLVr5z4VzX5GOnujZR2gEepQoB7p
	 9X1PtazteQd1w==
Message-ID: <d2610541-ba04-4a80-b3e6-c9c75bb1a486@kernel.org>
Date: Wed, 30 Jul 2025 23:15:55 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: canxl: add CANXL_PMS flag
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250729-can_tms-v1-1-21d0195d1dd0@kernel.org>
 <64bf8703-c80c-4a96-a5ad-0efc48bf0541@hartkopp.net>
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
In-Reply-To: <64bf8703-c80c-4a96-a5ad-0efc48bf0541@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue. 29 Jul. 2025 at 03:20, Oliver Hartkopp <socketcan@hartkopp.net> wrote:

(...)

>> My gut felling is that the TMS is intended to work in a similar
>> fashion as the CAN FD's BRS. In CAN FD, we do not have a
>> CAN_CTRLMODE_FD_BRS to tell that FD should operate only using the
>> nominal bittiming. And so, I do not get why CAN XL should be different
>> and have a CAN_CTRLMODE_XL_TMS (or CAN_CTRLMODE_XL_TRX).
>>
>> Stéphane and Oliver: maybe the datasheet of your CAN XL board have
>> some additional insights? Did you see a register allowing to globally
>> deactivate the TMS (i.e. not only at the frame level)?
> 
> You can take a look at the XCAN manual https://github.com/linux-can/can-doc/
> blob/master/x_can/xcan_user_manual_v350.pdf
> 
> And I have a XCANB specification which is a simple (non-DMA) CAN XL controller.
> 
> The TMS switching is only possible in netlink level and there's no TMS-style bit
> in the CAN XL frame layout that is pushed into the controller to send a CAN XL
> frame => there is not TMS-bit analogue to the BRS-bit your were searching for.
> 
> Therefore this patch is obsolete.

OK. I re-re-read the standard. It turns out that the CAN XL SIC is only able to
differentiate between the *nominal* NRZ and the PWM on the fly. The frequency of
data bitrate NRZ is already too high to differentiate using the 200 ns threshold.

So indeed the PMS is set once for all when the bus is inactive. And that switch
tells the controller whether it should use NRZ or PWM for the data phase. That
on the fly detection logic really confused me, but now I finally understand.

Thanks for the explanations!

> Btw. while we are at it: I would suggest for a name change of
> 
> CAN_CTRLMODE_XL_TRX
> 
> to
> 
> CAN_CTRLMODE_XL_TMS
> 
> as it makes clear how the controller should manage the PWM mode.
> 
> "CAN_CTRLMODE_XL_TRX" would mean "there is a CAN XL PWM enabled transceiver"
> available which tells nothing about whether the PWM mode is used or not.

Ack. I have the same opinion.


Yours sincerely,
Vincent Mailhol


