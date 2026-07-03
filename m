Return-Path: <linux-can+bounces-7981-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E1ahA71LR2qHVgAAu9opvQ
	(envelope-from <linux-can+bounces-7981-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 03 Jul 2026 07:42:21 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B416FECA8
	for <lists+linux-can@lfdr.de>; Fri, 03 Jul 2026 07:42:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=CQWXqKrY;
	dmarc=pass (policy=quarantine) header.from=qq.com;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7981-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7981-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C82A7301348F
	for <lists+linux-can@lfdr.de>; Fri,  3 Jul 2026 05:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446AB344DB9;
	Fri,  3 Jul 2026 05:42:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E7C344DA2;
	Fri,  3 Jul 2026 05:42:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057326; cv=none; b=rqSoEPn9hIW/63HgITjZtOo6wcuONaMKveOowdMoY9tO2o8IHVQwdtmePtZU1FtFoJa3rMoeF9YpBOyEZFPk3jgecEo2+6dL5Eu0qvZ/AZ+SLCWxJAd/UqK2g1d+oE0V4Lk4acql8h6lPjVBXDgOvYPUjcbyQA39Jr/+yun7kKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057326; c=relaxed/simple;
	bh=ViqeHQLIZm0HWnSQexz4QSSM3m74KlPcBjrXGGI/Zew=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=u/OuaMFzFCUnDfnCVUhJ7QJvZ7L55O8ZplY8V4dv2ZFHTgR5Njm7sfTwEoNT761S2VyWx3dUalItmQHoeLA/xktgVdxCv1NbbnWhHoWK+vYq3ErGmahwsNbzzFQlu8AWeClrI5pZrJuRFOh1II0bxbsSq/hu+nIi73gTFSLh4vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=CQWXqKrY; arc=none smtp.client-ip=203.205.221.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783057321; bh=ViqeHQLIZm0HWnSQexz4QSSM3m74KlPcBjrXGGI/Zew=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=CQWXqKrY4WQhgdQBLj533cjlb+QPOFKlA+nk7B29YRJpZHOzSGQ5UwbsSvwogneYp
	 QCxKZhizxjkhHXVSQQn7BGj3npq5XMTr0FiJeiTUN3gvWB/7SWdGdefwMlEM3HiwBX
	 Wx6E7mvv1ZbTej5eiu2+j4EF/yjJtMc168HVlB8I=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-XMAILINFO: NBGkhoQ8491PceFq1cOFzrfl6cKUIB8C33gPhPjpIur5KR6W4qQ36+vEohq5KR
	 bGdPokva9jQxNFgyFb/Zf7kJsbkoCTODLj1Ke5p61gsjsGiPaOtkQRAoy8rTCxyxhTQBeyF4FyekY
	 73uyxaZdMdqFI7Jl2f5fEXgEpQ7iHLRhj8RYcUPHTcgRxcUeW9fRW1PTfkFEyRana+WCTkY59rzDR
	 g6UrARgeeGGpdn0MnE2YlkwPNTAlY00I+LWHGJ8px+WsUjOPZ6HWKHOgVfP+IMuX6uf3BE2sFRvGS
	 neN000bWmA4Wij4iPe40l6Ws6vXyQdJb7uXiXK0oHo95zQX8OdXrnfPkwiKtZPPJqZHlMckh01EYC
	 ucInO8HwwMzap+1YxiYdIn/7045WcXw10f4K5giaLoQYOuV3+jRo4yvqGQn1gFQR99zcY66QLSFE7
	 20jumZIl0hj9PZAaROjipkFpJkO7egEuVUYVCqwn/tT6XaohVH7uEHQz9CiGMSBpNfNnIBB2ui0qs
	 cmPeL91PvOzPlTzOvm1c3pTE1WPFRkQxoYaOM8KAuaLlasY5ka+a1wUZYLZ4HTr3PDAF5DLZ1MBtm
	 kinXWMzb/vk70AAncpcacO2fP3L+Dik6eoFOqOiCbrvATDNGMnyx2IjidKt9zDNNte8Iz3+QXQY9n
	 sbBZKvq4koPVTzwCrQRVxMa3SYIbrnm239E5uLbcUoHZ0p58gIzrNbHhTSI8yEsbzKzmEHcPETB6r
	 4IxMDbcPNnMViUec9Imsp3INKPJB0XILlV1tJNTuPSK/FPLdRr61NRuQ8JxE8lO1mFqy7AZ8ZaLi2
	 0Ot49k1RHzqYSc3R/6sINM4QRtUCHGVuwiKecEBQnJr9LbmuHAsSy0MR1UEO/IYSg0lCjGNaoHQIf
	 VWzhEtLME08xFBylTHtFCPSVjlwDAgUZFE3oON548mTfQM+pznObBLQqvf8hz1zOYNsnwG879O6Mc
	 zByhMCrKwY0j6yEU/5C3APaP83efQcIBh2A3clfa5z//GdGkpYRLoWoQ5gdDWMCXVXxZERPF9nvnL
	 1eNJgVWsctkAx9cQxC9j3D9aeYihMb7ZVDXIg
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
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
Date: Fri, 3 Jul 2026 13:41:59 +0800
X-Priority: 3
Message-ID: <tencent_358CC86827C08D8405142316F9053629D00A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_C422347432620914231601BC882C7E604D08@qq.com>
	<20260702-accelerated-shoebill-of-elevation-76f536-mkl@pengutronix.de>
In-Reply-To: <20260702-accelerated-shoebill-of-elevation-76f536-mkl@pengutronix.de>
X-QQ-mid: xmsezb41-0t1783057319tq7q6pl5z
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	TO_EXCESS_BASE64(1.50)[];
	CC_EXCESS_BASE64(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
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
	TAGGED_FROM(0.00)[bounces-7981-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_EXCESS_BASE64(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1B416FECA8

SGkgTWFyYywKCj4gVGhlbiBDQU4tRkQgaXMgYnJva2VuLiA6Lwo+Cj4gTWF5YmUgaW4gYSBs
YXRlciBwYXRjaCB3ZSBjYW4gaGFjayBzb21ldGhpbmcsIHRvIGFsbG93IHdvcmtpbmcKPiBj
b25maWd1cmF0aW9ucy4KCkkgZGlkIHNvbWUgbW9yZSB0ZXN0cyBhbmQgZm91bmQgdGhhdCB0
aGUgaW1tZWRpYXRlIGJ1cy1vZmYgd2l0aCBCUlMgaXMKcmVsYXRlZCB0byB0aGUgdHJhbnNt
aXQgZGVsYXkgY29tcGVuc2F0aW9uIHNldHRpbmcuCgpBZnRlciBzZXR0aW5nIFJLQ0FORkRf
UkVHX1RSQU5TTUlUX0RFTEFZX0NPTVBFTlNBVElPTiB0byAwLCBpLmUuCmRpc2FibGluZyBU
REMsIENBTi1GRCB3aXRoIEJSUyB3b3JrcyBvbiBSSzM1ODggaW4gbXkgc2V0dXAuIEkgdGVz
dGVkIHRoZQpzYW1lIGNvbW1hbmQgd2l0aCA1MDAga2JpdC9zIGFyYml0cmF0aW9uIGJpdHJh
dGUgYW5kIDEsIDMgYW5kIDUgTWJpdC9zCmRhdGEgYml0cmF0ZS4KClRoZSA1IE1iaXQvcyBk
YXRhIHBoYXNlIHRlc3Qgc2V0dXAgd2FzOgoKICBDQU4gY2xvY2s6IDMwMCBNSHoKICBjYW4w
IDwtPiBjYW4xIGRpcmVjdGx5IGNvbm5lY3RlZAogIG5vIG90aGVyIGRldmljZXMgb24gdGhl
IGJ1cwogIGJ1cyB0ZXJtaW5hdGlvbjogNjAgT2htCgogIGlwIGxpbmsgc2V0IGNhbjAgdHlw
ZSBjYW4gYml0cmF0ZSA1MDAwMDAgc2FtcGxlLXBvaW50IDAuOCBkYml0cmF0ZSA1MDAwMDAw
IGRzYW1wbGUtcG9pbnQgMC44IGZkIG9uIGJlcnItcmVwb3J0aW5nIG9uCiAgaXAgbGluayBz
ZXQgY2FuMSB0eXBlIGNhbiBiaXRyYXRlIDUwMDAwMCBzYW1wbGUtcG9pbnQgMC44IGRiaXRy
YXRlIDUwMDAwMDAgZHNhbXBsZS1wb2ludCAwLjggZmQgb24gYmVyci1yZXBvcnRpbmcgb24K
CiAgY2FuZ2VuIGNhbjAgLUkgMiAtTGkgLURpIC1wIDEwIC1mIC1nIDEgLWMzMiAtYgogIGNh
bnNlcXVlbmNlIC1ydiBjYW4xIC1mCgpUaGUgdGVzdCByYW4gZm9yIDE1IG1pbnV0ZXMuIFRo
ZSByZWNlaXZlciByZXBvcnRlZCBjb250aW51b3VzIHNlcXVlbmNlCndyYXAtYXJvdW5kIG1l
c3NhZ2VzLCBlLmcuOgoKICBzZXF1ZW5jZSB3cmFwIGFyb3VuZCAoMCkKICBzZXF1ZW5jZSB3
cmFwIGFyb3VuZCAoMSkKICAuLi4KICBzZXF1ZW5jZSB3cmFwIGFyb3VuZCAoMzcyMTgpCiAg
c2VxdWVuY2Ugd3JhcCBhcm91bmQgKDM3MjE5KQoKVGhlIGludGVyZmFjZSBzdGF0aXN0aWNz
IGFmdGVyIHRoZSB0ZXN0IHdlcmU6CgogIGNhbjA6CiAgICAgICAgICAgIHJlLXN0YXJ0ZWQg
YnVzLWVycm9ycyBhcmJpdC1sb3N0IGVycm9yLXdhcm4gZXJyb3ItcGFzcyBidXMtb2ZmCiAg
ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAg
MCAgICAgICAgICAwCiAgICAgIFJYOiAgYnl0ZXMgcGFja2V0cyBlcnJvcnMgZHJvcHBlZCAg
bWlzc2VkICAgbWNhc3QKICAgICAgIDE1MDY2NzM1NiA5NTI4Mzc3ICAgICAgMCAgICAgICAw
ICAgICAgIDAgICAgICAgMAogICAgICBUWDogIGJ5dGVzIHBhY2tldHMgZXJyb3JzIGRyb3Bw
ZWQgY2FycmllciBjb2xsc25zCiAgICAgICAxNTA2NjczNTYgOTUyODM3NyAgICAgIDAgICAg
ICAgMCAgICAgICAwICAgICAgIDAKCiAgY2FuMToKICAgICAgICAgICAgcmUtc3RhcnRlZCBi
dXMtZXJyb3JzIGFyYml0LWxvc3QgZXJyb3Itd2FybiBlcnJvci1wYXNzIGJ1cy1vZmYKICAg
ICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAw
ICAgICAgICAgIDAKICAgICAgUlg6ICBieXRlcyBwYWNrZXRzIGVycm9ycyBkcm9wcGVkICBt
aXNzZWQgICBtY2FzdAogICAgICAgMTUwNjY3MzU2IDk1MjgzNzcgICAgICAwICAgICAgIDAg
ICAgICAgMCAgICAgICAwCiAgICAgIFRYOiAgYnl0ZXMgcGFja2V0cyBlcnJvcnMgZHJvcHBl
ZCBjYXJyaWVyIGNvbGxzbnMKICAgICAgICAgICAgICAgMCAgICAgICAwICAgICAgMCAgICAg
ICAwICAgICAgIDAgICAgICAgMAoKVGhlcmUgd2VyZSBubyBidXMgZXJyb3JzIGFuZCBubyBi
dXMtb2ZmIGV2ZW50cyBpbiB0aGlzIHRlc3QuCgo+IENhbiB5b3UgdXBkYXRlIHRoZSBkZXNj
cmlwdGlvbiBvZiB0aGUgcXVpcmsgZm9yIHRoZSByazM1ODggYW5kIGFkZCBob3cKPiB0byBy
ZXByb2R1Y2UgaXQ/CgpXaXRoIFREQyBkaXNhYmxlZCBJIGNhbm5vdCByZXByb2R1Y2UgdGhl
IEJSUyBidXMtb2ZmIHByb2JsZW0gYW55bW9yZS4KVGhpcyBhbHNvIGxvb2tzIGRpZmZlcmVu
dCBmcm9tIFJLQ0FORkRfUVVJUktfQ0FORkRfQlJPS0VOLCBzbyBJIGRvIG5vdAp0aGluayBS
SzM1ODggc2hvdWxkIHVzZSB0aGF0IHF1aXJrLgoKPiBQbGVhc2Uga2VlcCBpdCBkaXNhYmxl
ZCBmb3Igbm93LgoKR2l2ZW4gdGhlIG5ldyB0ZXN0IHJlc3VsdCwgSSBwbGFuIHRvIHNlbmQg
djQgd2l0aCB0aGUgUkszNTg4IFREQyByZWdpc3RlcgpzZXQgdG8gMCBhbmQgQ0FOLUZEIGVu
YWJsZWQgZm9yIFJLMzU4OC4KClJlZ2FyZHMsCkN1bmhhbw==


