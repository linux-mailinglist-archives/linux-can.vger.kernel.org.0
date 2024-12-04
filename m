Return-Path: <linux-can+bounces-2323-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5FD9E3588
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 09:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8E83B29A65
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 08:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3392818FDA3;
	Wed,  4 Dec 2024 07:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DMEr2eO0";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="dqwSwwJT"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F28518FC84
	for <linux-can@vger.kernel.org>; Wed,  4 Dec 2024 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.219
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298978; cv=pass; b=bDGpvpr/srAhxlgkdUzsX7iYAZtmZHpeCPBtKmVl7tmNe8f6tS7f7cpFRij/pT+l8yUeLS4Vtb84yMp6UWb9RDucwupRG66t/yRA+tRVKRxEugCES0O7b4AdwFiG/f0/7sUk71vA/o2WfLmtBfnRmyZKYd2KcynQ2D9hjVlhQSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298978; c=relaxed/simple;
	bh=Wm60Exwwp/8vpDwUZukwhtTUMMnnweUhSpF8TRq9/N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqCwkmnMzNi7Th3OPd4cW7IEbAFnYMmTraTOxREU8jL9qTB5p0djthSUJWOsEXbijrck1RiBewj137SssKQjliDj85Kb87sxiir/P1Pxf3ernd/SuRlkPPMJHmnzV+Z96HHMoi7viwOluAc+bmUKakB35Ehv+YLoWqP5uC+c3FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=DMEr2eO0; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=dqwSwwJT; arc=pass smtp.client-ip=81.169.146.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1733298970; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WQiVtNyn3Q92o/LcH6vEwARTCScCIJM6vZAMVL8JTFCzO+zEtXaD5I3dgiW3rpyLGr
    H9KrBEmPMeOf1LuCt/FCWejwrr4w4tRmXc2kw3kjR22v1gwEoSzc/2jM/zM7pmXXlEu9
    jo7Y6kiqYtgU43Ciagh396R2N2vlfU92kFfjm2NdelwoCk8cfMN2/qk30zsr4jtxE2uk
    lDkv7RDS/XUG1gEk4pDgCD48aWW3+6lmQaQ2fd/HR6qnZsPM2+C6RJx0YWY2Y1SxPIBs
    zqJvvuKBz8c+vWN1VekmBQ/PT5D4oD0rm8ycIb3RBFwDsO7Wurn1Y7E6ckg7p68+YxSE
    kpdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733298970;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=vE2CSf5sRALn2ZC47I/2hJ73rxOMVhdhGLCXgihnhM4=;
    b=nOGJwgEK5XuFrGLfkt3mdmJsOF9w4Dxybqi1ZzPrt+4MJc4DOdTRbtdT6m4dgn092s
    DvtPWghZisoKnLzrexy/8byAevMOxxlSZcC5y/A9d4H+asYx0jzwmT8qHkhU6OMDi4qQ
    yjKwDT4oMTe8iPKsn3pCuaY9bMghjYtIo/vR5Pavb3GldnjNjCEnFQtTEzDPCWdG4oTG
    gOZWcilSdDIp71ijDtbvnXhQr+EqB8HkBMsXRmOjo9o9c/L74QIsyudXwDs/Nb35MzMS
    jI3Wt0a9nfAklO9PBVxT8PpHxfCpSp4Rp6QwpIeAgfpV7CJdLYq1CoV2mS72fGfZitlr
    W4rw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733298970;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=vE2CSf5sRALn2ZC47I/2hJ73rxOMVhdhGLCXgihnhM4=;
    b=DMEr2eO0wMkIbrpBOJUB9wZLkaHfvopBKySMve3sXYMZpSjtbAm6Gkt949QS9WXARv
    mOFmzqkW9W21pNT1A/3z3+Uya6Mox5ePW81+v69KVKxwD6TA+FCi9KUIpjFDEo6RaeXG
    Lqf0P6QVnUjDr1XtJbwTKiPH5IERu4oEQ17nkhM41h3TrykeLYevfssA/cMe7t8ZtpK6
    9d5Rpd82Oi2zBfI++tsG/FoAMqA//Md/eEpycG5Qh4L1TdZkUpTmzpEUv2Huh+jgWy3T
    j0LQ3sEa/8f6ZCkNNIQP68vze11mw7tJkUz+mW8gX3zU6GyYWsJCXkt+9T52irhWHaGd
    Nu+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733298970;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=vE2CSf5sRALn2ZC47I/2hJ73rxOMVhdhGLCXgihnhM4=;
    b=dqwSwwJT3WdsMRhxOOjw2A2T4VksdlqcoQc3iegIfXCR7rqX03H9/N+sluRvJ51oCO
    blqbWKC+YRDb7G5O08Bg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSXVT6pap5"
Received: from [192.168.20.116]
    by smtp.strato.de (RZmta 51.2.11 DYNA|AUTH)
    with ESMTPSA id K63ada0B47uAsqg
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 4 Dec 2024 08:56:10 +0100 (CET)
Message-ID: <8be877db-028a-413f-b55d-71311e0c88c9@hartkopp.net>
Date: Wed, 4 Dec 2024 08:56:03 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/14] can: netlink: add CAN XL
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Robert Nawrath <mbro1689@gmail.com>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
 <ea52eb8f-c59d-445a-bf4d-26f2772f7426@hartkopp.net>
 <a9d8eb65-c88d-4bc9-b0c2-c0e0799ea5bd@wanadoo.fr>
 <23c914cf-0af2-4619-9f83-e4b6339ef65f@hartkopp.net>
 <12e013c2-d6ff-42b2-91ef-921db4e7ee0e@hartkopp.net>
 <77331a33-ac82-4cfb-9881-159d6d2daf58@hartkopp.net>
 <CAMZ6RqLi1oywkSZ=pVFnV04efwk8mJWmwP+FzSyMknR2d+9=RA@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqLi1oywkSZ=pVFnV04efwk8mJWmwP+FzSyMknR2d+9=RA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 03.12.24 10:45, Vincent Mailhol wrote:

>> https://lore.kernel.org/linux-can/20241201112333.6950-1-socketcan@hartkopp.net/T/#u
>> https://lore.kernel.org/linux-can/20241201112230.6917-1-socketcan@hartkopp.net/T/#t

> Thanks for all the testing and the fixes. Because of the lack of
> testing of this RFC on my side, I was expecting such issues. But I
> really appreciate that you took time to investigate and debug, really
> helpful! I will make sure to incorporate these fixes in the next
> version.

I'll send out an extended RFC V2 which is my current test base for you 
in some minutes.

Either for the kernel and iproute2 there are two new patches that add 
new controlmode flags.

> The next series I send will add the pwm and drop the RFC patch.

Excellent!

I assume it will follow the TDC pattern with
CAN_CTRLMODE_XL_PWM_AUTO and CAN_CTRLMODE_XL_PWM_MANUAL
or something similar?

> My
> goal is to have this CAN XL series ready for inclusion in linux 6.14.
> I don't want to overcommit, but hopefully, I would like to send the v1
> either this weekend or next weekend.

No hurry so far ;-)

> I will also rethink whether or not is it worth doing some NLA nesting
> as suggested by Marc here:
> 
>    https://lore.kernel.org/linux-can/20241112-flashy-straight-poodle-9a796d-mkl@pengutronix.de/
> 
> (I am still divided on this subject).

I'll take a look into this too.

Best regards,
Oliver


