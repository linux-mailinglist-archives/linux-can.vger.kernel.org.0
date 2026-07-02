Return-Path: <linux-can+bounces-7945-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 88ENI9nSRWonFwsAu9opvQ
	(envelope-from <linux-can+bounces-7945-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 04:54:17 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 807646F3204
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 04:54:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=ncXt4l7j;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7945-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-7945-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 152A73008624
	for <lists+linux-can@lfdr.de>; Thu,  2 Jul 2026 02:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054B530F815;
	Thu,  2 Jul 2026 02:54:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D483430E851;
	Thu,  2 Jul 2026 02:54:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782960846; cv=none; b=f0SFh6NKssDBWeAL5aJ0TOx+VX24XBwYs7bS0seT8mN5x3vKNF+IIeXgjspnESN694Nn6o+NeBznLDkZRpMwhtXoaA4JPazkTbYGiJUU3QV1Gg8VqYEcCTfu72g/Ue2oYDC+MrG7Wh25V5XRpEqtfnxMTG/K5s/u8ReOMvhIt8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782960846; c=relaxed/simple;
	bh=JGJIGU/YRV1OcQsRUiuMDIKLDqsz1oM2SvY1he2YuL8=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=B2JOqIeBm4QRe5qPKkRSUKQnELsM5WcMYpdMcJULY5587KUCxGxQyiGJNi9wAb0sf3ytj3yJAveXOw0nfGMSVQQ/fgBfH3qowpt2wdwluHUjwplah8dtYnqt+dviuxXRtAFG4Re0qDX2l82CrXy4C7NtsmSuRou7yKpCREtGjFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ncXt4l7j; arc=none smtp.client-ip=203.205.221.245
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782960835; bh=JGJIGU/YRV1OcQsRUiuMDIKLDqsz1oM2SvY1he2YuL8=;
	h=From:To:Cc:Subject:Date;
	b=ncXt4l7jbmCEHixRWamZK8J79PRis7V23z5lqLtnod7WBJ9XNcAgZjpbaDCAHDUPP
	 r2Dc1bts5KoqMIkkCdVAbuc8A60sjxzvF5+ehEeyOGvU+RCiSN2y1eLc0B/+hPPCPj
	 uVAdNFpvsJbN1BjyvJLr/eBZbDnRbqPc7iApYw60=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-XMAILINFO: N2nZekq4carkUlQ39untDC57buGLnHuS/eryVQoQkd343L3M7urja8FfELAjYH
	 +Y1DjiEfdZl9u+IrTlAqw1C5s7ZkypGAjQmeHYE9eQh+1IHHjYkl5XnvKQJnzpdOVurwElBLskKAV
	 OY8uDWwoy2XteftY02Aj3r1bmyR1X8NB9dMJzJEvRUAKqFOKoc3u6SXUUeFLUDWRrPgrUZMvAxqQ+
	 DP4nxOi7SEWjpeqRpsQEHNHyOMmR6ov7vGGrqlGUU8bHD3Xv8JS8JNqRadCvAUHJ9k7u+pfJvBzmq
	 zaakHhUOBKwkmA1+xLYDBuX6FAZluhb/0FU6WhBoEg68+YU67MDhk6XOcOQb8uHhk5xvrDVbRXNYb
	 Xm+jN0BPv9NAcDz+T9tk+pBD1Z2rT7Fgnw0eWU8T6FqkrVRHeVk4QapgjhVxBy8OigHeWxKn8MqYf
	 3nN7bCYkGQmzfzEVl0EhpYAWC7ErwAukZuVpQbgCljWmkJwURGcaKaV6ebv/3hhjCcSqD6VaqIHRE
	 soXapQ1M22WpAcfVN2dY2EeaCfrON82LOxXFug+ZqdA0JPl0YvzbPuj9kQ/uP8ExE7H6A/6MIwxnj
	 ss2KmVkOeIpVdApgWD1izE3AjeLwfnnE/vavnfTLZsGNxPeK8fNRqZHNBnKbbzD+h2D1zhfDbgLq8
	 /i4ljk2FY97oI530A3x2H20a0Q9JLlc1hi8bxhpxgDP5TdCr2sP69sjueSEBi+fKyFg2kpTb9HC7O
	 c1wz8380hwnjO9rjwUDpxOc2TBbKMcrZ+quF7ckUcIZl9g5D81Y9HZWc5a3y5ACempOkuUiMlygks
	 pg+Kk7IHCHjeL93f3aFxfxOcJwlLYPgmJ4L6uOAoosaNPYostXIOtGJCqBFR4fe0bBg12WzF0sFN4
	 oYMRrfABgCumteMyrk0TRKQGIx9g7NV6rC2/krQpWI4n2CSX8IdHW82PCOFSDdMOi8CMWeGuaZjIA
	 yuVedc2cqyKTuK55JvumSfoem6TGlCqy8dZZ867nMMHoHRuCM5OQ/1Dneb5eRiRTd9bWnki2kKb4T
	 qJlB8sKIeBV3s+m7wiNfp0bIZADrl2RA8/YUv/uqFsmvud2Gu0c1+G7Ilgph5byEK2E5jIfdUIVOd
	 bcLJ37jGaJJlmQ==
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?aGVpa28=?=" <heiko@sntech.de>
Cc: "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bWFpbGhvbA==?=" <mailhol@kernel.org>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?cm9iaA==?=" <robh@kernel.org>, "=?utf-8?B?a3J6aytkdA==?=" <krzk+dt@kernel.org>, "=?utf-8?B?Y29ub3IrZHQ=?=" <conor+dt@kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] can: rockchip: add RK3588 CAN-FD support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 2 Jul 2026 10:53:53 +0800
X-Priority: 3
Message-ID: <tencent_534F9A1699EA04B091BF8003C479BFA32607@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-mid: xmsezb41-0t1782960833tm1iad0r7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	FAKE_REPLY(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:heiko@sntech.de,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:kernel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	HAS_X_PRIO_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-7945-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_EXCESS_BASE64(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qq.com:dkim,qq.com:mid,qq.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 807646F3204

SGkgSGVpa28sCgp0aGFua3MgZm9yIHRoZSBndWlkYW5jZSwgYW5kIHRoYW5rcyBmb3IgbGVh
dmluZyB0aGlzIHRvIG1lLiA6LSkKCj4gSSBkb24ndCB0aGluayB3ZSBuZWVkIHR3byBwZW9w
bGUgd29ya2luZyBvbiB0aGlzIGFuZCB5b3UgZGlkIHRoZSBiZXR0ZXIKPiBpbnZlc3RpZ2F0
aW9uIGludG8gdGhlIGRpZmZlcmVuY2VzLCBzbyB5b3Ugc2hvdWxkIGdldCB0aGUgY3JlZGl0
IDotKQo+Cj4gU28gSSBndWVzcyBteSBwcmVmZXJlbmNlIHdvdWxkIGJlIHRvOgo+IC0gcGlj
ayB1cCB0aGUgZXJyYXR1bSA2IGludG8geW91ciBwYXRjaAo+IC0gYWRkIG15IGhhaWtvdSBw
YXRjaCB0byB0aGUgc2VyaWVzIC0gdGhhdCB3YXkgd2UgYWxzbyBnZXQgYSB1c2VyCj4gLSBo
YW5kbGUgS3J6eXN6dG9mJ3MgY29tbWVudCBmcm9tCj4gICBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1yb2NrY2hpcC8yMDI2MDcwMS1zZW5zaWJsZS1jcnlwdGljLW9jZWxvdC01
ODAzNWJAcXVvbGwvCj4KPiAgIGFzIGJvdGggb3VyIGJpbmRpbmdzIGhhdmUgdGhlIHNhbWUg
c3RydWN0dXJlLCBzbyBJIGd1ZXNzIGl0IHNob3VsZCBiZQo+Cj4gICAgIG9uZU9mOgo+ICAg
ICAgICAtIGVudW06Cj4gICAgICAgICAgICAgIHJvY2tjaGlwLHJrMzU2OHYyLWNhbmZkCj4g
ICAgICAgICAgICAgIHJvY2tjaGlwLHJrMzU4OHYyLWNhbmZkCj4gICAgICAgIC0gaXRlbXM6
Cj4gICAgICAgICAgICAtIGNvbnN0OiByb2NrY2hpcCxyazM1Njh2My1jYW5mZAo+ICAgICAg
ICAgICAgLSBjb25zdDogcm9ja2NoaXAscmszNTY4djItY2FuZmQKPgo+IEFuZCBzdWJtaXQg
dGhhdCBhcyB2Mi4KClRoYXQgd29ya3MgZm9yIG1lLiBJIHdpbGwgcHJlcGFyZSBhIHYyIHdp
dGg6CgotIHRoZSBiaW5kaW5nIHNjaGVtYSBjaGFuZ2VkIHRvIHVzZSBlbnVtIGFzIHN1Z2dl
c3RlZCBieSBLcnp5c3p0b2YKLSBSS0NBTkZEX1FVSVJLX1JLMzU2OF9FUlJBVFVNXzYgZW5h
YmxlZCBmb3IgUkszNTg4djIKLSB5b3VyIEhhaWtvdSBwYXRjaCBhZGRlZCB0byB0aGUgc2Vy
aWVzCgo+IEJ1dCBpZiBpdCBhY3R1YWxseSB3b3JrcywgdGhlbiBwZXJzb25hbGx5IEknbSBt
b3JlIHRoYW4gZmluZSB3aXRoCj4gZW5hYmxpbmcgQ0FOLUZEIDotRCAuCj4KPiBJIGd1ZXNz
IE1hcmMgbWlnaHQgaGF2ZSBtb3JlIGluc2lnaHQgd2hlcmUgdGhlIEZEIGlzc3VlIHRyaWdn
ZXJlZCBvbgo+IHRoZSBSSzM1NjguCgpJIHdpbGwgYWxzbyBkb3VibGUtY2hlY2sgdGhhdCBD
QU4tRkQgc3RpbGwgd29ya3Mgd2l0aCB0aGUgdjIgY2hhbmdlcyBhbmQKd2FpdCBmb3IgTWFy
YydzIGZlZWRiYWNrIG9uIHRoZSBDQU4tRkQgaXNzdWUgYmVmb3JlIGRlY2lkaW5nIHdoZXRo
ZXIKUktDQU5GRF9RVUlSS19DQU5GRF9CUk9LRU4gc2hvdWxkIHN0YXkgZGlzYWJsZWQgZm9y
IFJLMzU4OHYyLgoKVGhhbmtzLApDdW5oYW8gTHU=


