Return-Path: <linux-can+bounces-7352-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBhIKliN1mnzGAgAu9opvQ
	(envelope-from <linux-can+bounces-7352-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Apr 2026 19:16:08 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E783BF5FF
	for <lists+linux-can@lfdr.de>; Wed, 08 Apr 2026 19:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E039A3016491
	for <lists+linux-can@lfdr.de>; Wed,  8 Apr 2026 17:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCBA29BDB4;
	Wed,  8 Apr 2026 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="fE21r+7O";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="5IVVAq6Q"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C2A33985A
	for <linux-can@vger.kernel.org>; Wed,  8 Apr 2026 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775668564; cv=pass; b=uJLMlLMLCQhKgm8vo818Ev6+++Jck8Ed8RAlR24yrsFQSSicdXu7MGmKaA6cVoVuSgndn4TK284YrDx+33i4vAvoUMHLR1IgS9xtlCRfr6FlH3+v9y1OQnD4DtURD2VWYRXmIr+cRaG+WtoTeO1q7r4wmOQyaetSTApO8dMSsbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775668564; c=relaxed/simple;
	bh=WE23EORs9/3EW0DlwVGwMqGYr3pu8BT+USaDeejQmwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbcO2cbm1lYp13I/k4V0nz0ZTMigqas9sFcX8yd1UbGZWAFZe9RxZeFC70Wl2OM2QqiX//63VlGO2b+TGuabOM5DLCgqlVuO3bYzk2BYJU9sX/A3RaXv+0xKNw87r32/jv1u91fzzaj8wEISuJ8TTTxY40wgkZpFQa/HrrHK1VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=fE21r+7O; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=5IVVAq6Q; arc=pass smtp.client-ip=81.169.146.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1775668555; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jJv3wYNADnCscJvDYy7+SmctdYC7lXVVUUWCVR8vCYNt7o2BpVKd3lsGNOZM892WNp
    T4jpTdE7pSlDsP5EsDxoZeBNbV8ghBQPqHSK83t/r3jz0t2JP9ZMsnRFh6qilvzYI9RI
    zJExtndgbl4SmafSZwE1Fw7DPZ9eOKADCYK8YC42iMSr5p1iQMdqRH5I8TYyhrb5/Lyt
    y8Nh5Gw67C2bn60VfyBJ3b2rRUPeBxkjzZIabZd+zxiq1KDZ33g15SxuE4faJjlze3RZ
    avxSQx6CE+3FvwUjguvS35dbJnXjxPIcLBOePYCS170XXa42SIvztyK8YhEFvj+BCT9F
    dLIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1775668555;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ypGzVdPeKT2dOcB0pyNw+HbgLdNpTVtp9vpZUKM8O/Q=;
    b=NvNNqJ5CZb/30t+rBjCjLLn9MSI0NJGPgGkCZ/9yLJXg3FBSI39Mjq2wqPdetDfMMI
    VI2SNALUw/SAQuHHUb0iSGtDWkd2ste2arHWu0RVN1z82GxfDmDObQGOf/5b15NessPZ
    tBSxJJoAoI75fE7DsguumJ6DDRsgvhOvEXX3Z0ht/v/GBn7mtjF4bz19gIkdphlXhO5+
    YZTHkDPX82KLA+putGgOiy+sW3vYqme+Mf4W8ksrKxmoTzbFVuZJKU2BjFI/ns6Nrwwq
    7heGsl3j1k/sircKjeH0edmNtYPA3zzFf0cwKKdxY9GY0YvSjcx2/q/MdMrvkISDr8O9
    OL9g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1775668555;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ypGzVdPeKT2dOcB0pyNw+HbgLdNpTVtp9vpZUKM8O/Q=;
    b=fE21r+7O9fDwBLQmDfLwrU+jjYFws9BkbZGS6kldfG98qAGou0eWHeHdES3PdF/VlH
    ERx6Oxe5FvrE5JbGXYi7L4d/mCehX0Tghh9pja/AoSwWyJlex5w5v9HXwwXzfqrUrDF7
    Ap953kRv67PdJMJDHQsELq/VhRe9O6dvkuFfnQU3KjS2M1IeVMjk1Dt2mE2G5clUoZu5
    SvEbCB2jFfI2yjZw9UEPnyCkYJQBfGvGUEKotVRAYkPcHYVEF/0Odu5wm3n3ZXE1BiZH
    GkhIH2R10yYNRRKvFq8FrJKtH0Bsoxt+gock23QnDfdqe7+xlSnb4/exW9k/NpmtQDru
    jN9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1775668555;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ypGzVdPeKT2dOcB0pyNw+HbgLdNpTVtp9vpZUKM8O/Q=;
    b=5IVVAq6Q6/bNJ6BYQOh/08pYqNGnALQkiJXg0nJlWn32FeoGn75/clxNrpwswVK7dC
    xMjAnAbRKGLioBJJP2Bg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTRsLs5FrPm8xWJP2FLGj7g=="
Received: from [192.168.1.104]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d238HFruGP
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 8 Apr 2026 19:15:53 +0200 (CEST)
Message-ID: <34ff076d-fd14-4f00-b8b6-8d43389bdb0e@hartkopp.net>
Date: Wed, 8 Apr 2026 19:15:52 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC can-next 3/3] can: add can diag interface
To: Davide Caratti <dcaratti@redhat.com>
Cc: Filippo Storniolo <fstornio@redhat.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Robin van der Gracht <robin@protonic.nl>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
 "David S. Miller" <davem@davemloft.net>,
 Urs Thuermann <urs.thuermann@volkswagen.de>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-can@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
 Radu Rendec <rrendec@redhat.com>
