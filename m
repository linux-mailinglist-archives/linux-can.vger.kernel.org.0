Return-Path: <linux-can+bounces-7943-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DK8kA3YSRWrj6QoAu9opvQ
	(envelope-from <linux-can+bounces-7943-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 01 Jul 2026 15:13:26 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA636EDE92
	for <lists+linux-can@lfdr.de>; Wed, 01 Jul 2026 15:13:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=hCjy7Uh0;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7943-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7943-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C1B6337C3B9
	for <lists+linux-can@lfdr.de>; Wed,  1 Jul 2026 12:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0354A1399;
	Wed,  1 Jul 2026 12:29:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D3E4A138D;
	Wed,  1 Jul 2026 12:29:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908977; cv=none; b=VLbOdtOX+/sqmXmO7H9LmKdgguyjc7C2cf6+gwpgR6ITlqtCvXIA9NOinx4bf8l6oi2nZU3CrgbEmhiJGbbSb2pdlhFSdC37lGrV/+2izlZlmlp/vZP+AZmQx7aFh6aivHirQHFWvg7O+Ai1d6AXZWsP63EWjieseQ8q8MbCpQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908977; c=relaxed/simple;
	bh=vFMix5jjhR7CuzRHrIrbVr963oFYqy5Wi9Dt2KRuMXo=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=DdIDjzwN/FwbN2Z4POgtus7Woyy3E3k62JLl7QUQvdtLfGewIvjrY0OnlOUbYa3YeZ2PKNsaPp/4BmZckeIN74rjW+Ul38h6b9O35W1se1oecAA2FV1wBuSnGWZgXz98tXF7aeT7t5T0QRFcInDVDco4pAJvHr8yq1Cx/7CIdBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hCjy7Uh0; arc=none smtp.client-ip=162.62.57.137
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782908965; bh=vFMix5jjhR7CuzRHrIrbVr963oFYqy5Wi9Dt2KRuMXo=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=hCjy7Uh0cBMtP8derjlGLRzEEXOJtvhlC+H85NdHJwQMkeJkGIEcu6s7DsekJ/zuz
	 uAfhpCMSZVKnfWG/yhC0hh//tuYLF8D/wKVz1aFly2uZbRpMdUgFsjjh1Ey4sBgqH6
	 cetm/QRcdiDTeCIoLYbNcw+prtbr2WAizWIq+i4E=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-XMAILINFO: M0br9f/jyDWJRwU2R/Y3fvOY8mFCAJQk4lt4V9BBWTZ2xvRTvDhO2Gu5Z+nDsb
	 tWjKraDb/+FxIs7nrb6N6op9DWQhpss4qO5vFlEduJ49SWQaGH0FbY8hY3UMckWHV7MgJM9pgn3bf
	 spM9U+eKNKr7FyWgcoQYMUJWiBJW+6xcZ8/i8l7y3SWjk5a9+cbDqRyVZMItQgz8cVYokvlpup9zs
	 bxvnA/iWhPzwpX1GVwIm2wMD/fLAoQUz9i+nSO/JYP6RthJYRKPW05kT4ihVaMvNwL1mYmlNXg3sZ
	 tCShDBuxEWJ/+ftVWrhaVmHsDjsmQL4UP9owHXca7FkiHN2tgedM24moVaXrXTsnZTObq5MfqLMzO
	 KxCkPYPG5344KbRHFaYiwAzRioN7sx/M3fhT7iI8BvuRDUpkNP3xy/JnS/b/J+sahA+hSkMK2dufx
	 gduWGnfxf1DXs/BcH9ofK0WCo05f/FGAkwFvzIPe+Z5AJGoJ0Ja27uOHQha9QdM2f1a+KVhHlvNfY
	 3cgm7JcjmE29xuz8OiC1jjYGF05rsuY+M8KgzguJ1AuVJHB9V9Yjpx4NP504CF8JVFTAqv/uoZmIc
	 Lf/hpukp2x1bUKqPHoT+NakXTvFk2eDB5m6TyyZFl4Mf/jsmblckHPjdW5uKd/XDjFGtfvRe8Aj9b
	 FG/uWvDOMqsAN4Sw3JJv4ByoDKoyaHK+Guk+8qXPyV6PiWrrNGuL07qMvvJN0jG6mIymFkj2JJSf1
	 O60uHKua+/4qflhSnucQ0kSZO076IzCxE3tj7BE47pMUfYEp17KMMrgaDorC/i+hyIhCp4aIOtY0e
	 PvPsNAls4ePgtAs9rcnxRQzaI8ygkFP3O8nuUl2GO59PktnXtdtyZedgj7q5eIxRMUjzIRkThzFxQ
	 z9fY4xi5Hd6myM+X9SZzOT8ZHE6GMDEeGQtQfgaVBJZ126bsLoMVlb5Mr5wAjKnYiidYPXE6qfZWY
	 DS0oLnB7Lp6WU+w75sMzYNfeGxn5994Xap9d0wNefwa5ggen7VdxbfdQnjxx+h+KTyNeFT0bgpcUp
	 7LkzD2ItDKQcVx2WmKcQkzlLEr+vf6iSDe39dgdlZrBuKxLc=
From: "=?utf-8?B?8J+Sqy4yMjA=?=" <1579567540@qq.com>
To: "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>, "=?utf-8?B?aGVpa28=?=" <heiko@sntech.de>
Cc: "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bWFpbGhvbA==?=" <mailhol@kernel.org>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?cm9iaA==?=" <robh@kernel.org>, "=?utf-8?B?a3J6aytkdA==?=" <krzk+dt@kernel.org>, "=?utf-8?B?Y29ub3IrZHQ=?=" <conor+dt@kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
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
Date: Wed, 1 Jul 2026 20:29:22 +0800
X-Priority: 3
Message-ID: <tencent_AF88C27E354DFF34B132BC0906236A01A408@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20260701070128.2096267-1-1579567540@qq.com>
 <tencent_124D6134EB32480979234201E688087E5408@qq.com>
 <2064877.jZfb76A358@diego>
	<20260701-flashy-crocodile-of-flowers-a6a23e-mkl@pengutronix.de>
In-Reply-To: <20260701-flashy-crocodile-of-flowers-a6a23e-mkl@pengutronix.de>
X-QQ-mid: xmsezb41-0t1782908962t510hyevl
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	TO_EXCESS_BASE64(1.50)[];
	CC_EXCESS_BASE64(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-7943-lists,linux-can=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FREEMAIL_FROM(0.00)[qq.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:dkim,qq.com:mid,qq.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEA636EDE92

SGkgSGVpa28sIE1hcmMsCgp0aGFua3MgZm9yIHRoZSByZXZpZXcuCgo+IHBsZWFzZSB1c2Ug
YSByZWFsIG5hbWUsIG5vdCBhbiBhbGlhcy4KCkkgd2lsbCB1c2UgbXkgcmVhbCBuYW1lIGlu
IGZ1dHVyZSByZXZpc2lvbnMuCgo+IEZ1bm5pbHkgZW5vdWdoLCB3ZSBzZWVtIHRvIGhhdmUg
d29ya2VkIG9uIHRoZSBzYW1lIHRvcGljCj4gYXQgdGhlIHNhbWUgdGltZSA6LSkKPgo+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNjA2MzAxNjQzMzYuMzQ0NDU1MC0xLWhl
aWtvQHNudGVjaC5kZS8KCkkgbWlzc2VkIEhlaWtvJ3Mgc2VyaWVzIGJlZm9yZSBzZW5kaW5n
IG1pbmUsIHNvcnJ5IGZvciB0aGUgbm9pc2UuCihCdXQgaXQgcmVhbGx5IGlzIGEgdmVyeSBp
bnRlcmVzdGluZyBjb2luY2lkZW5jZS4pClNpbmNlIHRoZSBzZXJpZXMgb3ZlcmxhcCwgSSBh
bSBoYXBweSB0byBiYXNlIGZ1cnRoZXIgd29yayBvbiBIZWlrbydzCnNlcmllcywgb3IgdG8g
bGV0IEhlaWtvIGZvbGQgdGhlIFJLMzU4OCBSWF9GSUZPX0NOVCBiaXRmaWVsZCBjaGFuZ2Ug
aW50bwpoaXMgdjIgaWYgdGhhdCBpcyBwcmVmZXJyZWQuCgo+IEhlcmUgSSBjb3VsZCByZXBy
b2R1Y2UgZXJyYXR1bSA2IHRob3VnaDoKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21s
LzIwMjYwNjMwMTY0MzM2LjM0NDQ1NTAtNC1oZWlrb0BzbnRlY2guZGUvCgpUaGFua3MgZm9y
IHBvaW50aW5nIHRoaXMgb3V0LiBNeSBsb2NhbCB0ZXN0IHNldHVwIGRpZCBub3QgcmVwcm9k
dWNlIGl0LApidXQgZ2l2ZW4gSGVpa28ncyByZXN1bHQgSSBhZ3JlZSB0aGF0IFJLMzU4OHYy
IHNob3VsZCBrZWVwIHRoZSBlcnJhdHVtIDYKd29ya2Fyb3VuZCBlbmFibGVkLiBJZiBJIHJl
c3BpbiB0aGlzIHNlcmllcywgSSB3aWxsIHJlbW92ZSB0aGUgIm5vdApyZXByb2R1Y2VkIiBz
dGF0ZW1lbnQgYW5kIGVuYWJsZSBSS0NBTkZEX1FVSVJLX1JLMzU2OF9FUlJBVFVNXzYgZm9y
ClJLMzU4OHYyLgoKPiBUaGUgIlJvY2tjaGlwIFJLMzU4OCBUUk0gVjEuMC1QYXJ0MS0yMDIy
MDMwOS5wZGYiIGRhdGFzaGVldCBzYXlzIGJpdHMKPiAiNzo1IiBhcmUgUlhfRklGT19GUkFN
RV9DTlQsIHdoaWxlIGJpdCAiNiIgaXMgbWFya2VkIGFzIHJlc2VydmVkLgoKRm9yIFJYX0ZJ
Rk9fQ05ULCBJIGZvdW5kIHRoZSBiaXRmaWVsZCBkaWZmZXJlbmNlIGJ5IHJlYWRpbmcgUm9j
a2NoaXAncwp2ZW5kb3Iga2VybmVsIDYuMSBkcml2ZXIgYW5kIGNvbXBhcmluZyB0aGUgQ0FO
IHN1cHBvcnQgZm9yIFJLMzU2OCBhbmQKUkszNTg4LiBUaGUgdmVuZG9yIGRyaXZlciB1c2Vz
IGRpZmZlcmVudCBSWCBGSUZPIGNvdW50IGJpdGZpZWxkcyBmb3IgdGhlCnR3byBTb0NzLCBh
bmQgbXkgdGVzdGluZyBvbiBSSzM1ODh2MiBhbHNvIGluZGljYXRlcyB0aGF0IGJpdHMgNzo1
IGFyZQpuZWVkZWQuIEkgY2FuIGFkZCBhIHNob3J0IG5vdGUgYWJvdXQgdGhpcyBpbiB0aGUg
Y29tbWl0IG1lc3NhZ2Ugb3IKY29kZSBjb21tZW50LgoKT25lIG1vcmUgcXVlc3Rpb24gYWJv
dXQgUktDQU5GRF9RVUlSS19DQU5GRF9CUk9LRU46IGluIG15IFJLMzU4OHYyIHRlc3QKc2V0
dXAgdGhlIHR3byBrbm93biBDQU4tRkQgdHJpZ2dlciBmcmFtZXMgZGlkIG5vdCBjYXVzZSBh
biBFcnJvcgpJbnRlcnJ1cHQgb3IgRXJyb3ItV2FybmluZy4gSSBhbHNvIHJhbiBhIDEyIGhv
dXIgQ0FOLUZEIHN0cmVzcyB0ZXN0IHdpdGgKY2FuMC9jYW4xIGRpcmVjdGx5IGNvbm5lY3Rl
ZCwgMjAwIE1IeiBDQU4gY2xvY2ssIDUwMCBrYml0L3Mgbm9taW5hbApiaXRyYXRlIGFuZCAx
IE1iaXQvcyBkYXRhIGJpdHJhdGUuIFRoYXQgdGVzdCBpbmNsdWRlZCBwZXJpb2RpYwp0cmFu
c21pc3Npb24gb2YgdGhlIHR3byBDQU5GRF9CUk9LRU4gZnJhbWVzLCB2YXJpYWJsZSBETEMg
Q0FOLUZEIGZyYW1lcywKQ0FOLUZEK0JSUytFRkYgbG9hZCwgYW5kIGEgY2FuZmR0ZXN0IHJ1
biB3aXRoIDE5LDQxNywxMjkgZnJhbWVzIHdpdGhvdXQKZGF0YSBtaXNtYXRjaC4KCldvdWxk
IGl0IG1ha2Ugc2Vuc2UgdG8gbGVhdmUgUktDQU5GRF9RVUlSS19DQU5GRF9CUk9LRU4gZGlz
YWJsZWQgZm9yClJLMzU4OHYyLCBvciBoYXZlIHlvdSBzZWVuIHRoaXMgaXNzdWUgb24gUksz
NTg4IGFzIHdlbGw/CgpUaGFua3MsCkN1bmhhbyBMdQo=


