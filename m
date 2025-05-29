Return-Path: <linux-can+bounces-3729-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EA2AC7534
	for <lists+linux-can@lfdr.de>; Thu, 29 May 2025 02:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D943B1F70
	for <lists+linux-can@lfdr.de>; Thu, 29 May 2025 00:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8C715D1;
	Thu, 29 May 2025 00:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UALUa0XW"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-67.smtpout.orange.fr [193.252.22.67])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4117A55
	for <linux-can@vger.kernel.org>; Thu, 29 May 2025 00:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748480123; cv=none; b=uH/nXg0Mf8KfCKK0+x43SrY0hxL5e9hBow1fk3jCFxYD5RjuXKtMh19K7s4dfbLeMvyQWl82W1a6WjB01AvgqZhb9FQim6KrgIaUOfHrQRmdtr/L8HRsWYgiQm5LMX1TTQmW9eNMDr8LPzqVNLNuMsvp2KXmtj10DRGznrnRkL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748480123; c=relaxed/simple;
	bh=FkVVCg/C6h8y3SiJGZthsbe3E0hp+W2AwMNUJDvtRVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkBPFV+t/8a4LZ6fm3U8Xvswvg84KPyP6acvrcD0a77x1qN/AxnO6aiWZwt2PVQVWaATwW61yPQ1E5lUNosCHQi2b9Exl0XF7Os9/JB+3MqCCwiY8knUZX1+GfmwE4kobcSKj5HcWvLr+OktDDW4iFA59PPvzopgm7U/4dmBmBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=UALUa0XW; arc=none smtp.client-ip=193.252.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id KRX6ujCo3yzREKRX7u7jPq; Thu, 29 May 2025 02:54:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1748480051;
	bh=DTH3qZvVcnTXHLbZ6NRkcFo9TOboOJch8JfnSq08jAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=UALUa0XWxaO7YwPVoU/beEGJ98pIS8Ki1XUFvVacAgULyQTW59QM7JpZ3LNIzlJ8D
	 xHU1leiMcU4ooKhZdmxDtuPR6M4C14jJizgZieswAvKeTrPJ5Y08w+GOBkRSJ2C4tu
	 IkHlwGRHqxm8z6IAP82BlnQVRUeL6CE8aG2ULZjvejD9bsDEpOIN4clhjavfG26PoB
	 7SrUgtWaLqYTz0xwuMJgNCSn1RteCZNiEzCCBtAWaLZM9i14WoVD76gn2h5Q581ppb
	 Io8hPXcEehqIhZnKnErgQ/9c5B1SH6PBGu3IK6I34fI2lEl/K/4XEdnZ8R0O+YgfXJ
	 8O1kmu2dsHB/Q==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 29 May 2025 02:54:11 +0200
X-ME-IP: 124.33.176.97
Message-ID: <58c9cd69-f4dc-4da8-a549-a167105a0f19@wanadoo.fr>
Date: Thu, 29 May 2025 09:54:07 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fw: [Bug 220168] New: flexcan-core.c
To: Stephen Hemminger <stephen@networkplumber.org>, robbinvandamme@gmail.com
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>
References: <20250528144814.17721a4e@hermes.local>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250528144814.17721a4e@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+To: Robbin

Hi Stephen and Robbin,

Thanks for forwarding us this bug report.

On 29/05/2025 at 06:48, Stephen Hemminger wrote:
> Begin forwarded message:
> 
> Date: Wed, 28 May 2025 15:19:21 +0000
> From: bugzilla-daemon@kernel.org
> To: stephen@networkplumber.org
> Subject: [Bug 220168] New: flexcan-core.c
> 
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=220168
> 
>             Bug ID: 220168
>            Summary: flexcan-core.c
>            Product: Networking
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: Other
>           Assignee: stephen@networkplumber.org
>           Reporter: robbinvandamme@gmail.com
>         Regression: No
> 
> Bit15 (TDCEN) should not be enabled according to the spec if dbrp > 2 and in
> the driver it gets enabled when i set dbrp = 10. Resulting in RX Error Frames.
> 
> 
> spec:
> ISO11898-1:2015(E), section 11.3.3 (Transmtiter delay compensation) (page 52):
> It shall be programmable whether the mechanism is used at all. When this
> mechanism is used, the value of the prescaler for the data time quantum m(D)
> shall be one or two.
> 
> The "prescaler for the data time quantim m(D)" is commonly referred to as
> "dbrp" by implementations.

The issue which you describe here as well as the issue in bug 220170
[1] share roughly the same root cause: the driver is setting the TDC
parameters manually without doing any proper checking. The reason is
that, at the time of writing, the CAN subsystem did not have a
framework to handle the TDC logic. This has changed since.

We had a very similar issue on the mcp251xfd driver recently which was
fixed in [2]. Other relevant background information can be found in
[3]. The flexcan needs to be modified in a similar fashion.

I do not have the hardware so it would be hard to fix on my side.

@Robbin: I assume you have access to the hardware. Would you like to
try to write the patch for this? I can provide guidance.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=220170

[2] commit 5e1663810e11 ("can: mcp251xfd: fix TDC setting for low data
bit rates")
Link: https://git.kernel.org/torvalds/c/5e1663810e11

[3] Re: mcp251xfd: forced TDC
Link:
https://lore.kernel.org/all/CAMZ6RqKdyFPRwMbCZY5HwzLTeT9jcbxFiOfcuHbo+VgFF3ZViw@mail.gmail.com/


Yours sincerely,
Vincent Mailhol


