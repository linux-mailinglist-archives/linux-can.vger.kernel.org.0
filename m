Return-Path: <linux-can+bounces-7952-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4iErGksqRmqsKwsAu9opvQ
	(envelope-from <linux-can+bounces-7952-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 11:07:23 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C28396F510E
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 11:07:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=skcmYcDP;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7952-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7952-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A9CB30CCF8E
	for <lists+linux-can@lfdr.de>; Thu,  2 Jul 2026 08:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0D0429837;
	Thu,  2 Jul 2026 08:58:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063683D8132;
	Thu,  2 Jul 2026 08:57:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782982682; cv=none; b=rEg+wB29EroKHIn7kQgLcjMh0aFnO59A8PT6jqC7BXrH83N5pTC2XjF13hw6uyUm5O8TRY6D/qM7f8MqALKv+k4bj3+6EYiCl07kUQE2Mymnqi4U72CufYwIXG9hBbzQcXOhvOo1F873wAhCIL1FeEYOuYJKUJiEKLg/NPIolIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782982682; c=relaxed/simple;
	bh=g1tzCXhfJ6i/LBmjQejOU8xmPId9QB52ccgEyl7GbNk=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=FxzUAdk4TkuU5yHxmiU4FCTpMfb1mF8R/0Gl1jLQOpR2KJ34vO7trrf+bK1eNepzcuFI4v/09JFEsMP7JAxNqnwkcGlrfbLlgAw5pCaJ8SC4bUVXvaXW/9dTM2fAwjPtj/h/BPRgfMLlsS9+rWUaKDb/ssg3Hs+hMRPNfqS+dZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=skcmYcDP; arc=none smtp.client-ip=162.62.57.49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782982668; bh=g1tzCXhfJ6i/LBmjQejOU8xmPId9QB52ccgEyl7GbNk=;
	h=From:To:Cc:Subject:Date;
	b=skcmYcDPRinm9JQdh/HJi2j/syN3Z8wOLEdhyTIES/RNUj0tWTqtIOrx6JrDpKgMc
	 sF9LiV83Dua9jQJl1C1mxU8DB8jhvLJJ7yEA87Gr21ts+/JdD4d2pP959qD3sCTtdh
	 THjCSTjHAc9op01NNa0gZBalxL7iyZ9WrnsGQgnE=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-XMAILINFO: McF9JvsryK5J6Ks/wR8zL9of7ASkzOteCwRrFmEQOcNb0HYqeD3TOHYAxT1qnv
	 ZnkOBGssLTWF245PxCUVYkCwtPD4KiRryw5lTxQYqlKOmDbMsNkx+41cV1SL0mBCgQ3hJdBIdMQyp
	 hv9Rs+bajluxLjT1TOoplyMRF8kPBx4KPwYAa1qnbdZ0zFfcxd3t8o7POwCVaHjb2Qne7yVVOwS73
	 aKdLETXeXldQDd9hbs7mHyOX0i6rDtoO98mSimi4QY2g6f6xVkrSKIEBpsPlPTI2pJfdA0arfJcgK
	 PIzft07W7pB6UCx4oRfa/herkgepcInoueB83avM8+/+GyA0QCPNj+IYswencoRTWU71l+hYI0ARa
	 sDvKAKw3U3+jmKeWfDVc/JaPzFcdkMFFi2Z/kSEmj9A0LE3sFTwKE+2bE2yzOe0nw9GkRidrH7xu5
	 9M7SbeDQmNyaTsk/VgT7q/7TGQO7PkOoAoJRpfJSBVJetVDIiLsD18OzPV1hMOtE+y74PwvtEE7ZY
	 Tg21nLAEo2egUeSqmM1Nd8Oh3AyK0fc5NUl/TwKTemED1RfoNMLhgZqiyVh61lnqkr+nOFmuDarcD
	 vOhpMyLBkB0h8BOewhuqu1Lnh/EzV94x33/H2yRM8mStx84pNCV6UmHDzm5zDqegFdjSTusrB5ekb
	 QIiNZwK+6ih0z0NvbUQEjbAYyaE6B42N/txmbcIAc4NhZDgQjCg+aGGEmUfwv1OHGlC0M486uchOD
	 +5lAAGd0rKZNS+QCAjBDvhCvKm8DOBOoHD44Itl8ULyDsZIu9X0wFPgsq4GuEuC6l59uvikxPGQTG
	 vkLkMZdhfsyV0DD1U3OLCf4ThcpHufmb7aknUw3aamn6h1tMIqcmkKI57omSyg+9zYtYkanxBJ7MV
	 s+QUmpUZ/02d4pgf822LghecXv3r9PkOV9H8XCu9lIuX0zTE6duKl4S0cWaWnisoybDPaXTRR7pwy
	 rG7Zg605OZfrFb0SpuxMdbXi3rFaffQuZcFTL95k4CXx89+HIpmKwm00J3ejPyQ7k2KCpoGjcZdUd
	 mNN2hHDtFQVB6ExHC7ze9qmJ3YOQ2jCYqCoXC
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>
Cc: "=?utf-8?B?a3J6aw==?=" <krzk@kernel.org>, "=?utf-8?B?aGVpa28=?=" <heiko@sntech.de>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bWFpbGhvbA==?=" <mailhol@kernel.org>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?cm9iaA==?=" <robh@kernel.org>, "=?utf-8?B?a3J6aytkdA==?=" <krzk+dt@kernel.org>, "=?utf-8?B?Y29ub3IrZHQ=?=" <conor+dt@kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: can: rockchip: add rk3588v2 CAN-FD compatible
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 2 Jul 2026 16:57:46 +0800
X-Priority: 3
Message-ID: <tencent_F173D3200DB38C5942E848728028E291DF06@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-mid: xmsezb41-0t1782982666tvoi91hyc
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:krzk@kernel.org,m:heiko@sntech.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:kernel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	TAGGED_FROM(0.00)[bounces-7952-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_EXCESS_BASE64(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,qq.com:dkim,qq.com:mid,qq.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C28396F510E

SGkgTWFyYywKCnRoYW5rcyBmb3IgdGhlIGV4cGxhbmF0aW9uLgoKPiBIb3dldmVyLCB0aGUg
dmVyc2lvbiByZWdpc3RlciBfaW5fIHRoZSBDQU4tRkQgd2FzIG5vdCBjaGFuZ2VkLiA6Lwo+
IFRoaXMgaXMgd2h5IHdlIGhhdmUgYSByb2NrY2hpcCxyazM1Njh2Mi1jYW5mZCBhbmQgYQo+
IHJvY2tjaGlwLHJrMzU2OHYzLWNhbmZkIGNvbXBhdGlibGUuCj4KPiBZZXMsIHBsZWFzZSB1
c2Ugcm9ja2NoaXAscmszNTg4LWNhbmZkLCB1bmxlc3Mgd2UgZ2V0IGluZm9ybWF0aW9uIGZy
b20KPiByb2NrY2hpcHMgYWJvdXQgQ0FOLUZEIGVycmF0YSBhbmQgU29DIHNpbGljb24gcmV2
aXNpb25zLgoKVW5kZXJzdG9vZC4gSSBjaGFuZ2VkIHRoZSB2MiBzZXJpZXMgdG8gdXNlIHJv
Y2tjaGlwLHJrMzU4OC1jYW5mZAppbnN0ZWFkIG9mIHJvY2tjaGlwLHJrMzU4OHYyLWNhbmZk
LgoKVGhpcyBpbmNsdWRlcyB0aGUgYmluZGluZywgdGhlIFJLMzU4OCBEVFMgbm9kZXMsIHRo
ZSBkcml2ZXIgT0YgbWF0Y2gsCmFuZCB0aGUgaW50ZXJuYWwgZHJpdmVyIG1vZGVsIG5hbWUu
CgpUaGFua3MsCkN1bmhhbyBMdQ==


