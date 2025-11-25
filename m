Return-Path: <linux-can+bounces-5660-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 172B2C861EA
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 18:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B07B4EB1D6
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 17:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E847D32ABFE;
	Tue, 25 Nov 2025 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ZMf/QTt8";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="+Y3qLYee"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BA933342E
	for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.217
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089995; cv=pass; b=jK8oGRCUFgqUrfFmfS8+Q0p3qHWmfDqW5n2lgHq/zauXrn5X7M1kcI+sdUHjA90Vbcakh9o0zbGpg+ZXHb7P61Iwj//CXVqzu2UYrq86Jl/B54pZTNdCPXGttXbcM81/Esdkya81NWF706CecXgo11C6yZPtqbRpIfbAfgs7590=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089995; c=relaxed/simple;
	bh=AdN3rQ6rTc7EftucMDryB6ZLQQ2V4t3SNBXHARfu3ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgBdX0SDT+reJInwxJY0Fjkb2VY1XkwAR1Eg4Qt410u/BpCQcQluEkE9e8RhIyxVwK8D3+9DSUn2qNFupi5GqwYelCmn0xoxvhG48D/xDtEGTDs5QCizl84ecr/nL2g7BTgafL8q92unxP4ZvQDT+bBVAhZzhr+wlwKAUYq3JpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ZMf/QTt8; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=+Y3qLYee; arc=pass smtp.client-ip=81.169.146.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764089983; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LJ7tnYuutmR1x063bK/A3W8ozsZJmWq50W1TyfTqpzDaIp3Ix53V7OtmRIJFYHL9yj
    cGHCNf/H3ZkJwZFUK7mI/o9r1+0gJv4EL8iFHCfWcyYIo7gM4nwqTQNjOirU/C5j80Hu
    0EnCMFlOZYZVz6Zn6gXQB0TOOl9QZLW2WX6sJhPwPQAHY7l2EEdJHYvuKNgtNSfYMrIJ
    aoCHJ0uzCK9vofdP7eNENwxjbZDJvhndxSi33sdQSzBFaxvhe2q9inN1N7anfauNrf/a
    HozcHLgELzUGU2BCiZUg0v38E9Mnr4ef80sa+wqdEqY6NswhGBcWP1G9wa991S9VLIX4
    0Kgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764089983;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=U7Kps7pEmrm1klQKbEZJva9lm0MRPLb6zXsQF1G4GdY=;
    b=Zg3pI7x6kIU4ykU+KLxGd0PFUEjn8siHxzzlNDJbxHz8SEmxu5Ec5AgrENqG2h11nE
    7+vDLKqSUaPW2Pv1samiLftIJMVi8D8gP4X9G+CaaqjjP1VIh1VGCWGYRdzuLyMmtaER
    DdK4rPR1DqTWMv+NzSToFvudiKmVhizgGb4JV2D/+9iQU1YkL2EZiV07FZoD0eEfJjcx
    qrDn5LdY604YxQqTcNugl+p18hPu4cAJLiH0XSWf4UvfmmhF9R7UqOWiVbrwYTHCT0n0
    R6GOKtKJt86m/Wx0r3eQGfevIbm5Tyw46RvcsZ5yhkDzLZ8pM8e/ZaBCMhW2SCkIrqm9
    SLHA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764089983;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=U7Kps7pEmrm1klQKbEZJva9lm0MRPLb6zXsQF1G4GdY=;
    b=ZMf/QTt8sY7SCnEicreZ92yxGmVRw9laE/K4QUbx3CC/buXbRvCI7S4Un8asUpJ0wz
    gd6wfwRSn5TQfnEDotuNAw/5zgao407BwF+e91H5AkKJ0hPDJ4lnDsgVOBtyipDDbgeE
    ysTTdz06PDEPEPmtJ5HJa1480UevVO/r3lFGOdcy8ThvQwqJI50x6fQG6kRJUT5oRrTe
    sYQQQ3x1UJYHeYxITmZXudnPzGwwct2QP74XiLmd83VuC9x6ad3Zhi5NonIkfXT7i1g8
    mUsO1E1+ya8GtLbsxH5QQHxr1I/o/zAUCciIU8+8+ImrssHsAVvqGFp7hErgh+TCuW4l
    mKjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764089983;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=U7Kps7pEmrm1klQKbEZJva9lm0MRPLb6zXsQF1G4GdY=;
    b=+Y3qLYee7fkRRt3wmGeutrvNqa1gaYw6i4wQ0RVnVwGSY4iJxplKcNLwUvKPaVGbZ6
    RVEp8IAkqYyGMPzha6Dg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461APGxhUX7
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 25 Nov 2025 17:59:43 +0100 (CET)
Message-ID: <c6b03bd3-572d-463f-a21c-55e413128b00@hartkopp.net>
Date: Tue, 25 Nov 2025 17:59:37 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [canxl v7 00/17] can: netlink: add CAN XL support
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: linux-can@vger.kernel.org
References: <20251125123859.3924-1-socketcan@hartkopp.net>
 <20251125161346.412538-1-rakuram.e96@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251125161346.412538-1-rakuram.e96@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rakuram,

On 25.11.25 17:13, Rakuram Eswaran wrote:

> I tested the v7 branch and below are my observations.
> 
> Static analysis: Smatch reports no warnings.

Excellent!

> I also executed the sequence mentioned in (1). I had one question regarding
> the XL data-phase bitrate: Does the ISO specification define a minimum
> bit rate for CAN XL? When I set an xbitrate of 1230, the command was accepted
> without any warning or error:
> 
> ./iproute2-next/ip/ip link set can0 type can bitrate 1000000 xbitrate 1230 xl on tms on fd off
> 
> This value probably doesn't make sense in practice, so would it be useful to
> enforce a default or minimum bitrate in the kernel or iproute2?

I double-checked with some tools from Vector and PEAK. And although it 
doesn't make much sense was there no constrain that such a configuration 
is forbidden. The CAN XL controllers with their 160MHz clock and their 
very capable baud rate prescaler are able to deliver even such weird 
bitrates.

Therefore we better do what the user configures.

Or do you have a reference why this should not be allowed?

> I have another question regarding Documentation updates for the recent CAN XL
> changes. Would updating only Documentation/networking/can.rst be sufficient,
> or are there other places that should be updated?
> I'd be happy to help with improving the CAN documentation if needed.

AFAIK there is currently no updated documentation for can.rst in progress.

Feel free to contribute some patches for can.rst

Many thanks!
Oliver

> 
> (1) https://lore.kernel.org/linux-can/20251122093602.1660-1-socketcan@hartkopp.net/T/#maab93b52afce096b03c2cefd955795d43ce810ff
> 
> Best Regards,
> Rakuram


