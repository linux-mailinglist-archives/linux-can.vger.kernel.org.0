Return-Path: <linux-can+bounces-7983-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W6A2E4tbR2qtWwAAu9opvQ
	(envelope-from <linux-can+bounces-7983-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 03 Jul 2026 08:49:47 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1A36FF35C
	for <lists+linux-can@lfdr.de>; Fri, 03 Jul 2026 08:49:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=kvUuuDkK;
	dmarc=pass (policy=quarantine) header.from=qq.com;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7983-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7983-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B31C30087CF
	for <lists+linux-can@lfdr.de>; Fri,  3 Jul 2026 06:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2013815F7;
	Fri,  3 Jul 2026 06:49:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD3C1F94F;
	Fri,  3 Jul 2026 06:49:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061383; cv=none; b=OPHsmqzfYrxLgQPBN1CAqftFim6JrAhFgtuFOUkhJzirsbmq6Tsuuaq+tETOKXEnokBjy1zeZM7zm7XpGGlxG5zskRiQWVIJe4Tpm0WM+S+MtWJGaHlxrii5ZM6A4s7qUV9tTlZ2XvaAibDo2fQefN2vrOwhFboDj3sTbFrwPiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061383; c=relaxed/simple;
	bh=Qv1kwRVPne2QFB3ONtm+QRoyPApM0HbetYISv2n4VLw=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=aDmdLhpBtsIzJu3uhd4dg1vJpRNbPO9C0ln4nSTxQ2MLZ1sLhhQmgWcY+DrApds9fYX/8my5ovTdufOxJsmtl0IOLAd+36ldLg2d3V4AfqFFSeATRtBWsjMl7yECK9gpDLugZbaCqLytBksmnAuSixz0Tlu1r6i/CiiR/qzcfOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kvUuuDkK; arc=none smtp.client-ip=203.205.221.205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783061377; bh=Qv1kwRVPne2QFB3ONtm+QRoyPApM0HbetYISv2n4VLw=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=kvUuuDkKdzTrkPPO1YPK9DXkjA4NuEuyzkwQuj8K0IZwuyjVQzvb+83Ej0G4F5txT
	 rWSla6W2W/0Yg7tgi0MSZbucQFxi2jUqQwWr0HHzaICkr42ZxgAQ7NrMlkfP93MOGy
	 ytFokcv7bozfGmDfm4a0BgqW7ddebbQTw52Ah9Gk=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-XMAILINFO: NkQGnmzToUyFLGGtLNE6QEPHM00sgpR9dNAuu4hfh6sERgH6gk4Tonpk04ALFS
	 HtjVpORe/iBRufuyFzPu5nHHeRVELJVboNLswoK5HE5TdRkrdniQExTX9ckxEDRSCUjcV/Rnof9Pa
	 xgyIoM8IEBYYOPOwKEgH1S9ILeAOKdvETpxmfZvEZfFcPDmgDHva1WvDBkrzZe8sRDF0ZNaqjYHN6
	 c6McCT1CU75io6M/hUMavvtv3pXYZgNp/J3/CO5LXQYvXs7c+CIr/V1Q8UnM7ApcnZ359JIjlqqMW
	 xo/mh7IW+f4rmxM3mf5QKLheAQEbv73PDcdp//DhNpLyp6v45O8FZ7aOZa4rnJQF4/zgxZEVmtWqv
	 vTRZJ/sL1V+H/XwIP7ix7kY76UcuR99lnYDDktPDFvW+lazcgjoD3FRavOnRGfdZWB2FMz/HWupFb
	 tQZ274RK+uwmLn1+cr2fVNEsFtOPcGhL60N6GfmbogQbaJBDV80aKcLoqPspE/b7xBgHJPLRknyj+
	 YhwDJokHTjCs1JbrULSJCYQVlhnvKjqdmKGDCu32mwTrXbKMu/RlFL4fEn0xFYSvNmFINWjjd9WGI
	 pWRDjImr08Pu+0i5K26SbTRJLKstMNY3OLuGyngE1H50yWje9f5AoSZ8ZbHw8Y6s/NTIuYs2E01cb
	 e06aeBk56bPzL9W+4XBLWMPys+GLc7JTXBpav1F24LlgAwz9OoknJtxj0EBolisb9nLCppWvKYo6w
	 CP6woF8jVw/ak4JdOQwLCRmQNAXpxNm0/HhPciclGgk01qMEWBn0gyfGrlMVa49yG7k4vZWJ+UsGM
	 WnchtsJQSaJyeydhNP+7w5CQOJl3GvKf7dhoSiivo7n03Gb+f5+smJti73b6XCRoOlHEE2OYrMsdD
	 V9yNelAEWtAM+qnfTTUpX9xWeakHte6zbUatoViEIC+tVUXUjlS36batqB68RnuKygFqOWxCQ1oID
	 otWG/pH9lB4KmMsi5Dut/0CRo85CcnxFVtZOOOu7IK3ESqc+nVs9R5dP8mk0o5qf1TxrZkfPGwe5S
	 GPX3nXV01/hx2uBToFEj0mnu5aWon/ZONAGbZBfLcCIRPclg=
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk@kernel.org>
Cc: "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?Um9iIEhlcnJpbmc=?=" <robh@kernel.org>, "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk+dt@kernel.org>, "=?utf-8?B?Q29ub3IgRG9vbGV5?=" <conor+dt@kernel.org>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: can: rockchip: add rk3588 CAN-FD compatible
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 3 Jul 2026 14:49:35 +0800
X-Priority: 3
Message-ID: <tencent_EE004447BFA326179A1419A784CC91B48007@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20260703-master-v3-0-6d56de6fd2f3@qq.com>
 <tencent_3E31CBEFAE0986665A26322171642BC00B05@qq.com>
	<20260703-truthful-aardwolf-of-spirit-b6bafc@quoll>
In-Reply-To: <20260703-truthful-aardwolf-of-spirit-b6bafc@quoll>
X-QQ-mid: xmsezb41-0t1783061375tpzojrz7q
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	TO_EXCESS_BASE64(1.50)[];
	CC_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:mkl@pengutronix.de,m:kernel@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7983-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FREEMAIL_FROM(0.00)[qq.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_EXCESS_BASE64(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:from_mime,qq.com:email,qq.com:mid,qq.com:dkim,sntech.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C1A36FF35C

SGkgS3J6eXN6dG9mLAoKPsKgPsKgQWRkwqBhwqBkZWRpY2F0ZWTCoHJvY2tjaGlwLHJrMzU4
OC1jYW5mZMKgY29tcGF0aWJsZcKgdG/CoGRlc2NyaWJlwqB0aGlzCj7CoD7CoHZhcmlhbnQu
wqBEb8Kgbm90wqB1c2XCoHJvY2tjaGlwLHJrMzU2OHYyLWNhbmZkwqBhc8KgYcKgZmFsbGJh
Y2sswqBiZWNhdXNlwqB0aGF0Cj7CoD7CoHdvdWxkwqBkZXNjcmliZcKgYcKgcmVnaXN0ZXLC
oGxheW91dMKgdGhhdMKgZG9lc8Kgbm90wqBtYXRjaMKgdGhlwqBoYXJkd2FyZS4KPsKgPgo+
wqA+wqBTaWduZWQtb2ZmLWJ5OsKgQ3VuaGFvwqBMdcKgPDE1Nzk1Njc1NDBAcXEuY29tPgo+
wqA+wqBSZXZpZXdlZC1ieTrCoEhlaWtvwqBTdHVlYm5lcsKgPGhlaWtvQHNudGVjaC5kZT4K
PsKgPsKgLS0tCj4KPsKgQWNrZWQtYnk6wqBLcnp5c3p0b2bCoEtvemxvd3NracKgPGtyenlz
enRvZi5rb3psb3dza2lAb3NzLnF1YWxjb21tLmNvbT4KClRoYW5rcyBmb3IgdGhlIGFjay4g
SSB3aWxsIGFkZCB5b3VyIEFja2VkLWJ5IHRhZyB0byB0aGUgYmluZGluZyBwYXRjaAppbiB2
NC4KCkJlc3QgcmVnYXJkcywKQ3VuaGFv


