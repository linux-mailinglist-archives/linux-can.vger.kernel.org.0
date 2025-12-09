Return-Path: <linux-can+bounces-5832-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1374CB086C
	for <lists+linux-can@lfdr.de>; Tue, 09 Dec 2025 17:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A6B1300F9E1
	for <lists+linux-can@lfdr.de>; Tue,  9 Dec 2025 16:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B8D2FE582;
	Tue,  9 Dec 2025 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Qy/ty/VI";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="VZ93KRO9"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB35258EC1;
	Tue,  9 Dec 2025 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765297074; cv=pass; b=cQClsRMLp41ehoKhwyHkCb6qfGgNXqmJ+Oz9na9LBBe2csSZBCEqrbMC77xTcE77L7AaCE7ch3kkaulYIOeQsPI7uqF3lzsqq++c7uIUIURr15kw5CRSDLblzpNsyYcZQBT7WpEJWDSfbB7OCGvpSUJ7NQQA42J/aiioWW4nMog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765297074; c=relaxed/simple;
	bh=1A4qcDoIHS3hk1lbXC74y85y8lZ3gtYNASF0ZKUsdh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPMlgCbXYO+ZWwMlYxp3h4Db8awyUBvxb1EZjQTIu0PBF/dC2bpCQEkc6bzf2mpfzmm7rpkgep97o9W7qMfVQop2yAGnA84j8lMvf0g8q9lzbtJERyFAgPRnvrr3UhmEI+j1vPzCRe6LcO9bGVasJrFamFojE5Gq+exncfzb89M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Qy/ty/VI; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=VZ93KRO9; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1765297059; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=R4s6/BCe5OEIARUQML9loOV8n9zyQ5Wwtfwg0hInCjVK+mhb0julKpZ+HGIfpnLHVx
    Eo2OvTa5Lwt0OBg/yEV3vb0SyCB844dbtTCZsMhY1KPZ6fR71c5Qj3IQdYnV65BXWeWZ
    QQnDntDS8V4XLGTGWew5sIuJUtHqJgwB+7a1uwggyRou3y4imlsbRkiCssVfvrDFgbEz
    91kVRiQzAIOsAZpFBGwiZjlLN8uAtk71nTT+m8gperZGOy7bPfWM2n+HiZcRhxBOHRhX
    je5ekm5CpaKk787QBhq2sfbQ88soOV3TPeRLubg6Ugk1DOvkAzabvkz+fhklyxl78cbr
    7zaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1765297059;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=dzAx9NCQIFxGOcgIRruRbkzkqiTYwINA71JurVw4azo=;
    b=c9+yLJQ8Q2HXgJXEm7bFcZSZLtOkS5G2aY1CutpTrYmajsHgj+RRJsS0DCYkE6byfj
    HOW7n9yOolehbWNowYXqV1+BbyaPRTU/vcDbDT3iYMXzMdnItGL3nyg+726cBbvUdZ1m
    X/OTuM4pMC5dlq61NrFeuGNSfTWPfPD8NGM/O8rxoU2P1LFUXthwiVGqTxCu/Jp7sEpb
    JU8OsBgQsU2EF24Ik8VPwAobxZ4k9Pg+O2mT495imsCukPaWoAtyiCCmDc9+SiXYoOgL
    cpJF/fSCxm24yyQ2a24dtbBQ83YsaGOI1qWq8mn04ZTEmkk4wkKuynpWMWU7j6Fswf4s
    4owg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1765297058;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=dzAx9NCQIFxGOcgIRruRbkzkqiTYwINA71JurVw4azo=;
    b=Qy/ty/VIndJaJ5B+NHO7InuJec4mauu7KNBByS3+FEPziJvzuF72AJjbOSe0AlLIZl
    lQZO+WXHsneWSOgifgv8qoiro9PKJlJYFQwKequXFBUDz7s5grYDRkyIK3iKYOue8YeQ
    fMiHn/6SWLgkr5rGXQ6XgujkDCG0RjkCyWBGeYbRAGFgG2GJP6v34GOLkiibRCP6NuFJ
    cZlh7aM1gGFPRvPaBgkNiTUC8yrzqu+tclkYrmxx6tS1DFbiorYJqDQdBcaUQA9rIqv5
    aEYmlEWLlPpDDs698KLrZII7TEiIEifO0wlkzxwGwuW7WlbXMXLYyCRdGFW/Zz3Fe5Yi
    wluw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1765297058;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=dzAx9NCQIFxGOcgIRruRbkzkqiTYwINA71JurVw4azo=;
    b=VZ93KRO9GEZezFEH7DM0aZIcaaVAA5RW2jYv3GLv/duak4NjFUSORnNCSJcZOMJKWk
    hHOivJT7WQO3V84OdhAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461B9GHcmRH
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 9 Dec 2025 17:17:38 +0100 (CET)
Message-ID: <f33bb7a6-75c7-4ee4-baae-755ff25d81d6@hartkopp.net>
Date: Tue, 9 Dec 2025 17:17:38 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] can: add dummy_can termination and update
 SocketCAN docs for CAN XL
To: Rakuram Eswaran <rakuram.e96@gmail.com>, linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mailhol@kernel.org, mkl@pengutronix.de
References: <20251127191808.144723-1-rakuram.e96@gmail.com>
 <20251208141904.8737-1-rakuram.e96@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251208141904.8737-1-rakuram.e96@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Rakuram,

On 08.12.25 15:19, Rakuram Eswaran wrote:
> On Fri, 28 Nov 2025 at 00:49, Rakuram Eswaran <rakuram.e96@gmail.com> wrote:
>>
>> This RFC series introduces two changes related to CAN XL support:
>>
>>    1. Add termination configuration support to the dummy_can driver,
>>       enabling termination testing with iproute2.
>>
>>    2. Update the SocketCAN documentation to describe CAN XL operation,
>>       including MTU changes, bittiming/XBTR settings, mixed-mode
>>       behaviour, error signalling, and example iproute2 usage.
>>
>> The goal of this RFC is to validate whether the proposed behaviour and
>> documentation match the expectations for the ongoing CAN XL upstream
>> work. Feedback from the maintainers is highly appreciated.
>>
>> Base commit:
>> commit 30f09200cc4a ("Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux")
>>
>> For testing, this series was applied on top of the following patchsets:
>>
>>    * "treewide: remove can_change_mtu()" (Vincent Mailhol)
>>          b4 am 20251003-remove-can_change_mtu-v1-1-337f8bc21181@kernel.org
>>          git am ./20251003_mailhol_can_treewide_remove_can_change_mtu.mbx
>>
>>    * "can: netlink: add CAN XL support" (Marc Kleine-Budde)
>>          b4 am 20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de
>>          git am ./v8_20251126_mkl_can_netlink_add_can_xl_support.mbx
>>
>> Testing was performed using the iproute2-next tree (canxl-netlink branch),
>> which contains the required CAN XL netlink support for validating
>> these changes.
>>
> 
> Hello,
> 
> Gentle ping — any feedback on this documentation update patch series?

Many thanks for the patches.

The termination patch should be commented by Vincent, who is currently 
pretty busy.

But as the next merge windows is far away this can be managed in 
January. No hurry.

The documentation is almost fine but still has error-signalling in the 
ip options and there's definitely no xl-cc-len16-dlc option.

Please use the latest iproute2 code to generate the examples:
https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/

Best regards,
Oliver


