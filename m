Return-Path: <linux-can+bounces-8093-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IoIZAdQSTWqOugEAu9opvQ
	(envelope-from <linux-can+bounces-8093-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 16:53:08 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A1971CDDC
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 16:53:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=IPFhWWgR;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=BsyeFMly;
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8093-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-8093-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 008BC301DC59
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 14:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335DB3749F1;
	Tue,  7 Jul 2026 14:51:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF73E7BCD
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 14:51:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435915; cv=pass; b=lYHJfHsbmwT0iEpqRDUJT+9pZMurw/qGOzxa8Zc6HxTz898/UXGNZYoyRtIThaFW1daATLWmcZncRFId5oDjyL0gCMnmtsyelA2hNWOaKdr9+KQMK3x5JLkN3J9u0HDFwi9zaJujlCjcGf2/iGU+PhzYC4oXbbf89nF2J7NB+yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435915; c=relaxed/simple;
	bh=6V8RpDkPw1PjnwAF4dM+0jCYt/XS8q/zG89DqMv4wOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcaCasj95O4nIBGtG8tqu43Q8Eis+uONWPA5liXyFvA0+xVW/EmMjcXnJFtWX+LV9Fy38fIsb5Gu9rP8j5IP+yZps42ABZYamt0+gSLz8PTln7j7+y4gaWGwATWdOt5Zdh4vKvvrxvSchynMEspLOG4rwZFY+F1c2eBEe7fkPL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=IPFhWWgR; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=BsyeFMly; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal: i=1; a=rsa-sha256; t=1783435723; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fRznZOBZpZ6cdlblY3uD7xXwT4hVI87LoQ/boA4+Y4V8WdEdqE5RBOBMBlkWvJeCGT
    XZMZ5unWYx32RKIS3SBGA9/qKrSrlZ4yyALTG4BDHoh+5WaQk5pn911hIV1vzKFq18dw
    P+qjbCO2GS1KAammnRrMl4oKOBuftGZZVZQ95hzBI9bTzdsUMAiotqEqnYXkUZZ2R1+L
    gX/M+ayhPxIE+vETzeBMFcNn7NhHA9SIoMRno0z2quCteeI9XUVnpkb/15zJAIr7xUpn
    6UuGPLGFzU8Rk0Od7/JXfwfr8pzmv+/0P2pp4BOGWm9EcNNofpOZRqnfVnNyViuMjjpx
    +PMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783435723;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=M4A2lhzy7Zy4R1PGpzMQUxzwN2iVu4uevCRfwyR1uqA=;
    b=aJ9uUPSf/DBEUS+MUbcZmIh/WEEOoKk3is3GdHCCoaNHM8p0jWhGQ5xCLZQmYzaolz
    uUYvmQdyU0oWypnMUpTxqrpRsrdadBfTVI6s2dMiUKKRar6Ctc54zM6sJbCHCpUpjh2r
    gmIac+DMkLpVklKDCtExASh8M7ZlHF6jUhyHB4O8SmpfAabDyPqdsXI4pC6Pp8k+5/Fe
    cgBeIJkdrdDHgLQ2YFBnh8oAZgS60Jiuj/mvSLrY0GmRTWe7njaAFBVdIip4C9vGMMn5
    dG8OfowvhENHjJxIHTwbfm091xuuNJiS2bniNmkx5MConFxtrZaAwFgKQszPBklMHL4X
    AuKA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783435723;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=M4A2lhzy7Zy4R1PGpzMQUxzwN2iVu4uevCRfwyR1uqA=;
    b=IPFhWWgRhvDv1esu8RZw47PIjGs8YnzXfJQ0p8tzJIUvEI1gV5d6a4dCbBtbkxnfBp
    9NfgV2q2h5kMOxEIC9KBfFR2kja8RDe7wbIwLUluFr+8fCz7v+umlGwEwPeIQT8ksz5a
    B/jlSAagY674avuFp3RpE2lbG0f5pgBOK+sERqOyqe/TPfqXm3aWyGUms6LiSiyT7UCM
    IvYBq/06yJ0Yvy3ZrvbPfMEOVFuvgGqkAz7EaZiggAszD1BF4/igAPNSH/L6kgvGUSS+
    xr/0agD2bRFupSmKg9Xrz+FRVX9iWJstbd6UswmG1zWSQTEZ/VeSHOC6XKccwfNoCXcA
    IjPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783435723;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=M4A2lhzy7Zy4R1PGpzMQUxzwN2iVu4uevCRfwyR1uqA=;
    b=BsyeFMlyW0vHDG4bu2ldx7fs4tIZW55wTeibulg3mNWIzgXfU4zBEuwmc6RwMSvAyq
    duEMwBd99itDexhkpuCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.218]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb267EmhUwM
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 7 Jul 2026 16:48:43 +0200 (CEST)
Message-ID: <2414d4b7-0269-4978-9c17-f9fadffe5d39@hartkopp.net>
Date: Tue, 7 Jul 2026 16:48:35 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] can: bcm: extend bcm_tx_lock usage for data and
 timer updates
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Cc: linux-can@vger.kernel.org
References: <20260707-bcm_fixes-v4-0-aa87b8b9d33f@hartkopp.net>
 <20260707-bcm_fixes-v4-6-aa87b8b9d33f@hartkopp.net>
 <20260707-legendary-beagle-of-joy-6ab722-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260707-legendary-beagle-of-joy-6ab722-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8093-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:devnull+socketcan.hartkopp.net@kernel.org,m:linux-can@vger.kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,socketcan.hartkopp.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87A1971CDDC



On 07.07.26 16:38, Marc Kleine-Budde wrote:
> On 07.07.2026 16:32:18, Oliver Hartkopp via B4 Relay wrote:
>> From: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> Stage new CAN frame content for an existing tx op into a kmalloc()'d
>> buffer and validate it there, mirroring the approach already used in
>> bcm_rx_setup(). Only copy the validated data into op->frames while
>> holding op->bcm_tx_lock, so bcm_can_tx() and bcm_tx_timeout_handler()
>> can no longer observe a partially updated or unvalidated frame.
>>
>> Add a missing error path for memcpy_from_msg() when copying CAN frame
>> data from userspace.
>>
>> Also move the kt_ival1/kt_ival2/ival1/ival2 updates in bcm_tx_setup()
>> under op->bcm_tx_lock, and read kt_ival1/kt_ival2/count under the same
>> lock in bcm_tx_set_expiry() and bcm_tx_timeout_handler(), closing the
>> torn 64-bit ktime_t read on 32-bit platforms.
> 
> Can you please update the comment for struct bcm_op::bcm_tx_lock, it
> still reads: /* protect currframe/count in runtime updates */
> 

Ah, I got that wrong as I only focused on the commit messages.

I'll wait for sakoshi-bot once more and send a V5 then.

Best regards,
Oliver


