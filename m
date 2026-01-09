Return-Path: <linux-can+bounces-6089-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A54FD0B039
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 16:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E52913019B69
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 15:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA2C2C21E6;
	Fri,  9 Jan 2026 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ltuiKz2v";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="U/h2Jk6U"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D4F500946
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767973387; cv=pass; b=YqVqcOrW7Kfjd0/ORWYMej0HwnWABBY1JdFFLDNCpZyci1npkkKbSkmQRoNx9RKfEq54lT+0vuBl0y1znZTpcxhp9BCQ+j6ejDohFdx1YMZwiRqameXC1q7mMVH+eMdnS+QTrHT+fu9PaWNIr4kUzbhazh05l7mkmWgAxMWqFpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767973387; c=relaxed/simple;
	bh=Rk7O9icPa/P+g2SUOdfa7MAV0MEAJ7sA6p3wHN+GXH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LzWZSlel96VlH9B20vhwbsf6OBHlUTjd2EB3dV1vvIG3WOw6ryVGoYpUkJycC2eee3RjOVr3hLAFNQYhSUHu7WCSFQFPtSzXHJo64PbIwONLZto7pgvN1LsW3W8n/1qKGYJTgdZWB6DpkaaAdm0nAs9vMWwRiqUsPts3x0PEK9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ltuiKz2v; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=U/h2Jk6U; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767973383; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mqLxcI/WAXg3aVy5B4zPepMeUeQyJJ9D6lxX0DJX6u8uGvtiHr3N11k4PDf8o0rIoQ
    oHC3XspX5dRdbfUhflxxnZV98C3FITLnt1MZBicSj654Tv0YiHiDBqNfUK0jZhC8Rle7
    IXx5JTDvGw+t5JJrezOVIyF/kGebYa6Ay54xTmxXLCNp9FgFGkcMiasOD7u6282NF/2J
    4y/u4YgktXnflcx5/a+EQ26KzGaFAbsvHjlDbiXzUjSK9JwCGY+E3+Vwcu0Mki+qKZ+P
    riam4bOQMHW6ClEelA/t7SGQtApJPNokMR+zpIB6zX4jXDrukOhReYk+kuV4kCa+h4LC
    tBdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767973383;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=oldyijM7r/SW0auWmDGn369OWQ90H6pTCbBUtspMnqg=;
    b=Fdg/AMmxjLu22tDZkB291OPItbpLW1SYEp/boqQZzKvyJVkJNU3fPr7Tu/UCOAUP3z
    PW95F9/ctYxsBVUYkxLGVkfcElFzhb0HbLKg0lXnKkenwYxT6DnRvWeMiwLLg+ksrKeA
    MWTh7XRsTrfMtO28AZtuFOB1/8GQi/mgeNLciL7hcVkDpzehhOduQERm8Xwq50f1SFF7
    ZYGnOE3NJg7T94qBL8bO5JDG0pgzBJC80T+cshsrTOAi8d+gxOLdHMaDYL9bCtG8yiTR
    kr27Z2AA3eknx5gWgu0KK9570BBt5yOySG6jcUpbLnNJPNSaNcfn+HrszUhwJvC5TOyK
    oAvA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767973383;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=oldyijM7r/SW0auWmDGn369OWQ90H6pTCbBUtspMnqg=;
    b=ltuiKz2vCmUW5yWGHwlu/LdbldCaRLHI4OxwLAn4gzD6gzFUNvukJKLzsaaT32E/tT
    hxXASUcH6DM9xKXIFrFj70GpFvwIjaoOBWQYx9P4lIaYe3mzql+RO6sBMgD9mskqEjaB
    4kgv4GdH3SNSWWNNfjbdy4t6JGrn+vYsCOTg6XoBycz8odP9cB5Rc3DnsQX9Q3T3TTLw
    U+l3W2hgaS6zPYdbKk1Q2UcxPszsCviTSYpZDDIOHUvTaS6GZmp/JD3Yvaji2FNK89xy
    24b9vDjN3LkHFdHX6As9LLYhMCc+V0xWo/FKZxcjXlWN54X6uAm1xUozmffdFWf+L3AF
    XqVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767973383;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=oldyijM7r/SW0auWmDGn369OWQ90H6pTCbBUtspMnqg=;
    b=U/h2Jk6UE9YnOFS7n4o77W3aTTHYMYdFHZUtyHZfOojGmngGazuyQ42GqXs1pscezl
    atKdI6ZyKlXndfqU+6AQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b209Fh3PgJ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 9 Jan 2026 16:43:03 +0100 (CET)
Message-ID: <1e64eeef-5c26-4262-b511-49c754c26158@hartkopp.net>
Date: Fri, 9 Jan 2026 16:42:57 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Revert "can: raw: instantly reject unsupported CAN
 frames"
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20260109144135.8495-1-socketcan@hartkopp.net>
 <20260109-overjoyed-refreshing-eel-f887b6-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260109-overjoyed-refreshing-eel-f887b6-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09.01.26 16:19, Marc Kleine-Budde wrote:
> On 09.01.2026 15:41:32, Oliver Hartkopp wrote:
>> This reverts commit 1a620a723853a0f49703c317d52dc6b9602cbaa8
>>
>> and its follow-up fixes for the introduced dependency issues.
>>
>> commit 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
>> commit cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure by default")
>> commit 6abd4577bccc ("can: fix build dependency")
>> commit 5a5aff6338c0 ("can: fix build dependency")
>>
>> The reverted patch was accessing CAN device internal data structures
>> from the network layer because it needs to know about the CAN protocol
>> capabilities of the CAN devices.
>>
>> This data access caused build problems between the CAN network and the
>> CAN driver layer which introduced unwanted Kconfig dependencies and fixes.
>>
>> The patches 2 & 3 implement a better approach which makes use of the
>> CAN specific ml_priv data which is accessible from both sides.
>>
>> With this change the CAN network layer can check the required features
>> and the decoupling of the driver layer and network layer is restored.
> 
> Applied to linux-can.

Thanks!

Unfortunately we had some snow problems here so I missed your PR.
¯\_(ツ)_/¯

Have a nice weekend!
Oliver


