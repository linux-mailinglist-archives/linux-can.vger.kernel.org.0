Return-Path: <linux-can+bounces-7970-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KWhCO/ifRmrBaQsAu9opvQ
	(envelope-from <linux-can+bounces-7970-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 19:29:28 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 480986FB604
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 19:29:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=j4hFMk1N;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7970-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7970-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32976314F735
	for <lists+linux-can@lfdr.de>; Thu,  2 Jul 2026 16:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B46931AAAF;
	Thu,  2 Jul 2026 16:32:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8763AA4F6
	for <linux-can@vger.kernel.org>; Thu,  2 Jul 2026 16:32:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009959; cv=none; b=K01fl0DSpHLmYWqiF0NDkJjDjh435DDckepz4snNoQztqMmfPbGPkfldLyPnQyMgbhebtTR3VGgbf3d4zAfWSH66Hg1hnXu/Xm8xfynI9FUSjFT0BuRlOHN0ivHjTtF/dYs/xabx9yazsfR8ZbkErsXzeSpNilk/S38GE/Hdbws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009959; c=relaxed/simple;
	bh=OnW870l0yC9mr/LlBv2UdLFBV+iCbhzmV8aj4QwT7js=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=hYZVf2hs5AIRLzxlpU5w6WfkYqlw9mzSJhRb8MVqbFKYxE3+QPCIPO1aFBPywyQiHD5gNK/0r37qRPBS5uGtFHKawcaTKoWzKq/tIhKwjgp8B0reDX6LLfC8AMTWV/udZ3l9a7UtMUGUO00v1YocKi6XIyOWNa6qwiJ79K4lhkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=j4hFMk1N; arc=none smtp.client-ip=43.163.128.53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783009948; bh=OnW870l0yC9mr/LlBv2UdLFBV+iCbhzmV8aj4QwT7js=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=j4hFMk1N/h3OTU0UVYZO+w0N33E6MBV+2FQA7+4IbqJknmcGOL8gFBY0byucW2pHL
	 kt+7W+0wZRfj5KA+mNc+NVTwucs2WLVAANHI76ZEtPKCNPr0YsevP4CUCdJmDf8Arh
	 dH9yZjfYc3jGPgzKamYGee0d5BrLs6KxdoIR+YY4=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-XMAILINFO: McF9JvsryK5J2MbxooxpFinMQvrcWw5im6o2Q6S6gW5u3vK+e7cbb8hasHzSKI
	 bcHTBt+6j2qlIdyMSYAtV4T4FkElEeOkhPgUjutEqxSZlE9pwpXcmYwVL07UwlPWfKyDB/k7yJPCd
	 O/FwzzTIDfS6OMkFEs9WAYsIQIOWNO+byR197KMqoN69geEX3QNLF4uCZeS9sssoBvgUbE7eHtJ73
	 uLxAtB59HYqah38S61HXgi7+ecvVPE2eAoocyRHDXxtREgZE4n9kB0+cKPWhgzNQ+RcWfexXszztR
	 KKTxN+RDMYhH2tZox94LMxZO0QxJbV5OWgEt4ZPNBgosE6wmjyU/kWY/ynBS9NjV4CrEGBhpP8pgE
	 kKrx5xDLW7Ylf7x0n03qpySTyuk/y0P5ENgh4lsbd6nCPP2SjYirm2UbNATs1ARVThiRQAHR7xeCH
	 RjHXuoZE4ISLTI5Hnyca1FBFBMtv+PU1e+c/xx10pOFi/TwkxfRYWjFHw50+m0Okder38GSiOXR1F
	 NQn9PFhTcEYqsMInYAQKW6uXJqoaqRpX0Li+7TJ9wk4jjsiOMq5Z7AApJpHGDojBEsJt7QXt74oS/
	 BveXTjV0ZYpWevj3fD4aDytAo018wnoFb86DPsGuqMP2/bcOtManjx+CPn20yxVDKYJh3s+HrgNiA
	 XG9+uNODenrAhEugrR4mfA7ABssjjmXFuMCrO4RILgfAhB1ODwR5n9ZyAJK2AY+egS64dNI/yBh35
	 dWDV/jSUyjbuGIj7bWQsbElPpuRt3+IsuVqI/yeyc2TPQBlIx2msP+v0VbJ76S8MUsWMCakJIAh3/
	 E/ae8K8VWzdLV9aTnQbFO9FZC+kCGg3TrgUdiIeMs6ZTDxVMNskXs0B0FRJzhkYWMO29QCZyU9B1Z
	 bZL4rWB///fCE/W1WnSv9GkSXF0IJaInY+mpYt2RpXvX3E5R7vbjg4jDjvJjCGiaxvjx3rJUSXJin
	 U8zbkaK2CTClnmuU97UpOUqyzo4h+otk3jvZMDkV6x7EOylkMw1ZhITE52UobaUR1DcJqfl/BRLS3
	 hqOio78a22z1UZ2t25FSQnHF27mNnp4CrZgQK4EAhmPoLjDt9DfTyU0c6vQ==
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?SGVpa28gU3TDvGJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>
Cc: "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?Um9iIEhlcnJpbmc=?=" <robh@kernel.org>, "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk+dt@kernel.org>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?Q29ub3IgRG9vbGV5?=" <conor+dt@kernel.org>, "=?utf-8?B?RG1pdHJ5IFRvcm9raG92?=" <dmitry.torokhov@gmail.com>, "=?utf-8?B?U2hlbmdqaXUgV2FuZw==?=" <shengjiu.wang@nxp.com>, "=?utf-8?B?UGVuZ3BlbmcgSG91?=" <pengpeng@iscas.ac.cn>, "=?utf-8?B?UnVzc2VsbCBLaW5n?=" <rmk+kernel@armlinux.org.uk>, "=?utf-8?B?RXJpYyBCaWdnZXJz?=" <ebiggers@kernel.org>, "=?utf-8?B?TWFyaW8gTGltb25jaWVsbG8=?=" <mario.limonciello@amd.com>, "=?utf-8?B?S2FybCBNZWhsdHJldHRlcg==?=" <kmehltretter@gmail.com>, "=?utf-8?B?WWl4dW4gTGFu?=" <dlan@kernel.org>, "=?utf-8?B?U3RlcGhlbiBCb3lk?=" <sboyd@kernel.org>, 
	"=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
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
Date: Fri, 3 Jul 2026 00:32:26 +0800
X-Priority: 3
Message-ID: <tencent_E65CC81827F48E7C0708213AFA3934F9D00A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20260702140654.2961561-1-1579567540@qq.com>
 <tencent_3B2B6003D1DE4FB7A984665A062581766405@qq.com>
	<2459655.BjyWNHgNrj@diego>
In-Reply-To: <2459655.BjyWNHgNrj@diego>
X-QQ-mid: xmsezb41-0t1783009946tqms5g9r6
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CC_EXCESS_BASE64(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:heiko@sntech.de,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:kernel@pengutronix.de,m:conor+dt@kernel.org,m:dmitry.torokhov@gmail.com,m:shengjiu.wang@nxp.com,m:pengpeng@iscas.ac.cn,m:rmk+kernel@armlinux.org.uk,m:ebiggers@kernel.org,m:mario.limonciello@amd.com,m:kmehltretter@gmail.com,m:dlan@kernel.org,m:sboyd@kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:dmitrytorokhov@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-7970-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,nxp.com,iscas.ac.cn,armlinux.org.uk,amd.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt,kernel];
	FREEMAIL_FROM(0.00)[qq.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,qq.com:dkim,qq.com:mid,qq.com:from_mime,sntech.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 480986FB604

PiBhZnRlcsKgZml4aW5nwqDCoEtyenlzenRvZidzwqBjb21tZW50Ogo+IFJldmlld2VkLWJ5
OsKgSGVpa2/CoFN0dWVibmVywqA8aGVpa29Ac250ZWNoLmRlPgo+Cj4gYW5kwqBkb2luZ8Kg
ZHRic2NoZWNrwqBvZsKgdGhlwqBiaW5kaW5nwqBhZ2FpbnN0wqB0aGXCoGR0LXBhdGNoZXM6
Cj4gVGVzdGVkLWJ5OsKgSGVpa2/CoFN0dWVibmVywqA8aGVpa29Ac250ZWNoLmRlPgoKSGkg
SGVpa28sCgpUaGFua3MgZm9yIHRoZSByZXZpZXcgYW5kIHRlc3RpbmcuCgpJIHdpbGwgYWRk
IHlvdXIgUmV2aWV3ZWQtYnkgYW5kIFRlc3RlZC1ieSB0YWdzIGluIHYzLgoKQmVzdCByZWdh
cmRzLApDdW5oYW8KCgoKCgo=


