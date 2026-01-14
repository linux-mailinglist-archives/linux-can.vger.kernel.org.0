Return-Path: <linux-can+bounces-6151-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D77D205D2
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 17:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 189153009481
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 16:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D78C39E194;
	Wed, 14 Jan 2026 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="eHTlQTgE";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="KzWCT/g5"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B5E1D5170;
	Wed, 14 Jan 2026 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409770; cv=pass; b=iCUnDmmAdr4pukyiNbY5KwyZQe9BSOY4Z0AuyqE0QFZwxxbHPzGQ1/WFZ/34BdVy6gYqUW6eRQAFIXoTMUMO5L4XweFUI2eiB1rRJUWQ5scCxJOc/4RRWeRQOq4tQ4ZoWzxGRptQEQxQTR/MiBhqeHu51124Kq48MkWxSMDN674=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409770; c=relaxed/simple;
	bh=netvWp8HMu5F68sSUgrtPN31M7VfJJ3V5ro7P6W7kIQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o78Qqhr7icF9skGcVP5CFJ2otv67PTJQ26+zS4rjuXkn/v1b+1EYM2cFpyAvzrfAgYkpx47GLrpTQRIMtNptvCew7KXRNMor6boFvcwTyntl75oNX/lBmtkIsScvr9JHlbr4VKAlykaHjKwkJsff/h53bC3GDsTZTnMaAQVpCrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=eHTlQTgE; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=KzWCT/g5; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1768409765; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Co5ChP3FeP91Jxb5w9B76w612rcdihF0C079dI30EnOIdYXMkIwNcfRBn+dxWY3+24
    r/fJuEAgsvCcJAt8KXXFupt/h+iin9DI2pQffNvp8LocBVOP89QVJnVBj/OWVtg8J0un
    dXx6wQHd5w7VMi1FLtS1MHPHJKEw/fsiT0C7rPaR44U225H38nEdq3I327cbfc2CHhwr
    87YGEHWFAvqD3ShOT7zGKmDXueA+B73WVullrCW0Vj1n8OGeMqyBnlp9X8XUfwcqN/s/
    IspeE2WBNIlrEJ+SBF4XXnNNLUU6nLO2+c9Kb9H1q5u/srzuKw12xfFlpCsaQ6DDR4p1
    wMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768409765;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YRgXCsZkgp987wIF+DINeW4kt6V2borISeBk6YwtmeY=;
    b=tFhqVquSO34hMd8SsEfBKYq39MmeiOFYE2QefdZpibqOlVoUbfpj8sZ34OnDkOdlCC
    BAOqWuZ6KjgRlbTxi575FZ2wckr3I35izbfzoRn8iD3k2WjXc3SgQv1BjkOMkfzR85VL
    bCjYxENCICcAEQ+BZR4P+nN+o7zCfHB0DkD0+wtiK1wqgroLFySc8KaHEH8TUAdOfBmR
    s8fQ+h/eTq+sdHQJaws0XckLaPI53ztoKtFkMbfUgkDrAR+qEo2hjKbQtEBbIH+jGrXq
    Vcv5eyUjcrOScOdFEKjxYh6hj2/vEHCxT+TdYre4jxcOYtbMw7jxy8ViEIFABc8eG9WF
    RnJw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768409765;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YRgXCsZkgp987wIF+DINeW4kt6V2borISeBk6YwtmeY=;
    b=eHTlQTgEE5ZaVPhAkWTw4Qbwk4Ou8Xq4GSvbSJnkI6xhid/Xs+c3OQI+eXVu4gPz+q
    s1d59bPqgZnsPtbi5vmthYqPAnEZzvrAT+SlA8zN6X1NE15fcjPtNDYLC1+l0qNRCVQ9
    325flgchGI+QOaIDN5uE2/nTxTHNrEvpnmjoWfuYLjwSfgJBk9x0mGir2fw7DLLBd7G3
    gYsNeaZlyZKcWsHP3U7cSzePXFu5wPlMCQgSk4tIOCC8xvFUL/x7AqQlylbaUYdqHaN4
    bGtS6SiYcJnp5C/ki3zZYWDIxTGNTuEOMdDJY/H/QaClug/EOqmjB4UxQtjQo2be9aWA
    mfTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768409765;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YRgXCsZkgp987wIF+DINeW4kt6V2borISeBk6YwtmeY=;
    b=KzWCT/g5mDQNBf1JrqcZJJeBR4SwAJqgzy5+sXTtHsWre0tTmyh9y7qRXHkfKBr0wg
    DoVPgyvvoF9nIRyxSIBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20EGu5uCc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 14 Jan 2026 17:56:05 +0100 (CET)
Message-ID: <5d24e045-8ede-4db1-8b0d-a6efd5037704@hartkopp.net>
Date: Wed, 14 Jan 2026 17:55:59 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] docs: can: update SocketCAN documentation for CAN XL
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Rakuram Eswaran <rakuram.e96@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20251231-can_doc_update_v1-v1-0-97aac5c20a35@gmail.com>
 <20251231-can_doc_update_v1-v1-2-97aac5c20a35@gmail.com>
 <5f8f17eb-b0d7-4b5d-aa66-31113ee891c5@hartkopp.net>
Content-Language: en-US
In-Reply-To: <5f8f17eb-b0d7-4b5d-aa66-31113ee891c5@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Rakuram,

On 13.01.26 17:14, Oliver Hartkopp wrote:

>> +For user space applications the following rules are important when
>> +handling CAN XL:
>> +
>> +- Use ``struct canxl_frame`` as basic data structure when CAN XL traffic
>> +  is expected.
>> +- Set CANXL_XLF in ``canxl_frame.flags`` for all valid CAN XL frames.
>> +- Ensure that undefined bits in ``canxl_frame.flags`` are kept at zero.
>> +- Respect the configured device MTU; do not send frames larger than
>> +  the MTU announced by the kernel.
>> +- For mixed-mode controllers, be prepared to handle Classical CAN,
>> +  CAN FD and CAN XL frames on the same interface and choose the frame
>> +  structure according to the socket/protocol semantics (e.g. dedicated
>> +  CAN XL APIs when available).
> 
> There's one big difference between CC/FD and XL frames when you read/ 
> write it to CAN_RAW sockets:
> 
> For CAN CC and CAN FD you write struct can(fd)_frame's with CAN_MTU 
> resp. CANFD_MTU lengths - no matter about the data length (cf->len).
> 
> When you read/write CAN XL frames you are reading and writing the 
> CANXL_HDR_SIZE + the length of the data.
> 
> So only in the case of writing 2048 byte data, you write 2060 bytes.
> 
> The minimum size for read/write is CANXL_HDR_SIZE + CANXL_MIN_DLEN == 13
> 

Here is an example that I've been implemented recently that shows a good 
example how to handle CC/FD/XL frames, when they are all enabled on the 
CAN_RAW socket:

https://github.com/hartkopp/can-utils/commit/bf0cae218af9b1c1f5eabad7f3704b88ab642e00

Feel free to pick the code for some example.

But please do not reference the commit as it is in my private repo and 
not yet integrated in the official can-utils repo.

Best regards,
Oliver


