Return-Path: <linux-can+bounces-7159-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHEsJ6EUvGnbrwIAu9opvQ
	(envelope-from <linux-can+bounces-7159-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 16:22:09 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0857D2CDA27
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 16:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A819D32A0170
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 15:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C84E3E558F;
	Thu, 19 Mar 2026 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="tDEEvHv8";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="lpFTAQJI"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026503D5244;
	Thu, 19 Mar 2026 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933336; cv=pass; b=p35JM5a56/lpTP5drTqCU6BYYXSM1goQjbuT3FBp//7wmxiWHxRG9pbpnbXceAQkn/CJ3RdwclVLjkmR5HOaU+pfJvQ9gzgJIBJGC9xbQ6rVxzf54wTYhv36M4RYWz3NSTz6TqWbUrCJKjyaKSg4JpREQbZ0Iqn34xiEUbikbH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933336; c=relaxed/simple;
	bh=66uZnNF1/yeEa3vsMUeNAHK7IvHN/fCu610L58DeQRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T0V8nTiG8/WRtGOVjMBdmezhff+Qh2WW4proSkzw5qRMbcSqwGhmJ991Qz7w8rtBY1Jv8J/aV6Hlqn06iYpF3Vvb2o/0MBuzXURimFmnIzPKMekd06u3YcewKHAQ19gYx7CihgSU+5d5/Xuo7HVZ4zc5sG9wwk8NGEiVcDATHwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=tDEEvHv8; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=lpFTAQJI; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1773933147; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kZnDt/IqNtgxSHeinuglbhfi7t+HUTHOyIIYF/lF+0t49Otjlf57DLABTfjw59Nfsm
    Wiuf4+V6Y4RMuEQARz3tSEFFaiFMpjcG0tY9CWVJ3TIjJCXIvy7Qbsg8G5pOVQoudvJ4
    dn9MYC3cOg9FJpVWhASrA1qV/MJJdPmMZtkteeKWMrRcwiVg3mz/DCnzipjVeH/wrt7W
    IlpQk20l4352NGyNKTKc08A7OfcpyKAxjZaHi4OR1zfwNu2zgmb39iADYM5w/Hhz7Vuq
    1ga/krI0YamrYVA0r8dq2GcxrplHsZSKNExhmWBUSbRL8igN5aqAKYuxAZYOyxDsShru
    0YDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1773933147;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QTbHwNgUlpuQ+14PDiJGaCg2VhpJ5FNy5BP2ftkcQwM=;
    b=EUEDNZQtxnTqpOhJ7QeSwE5lCEKOlJL241LXLeZVX3op+uP5meAT7JskzkSSRuJFX2
    YXMnoJySHfUbugXrYVoxhvEDflGn41E52eNnLOOpYgpZZ4nEut0KiT1l6TV9v0dKEg4Q
    sZubZPUbHLx2Wkru/wxvMm/M9U3o2EsfiPGw5PoEJs5Ok+W1g/1UD8gUDzpWhJlW6zud
    iMRkuHUK2ctCo/yX4SAJ9cMyIc9AJ7IJtqHzmGPz71aINaCMo3eWdpbMr3vUNic8+I/j
    BY1wk4O5paIRqeG5LXYb1DicrPHWp4AZykQNWdEXBM8/W6aG/8iGoWvGeQT0WE8JCjaP
    1V0g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1773933147;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QTbHwNgUlpuQ+14PDiJGaCg2VhpJ5FNy5BP2ftkcQwM=;
    b=tDEEvHv85mSpeTQI6QXda4mqQeaPF/10pUj/0rNgtUDj75nek+CC4S/EBSbA6oxTHr
    MczYphmxdVydAbkcgmNccEJ9IE5i4XnOtSdnTc2yCGvKSEV8Hnxq0Fe/yoFXETsYb/bR
    E1cXBMmAaGj1CBBbAZP6MFsdZHdClkIEt2HK0M3/CHMf3lWfC69d2afmmgX9yabC4SUH
    GY3iuZ19upZ0b4mmARAOSll0zcZ/rSyv5zyVag/XODwRZARMM0dvxSOYsBee6R0nVcml
    QPWNHy21Ks/hmwcESOvVfDEDViCVIY6VfgjZV5OOEwTJ+LfQIw9pL9cTj01KL4FKRti5
    HsEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1773933147;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QTbHwNgUlpuQ+14PDiJGaCg2VhpJ5FNy5BP2ftkcQwM=;
    b=lpFTAQJIRHzDyIm9JJ3VD4poVlsS1jmyzqT/HDveXM6fCAKJmeK5kcQkx+4/+I8hti
    EnVJl7Ii4LEE2MxmkoDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4NqH8="
Received: from [192.168.90.131]
    by smtp.strato.de (RZmta 55.0.1 SBL|AUTH)
    with ESMTPSA id Kba96d22JFCQsXE
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 19 Mar 2026 16:12:26 +0100 (CET)
Message-ID: <2f4e771e-62fd-4908-9dab-02120bc51467@hartkopp.net>
Date: Thu, 19 Mar 2026 16:12:21 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] can: isotp: fix tx.buf use-after-free in
 isotp_sendmsg()
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, stable@vger.kernel.org,
 Ali Norouzi <ali.norouzi@keysight.com>
References: <20260318165120.17560-1-socketcan@hartkopp.net>
 <20260318165120.17560-2-socketcan@hartkopp.net>
 <20260319-dashing-scarlet-angelfish-dfaa67-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260319-dashing-scarlet-angelfish-dfaa67-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7159-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:dkim,hartkopp.net:email,hartkopp.net:mid]
X-Rspamd-Queue-Id: 0857D2CDA27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 19.03.26 15:58, Marc Kleine-Budde wrote:
> On 18.03.2026 17:51:20, Oliver Hartkopp wrote:
>> isotp_sendmsg() uses only cmpxchg() on so->tx.state to serialize access
>> to so->tx.buf. isotp_release() waits for ISOTP_IDLE via
>> wait_event_interruptible() and then calls kfree(so->tx.buf).
>>
>> If a signal interrupts the wait_event_interruptible() inside close()
>> while tx.state is ISOTP_SENDING, the loop exits early and release
>> proceeds to force ISOTP_SHUTDOWN and continues to kfree(so->tx.buf)
>> while sendmsg may still be reading so->tx.buf for the final CAN frame
>> in isotp_fill_dataframe().
>>
>> The so->tx.buf can be allocated once when the standard tx.buf length needs
>> to be extended. Move the kfree() of this potentially extended tx.buf to
>> sk_destruct time when either isotp_sendmsg() and isotp_release() are done.
>>
>> Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
>> Cc: stable@vger.kernel.org
>> Reported-by: Ali Norouzi <ali.norouzi@keysight.com>
>> Co-developed-by: Ali Norouzi <ali.norouzi@keysight.com>
> 
> I'm missing Ali Norouzi's S-o-b. It was in the Mail that Linus Torvalds
> forwarded us:
> 
> mid:CAHk-=wheQ2o0B_-EV5H3w=ZZS2huESOxrvTaub_EbrbAMbgi4A@mail.gmail.com
> 
> Ali can I add you S-o-b here?

Is this correct?

I picked some of his commit message but the code is entirely my product.

Best regards,
Oliver

> 
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> regards,
> Marc
> 


