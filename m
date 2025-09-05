Return-Path: <linux-can+bounces-4493-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CB1B45616
	for <lists+linux-can@lfdr.de>; Fri,  5 Sep 2025 13:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175A5179B5B
	for <lists+linux-can@lfdr.de>; Fri,  5 Sep 2025 11:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F42834A339;
	Fri,  5 Sep 2025 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="gvELK4Ix";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="jY5O2cnJ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7315834F482;
	Fri,  5 Sep 2025 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070907; cv=pass; b=AmKssqmGFyzpiQWVOSElUSpRmgBRgF5hWBQS07AfPe9GKeikTcXNF1cqchEBw0kdWfAuP28+cGu+7X6KFJR0CbuQlXcnQTNOdrnyY+WkU8bBN4gHogcwlyPRiRlQ+AkFMxGSytS7bmMja6karzv2d0a1kpP3Q56SxRSYwUJkvDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070907; c=relaxed/simple;
	bh=5UpspWgiS0HcpIJL/OKDIm2gqbeCHpwQcmh9qPygNks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQE263mtaYFnERT0Rc7B4lPSW6XwROtlrpBTGjvZLD3hfsqdtRmQkPja4/ST6sSnlKjkCqYn6V470KAOamE72FggjKUOTkocwg8YgvUDP7SoW0b2eSh3I8+0AQp1UBqEV+bwGyK2QdYN0kjiTZ9o95hV6VBtGj8a7p2FVkVaajA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=gvELK4Ix; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=jY5O2cnJ; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757070716; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cJ96kMXqw4cX19wJYwGuUL8+l79vn2zlcj24sEUsn50cjsuSB6U+GPro7S9+QCWhS3
    zqPVn3MVKEKEUn+1RVXCg2wy76h2VOVLc8UYh/mtpm+yFwHSnNcnP3r8Pc+RyCMJ92em
    24f9ZeS0EzT7SDlqJMQNvQYBj1u0krjAr7ilSHsESh3G3BZDOBd493dXLGK80IFjGngR
    DSf8CAoJMk+1WfwX5J7LGpfpY0gGbKyQpbSm73a5BzHxiYLluhPqUzjz0zXS+ivelnxq
    bwBPv/+LGOOP6wn1gvSS4Wzig31DkuZmeWrKDIW4D0XwuXzA1iDfs18FT5OT+c/5cmzJ
    RaIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757070716;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=yNJzwxqPzVq3CcGkZg4xoFAXvW1IoZ5zrFxaYvAixpM=;
    b=bFyiDfK5poT9ZhSBAUdzSIApUADCyLl33VsTQ5ZriyprZ6aJ6Vl/eLR/zE9ZabWYC7
    GAHOZfZpbZEkg4H1iMRJTQ6DEVEEWFInqd7oNpXcua1KFjGnNjualZOfWlQakb+g2XTR
    bAN3tcgEhY7X6R7fYzSCeIf2RKdvUfH2jtpoeEa7Jh8b43AOHSks6YdgIHmDN5x8xCqq
    NklnVanqh1dz/3FZTfdGk+zleg7SesGl8E4ZztqhE8rTeA1AZBiH3sb0J6x3AmoUMtwS
    sOTsIpReZuFl2pQMxfD0RMfLWf87RR4c5td1flbACIPxLJaHnD4sNUfxdXtG4WYcqwYC
    aLAw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757070716;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=yNJzwxqPzVq3CcGkZg4xoFAXvW1IoZ5zrFxaYvAixpM=;
    b=gvELK4IxLzls1RSPu1+3niqliSJ1nkVXOPu41xxv8Pv2dcK7BuQZDD/C3iOcrnrAKc
    EYzNiM958xtmotwMsf8XeCqp1vGJEyGAbWMPh02ybAYcwSeAnQ/XNPD8sZk1wz+P1eFe
    Z6wu2yuloJuk/BXSBJMekXlu9wmifmL4rHjgpl+Iw6khDYyYwH34pRU1tQYNvfyvYWtm
    XY1BQHfEIYANH8psYFjYeNFH3v+bXAw21Fln2BYbBA2E7LjO3YrColbTXWTcl+qdcLg6
    6+Ptcidqk8tFFv3B9kNz4yYs8E9jlXmDkYcBYb81KuZcf8bRuNrx8Y5CghRCr7G1yW0J
    W79Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757070716;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=yNJzwxqPzVq3CcGkZg4xoFAXvW1IoZ5zrFxaYvAixpM=;
    b=jY5O2cnJZhcLN9ysq9rALY3SAsu1dnsW6OUD7zJsRJDUx3QTW+FtuRjG+CYZ56pGtl
    eoE1CYiY34US3hPJXdAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d361185BBtRGM
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 5 Sep 2025 13:11:55 +0200 (CEST)
Message-ID: <32fc8ebf-1cf5-41b0-b843-1af4821a8ddb@hartkopp.net>
Date: Fri, 5 Sep 2025 13:11:55 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] can: netlink: preparation before introduction of
 CAN XL step 2/2
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
 <6e4dcab9-d3d7-4c8b-99c1-f472bb7caa07@kernel.org>
 <e37c9890-823f-4a38-bdcc-c170dbe67e13@hartkopp.net>
 <88d2836b-2702-481f-b504-20c6efa5cb1a@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <88d2836b-2702-481f-b504-20c6efa5cb1a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.09.25 11:18, Vincent Mailhol wrote:

> Concerning the CAN_CTRLMODE_XL_RRS, I am not sure if that one is needed. I still
> have it in my WIP series but I am recently considering to remove it. The reason
> is that when reading ISO 11898-1 having RRS configurable looks mandatory to me.
> 
> In the logical Link control (LLC) this RRS bit is named FTYP (for Frame Type).
> For example, CiA only mentions FTYP in their CAN XL knowledge page:
> 
>    https://www.can-cia.org/can-knowledge/can-xl
> 
> Contrarily to CAN FD's RRS which is indeed specified as being dominant and which
> is just ignored in the LLC, the CAN XL FTYP/RRS is part of the LLC interface and
> is meant to be configurable.

I double checked my XCANB CAN XL controller spec and indeed the RRS bit 
is part of every RX/TX FIFO element and the figures see it as 
configurable element too.

> Nothing in the standard tells us that this should be a dominant bit. I think
> your intention was to add CAN_CTRLMODE_XL_RRS as a quirk for the devices which
> expose this flag. But as far as I can see, it seems that a device which does not
> expose it is just not compliant.

Let's see if we will find CAN XL IP cores where the engineers have a 
different view on this. I currently have a discussion on this RRS bit 
with the Vector support because the RRS bit is not visible in the 
CANalyser 19 GUI.

> If some day a device which can not set the FTYP/RRS flag appears in the wild,
> then maybe we can add a flag which would specify that RRS is not configurable
> (opposite logic as what you suggested). But as long as such a device do not
> exist, it is better to add nothing.

ACK. After this discussion I would also vote to omit my glorious patch 
which added the CAN_CTRLMODE_XL_RRS flag. Let's see if we find a CAN XL 
controller that does not support the variable RRS bit in reading and 
writing. And if it shows up we can add this flag to handle it (similar 
to the fd-non-iso feature).

Best regards,
Oliver


