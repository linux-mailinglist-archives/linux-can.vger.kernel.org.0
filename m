Return-Path: <linux-can+bounces-4288-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60496B2FF68
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 17:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201A81CC822B
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 15:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EB128DB76;
	Thu, 21 Aug 2025 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeeFzYdL"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35A028934F
	for <linux-can@vger.kernel.org>; Thu, 21 Aug 2025 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791240; cv=none; b=VjG0GdkCvpjCYHGCm+BcPd+pqcxQGe28SrzzY34vOhdRDeHMyUP0LlBc27rhh9eDa9H/cL+0+nj99rUM4iQ6UKjIgNO/HtERSeRSzKSgT+LST6vQZ95AEJ2WpIebCZj+UdRQ9I+55qUiuXsITTxYHiq0QXYpv5eoHhxSRx2mH48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791240; c=relaxed/simple;
	bh=+MLZDrqKPzwmqjXfRANXh8FFXQvkOhkCda5UfEmZBmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=POeVXizYIc6Q0TN0JK39m4f4xRj0WRGeirPb5WQQQ9102bG12qLupGDOzBY4z7G8UZbVQdvLWtL0Rqp9bPY/iPJLjgDT9D0jTaKFvkdYWNi0kxpbVbAKzu+NhdVgORbmIG6ThTmN7hQp7Y7cg1EHNXYCGc9XDoPdYxEOtfEJ68Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeeFzYdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FF4C4CEEB;
	Thu, 21 Aug 2025 15:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755791240;
	bh=+MLZDrqKPzwmqjXfRANXh8FFXQvkOhkCda5UfEmZBmw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eeeFzYdL8pJUGEcmiUR6Q4ZL4K5qaSG14wB9os/9I+E2YlwKkrkhYRciWeTwcyg7c
	 +Ds4whumX+mizWvbb38dSX+I94MkLtTKWJQnB8ewmXxKjIAVsXbqV/eANgL8SJCU23
	 pLggU18FoCrXsWWRL3VhkjDBdNGIFNhYhF5E3K65otmsVmSiZ7Ui8FgH/CcOAdsgqM
	 9zonfWql8CfUXKY3m1l9gWsEHvGb22hHx9VrlqAnXDngpwmwrLsAO/ZEWO9cd4jEue
	 1GLdozvlIGK51stP/Ykda1zGLjlQ9+XhF8L9aTMg1Sycwa2k0DMg6p+jUzze1K2Rxf
	 Zn0IGpoAwP17Q==
Message-ID: <d73d326f-0c49-4e21-8d59-2f54e2be5f0e@kernel.org>
Date: Fri, 22 Aug 2025 00:47:18 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: canxl: add CANXL_PMS flag
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Robert Nawrath <mbro1689@gmail.com>
References: <20250729-can_tms-v1-1-21d0195d1dd0@kernel.org>
 <64bf8703-c80c-4a96-a5ad-0efc48bf0541@hartkopp.net>
 <d2610541-ba04-4a80-b3e6-c9c75bb1a486@kernel.org>
 <a1a752e8-63ac-4a2c-998c-c88a223dd57a@hartkopp.net>
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
In-Reply-To: <a1a752e8-63ac-4a2c-998c-c88a223dd57a@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Oliver,

On 18/08/2025 at 21:35, Oliver Hartkopp wrote:
> Hi Vincent,
> 
> On 30.07.25 16:15, Vincent Mailhol wrote:
>> On Tue. 29 Jul. 2025 at 03:20, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> 
>>> Btw. while we are at it: I would suggest for a name change of
>>>
>>> CAN_CTRLMODE_XL_TRX
>>>
>>> to
>>>
>>> CAN_CTRLMODE_XL_TMS
>>>
>>> as it makes clear how the controller should manage the PWM mode.
>>>
>>> "CAN_CTRLMODE_XL_TRX" would mean "there is a CAN XL PWM enabled transceiver"
>>> available which tells nothing about whether the PWM mode is used or not.
>>
>> Ack. I have the same opinion.
>>
> 
> We are already in 6.17-rc2 and I would definitely like to have the CAN XL driver
> support finalized in this net-next merge window phase.
> 
> What is your plan? Do you have an updated patch set to be posted for the
> discussion?

I uploaded my current WIP here:

https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/linux.git/log/?h=b4/canxl-netlink

As you will be able to see, most of the features are here. Now, I am trying to
think of all the edge cases and make sure that any incorrect configuration is
correctly rejected.

I am just sharing this to reassure everyone on the progress. The patches are not
yet ready for discussion. You can have a look if you want, but no need to do a
review as I am still making changes.


Yours sincerely,
Vincent Mailhol


