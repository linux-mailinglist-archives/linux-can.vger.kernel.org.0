Return-Path: <linux-can+bounces-7950-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oIZhBQ4gRmqnKQsAu9opvQ
	(envelope-from <linux-can+bounces-7950-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 10:23:42 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2F66F4C0C
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 10:23:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=cpd2NHg1;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7950-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7950-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A5CC302BCE2
	for <lists+linux-can@lfdr.de>; Thu,  2 Jul 2026 08:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B5E426400;
	Thu,  2 Jul 2026 08:18:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988AE2C21E8;
	Thu,  2 Jul 2026 08:18:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980292; cv=none; b=ZXKBGrcaQQ+JYwOcfyC5JE8hyVB6Uiu34zyc8746iTnFhnt9gHhttwlKweyueMIzgx28N3im+0Dj6GkF3n3NYPA0ssYP6copVVsNlCWL/VZkA7aqxJEWr87qbNg1iAnR/rcQmoSyuE5fmsW0+GBF9ktDAnjmjAAjl0QWNmamT2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980292; c=relaxed/simple;
	bh=1B5GSyAJIOG4wfRq0mDuvB3G4ilaYLoysw4eWFLduAs=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=Lj9l6AZC1PLgk8SRBGat03UaVIEGD4cqzUy14zphOHHMLN2+WZzz17Lfo8+tI5ta+Ngw9WKuSpowwFwkzusyVDfX+jeJ9nL1Z9G1xeED4avZ2ptFvkwwCt/qqsGeHJSJmzr2fyBQhCAPl60W8VoTrnnGAn4/aobKMyfp0lvseuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=cpd2NHg1; arc=none smtp.client-ip=162.62.57.87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782980247; bh=1B5GSyAJIOG4wfRq0mDuvB3G4ilaYLoysw4eWFLduAs=;
	h=From:To:Cc:Subject:Date;
	b=cpd2NHg1cpKsDzPB67xLogddoX0ZexDC8qnbgdxJEwhGKQ1qR7hMp2oJ2oKX2sa26
	 tt2XXkk+1D674l/Q0O3epxFPonHVpGqdVZ75BwOhvuA7gcTCPu1ttWYBvJEQ3xuARA
	 hCbWyEt6uyUAO5OctzMpT6nUUp9ij3qUQSn0tF4s=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-XMAILINFO: M/7aYRxQgGxsDc7Ynwti5r/VjLIh7JToZmaGq7z/9Lpn+xoTtnMY+ObYS5q7v3
	 8tGSzg+S/2qII7mL9LKOta4NXyXzmq00jDmWAGEBwcFcXOu2vEZiQCYYFn5QRLh4zSF87Gpd3lH+c
	 VbRSN7jq4nJMSt0o8AxY80ZbfcgAdWYxm/BEhJObUXUhq/opU0rhMEXxuZFUMdITWda4qneGtswU0
	 6/600Oum+0LTImHQbWjz07VvKDwjuGzg90NC3nmMUcawyRZ9iTZlMb3GMsbFvWQvxFcHlAxW9rdVL
	 R8zDRCsYpb4veRyIh/x0KaVAfLcXGvPgKqHoX+WzCEyDK3L0gPY9EOtiF3tVDQ33cxrnGbpb48ybU
	 ShfTiKqv583HgYrYz39xKvQX9T8oUhbVdwyRHDEoNM+PEIxPWaS4PfuBCspWyFSpt7Fe9k3QY6mrE
	 /6JS/xTS55iW6vC0CFarU2zIX/QBqyxZoK2W4vaeQENwTit4l/I0Ll7e5ijCiQAjX2uNojQtqisg4
	 ngTrzq9Ym8GvP1s/hSM85bSsmsDhq7hMZwOahFxr32T0kMnNk24UgxfhhpDZxcn/7YGn4Z3AiYYnW
	 1ZA/jClQKpcqfzIOCWVaYDUBTY2A1bTQNL+DiKW+h1Qbeqmika+roigtEdjdLnDD1puyIkNIffvzi
	 bLTj6QLnt7PakN55+kYWbUfmSTlxiVoYgH5dX9UYbZ6TY5+4cN8rWj1xstYHMHXAwxxZWorfFl/0M
	 2RTOmiTr6Us2sTTruEhxJ2+sv1cxN5kTRBz1UsiXGeGH/3nTTAnX1to6TTviEDWgmKGYwXT7sFVEf
	 HtJgatzh1T3rnVViBYB8+ko954blgfJJ2Ztgm7/QwuPBO1e6xtuRZadWAvCNwMY+dVP9UJKYJ2HQ+
	 tSPZEMz4xdwc14WqoMaNwoDb4LMX3S/dRVnB0gmWLI4Cf/PJAo5uRd4hi9yliO/GHhwFdXTQ6FNIG
	 1IkdX2JAiQCi/ZbB9hUUTiCLEViEXhWjWJIgw7x+o9DMWgoqMyXyDe0SULRF5ccANJSMzNvIgK7zK
	 FfrtrGWutjheKsws6DxLyMvYq4/HthrgeVteV
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?a3J6aw==?=" <krzk@kernel.org>
Cc: "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>, "=?utf-8?B?aGVpa28=?=" <heiko@sntech.de>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bWFpbGhvbA==?=" <mailhol@kernel.org>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?cm9iaA==?=" <robh@kernel.org>, "=?utf-8?B?a3J6aytkdA==?=" <krzk+dt@kernel.org>, "=?utf-8?B?Y29ub3IrZHQ=?=" <conor+dt@kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
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
Date: Thu, 2 Jul 2026 16:17:25 +0800
X-Priority: 3
Message-ID: <tencent_97F21396469202221027FD429A6E69DA6409@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-mid: xmsezb41-0t1782980245tkalsowho
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
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
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:mkl@pengutronix.de,m:heiko@sntech.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:kernel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	TAGGED_FROM(0.00)[bounces-7950-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_EXCESS_BASE64(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,qq.com:dkim,qq.com:mid,qq.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A2F66F4C0C

SGkgS3J6eXN6dG9mLAoKdGhhbmtzIGZvciB0aGUgcmV2aWV3LgoKPiBEVCBwcm9wZXJ0aWVz
IGhhdmUgbm90aGluZyB0byBkbyBoZXJlLiBBcmUgeW91IHNheWluZyBpdCBpcyBmdWxseQo+
IGNvbXBhdGlibGU/IFRoZW4gZXhwcmVzcyBpdCBwcm9wZXJseSB3aXRoIGZhbGxiYWNrLgoK
Tm8sIEkgZG8gbm90IHRoaW5rIFJLMzU4OHYyIGlzIGZ1bGx5IGNvbXBhdGlibGUgd2l0aCBS
SzM1Njh2Mi4gVGhlIFJYCkZJRk8gY291bnQgZmllbGQgdXNlcyBhIGRpZmZlcmVudCBiaXRm
aWVsZCBvbiBSSzM1ODh2Miwgc28gdXNpbmcKcm9ja2NoaXAscmszNTY4djItY2FuZmQgYXMg
YSBmYWxsYmFjayB3b3VsZCBkZXNjcmliZSBhIHJlZ2lzdGVyIGxheW91dAp0aGF0IGRvZXMg
bm90IG1hdGNoIHRoZSBoYXJkd2FyZS4KCkJvdGggc3RhbmRhcmQgYW5kIGV4dGVuZGVkIENB
Ti1GRCBmcmFtZXMgd29ya2VkIGluIG15IGxvY2FsIFJLMzU4OHYyCnRlc3RpbmcsIGJ1dCB0
aGF0IG9ubHkgY29uZmlybXMgQ0FOLUZEIGZ1bmN0aW9uYWxpdHkgb24gdGhpcyB2YXJpYW50
LiBJdApkb2VzIG5vdCBtYWtlIHRoZSBSSzM1Njh2MiByZWdpc3RlciBsYXlvdXQgYSB2YWxp
ZCBmYWxsYmFjayBmb3IKUkszNTg4djIuCgpJIHdpbGwgcmV3b3JkIHRoZSBjb21taXQgbWVz
c2FnZSBpbiB2MiB0byBleHBsYWluIHRoaXMgaGFyZHdhcmUKZGlmZmVyZW5jZSBpbnN0ZWFk
IG9mIHRhbGtpbmcgYWJvdXQgdGhlIERUIHByb3BlcnRpZXMuCgo+IERvIG5vdCBleHBsYWlu
IHdoYXQgeW91IGRpZC4gRXhwbGFpbiBXSFkuCj4KPiBEcml2ZXIgaXMgaXJyZWxldmFudCBo
ZXJlLgoKVW5kZXJzdG9vZC4gSSB3aWxsIHJlbW92ZSB0aGUgZHJpdmVyLWZvY3VzZWQgd29y
ZGluZyBmcm9tIHRoZSBiaW5kaW5nCnBhdGNoLiBUaGUgdjIgY29tbWl0IG1lc3NhZ2Ugd2ls
bCBleHBsYWluIHdoeSBSSzM1ODh2MiBuZWVkcyBpdHMgb3duCmNvbXBhdGlibGUgZnJvbSB0
aGUgaGFyZHdhcmUgZGVzY3JpcHRpb24gcG9pbnQgb2Ygdmlldy4KCj4gV2UgZG8gbm90IHRh
a2UgYW5vbnltb3VzIGNvbnRyaWJ1dGlvbnMuCgpJIHdpbGwgdXNlIG15IHJlYWwgbmFtZSBp
biB2Mi4KCj4gU28gdGhhdCdzIGp1c3QgZW51bSB3aXRoIHByZXZpb3VzIGVudHJ5CgpJIHdp
bGwgZm9sZCB0aGUgc2luZ2xlLWNvbXBhdGlibGUgZW50cmllcyBpbnRvIGFuIGVudW0gaW4g
djIuCgo+IEFuZCB3aHkgaXMgdGhpcyBkaWZmZXJlbnQgZnJvbSByazM1ODg/CgpUaGUgcmVh
c29uIEkgdXNlZCByazM1ODh2MiBpcyB0aGF0IHRoaXMgaXMgaG93IHRoZSBjb250cm9sbGVy
IGlkZW50aWZpZXMKaXRzZWxmIGF0IHJ1bnRpbWU6CgogIHJvY2tjaGlwX2NhbmZkIGZlYTYw
MDAwLmNhbiBjYW4wOiBSb2NrY2hpcC1DQU5GRCByazM1ODh2MiByZXYyLjIgKGVycmF0YSAw
eDAwMDApIGZvdW5kCiAgcm9ja2NoaXBfY2FuZmQgZmVhNzAwMDAuY2FuIGNhbjE6IFJvY2tj
aGlwLUNBTkZEIHJrMzU4OHYyIHJldjIuMiAoZXJyYXRhIDB4MDAwMCkgZm91bmQKCkkgYWxz
byBjaGVja2VkIFJvY2tjaGlwJ3MgdmVuZG9yIGtlcm5lbCA2LjEgc291cmNlcy4gVGhlIFJL
MzU4OCBEVFMgdXNlcwp0aGUgYmluZGluZyBuYW1lICJyb2NrY2hpcCxjYW4tMi4wIiBmb3Ig
dGhlc2UgY29udHJvbGxlcnMsIHdoaWxlIHRoZQp1cHN0cmVhbSBkcml2ZXIgaGFzIFNvQy1z
cGVjaWZpYyBjb21wYXRpYmxlcyBmb3IgdGhlIFJvY2tjaGlwIENBTi1GRCBJUC4KVGhhdCBp
cyB3aHkgSSBjaG9zZSB0aGUgU29DL0lQIHZhcmlhbnQgbmFtZSByb2NrY2hpcCxyazM1ODh2
Mi1jYW5mZC4KCklmIHRoZSBwcmVmZXJyZWQgYmluZGluZyBuYW1lIGlzIHJvY2tjaGlwLHJr
MzU4OC1jYW5mZCBpbnN0ZWFkLCBJIGNhbgpjaGFuZ2UgdGhlIGNvbXBhdGlibGUgaW4gdjIu
CgpUaGFua3MsCkN1bmhhbyBMdQ==


