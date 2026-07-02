Return-Path: <linux-can+bounces-7967-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /bAfEjiFRmocXwsAu9opvQ
	(envelope-from <linux-can+bounces-7967-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 17:35:20 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 763446F97BB
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 17:35:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=GxBiCEqI;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7967-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7967-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D27B30D5CA8
	for <lists+linux-can@lfdr.de>; Thu,  2 Jul 2026 15:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6C4353A6F;
	Thu,  2 Jul 2026 15:29:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631DA353A60
	for <linux-can@vger.kernel.org>; Thu,  2 Jul 2026 15:29:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006144; cv=none; b=eMscLawbrTrIOJMRad14JZSx2nPknBTsflDZc9IoJInzJw1EFTQcefbPGQZCBEIKw8XzNfuGhtoYGlU1WcEaEIrguLvzS/94kw704AI8oMNZf5sm03K/4P7dmtdyD5x6T1ZaHTIXLpkrKyGQJfJN+2qQgcNabxfYXzVbQKGVyrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006144; c=relaxed/simple;
	bh=/fVlbPyZGXATH2z5WzJ6VMWNrQv8f/QALE3Mh5Gazek=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=W6S/9znuqH7B84RC7jncLQ7mfVRRrLWcd+SQ+WdwIjm528rCEfIY5lT4JoQNc03KGw6j9eu/McDkNsDJy5P5gowLJBgLwXE+AWkYVYijPxKYHc4dZ7Dz47n461gIvep+uXTqHzIqmf2LDfucaIcHKw73+HqF5m5MAQbFXKyYdRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GxBiCEqI; arc=none smtp.client-ip=203.205.221.235
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783006134; bh=/fVlbPyZGXATH2z5WzJ6VMWNrQv8f/QALE3Mh5Gazek=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=GxBiCEqIU/Yk4xjpzhyQOQxwaWYRm6VHuItlA4LdrjTtw+fDahqGTXSqeXtz54ghg
	 LFYUGDb7WFZLFqRFekWfTwfROzKvwMLsYqwCfmlQWE/TyhRxhbPIkAX+cq6BzaeXvQ
	 LiBPSKtSVl7LmXLJtxicxHCY36x6WoR1+4/tiqSA=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-XMAILINFO: OMqlb7aP4Kjek7vshZOnZvDZb5+pT3yBZiNHZ2hUy7w914sLyLT+p04C4P4x9K
	 rkZ+UKZDF1Ze7T+AawbmzHHGc26F1svH7n53Pvt+ALBPPxl0IPtoRBjpyAJa//Esxs17tB/Auzk6u
	 1Lajtt9xuWDgjgrIjlher+7Hl63RNJawzBh26kiI8HTEW7VCfaHYk1NUFjjwLB3HgoBfJKB4EZ5ig
	 oCav9Hj+HJ/1LklYGXN+XwS9+3qQc6feB0IVzWrvgZg82gW45ooi3e2LaeHj8eULaFH88D1vtIIeK
	 aRJ8FQ/0gnwG2d8Qc0WE8fy4tIfo+SGJZ2CMSCuldorzRe0jzui3TVT/d2Z1rYDbB3okr2mC6Xbcg
	 WmcdNFUq92zXv+2WD1HcQJxAMK8TmZ+cjFKsVMCgu8qw1I6veBYoegqV1FK4vpAcHWrt7qhQG1+oA
	 57TMkADUVea3y7+vBjr4hLDQ1rRKOYeIue1+tepREdsO6WMXGjiLoD4L/up6XbC4JV2vAXqliu1Di
	 lo9Tyqbtg73CTbtd+xPA84EFFoas8G7kI5JGaKZl/EPw7CZXoOFe9pw8iE/P2Q6VzzSyqu0lwUzzj
	 rGPtrF5sxqDcCPEoMYs0tSA73FRjVaU2ACsERW1/O+iT/m3u6qCaKUBtp7xbtrf8kQNdKEHWLNOOq
	 RfRgsqQlQAr9asLRI1XXDQsfiSaQ3JKY2Fe9gcGuk4501d1ceO389TNWiSnbrP+969Ap0kvgP1u3q
	 tL8gcilPGFjtI1bRpu+oI64kWmPJHE5aNl+iGuW2GLaRzJKymPzMWa4hnF4YN5qTiYFoDRrAzKvOv
	 MpvRkwsqG+nL1+o6H0bdP96Niaz3Kx8ekjPGky+WG9QryPnXSD2+jeiSx/WwQCB7vCgiXVQI6JdOe
	 0lNdNfU8d6yxbgOp/yTbeZ3liRCydfFKcFefzHxySIvRVU4NKKyeKcdXJ1QsAiE0+xpr3HqsJpSfQ
	 KwymHuUnQhjREoVqEjPLCOqZ4Am0ruyU/Ej1t43Yo++L6XbjHzGMomiwFxp05yhQbm3wGZYN46kWD
	 6G7VmL3dax4MsHfb3Lx972hi5U4ZlXAyBeiI9w9WZKxkMkXiBgcx/x+e2vWeJh291utzlraY9looR
	 5LW5dLsDH1GlvTOz97hK3tRe
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk@kernel.org>, "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>
Cc: "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?Um9iIEhlcnJpbmc=?=" <robh@kernel.org>, "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk+dt@kernel.org>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?Q29ub3IgRG9vbGV5?=" <conor+dt@kernel.org>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?RG1pdHJ5IFRvcm9raG92?=" <dmitry.torokhov@gmail.com>, "=?utf-8?B?U2hlbmdqaXUgV2FuZw==?=" <shengjiu.wang@nxp.com>, "=?utf-8?B?UGVuZ3BlbmcgSG91?=" <pengpeng@iscas.ac.cn>, "=?utf-8?B?UnVzc2VsbCBLaW5n?=" <rmk+kernel@armlinux.org.uk>, "=?utf-8?B?RXJpYyBCaWdnZXJz?=" <ebiggers@kernel.org>, "=?utf-8?B?TWFyaW8gTGltb25jaWVsbG8=?=" <mario.limonciello@amd.com>, "=?utf-8?B?S2FybCBNZWhsdHJldHRlcg==?=" <kmehltretter@gmail.com>, "=?utf-8?B?WWl4dW4gTGFu?=" <dlan@kernel.org>, 
	"=?utf-8?B?U3RlcGhlbiBCb3lk?=" <sboyd@kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: can: rockchip: add rk3588 CAN-FD compatible
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 2 Jul 2026 23:25:31 +0800
X-Priority: 3
Message-ID: <tencent_190046D203F61069FC109A4268AC654C1309@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20260702140654.2961561-1-1579567540@qq.com>
 <tencent_3B2B6003D1DE4FB7A984665A062581766405@qq.com>
	<ec548326-dd8d-4d81-8500-ed4c4c30ddb2@kernel.org>
In-Reply-To: <ec548326-dd8d-4d81-8500-ed4c4c30ddb2@kernel.org>
X-QQ-mid: xmsezb41-0t1783005931tqwjx3m1m
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-7967-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:kernel@pengutronix.de,m:conor+dt@kernel.org,m:heiko@sntech.de,m:dmitry.torokhov@gmail.com,m:shengjiu.wang@nxp.com,m:pengpeng@iscas.ac.cn,m:rmk+kernel@armlinux.org.uk,m:ebiggers@kernel.org,m:mario.limonciello@amd.com,m:kmehltretter@gmail.com,m:dlan@kernel.org,m:sboyd@kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:conor@kernel.org,m:dmitrytorokhov@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,sntech.de,gmail.com,nxp.com,iscas.ac.cn,armlinux.org.uk,amd.com,vger.kernel.org,lists.infradead.org];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_EXCESS_BASE64(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[linux-can,dt,kernel];
	DKIM_TRACE(0.00)[qq.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qq.com:dkim,qq.com:mid,qq.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 763446F97BB

CkhpIEtyenlzenRvZiwKClRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQuCgo+ID4gQWRk
IGEgZGVkaWNhdGVkIHJvY2tjaGlwLHJrMzU4OC1jYW5mZCBjb21wYXRpYmxlIHRvIGRlc2Ny
aWJlIHRoaXMKPiA+IHZhcmlhbnQuIERvIG5vdCB1c2Ugcm9ja2NoaXAscmszNTY4djItY2Fu
ZmQgYXMgYSBmYWxsYmFjaywgYmVjYXVzZSB0aGF0Cj4gPiB3b3VsZCBkZXNjcmliZSBhIHJl
Z2lzdGVyIGxheW91dCB0aGF0IGRvZXMgbm90IG1hdGNoIHRoZSBoYXJkd2FyZS4KPiA+IAo+
ID4gQ2hhbmdlcyBpbiB2MjoKPiAKPiBDaGFuZ2Vsb2cgZ29lcyB0byBjaGFuZ2Vsb2csIHNv
IC0tLS4KPiAKPiBTZWUgYWxzbyBzdWJtaXR0aW5nIHBhdGNoZXMgb3IganVzdCBzdGFydCB1
c2luZyBiNCwgd2hpY2ggd291bGQgc29sdmUKPiBhbHNvIHlvdXIgYnJva2VuIHRocmVhZGlu
ZyBwcm9ibGVtLgo+IAoKSSB3aWxsIG1vdmUgaXQgYmVsb3cgLS0tIGluIHYzLiBBdCB0aGUg
c2FtZSB0aW1lLCBJJ2xsIGFsc28gc3BlbmQgc29tZSB0aW1lCmxlYXJuaW5nIGhvdyB0byB1
c2UgYjQsIGFuZCB3aWxsIHVzZSBiNCB0byBzZW5kIHRoZSBuZXh0IHYzIHN1Ym1pc3Npb24u
CgpCZXN0IHJlZ2FyZHMsCkN1bmhhbwo=


