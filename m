Return-Path: <linux-can+bounces-8165-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OvOPI26ZTmo0QQIAu9opvQ
	(envelope-from <linux-can+bounces-8165-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 20:39:42 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B50729990
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 20:39:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=FaRrDs1v;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=g0j0CVE3;
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8165-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8165-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE51A302FA85
	for <lists+linux-can@lfdr.de>; Wed,  8 Jul 2026 18:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEBC4C8FED;
	Wed,  8 Jul 2026 18:39:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC9D4C8FEB
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 18:39:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535955; cv=pass; b=YCJu65znUDWbEKsrRKugeJuoj9s9I1OcK89DTp+vE6ri8iHRQfb+PfOey2kPl9dtczImfGtY7QQFOBXZ5WJkcb1q71Ie20wlxm8jU0P+5hduGYqOiEW0WZXrtAwjee8bTjtapHzcdhI6KGezGHyRq90Yxt+h8mihOxydmbYjJhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535955; c=relaxed/simple;
	bh=JqSZMk/JOzEFo99YttxIslaIu2KxIZ+skJ7k66ej0Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FnAZeWf9RLRLAeIDLap9mdyZzrzTkK3GfB5Lx7NIIlnCB0bbEHs4U39o9ugLB5bL7aM5JBqT8aCXcVvwOjQk80sM5V1TT2GfLGDoxaCUFbdl+fRPh/wYN2cdAgRWO5et3E/JMEHTUIy3Q/VZxr987d6mlUNRJyt4ofT8Z5NK1NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=FaRrDs1v; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=g0j0CVE3; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal: i=1; a=rsa-sha256; t=1783535935; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SJ/uCHYFzOmt+NUpAUngLbv5aYReFFAxZsPnkbGO31Hm3iNsf1X+4AAYO4M/xiDa0c
    hGV4LNEb40M6gPUw2rtDg/2An8q7EAEbhp1H0eYGAhLq0qRg4RV6suOY3fEWHpg6ddsy
    zze6I4LRpeZkw/3J2hh7C/waavSyr5xwCw6MsNm7Hl9ITSYTQjvizu+2+IpIRVGSTi7M
    wwuN/4HRUxz6Yb7bDTfok+K/erwUnlliIKpvFV3tBp2tXCuyoZJAbJGEyITkv4ODNvfv
    f+o593JzT0YG3eRpQXStY6fpMg3OsV4NFbgX14oeTcND3vfgyI62YR+DrTWSntzXFIEX
    5KHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783535935;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Q8pUHmnsTXeXsNoc413CAFMsuf5gLD+T/mfEMPovwCc=;
    b=ou/I3FbJ2uNYHj+HTftaVSs4BNwn9X0xNIaVNjGoeubtu8odUpfrsN0wqSfdGGEpxO
    S/anK6KA5tOwR0YAPhD3ochVF5xrAlAEnrcI/fIcfnipBxR4nVhU8t+gOrUKK/ApFETr
    HtW7jHuK5XUPd59HmMI6mLKQhJtx5L2HVU+XeenT64e6CfVJjwy/vAlKerLNJlK2+REs
    U02sdlTpo3PrSi3cWF9n4emw/DHgekmkT0pGmSWdttN3iLiux+NiL4Mq8xABn3dLWkTZ
    3QY2FKraU78nT7sdYlDPzeKIhvIb10pnHXtQye5U6TEtvWL4yquLubaIhE0Ksc2GwQyD
    ACMg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783535935;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Q8pUHmnsTXeXsNoc413CAFMsuf5gLD+T/mfEMPovwCc=;
    b=FaRrDs1vm6+ug2B00ddtCdWKYf4gdJpfPUTma+6C8gsMTmYgOYiTZtO0HEUNWqLU/u
    8sPWQKa63M/D78Vm9AtKJxAsTKxJA0ClU5Cxt8DkSasllc0ApBUzliYZl12CeY7SLmPh
    GcJRs6DSmTvhIVl1T/+fSSO0gYGUS3ldJ07CHVfmPTTYKBNk2xmTUtkuVoTcRyVy2kr0
    ygaVpbNMCAlJKRYnrlBUrSycUIF0uPzA7AzRwTtxM/FV59AOhy94l2pPv34sEBPEVAmZ
    KkcO6YN4B0m/O+9xBHWAl6MHMcHKXuIAhHM/bRQcavVw9I2JwazeqJrwhTfXDeEAmY1J
    QsrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783535935;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Q8pUHmnsTXeXsNoc413CAFMsuf5gLD+T/mfEMPovwCc=;
    b=g0j0CVE3CrOu7h5ukfSINGUjUMkTTwqZ8GxVGvgO3/zjciUUkVlLHXo06I7zF7Ef/c
    r2dZEs8caGPGM/DX12Dw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.236]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb268Ictg3J
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 8 Jul 2026 20:38:55 +0200 (CEST)
Message-ID: <a365adf7-62a6-4d13-a2d5-918d67952486@hartkopp.net>
Date: Wed, 8 Jul 2026 20:38:49 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/10] can: bcm: fix data race on rx_stamp/rx_ifindex
 in bcm_rx_handler()
