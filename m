Return-Path: <linux-can+bounces-8372-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Qii7OREJVmpWyQAAu9opvQ
	(envelope-from <linux-can+bounces-8372-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 12:01:53 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 399DE7532D3
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 12:01:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=fRLzbWHa;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=GGxolC4W;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8372-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-8372-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 626C9300A67F
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 10:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069772D97B5;
	Tue, 14 Jul 2026 10:01:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB23AD24
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 10:01:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023301; cv=pass; b=swzgnLVRV2otKpU+L0t9iL6mc9306b/oSobRzGA63ATThAS3FejoMGPNXOToIyWzuS8O+GDLEUNd2ESH5KFZV/6DVpyCEpR/sHOBmGhCBYTqYhzyGCbEFE3gGVYFMIcGe7rOthKcXH5GC8Ri/g7Yg1/pIVc/ebGm5rIgrnbeyCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023301; c=relaxed/simple;
	bh=Z3vQxfNikZHHrwR+Vvdlin4IX6P5NXXoTFF3I5PV2c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2S1wb7W5Ed6Dr3kMBVTBR93uP8ROViXJfOXMEds6hHc7tZMXKFtluSI6tUQygEHG1UpySwbSczKAraH2e4ky2DewvZmu2Pcp8bothwMq+4ObI9kPKECPnwdnY5hMLsu+uqPrF0JtlOvBt7rOMgoCkIZ0hVy1tpwSGfeBwyY4Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=fRLzbWHa; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=GGxolC4W; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal: i=1; a=rsa-sha256; t=1784023290; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BYkY0pYRJ9jbEa4yeTmWcQ5da1CzXgjH534w/6LqvziRf+VWC9FfiT4LYvju4OGslV
    jIVUCqDaVt9kAp+V/22Z95gnBEzPd0c00h7inGEZluSy6cHz6CiXi0A4mnoqoln5PQUp
    VWD0xZFyqa6JZdAXLv4W4bD2YjC+zCQqX3BdLKqHh7ov1Wi0yHqf0eRz4oTfj5gzhQhr
    f0jv7w+Yp24/Y5CEbK+bZB/1kR6iCLE+jKJtJOje/XUMUQCqx5GY+2X1H/ZeeFsEff1s
    6jdFw/UVIgT4p7OFkrFDxz2CyjJb6GFUagKlJ7SQVjaHgmspO25O+3w04dgZYp0lHvau
    jNJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784023290;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=67OIDJ+L8Mu0SAsWs2LCHyg/5xxRCXs8h0e0b0JDy68=;
    b=QvYlxPFa7mdXa92ZBFtK+cT5jZL/KUH0Or6Iu4XdY0scc/SJCGFBwheLvPvmpNL567
    F5GQxa2rKVfIKxIc9WHwrhFPHlat4ce65yed5o/WXwiV+XolhFL+FuG+mNPZWSP87nzH
    tuocgjRQqf5+3F1/pTjlKKWT3AUnenh575X0xgCa1wIGC85uThSn6SfT8HtKRktvsYGf
    IBSIEPsde0F2iZT/1mbZzww0eGKnszVFRNjK9DCEkZlF6hlRztYlkwx2GsM7Q49DbTnV
    bSr5xZZVj5OVWqBs87D4ajpWsXjJ2P97SdLyBeNbmNeYhUyQIDCAGg6dnQsUoIJ65S2b
    X7uQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784023290;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=67OIDJ+L8Mu0SAsWs2LCHyg/5xxRCXs8h0e0b0JDy68=;
    b=fRLzbWHaxmYjY8jVjxNZgeurNZ982xQxLU6O5nFsjtle0WEygZhMh5ayggifIk5GcQ
    oe8jKjz5iHSK8gRdHcLOTjsMPXQQuYibwNIeppk+sj0iOZz04pDCSVwXZ8JQH4B6zoh/
    plFdM5NtX0TKW8UKdFghK5VNSUEvxSD4kk2D7QtbYsZlW+2FrADIlJNcPApIwArDtwtm
    ajWwnyZr5C6KGHvixCPpSMvchIHrLb5chaWI7aj4skYvm5OyBHcJUg5OuQOut/eqRZYO
    JJkocYmZ042XZW0hqCeEWAwexNxwhoT+44QAziS+L93mIV+kRvGmouJppxUgC8gE/lNs
    SY2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784023290;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=67OIDJ+L8Mu0SAsWs2LCHyg/5xxRCXs8h0e0b0JDy68=;
    b=GGxolC4W63OFMpxDgw5MB5aargUPga11nxbRAvi18C3AKI6kJLy+pTDh0AtAJ+q3uj
    QfBMNBkQt5PyP9gSnGAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.190]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb26EA1Uimt
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 14 Jul 2026 12:01:30 +0200 (CEST)
Message-ID: <10179a2c-c8fd-428d-a918-955b6412e712@hartkopp.net>
Date: Tue, 14 Jul 2026 12:01:25 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Weekly net upstream? - Re: [PATCH] vxcan: fix Kconfig description
 stating no local echo provided
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: mailhol@kernel.org, linux-can@vger.kernel.org,
 =?UTF-8?Q?Alexander_H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
References: <20260619090035.17769-1-alexander.hoelzl@gmx.net>
 <1f3a3c0d-71a6-4c7d-9e08-5e19f1999af2@hartkopp.net>
 <ef991c9b-276d-44e9-a48c-7bf52f69ea0a@hartkopp.net>
 <20260714-vole-of-sheer-leadership-1bf399-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260714-vole-of-sheer-leadership-1bf399-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hartkopp.net:from_mime,hartkopp.net:dkim,hartkopp.net:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8372-lists,linux-can=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmx.net];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:alexander.hoelzl@gmx.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	RSPAMD_EMAILBL_FAIL(0.00)[20260712181155.b42ea1f000e9.smtp.kernel.org:query timed out];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 399DE7532D3



On 14.07.26 10:51, Marc Kleine-Budde wrote:
> On 14.07.2026 08:55:32, Oliver Hartkopp wrote:
>> I would be glad if you could upstream this patch together with the now
>> sashiko-approved fixes for can-bcm and can-isotp:
>>
>> https://lore.kernel.org/linux-can/20260712-isotp-fixes-v10-0-793a1b1ce17f@hartkopp.net/
> 
> If I understand you correctly, you say that the issue sashiko claims to
> be in patch 3 (mid:20260712181155.B42EA1F000E9@smtp.kernel.org):
> 
>>> [High] Lockless state transition in the timeout handler creates a
>>> race condition that causes timeout errors to be silently dropped or
>>> misattributed, leading sendmsg() to erroneously return success for
>>> timed-out transfers.
> 
> is a preexisting problem?

Yes. Always broken for years but nobody ever complained as the pattern 
that would lead to this problem is not used.

The core issues with concurrent execution UFA and probable stalls are 
fixed within the patch set. Fixing the in rare cases wrong (and unused) 
error attribution would be a huge effort.

So it would be something for can-next or wont-fix.

> 
>> https://lore.kernel.org/linux-can/20260709-bcm_fixes-v12-0-61c06291bf1c@hartkopp.net/
> 
> Can you clarify these claims:
> 
> https://lore.kernel.org/all/20260709203552.D473D1F00A3D@smtp.kernel.org/

Fixed in patch 9.

> https://lore.kernel.org/all/20260709204058.5BEED1F000E9@smtp.kernel.org/

Oh, this was really an open point that I have overlooked.

Will send a V13 asap.

Best regards,
Oliver


