Return-Path: <linux-can+bounces-7953-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2aTlJ7svRmpfLQsAu9opvQ
	(envelope-from <linux-can+bounces-7953-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 11:30:35 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC446F5434
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 11:30:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=yQZDL35m;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7953-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7953-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B622E3024A03
	for <lists+linux-can@lfdr.de>; Thu,  2 Jul 2026 09:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F337C3C98BA;
	Thu,  2 Jul 2026 09:24:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7494399365;
	Thu,  2 Jul 2026 09:24:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984245; cv=none; b=V8vadt4k3QrhGeqbloKLahtXFoZvddFytnv079C8nFdLqPQXcrcYGUmi1J1wge73nsTjCRUnbun/1M7x3rA5dEi8OMdec/x6e0BxlGxWz7Oxd8RWBFHuDilb813tjsVCMBd9wjdOZ8WHl3kwerfuMmOmxbzccSU+qIlNQhTnNuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984245; c=relaxed/simple;
	bh=D4tG8vGW1AFdbEN3gBoFcfO+Fuu2YWofUBpUET6KUuI=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=hx8KVPc8792vPDPVPCQSs6TmFMfLOoSvSpAwLa3EgnuYm7znx14iYSkXxYBQAS40zmYINkEq4pgHlM5Jus+tEwmhNqhhsMLGaFWar+uRjTzFdJ3nLbo9Wcg1gpReQBvktfaHOn5OEnpOVEHP4uD3rRe/c26CNNDnWZ4Mwua8r6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=yQZDL35m; arc=none smtp.client-ip=203.205.221.245
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782984240; bh=D4tG8vGW1AFdbEN3gBoFcfO+Fuu2YWofUBpUET6KUuI=;
	h=From:To:Cc:Subject:Date;
	b=yQZDL35mAvkm6kBetIyJyIqUZPPp1JIwS3EaARZMhWQdDm/s2AlpFZ2gGTPSQzUJs
	 aC+KjkxaR9wTRXqGwuWLCydb0oiAbmgbyNasrZQChiD/IoRJNNQWgfKfuG17EoFwm/
	 lBVcDtHoP5cYini3YwCVsIkGmeDQE75Kulj9hy98=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-XMAILINFO: MdmyWVu0InhAZ7rVzEiuBopvB/DXzTveGbrv4Ra3+pz8TH6fpAts73FgMoATRN
	 ewhsO8kWAqwEkhylcTyJx/7CwQZHX8aK9wuLdT9dufDRlg9HFbtz5VAPmnfpcfQvm9awZ8qXMdbPx
	 6dCweUqRP2YMkYoUcodysalji9/fMiZ1CcYRd2va0crHbwPFHsyxPYNlrVq/djVXiUgo7ylNYWlj9
	 25qO0Hl6IrMBDPQpdBxq6GWPoRwcdEBqxVBBUQHX3P08EmB5zkZJMsKdd1lsGpMpLAfaqDRzsdhk8
	 sPb2654G2RvPo7Gf4ClRf3kYdvMNmxUMUlwSia9JeQaYSX5bk3z7PIYyQ03vaH2dc7S9AyNqGkGV1
	 GLtnbRk7YGyCeK0pFRcubwZV4jRJd5d3HbbK6TBDhKiTBSBGVIZBfdxv2FV+PgwlqZvWlLQ8ZJOTm
	 /8RtqJE7T5hUjJbO0Gaq39j1miIGXgkF54hXS4UiPbilmcKmrGL02ACmTFU1J4CNWMiiB3YeY5+FS
	 RbVfuhygb56pdVuXb8jBxHkO8l3MJfl5SHI/OUU9g0B+HExYxmvleonPYUJn8zIYvjKqI9u/TfgLL
	 feJ6XxiWXQqQjRgklYZdD0jt9Oac3TpVZDWOeC/4vFJegx0/4v/eVLE+Y9xGUL3Q1U3rxvZO6ZbK7
	 /zPFmw9rfv5t2TFu6kAe8Iaz1kThhcLazak27uQupWuQGY4YzOVstg7b3pI0MRIJ+hC9Agng4p1i8
	 5ubFn/A+3EWWx0C4Ry8cvcZx7AIMPCThlz+hxofse2Yo8DR4sY1r17Sf+HwBHrlMd5oIMSAOqrjF9
	 6Afuam1yTrzk4QZvoEM5gPip1+2fXelmG1zTFwsSNt0/WM7bZWlPgx1JValr9jEO4DisIp7M+SM5e
	 9aSG2rGZlOmckrIAhXgMIay9NMivpJYacEvZlj1h9JR/BvpAa/yzjjSYpG99xPq38nE3rE+IGakbF
	 E273dQMKfE82lOxTwCwTvL2w/Uu/TgsFNfnnsQZjm71aVg4gTGbK0ry/98xYWkXVYLyoJm9JxMFKy
	 cuk2J1lci4OV34ezDb8+7k+rwQzrCq8DClOF9A7tPHhD4tu3JMs2TG0TCmCQv3gVABpjHaJtRTQPm
	 MQI=
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
Date: Thu, 2 Jul 2026 17:23:59 +0800
X-Priority: 3
Message-ID: <tencent_C422347432620914231601BC882C7E604D08@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-mid: xmsezb41-0t1782984239t81pl8d8g
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-7953-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_EXCESS_BASE64(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qq.com:dkim,qq.com:mid,qq.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BC446F5434

SGkgTWFyYywKCj4gSXMgdGhlIFNvQyB5b3UncmUgdXNpbmcgYWN0dWFsbHkgYSAndjInIHNp
bGljb24gcmV2aXNpb24/IEF0IGxlYXN0IG9uCj4gdGhlIHJrMzU2OCB0aGUgZG93bnN0cmVh
bSBrZXJuZWwgaGFzIGNvZGUgdG8gcmVhZCB0aGUgcmV2aXNpb24uCgpUaGUga2VybmVsIHJl
cG9ydHMgdGhlIENBTi1GRCBjb250cm9sbGVyIGFzIHJrMzU4OHYyIHJldjIuMjoKCiAgcm9j
a2NoaXBfY2FuZmQgZmVhNjAwMDAuY2FuIGNhbjA6IFJvY2tjaGlwLUNBTkZEIHJrMzU4OHYy
IHJldjIuMiAoZXJyYXRhIDB4MDAwMCkgZm91bmQKICByb2NrY2hpcF9jYW5mZCBmZWE3MDAw
MC5jYW4gY2FuMTogUm9ja2NoaXAtQ0FORkQgcmszNTg4djIgcmV2Mi4yIChlcnJhdGEgMHgw
MDAwKSBmb3VuZAoKRm9sbG93aW5nIHlvdXIgZWFybGllciBmZWVkYmFjaywgSSBoYXZlIGNo
YW5nZWQgdGhlIHYyIHNlcmllcyB0byB1c2UKcm9ja2NoaXAscmszNTg4LWNhbmZkIGluc3Rl
YWQgb2Ygcm9ja2NoaXAscmszNTg4djItY2FuZmQgdW5sZXNzIHdlIGdldAptb3JlIGluZm9y
bWF0aW9uIGFib3V0IFJLMzU4OCBDQU4tRkQgZXJyYXRhIGFuZCBTb0Mgc2lsaWNvbiByZXZp
c2lvbnMKZnJvbSBSb2NrY2hpcC4KCj4gQ29tcGlsZSB0aGUgbGF0ZXN0IGh0dHBzOi8vZ2l0
aHViLmNvbS9saW51eC1jYW4vY2FuLXV0aWxzLyBhbmQgdGVzdDoKPgo+ICQgY2FuZ2VuIGNh
bjAgLUkgMiAtTGkgLURpIC1wIDEwIC1mIC1nIDEgLWMzMiAtYgo+ICQgY2Fuc2VxdWVuY2Ug
LXJ2IGNhbjEgLWYKCkkgdGVzdGVkIHdpdGggY2FuMCBhbmQgY2FuMSBkaXJlY3RseSBjb25u
ZWN0ZWQuIFRoZSBDQU4gY2xvY2sgd2FzCjIwMCBNSHosIGFuZCB0aGUgaW50ZXJmYWNlcyB3
ZXJlIGNvbmZpZ3VyZWQgYXMgZm9sbG93czoKCiAgaXAgbGluayBzZXQgY2FuMCBkb3duCiAg
aXAgbGluayBzZXQgY2FuMCB0eXBlIGNhbiBiaXRyYXRlIDUwMDAwMCBzYW1wbGUtcG9pbnQg
MC44IGRiaXRyYXRlIDEwMDAwMDAgZHNhbXBsZS1wb2ludCAwLjggZmQgb24KICBpcCBsaW5r
IHNldCBjYW4wIHVwCgogIGlwIGxpbmsgc2V0IGNhbjEgZG93bgogIGlwIGxpbmsgc2V0IGNh
bjEgdHlwZSBjYW4gYml0cmF0ZSA1MDAwMDAgc2FtcGxlLXBvaW50IDAuOCBkYml0cmF0ZSAx
MDAwMDAwIGRzYW1wbGUtcG9pbnQgMC44IGZkIG9uCiAgaXAgbGluayBzZXQgY2FuMSB1cAoK
V2l0aG91dCBCUlMsIHRoaXMgdGVzdCByYW4gZm9yIDE1IG1pbnV0ZXMgd2l0aG91dCBwcm9i
bGVtczoKCiAgY2FuZ2VuIGNhbjAgLUkgMiAtTGkgLURpIC1wIDEwIC1mIC1nIDEgLWMzMgoK
V2l0aCBCUlMgZW5hYmxlZDoKCiAgY2FuZ2VuIGNhbjAgLUkgMiAtTGkgLURpIC1wIDEwIC1m
IC1nIDEgLWMzMiAtYgoKdGhlIHRlc3Qgb25seSB3b3JrZWQgd2hlbiBkYml0cmF0ZSB3YXMg
ZXF1YWwgdG8gYml0cmF0ZSwgZm9yIGV4YW1wbGUKd2l0aCBib3RoIHNldCB0byAxTS4gSWYg
ZGJpdHJhdGUgZGlmZmVyZWQgZnJvbSBiaXRyYXRlLCB0aGUKY29udHJvbGxlciB3ZW50IGJ1
cy1vZmYgaW1tZWRpYXRlbHkuCgpTbyBteSBjdXJyZW50IGNvbmNsdXNpb24gaXMgdGhhdCBD
QU4tRkQgaXRzZWxmIHdvcmtzIG9uIFJLMzU4OCwgYnV0IHRoZQpzdXBwb3J0IGFwcGVhcnMg
aW5jb21wbGV0ZTogdXNpbmcgYSBmYXN0ZXIgZGF0YSBwaGFzZSB3aXRoIEJSUyBkb2VzIG5v
dAp3b3JrIGluIG15IHNldHVwLgoKVGhpcyBsb29rcyBkaWZmZXJlbnQgZnJvbSB0aGUgaXNz
dWUgZGVzY3JpYmVkIGJ5IHRoZSBjdXJyZW50ClJLQ0FORkRfUVVJUktfQ0FORkRfQlJPS0VO
IGNvbW1lbnQuIFRoYXQgcXVpcmsgaXMgYWJvdXQgc3BlY2lmaWMKQ0FOLUZEIGZyYW1lcyB0
cmlnZ2VyaW5nIEVycm9yIEludGVycnVwdCBvciBFcnJvci1XYXJuaW5nIGR1cmluZwpyZWNl
cHRpb24uIEluIG15IHRlc3QgdGhlIG5vbi1CUlMgQ0FOLUZEIGZyYW1lcyB3b3JrLCB3aGls
ZSB0aGUgZmFpbHVyZQppcyB0aWVkIHRvIHVzaW5nIEJSUyB3aXRoIGEgZGF0YSBiaXRyYXRl
IGRpZmZlcmVudCBmcm9tIHRoZSBub21pbmFsCmJpdHJhdGUsIHdoaWNoIGltbWVkaWF0ZWx5
IGRyaXZlcyB0aGUgY29udHJvbGxlciBidXMtb2ZmLgoKR2l2ZW4gdGhpcyByZXN1bHQsIHNo
b3VsZCBJIHN0aWxsIGtlZXAgQ0FOLUZEIGRpc2FibGVkIGZvciBSSzM1ODgsIG9yIGlzCml0
IGFjY2VwdGFibGUgdG8gZW5hYmxlIENBTi1GRCBidXQgZG9jdW1lbnQgdGhhdCBCUlMgd2l0
aCBhIGZhc3RlciBkYXRhCnBoYXNlIGlzIGN1cnJlbnRseSBub3Qgd29ya2luZz8KClRoYW5r
cywKQ3VuaGFvIEx1