To: sashiko-reviews@lists.linux.dev
Cc: linux-can@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
References: <20260708-bcm_fixes-v8-0-8c2f5f3bc212@hartkopp.net>
 <20260708-bcm_fixes-v8-10-8c2f5f3bc212@hartkopp.net>
 <20260708174739.7E1111F000E9@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260708174739.7E1111F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,m:mkl@pengutronix.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8165-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5B50729990



On 08.07.26 19:47, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the patch fails to fully resolve the issue it claims to fix: Metadata mismatch for delayed/throttled CAN frames. `op->rx_stamp` and `op->rx_ifindex` are overwritten by subsequent frames, causing delayed frames to be delivered with incorrect timestamps and originator ifindexes.
> --
> 
> --- Patch [10]: [PATCH v8 10/10] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler() ---
> commit 1903094034673eeaf05aa58b49f4d0ff45d06795
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
> 
> This commit addresses data races and torn stores on rx_stamp and rx_ifindex
> by moving their assignment inside the bcm_rx_update_lock section in
> bcm_rx_handler(). It ensures CAN content and metadata are bundled correctly.
> 
> Link: https://lore.kernel.org/linux-can/20260707145135.5BC831F00A3A@smtp.kernel.org/
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index 66dd8789843b5..1986d33a7d279 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
> 
> [ ... ]
> 
>> @@ -805,6 +800,14 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
>>   
>>   	spin_lock_bh(&op->bcm_rx_update_lock);
>>   
>> +	/* save rx timestamp and originator for recvfrom() under lock.
>> +	 * For an op subscribed on all interfaces (ifindex == 0)
>> +	 * bcm_rx_handler() can run concurrently on different CPUs so
>> +	 * the CAN content and the meta data must be bundled correctly.
>> +	 */
>> +	op->rx_stamp = skb->tstamp;
>> +	op->rx_ifindex = skb->dev->ifindex;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this fully resolve the
> metadata mismatch for delayed or throttled CAN frames?
> 
> Since op->rx_stamp and op->rx_ifindex are unconditionally updated here, will
> they overwrite the metadata corresponding to pending throttled frames?
> 
> If an application configures a BCM socket with a throttle timer (kt_ival2 > 0)
> and a frame is marked for delayed delivery, a subsequent frame arriving before
> the timer expires will overwrite this global metadata.
> 
> When the timer expires and the delayed frame is eventually flushed to user
> space via bcm_send_to_user(), it will be sent with the clobbered
> op->rx_ifindex rather than the interface it originally arrived on. Could this
> lead to the user application receiving an incorrect source interface and
> potentially responding on the wrong CAN bus?
> 

Good finding!

Using the ANY CAN device for bcm rx_ops is a corner case anyway that has 
been allowed for completeness. So when a specific CAN ID is configured 
with ANY CAN device as a rx_op the meta data might become unreliable 
when this same CAN ID shows up on different interfaces in the throttle mode.

There is no known use-case for the throttle mode together with ANYDEV as 
the throttle mode is intended and designed to throttle a single(!) data 
source. Not multiple. So we can change the 20 y/o API and throw an error 
when someone configures a throttle mode together with ANYDEV. Or we can 
leave it as-is to maintain some auto-detect functionality that e.g. the 
interface is not needed to be provided.

>> +
>>   	if (op->flags & RX_FILTER_ID) {
>>   		/* the easiest case */
>>   		bcm_rx_update_and_send(op, op->last_frames, rxframe,
> 