References: <20260402-feat-can-diag-v1-0-245b56434c1b@redhat.com>
 <20260402-feat-can-diag-v1-3-245b56434c1b@redhat.com>
 <ba4170ca-3e74-49f4-856f-dca130db05ad@hartkopp.net>
 <ac6YI19sCfSmgvyh@dcaratti.users.ipa.redhat.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <ac6YI19sCfSmgvyh@dcaratti.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7352-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hartkopp.net:dkim,hartkopp.net:mid]
X-Rspamd-Queue-Id: 28E783BF5FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Davide,

On 02.04.26 18:24, Davide Caratti wrote:
> On Thu, Apr 02, 2026 at 03:07:53PM +0200, Oliver Hartkopp wrote:
>> Hello Filippo,
>>
>> many thanks for your patches.
>>
>> I'm not yet convinced we would need this kind of interface as many features
>> in ss(8) are only relevant for IP and not really for CAN.
>>
>> Btw. having an overview over PIDs and open sockets might be a nice
>> informational feature.
> 
> 
> hi,
> 
> thanks for reading!
> (an unsolicited answer to the above sentence, just because of the
> "Suggested-by:" tag in patch 3/3 :) )
> 
> Enumerating open sockets with {uid, pid, interface, protocol} looked to me
> a good-enough reason for adding support for ss(8): this is done also by
> other non-IP socket families, such as AF_XDP [1] and AF_PACKET for the same
> purpose. An alternative would be a tool like tcpstates [2], but it needs to
> add tracepoints as well; the diag module (at the expense of serializing
> 'can_create()' with 'proto.release()' with a mutex) looked a cheaper
> solution.
> 
> [1] speaking of this, I wonder whether we should pack some of the info we
> have now in 'rep', e.g. the result of 'getname()', into a dedicated
> attribute. That would save from returning zeros for modules that have stub
> getname(), like can_bcm. WDYT?

There's generally no address information like IP-address or port numbers 
in CAN. It is all about CAN frames containing some data. And a CAN frame 
is defined by a CAN Identifier and a CAN bus (CAN interface) it is sent on.

Either can-raw and can-bcm simply work on this CAN ID / CAN Bus kind of 
"addressing". They use a CAN ID filter infrastructure in af_can.c to 
subscribe for CAN IDs received on a (specific/all) CAN interface(s).
But e.g. a CAN_RAW socket can have 200 filters you probably do not want 
to provide via ss(8). The filter lists can be seen in 
/proc/net/can/rcvlist_*

ISO 15765-2 and J1939 define higher layer protocols on the ISO level 2 
CAN bus. And only those two protocols can show something valuable that 
might look like a getname() content.

Best regards,
Oliver

> [2] https://github.com/iovisor/bcc/blob/master/tools/tcpstates.py
> 


