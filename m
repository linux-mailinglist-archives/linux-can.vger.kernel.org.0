Return-Path: <linux-can+bounces-3105-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C3FA635A4
	for <lists+linux-can@lfdr.de>; Sun, 16 Mar 2025 13:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B824116C610
	for <lists+linux-can@lfdr.de>; Sun, 16 Mar 2025 12:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5EB42A96;
	Sun, 16 Mar 2025 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="aVCz1fZh";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="KPCy442j"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E8DF49
	for <linux-can@vger.kernel.org>; Sun, 16 Mar 2025 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742128765; cv=pass; b=tUSjRgK2XFejYU12WQgG0UAjAws1UFhTyKB+n+U4YFH12g5yWATHMKSthL2DtvCubQHC9PCwIW8pIT1QB+0XLodkIq3lcCorAlpZWCkXHi1WSDg5VaPSRH2Vx+4QYZMFQPnR5GTmcs1aJvBZfV7Udb+J0rVn3beTlq0GUac6D3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742128765; c=relaxed/simple;
	bh=oHPH6z88kIOyT+wXmB1qBXkt9xFBCNaoGpqx6Uf42ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VL9x5kdjsx4B7b4h8aMB/nvnvfAFNEAUtPJVRWCMn97Zmo0tB4yEjEszDmOW8+pDlr7IR3NZ6R+HNQv16u5lgvEPMNX+jFyacJzMB+nwk8TTlvXjBEky0SjDT5u2Qwvt50bpzf65Hp2eRv3hy79XkRuwsTk148cqK/rQyRDln9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=aVCz1fZh; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=KPCy442j; arc=pass smtp.client-ip=81.169.146.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1742128756; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gVV0GSTJmJgrF5bB1jwXQunZsd85Iy9yKB+++Fl2c0g32xKc+jAh3lFzkLBqjV0maI
    LKalaFAD/rbYPbtHbFRek9G77x+GjXJzYqFedKcunzTnLzpIkpyMs27TBSP5edIB0Sha
    M2tFUVpR4UYKTVG+kZrdyKSdNWFkwwyQeKyEGq8JDgtEf7XiIMdQbf/MbLo4kozd8S5L
    w0Zr/X5TGfW8ExcRjbW9gD8c6PbAJtgQGo3OPAm03MTnYss1/STL0zDVJ/4265tNrs+z
    rU8Ic1pCX3J6cnkCKpYMd0RGA37MSxQQXFbwPvbBEZZT5BgEy1owh+mxlZ0RsUB9JEQg
    NuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742128756;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zJL4vQyG6zO5ekzJmz7HK11d0J/LO1xMwf2B+2ZbizE=;
    b=ln+HRgQBuSD1ji08/zv33zgTVlcRyohu9Ag/rFnVzM6QQ0t8H7At7mAS9wVhjHbtWJ
    wAgAjDlztC6zeWzdtPe0zkMp4FqLKtWah2oZJJuy19HmwelrRMJlXiWoOTnk6YS0ILhl
    MrD++zYsoo7o2ZOSbJjT3CHYogmKeyGFf66+77MftuCmUCWjqcf9fj8G3wFwT8pqoaa8
    xnYAGRnjuwNg9Um1etcjCJSgy5u/0GjK54CRz8MT63KVCuV5qgBB0DT9kzKf2DkJo/dI
    rg2OWXzSyLsC/xDoLjSZ3r+w2CH1pBjZhn1FFVzp5GhyU6SW1Mel51HVA1LjDNnRRjg1
    OQ7g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742128756;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zJL4vQyG6zO5ekzJmz7HK11d0J/LO1xMwf2B+2ZbizE=;
    b=aVCz1fZhRSYpjneZT0BxvkEXjW05pyREVhPJuDUfx0N8NH/IlvR5szhpjchh1/yn3q
    mytQ6Mo5XlTc57jgLldmBCRaNYRHPpj8pt07LXMoVaTFLnccWIKls2ZHp0krARz7b6U3
    Ay3ftFG5KErk9AUSsSIZkVNUZRR+UtIFdbU/vVhLtngHPksKjCilG9omMjMDB7miy3li
    NbSUsogDDE6Rmk6XOLHx3EYK/IBk2C/iA8KLY4d4w5nF8/5IZkMYVmx2b0kWSsbv16Mb
    4kI0DHxrFKnzvyQgqO4kL0aPYDJABqLYcEVS6I0g/lg+jxEE0WvpvWSbcHCVqzLSVdl3
    d/Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742128756;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zJL4vQyG6zO5ekzJmz7HK11d0J/LO1xMwf2B+2ZbizE=;
    b=KPCy442jfO5Oa2un1/nRwLBrja+tv/0JpJDlK5kulmAEi+NX2plmPwJxiuNXUrjMoi
    4nqAQNNyqyvJrcFnPwDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e512GCdGvyU
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 16 Mar 2025 13:39:16 +0100 (CET)
Message-ID: <7e35b13f-bbc4-491e-9081-fb939e1b8df0@hartkopp.net>
Date: Sun, 16 Mar 2025 13:39:16 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: add protocol counter for AF_CAN sockets
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Davide Caratti <dcaratti@redhat.com>
Cc: linux-can@vger.kernel.org
References: <9db5d0e6c11b232ad895885616f1258882a32f61.1741952160.git.dcaratti@redhat.com>
 <20250314-messy-fierce-squid-0ce7c3-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20250314-messy-fierce-squid-0ce7c3-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14.03.25 13:31, Marc Kleine-Budde wrote:
> On 14.03.2025 12:39:49, Davide Caratti wrote:
>> The third column in the output of the following command:
>>
>>   # grep CAN /proc/net/protocols
>>
>> is systematically '0': use sock_prot_inuse_add() to account for the number
>> of sockets for each protocol on top of AF_CAN family.
>>
>> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> 
> Applied to linux-can-next.
> 

Maybe too fast? E.g. J1939 is not handled.

https://lore.kernel.org/linux-can/78951192-82b1-45bc-9903-d314c94cd182@hartkopp.net/T/#m87afc41fef8ec9099344c753e32b06f302cc0e39

Best regards,
Oliver


