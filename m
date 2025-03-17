Return-Path: <linux-can+bounces-3116-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FE7A64944
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 11:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5563B6340
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 10:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B779223312D;
	Mon, 17 Mar 2025 10:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="UcvhBcyv";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="s/Jvx9DL"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E410D231C9F
	for <linux-can@vger.kernel.org>; Mon, 17 Mar 2025 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206498; cv=pass; b=Vj+2Zlsw80gS1rhBBh/jkfr9NAcrYZUFCfrh9GN1b7fvKzstBra1OUGaC4WKE2P1Rr1M0+3sahIIuupsDGFi5tL9jiIZ85UOSNNMkWoUYq0Kp3KbHhrxmEVl8XA1mgSD6XNlMeUEeMLarqyZannU3iTI4lZX6XJYBq9jZeWiRI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206498; c=relaxed/simple;
	bh=IcBIQElUHwZt4chotFiyqWvCvNZd0+lWpRRbUPXXt18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uk7t2sYRQ8WZZ2pYiMNysIEiHHda2rf8JXr8uvSjqMrBmY4XLMHo5Hxc5ZubU5Cq1DeuuIeAWfcefQsm5swKXnAHnAzWxTi5hfQfHhr7u8XGIhLYZh73xpf5XdM3WpZYNyQ6BgT0dXdbPtFUM/eAkM3RilHRvHmUv0RYrGXEAIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UcvhBcyv; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=s/Jvx9DL; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1742206488; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ren3XwguhZhG5Ot+a2boeiQcQCnN+J9WIMBYm11EqruxoSmTxgqAzTKpK3tkfigeBp
    JBevxwc6fe1CvkLKYWT8SWIdWsect93pyAm+PGYGAS+z/jSfxf3oLYRD9lTtoXgEP8fr
    vhsrBftNYsRJMIqQS2mRFNrRQzrNQI6e1K017vopbZPLa8bNPhbEhKfwU45LfDZ667+j
    YgQv69Y0cOeFvZYCGZVb3SptZ0GLt5jqTlTsXAp2K/F4A2h0vZ/XZxsHKZj+fhW29Sz0
    7l9RhBu6RMO3HAvxYAHZ8czMn/7HXiF5cYW2PvRVnvHcAGOKMCnFWOxeNPx88Dy6R3EJ
    oYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742206488;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=mWAG8Tyq1mMoUR6qKf3VC9id8AJWBdby82fztc5U2yo=;
    b=nGgZ2n6s8gz9M1Wf5TapGExhrIa1+Hdzo93dIR5ukd+GUcnqREiEklC7nZCwUtqOg8
    xIodieLuJZgKDHKfSCZJCbVMeFnyhtmJWXMqPavZvozWf7gZhBWI2Dbz8RwgE2rwYxtK
    GkNCyQEmc5M5wfiKh8rQchL9V9q0eNSxLYjDeh99gnqda0fWH9/S0hdPcbML+pgub8Zg
    65yGn6BsZQgX3zG5Uxb+jilOFTItatTx0FWI3tEjzP2aOjQtSCC7wtJIsiQwiT1ejuGy
    DT2ix2lmmOhyvzPfYMqJ8BTtmufUso4PZVgJbGYtG6FD7kT3raZhD0Qt4eC8QNT7OXaB
    VVlQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742206488;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=mWAG8Tyq1mMoUR6qKf3VC9id8AJWBdby82fztc5U2yo=;
    b=UcvhBcyveuZ5fidrLCCOnNfTZTZ7XEFkyUKmHms2neGOBqjt5FXuCKJeZgkrvxn8mD
    wET94ufNliW5AwPPYn8LR06KLPjvQyhWqE+p6PCLkJjk+lk7gX6XC3QLqhifnU0Zmeyg
    6uF6M4MAKHDtbbEdRQJeXxbiFKxLIyKsryy4/6wBYq1K5oSHASTiafPHdpx1RcW0rdO+
    W0l5qpT1HoE3jwf50YAWJSXOmLgRusFR7tMI+vtT11xE9Wd8sP3Nl/ZsUqD/vzKptL2K
    mvKhrEzGAq5hexO0UNQZVXXl0Zxo+FA1SN1QDR7vb5CLIdG4T7SmvLnReAUy9/fPrH9d
    EQhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742206488;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=mWAG8Tyq1mMoUR6qKf3VC9id8AJWBdby82fztc5U2yo=;
    b=s/Jvx9DL0aPou4R1mC5VEG6jg0iHoB6X0r3oLSZbDh9dqOx23v9NO1xlE/IYCbatWx
    ry80OTqwYvqiRWxlwPAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e512HAEmztu
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 17 Mar 2025 11:14:48 +0100 (CET)
Message-ID: <59713f21-d2db-4ef4-ad44-077002782205@hartkopp.net>
Date: Mon, 17 Mar 2025 11:14:43 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: add protocol counter for AF_CAN sockets
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Davide Caratti <dcaratti@redhat.com>, linux-can@vger.kernel.org
References: <9db5d0e6c11b232ad895885616f1258882a32f61.1741952160.git.dcaratti@redhat.com>
 <20250314-messy-fierce-squid-0ce7c3-mkl@pengutronix.de>
 <7e35b13f-bbc4-491e-9081-fb939e1b8df0@hartkopp.net>
 <20250317-muscular-ancient-weasel-ad4392-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20250317-muscular-ancient-weasel-ad4392-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17.03.25 10:20, Marc Kleine-Budde wrote:
> On 16.03.2025 13:39:16, Oliver Hartkopp wrote:
>>
>>
>> On 14.03.25 13:31, Marc Kleine-Budde wrote:
>>> On 14.03.2025 12:39:49, Davide Caratti wrote:
>>>> The third column in the output of the following command:
>>>>
>>>>    # grep CAN /proc/net/protocols
>>>>
>>>> is systematically '0': use sock_prot_inuse_add() to account for the number
>>>> of sockets for each protocol on top of AF_CAN family.
>>>>
>>>> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
>>>
>>> Applied to linux-can-next.
>>>
>>
>> Maybe too fast? E.g. J1939 is not handled.
>>
>> https://lore.kernel.org/linux-can/78951192-82b1-45bc-9903-d314c94cd182@hartkopp.net/T/#m87afc41fef8ec9099344c753e32b06f302cc0e39
> 
> Can IMHO  be added in a later patch.

Sure?

can_create() creates all CAN sockets, right?

With this patch the sock_prot_inuse_add() increases the counter by one 
for every CAN socket.

But only RAW/BCM/ISOTP are decrementing the prot-in-use counter when 
removing the socket.

IMO this patch introduces a bug.

Best regards,
Oliver


