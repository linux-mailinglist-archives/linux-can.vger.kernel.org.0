Return-Path: <linux-can+bounces-6013-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FAACFAD9D
	for <lists+linux-can@lfdr.de>; Tue, 06 Jan 2026 21:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECB923068BE5
	for <lists+linux-can@lfdr.de>; Tue,  6 Jan 2026 19:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC6F33EB1A;
	Tue,  6 Jan 2026 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="gruy97b3";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LXs9XWPs"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F933F364
	for <linux-can@vger.kernel.org>; Tue,  6 Jan 2026 19:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767728828; cv=pass; b=kcrWbmwvi+Eg/wo2EiDIuYmJhab6XmzrpV0tQ5Gq+Z3cG9wJH3L29NwcdFdCRtgWlUY+P0yT6zJ+1erwU9/lQRsTcyEd2W0mLqRzTDleCuOauWsBeQ28jTvJQDsZjpPgsEMLS/cpkIJgQp/larLXHCbQ1lmqEPcuE3MWnyMq//Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767728828; c=relaxed/simple;
	bh=eLJKCMZeavACeG8gllAT7B6hWi87H60u6pW0IFLjwKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xu0RMAmU7rr/zxsDysrgXDNYjSYi3/VYVSFqJWXhIBo179Oa5JjQSxhOV8Zp9Ra4/ltgSc+9tXGcsVfrYK4tsFBWzPXzQCqhrDUvTWWJna1VsLZCAD/uYFCV3fJ5Pfrcn2lvsr6Ih5lIxkFs1138tJPjaQLX6KTPMR20Vabl3E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=gruy97b3; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LXs9XWPs; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767728629; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RoNmr2PF8J9i8DzFmBfA3L0fMRxNyZgNzZ6lMJy9ysSsyn9HZaJNEp/CRPDKUMWN7g
    bRYJGI92CBsGlXwxXC7WWC5CuoqZQrqy6jxs735uOw8f8JXWX78j6/LRp+evglibNNEo
    W4IyGAOJpPBdmIwBu37b4K2Jx+O4RHiQ052S/FbDrKxf5IDTeM+Nl/wX2if3KbuhOYB3
    jqwT9GJ5MYrw6kkb8+wHVB9h9Xu/VkWy9Y7nMIa1v1J4WT832bGQ644g6+KkBGG8Vj3b
    ZFlL/fcSZhUkbHNd9zRSdkvTXw5/eQx2+7aTjL1rLIjYo0LyHxfzE0/arRrh/t2eMV/x
    tfYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767728629;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ResBB95FxK+keR8Mgta1PB4ApDotZa4b+5nSrW73gow=;
    b=PgCM0utVBclm8IZ+kxvB2AYQ8V4LZjnHpgG3WRXsE3hi/MhCS32rUbOClZqEN2E3vV
    SV8Arugg/ghFX+B2/LOYRsGLeGPOP/f68DNYieLIUQvNcSj0L1kYCnDS9mkPt+NmDIP8
    uVTcJIBVWvO6tdz3Xva4viejIyH+nmsTXZpNVQioambZPkaXs+95bhR7bS9gfejL/hFW
    jmYD/ys8Y8TndMUy1PSEIK8ZL3JodL0ZTZx0RUE6SM5EX8vT2POrEwaUygNX9dNmTQZQ
    9CMuW0fMzS+aksAxlTt/WONk5ao9twKHB8HvxbXsS5hZ95IjEZKIap/YGe1bmTc1XC+e
    ilhA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767728629;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ResBB95FxK+keR8Mgta1PB4ApDotZa4b+5nSrW73gow=;
    b=gruy97b3GO7PEmAcqoHfKWrDL9hGltLJyJFBmgbqS8zpGJxhKn+lM94kt3QXjECME+
    MDkJ+f0X9BpHxG8b6DNp7RMv0lz0EtmkeZ0k8OI6kumjy7mOnYtv31f7Ujej6Qd3wAj/
    bPwC5ji06pBET0nmPlafhKY0BSuCSoeL2CipPEs/Ga/0sh4zx1/YinSOhQNiH2YUfVaS
    iquSH3pRxJ3YRhE+IWUDVCRTIIiej5Nqb6DD2xFdJ8VLbLBxZKRVhcKF5vN2z4Dl7qXO
    rjsR5In7eLtPOCpMXBciPSUPnJy8i5KHzfEzDzc2yhMqkyzr8allQ4rbjKOXzkn70BBU
    btPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767728629;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ResBB95FxK+keR8Mgta1PB4ApDotZa4b+5nSrW73gow=;
    b=LXs9XWPsidZRMFcOV/+INqlUqdEUxaoNnbz6vS4ohx5jAk5JOm+IAeYy9FFw0dHkqs
    hR7Tku+oNvkBSFLvuiCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b206Jhm6Zg
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 6 Jan 2026 20:43:48 +0100 (CET)
Message-ID: <4cf222cb-e6e3-4d09-a7d8-bc64b8e148bd@hartkopp.net>
Date: Tue, 6 Jan 2026 20:43:42 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
To: Harald Mommer <harald.mommer@oss.qualcomm.com>,
 Francesco Valla <francesco@valla.it>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
 virtualization@lists.linux.dev, Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <aQJRnX7OpFRY/1+H@fedora> <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora> <aT7XAsTWr0_yyfx_@bywater>
 <aVLOPMmpvArnVAHZ@fedora> <aVLq1ibPcPHk-7Qv@bywater>
 <e5bc1353-ed3e-478b-a26e-0bb9a50b3863@oss.qualcomm.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <e5bc1353-ed3e-478b-a26e-0bb9a50b3863@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06.01.26 17:50, Harald Mommer wrote:
>> With the plain 'cangen' you are not really flooding the interface, since
>> you are only sending a random CAN frame every 200ms. The only way I can
>> reproduce this behaviour in a consistent manner is running from the host:
>>
>>      while true; do cansend vcan0 134#00; done
>>
>> which seems to generate the maximum amount of traffic.
>>
>> This is not of course a realistic bus load, but is leading the system
>> (at least on my setup) to a corner case somewhere.
> 
> I have no idea how long the shell needs for a loop, always used cangen -g 0 to stress the setup which is most probably faster than the shell interpreter, and sometimes did this for both directions (RX and TX).
> 
> Full load is a realistic setup. And even if it was not, if something stopped working or worse crashes torturing the setup this was a problem.
> 

Yes. cangen -g 0 -i <interface> creates full load - even on real CAN 
interfaces. You can also generate fixed content if you want to omit the 
generation of randomized content. 'cangen -?' prints a help text.

Best regards,
Oliver



