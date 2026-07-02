Return-Path: <linux-can+bounces-7956-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LWW7MStgRmpTSAsAu9opvQ
	(envelope-from <linux-can+bounces-7956-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 14:57:15 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 090576F7FF5
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 14:57:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=azV2hz4t;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7956-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7956-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A68FC30B30D3
	for <lists+linux-can@lfdr.de>; Thu,  2 Jul 2026 12:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56802480DD0;
	Thu,  2 Jul 2026 12:46:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EF747ECE6;
	Thu,  2 Jul 2026 12:46:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996411; cv=none; b=h/FlKdh0+jShIAnK+ZQjrfQU2H8kf02v7/hmddcf2SYxIyhhL4iuSRrZX0e/NsSsQDS+jW4wFoWDlQaZ66801IwWeOUpCTeNbAQmB+or0t7jJPnQBQr89woWVkTqgza2m4z7XaoeiiIyi0NTypXgdmYzEUDvdviuylfct1oy1ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996411; c=relaxed/simple;
	bh=cZ82wpzG4dEDpgB0onYrYhbBV1XpTLYDCKUM8jFjHJ8=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=b/Lh3JRpg9zQ64dx/iQAbOxq828oBBBEZyICOEWbWjFTOLGXFjFhE1w8Jds81L7QCHpa3e9A29X62iBEv0gT0mbgJ/tB2MkzU/CztDmbr3dbgvRQZd2G0q+cVxoIadf5yLeAwECB5bsyM+pEAdyoFTSDQaIwQol9QKFzXQD6wIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=azV2hz4t; arc=none smtp.client-ip=203.205.221.191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782996401; bh=cZ82wpzG4dEDpgB0onYrYhbBV1XpTLYDCKUM8jFjHJ8=;
	h=From:To:Cc:Subject:Date;
	b=azV2hz4tgzVRPzqUT1cmejO8zhXMUF+PRp5a0TeWOS3nj3nJsAknPEBmkV5OcSaza
	 tYWDF9PoWx2dX14KRA/UHEOCKBwVCZ5bWPc52ThbhhOaXk8Rm5agePaGLplcsDS7Em
	 7kAYtamYNHRiwhXD7rahRxO1sCW4NaNaqmnXH1iE=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-XMAILINFO: McF9JvsryK5JD7mWECZX57rL5Rprn8Mk7XTA5UJtsp7kYfow6fxNMQoWuwoNn4
	 tVNny0O4V2vpwvGzR8je738IRA73nQ9hA5I5rcMIdTzKVx9EGI1zSQxUlfeg6uNX6coG0Lu0rFrZM
	 Gc2hC1WBmGJS+vZOXQnEEGnrm3PJhaq8gTjLC79BGpyYMM6oSPKeefpCufewFwvgu816KhSivasKC
	 68Zm4+ENlNp2iAdgXSsvyjHmLAhVgSS5v5+CYo38hQpEHAmCY2sDnrhqddBJdT7NNRIGbixFpLUjD
	 7NjyU0kZnFNrO+mnW28uCsZf5ezJwS7kFne5/aQb7ulFhvU9VtxmokbMXBZtQmtMjKf/CtnlPUcRc
	 QMa8jw7A4oA0xECBhNx5+oZqpPVFqOX7uBs1MkcJqDhCl+1pA8y129xhO6bP4x+iCk+kkoh1P70/Y
	 xflsNu4w6e6HRkDFDjzwxHKVdlW7H9IoqWwEslXZxxqYOOnqe3SyMTwZNW3w0CVtKtToykPYHT0Yn
	 kLqkw4s2narZarifHngjrPdFqkge1/1F5HLpjdTxMC2oE3M49xXGn/5M4203ckggz17/d+QEl7IGX
	 mO1VZSp2i1skxVN+4QK+AgcRnH+1jGkdpv8yh4aBSkxfrcn2MMaYhahjahYtxpyrmR8ZovLKRFd3q
	 Gw+/UVFPGGE0JAqe1dLgGYJRRDaCe14wQdiBGlCfzqsqN18MDsA3EU33ecHvh6ggTce5K1E5sLzNB
	 lcvu2q5VJ08cW4lhqGpEchzKAobjVkEltnK4ZZozgEzKxT3UaHIpH2OBBXolwM6/U/m/lp4VJJq8y
	 2tzifYVJXW9X/BPK6fNpVd7iiMmbIrOYzhtAmTETMByvXutnrPpEJ02/pu3/sUS6wB0iW0B/MbO1c
	 OKm6WYyr4dBRmA7AMjJtV/fifAnIdaE8R9gqLQPfD/nqsI2TxO2XU1iRkEeiMQ9JwlJB2QEIgdVWh
	 ix/6ITZu4TUSDeQcfFBcwXRnTzupl1aSIoKu0GS6FBL8kFlI3DzzZBijXcnkyg4in4sDL6FxBxPT5
	 ddNgfrREJIzrdxV1gFatoJa7EzOOHwf6iAM/phNxLQMe3rNzg+YD+R9SdvA==
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>
Cc: "=?utf-8?B?aGVpa28=?=" <heiko@sntech.de>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bWFpbGhvbA==?=" <mailhol@kernel.org>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?cm9iaA==?=" <robh@kernel.org>, "=?utf-8?B?a3J6aytkdA==?=" <krzk+dt@kernel.org>, "=?utf-8?B?Y29ub3IrZHQ=?=" <conor+dt@kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
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
Date: Thu, 2 Jul 2026 20:45:27 +0800
X-Priority: 3
Message-ID: <tencent_2AA2119D8067447DBFA826619A5419878407@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-mid: xmsezb41-0t1782996327t5ajzis1k
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:heiko@sntech.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:kernel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	TAGGED_FROM(0.00)[bounces-7956-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_EXCESS_BASE64(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qq.com:dkim,qq.com:mid,qq.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 090576F7FF5

SGkgTWFyYywKCnRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLgoKPiBUaGVuIENBTi1GRCBpcyBi
cm9rZW4uIDovCj4KPiBNYXliZSBpbiBhIGxhdGVyIHBhdGNoIHdlIGNhbiBoYWNrIHNvbWV0
aGluZywgdG8gYWxsb3cgd29ya2luZwo+IGNvbmZpZ3VyYXRpb25zLgoKVW5kZXJzdG9vZC4g
SSB3aWxsIGtlZXAgQ0FOLUZEIGRpc2FibGVkIGZvciBSSzM1ODggaW4gdjIuCgpJIHdpbGwg
YWxzbyB0cnkgdG8gaW52ZXN0aWdhdGUgd2hldGhlciB0aGUgZmFpbGluZyBCUlMvZGF0YS1w
aGFzZSBzZXR1cApjYW4gYmUgZml4ZWQuIElmIEkgY2FuIGZpbmQgYSBwcm9wZXIgZml4LCBJ
IHdpbGwgc2VuZCBpdCBhcyBhIGZvbGxvdy11cApwYXRjaCBpbnN0ZWFkIG9mIG1peGluZyBp
dCBpbnRvIHRoaXMgdjIgc2VyaWVzLgoKPiBDYW4geW91IHVwZGF0ZSB0aGUgZGVzY3JpcHRp
b24gb2YgdGhlIHF1aXJrIGZvciB0aGUgcmszNTg4IGFuZCBhZGQgaG93Cj4gdG8gcmVwcm9k
dWNlIGl0PwoKWWVzLiBJIHdpbGwgdXBkYXRlIHRoZSBSSzM1ODggcXVpcmsgZGVzY3JpcHRp
b24gYW5kIGFkZCB0aGUgcmVwcm9kdWNlCnN0ZXBzIGZvciB0aGUgQlJTL2RhdGEgYml0cmF0
ZSBpc3N1ZS4KCj4gUGxlYXNlIGtlZXAgaXQgZGlzYWJsZWQgZm9yIG5vdy4KCkkgd2lsbCBr
ZWVwIFJLQ0FORkRfUVVJUktfQ0FORkRfQlJPS0VOIGVuYWJsZWQgZm9yIFJLMzU4OCBpbiB2
Miwgc28KQ0FOLUZEIHN0YXlzIGRpc2FibGVkIGZvciBub3cuCgpUaGFua3MsCkN1bmhhbyBM
dQ==


