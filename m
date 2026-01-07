Return-Path: <linux-can+bounces-6021-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 313BFCFF1AD
	for <lists+linux-can@lfdr.de>; Wed, 07 Jan 2026 18:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6ED331A94B6
	for <lists+linux-can@lfdr.de>; Wed,  7 Jan 2026 16:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA0538E107;
	Wed,  7 Jan 2026 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="MKoJodo5";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="kYONKIEQ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B4438E114
	for <linux-can@vger.kernel.org>; Wed,  7 Jan 2026 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800734; cv=pass; b=fBBWVoHvCxDBpCA5r3Wxw7H4RBzbe4jd8DdoH7eSEZx0EXBSoHihXds0Vk6SQY+DEX8ZElrQQ8MGaeSo1VWAvZFFliLt7oiUv2uVLkg1hbHzgQ6C0KrI8/Rx2MbnwMYqB8ECwEH06juRiAAC/r6eMWtCydvV/A0lfCR8A+GLgLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800734; c=relaxed/simple;
	bh=SUxYKUuFHhAEpGGBNH5IL8n/03E74REN90pkA/Ek6ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5s1bA8D956b/7HaRCYc0Ol6twfW05c0SaJAeMEUxxJNrmlPJGH0UTYK4Pv4aEWFOc0KzaLxlW4L3VaOpn6gEJtKqZ5YY0uY8MdR6wAb3U+NlixIwkwIRm+Kkjtn1q83QUDetTM4GYmhEzBO1FGqclnTBHR3v+DFBH9HggK/qjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=MKoJodo5; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=kYONKIEQ; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767800546; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WOudiYoSVUwbG3ydltPWbpAD7QxdEugD3fcoSfrKkXrvevToc4eutsGHGgvuOexvQI
    zZrJAYgIC9r+da/zDZ1xfJSBqD4CfpNjOdZLEyHGn2zmRRReEXAYCJ7wbAcGvcG5s2q8
    jMXyH2asp+3zPCH0xL1dSOAbuUTgT+599bidcRnLvStbDZ5mU0nT/fk1tfKxPrqmuqwX
    yQ8rcD4gwgJvXf0R6RtTQgf0m+cGyb7Vb1EVagZtuk5LLp/2PquIWnhaL78IoYXdbTuX
    qdUiVAqjh1yJtu9O6IXVGWgY/iTu++XfZFQdYESPhR39bclElLsJ79si27OiDoKChn9B
    xDTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767800546;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=vOIIEfctkpVxXTnIIS08Zn5exdpTl3dZ8IoObdGk2SQ=;
    b=SzmUY+WPu/KUNYAkzyXPYzb8ZvQwFESnQw628+vK5sGfS8bK4n7l03W87NcvoPOcOt
    /Td2sykmyy6WsDKe2Notrp/NMwPRc7sYX6/tn6vjOaakY8cS3KQ/SM0BlUuejOOeBFlt
    klpj7IsjqVoqxRaZO/6ecR1ELxBSkIJS2c24P16q4xvqEkKmauIZpHvgiQ/HfJlnuthC
    YvP3HuqkzIqd09rYhKb3diVNlujmuS1TY2ZIH39xAZeb6qwdNzUIIM8vr5Wm5SRPChCN
    /Fuz23USTJZ5+Iof9rDuiIgPocS1X0u94B5vFFA23gfGMmYuwhU/ma/KzvFvoxCTgpEO
    ZN0g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767800546;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=vOIIEfctkpVxXTnIIS08Zn5exdpTl3dZ8IoObdGk2SQ=;
    b=MKoJodo5KuVCqxoc/Mp28Nj6Oi+H+l32iIqLSxmvugVpvK80aSjKyPMhun62Ogvrky
    aK7S4M+NEsZWdR/dwwGNGQMgJTL9SnPSQ806asvGdgJhKv+QC5LDWfO7W3zo8EY7n4Zn
    RXODdjDCaqX5qia7KP432ykKJn2yUSuzCjRU1NJ8Su2F+z2ou4qICOZRtsYLwk8KUb0p
    bZqfbIwE9hDf5J3ZE6+uzKoSX4IDLxjoVL4AKDjKQL1Y30tv4XigLlqjKzEWeWe92HQn
    Bkfu7KHP3qsgbUfI23C2zJ5MHJkE/Q9iuavWF7C28eU4Srg/LT6pNuH7gFQ/JCumFVW3
    HS1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767800546;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=vOIIEfctkpVxXTnIIS08Zn5exdpTl3dZ8IoObdGk2SQ=;
    b=kYONKIEQy/q29Y/uzeRV1RGaQxqhx1SeBlM6+NhauwDK9pF3DeI7mr3VU4bOe8NWvy
    5OEZXkaYITmgS9DuIZCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6800::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b207FgPD9c
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 7 Jan 2026 16:42:25 +0100 (CET)
Message-ID: <8134fcf0-9a9d-41be-bcc3-80db23932f9b@hartkopp.net>
Date: Wed, 7 Jan 2026 16:42:24 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
To: Francesco Valla <francesco@valla.it>
Cc: Harald Mommer <harald.mommer@oss.qualcomm.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>,
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
 <4cf222cb-e6e3-4d09-a7d8-bc64b8e148bd@hartkopp.net>
 <aV1zB_fYQE_OBZm2@bywater>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <aV1zB_fYQE_OBZm2@bywater>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Francesco,

On 06.01.26 21:39, Francesco Valla wrote:
> Hello Harald, Oliver,
> 
> On Tue, Jan 06, 2026 at 08:43:42PM +0100, Oliver Hartkopp wrote:
>>
>>
>> On 06.01.26 17:50, Harald Mommer wrote:
>>>> With the plain 'cangen' you are not really flooding the interface, since
>>>> you are only sending a random CAN frame every 200ms. The only way I can
>>>> reproduce this behaviour in a consistent manner is running from the host:
>>>>
>>>>       while true; do cansend vcan0 134#00; done
>>>>
>>>> which seems to generate the maximum amount of traffic.
>>>>
>>>> This is not of course a realistic bus load, but is leading the system
>>>> (at least on my setup) to a corner case somewhere.
>>>
>>> I have no idea how long the shell needs for a loop, always used cangen -g 0 to stress the setup which is most probably faster than the shell interpreter, and sometimes did this for both directions (RX and TX).
>>>
>>> Full load is a realistic setup. And even if it was not, if something stopped working or worse crashes torturing the setup this was a problem.
>>>
>>
>> Yes. cangen -g 0 -i <interface> creates full load - even on real CAN
>> interfaces. You can also generate fixed content if you want to omit the
>> generation of randomized content. 'cangen -?' prints a help text.
>>
> 
> I agree with both of you - I was simply arguing that a plain 'cangen'
> with no parameters is not really loading the interface.
> 
> For some reason, I was only able to trigger the unwanted behavior with
> cansend in a while loop and not with cangen -g 0, even with fixed ID and
> payload. However, I suspect the issue is a matter of timing and
> coincidences rather than load level.

Yes, the difference is, that you open a new CAN socket each time with 
cansend, while cangen opens one socket and pushes lots of frames into it.

Btw. this should not lead to a stuck CAN interface.

Is the interface usable from another terminal (with cansend/candump) or 
how does this 'stuck interface' look like?

Best regards,
Oliver


