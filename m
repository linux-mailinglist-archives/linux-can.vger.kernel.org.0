Return-Path: <linux-can+bounces-2380-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 735E29EB44A
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 16:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D8A1888933
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 15:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADBB19E992;
	Tue, 10 Dec 2024 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hainzl.at header.i=dkim@hainzl.at header.b="nCx0dJ1l"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.hainzl.at (mail.hainzl.at [80.120.1.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E339923DE87
	for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.120.1.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843074; cv=none; b=qqRu8nZiwizYOPWS9GL0JSU5m+oaElOTFyz84dSSYnwV2CncIYA59OTS1DnOliicxAQOLDOBwOLpXJJlwsO/ikV5xOIYvV/g0AghkpP46EU3SOEb2/A9e9Uto2NrsHDnTl3hIyh9uz6P5OOmj8wGDu4FqTeBTgU91omqik8UdXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843074; c=relaxed/simple;
	bh=aVe7ipNl3jy6fNKAwTA9nd3lBOqWuW0b2j2v5NWmQqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DfaOPE8zYJVz6OuP9ZDxZmJEtxSKg0xcBPqenFfbX5ybGJ7Yg/afsa77HpTT5/xwL1GaqF7NvY0MgiC9HNyroBsZK8J1ZivpMd+btxSb3C3hDWwVYYF44AZfDN52ongD1VwPadz5kyy39ElI8TCQGVSQqPvifRrJuTNOFMSi9IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hainzl.at; spf=pass smtp.mailfrom=hainzl.at; dkim=pass (2048-bit key) header.d=hainzl.at header.i=dkim@hainzl.at header.b=nCx0dJ1l; arc=none smtp.client-ip=80.120.1.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hainzl.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hainzl.at
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=hainzl.at; i=dkim@hainzl.at; q=dns/txt;
  s=his-dkim-selector; t=1733843073; x=1765379073;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aVe7ipNl3jy6fNKAwTA9nd3lBOqWuW0b2j2v5NWmQqQ=;
  b=nCx0dJ1lOW9DtMuXD70MrVH7K6CSsjGYKrsX+UJ49GKLXi2M7SKNOgwK
   Ri2l6GDVupUoDjUuMkv7gyxGXyNnQlJL18HjU4oJJjBwHksnvZhK06zfj
   5zOIm9KAFstNEOsPh+0fsX+h+fhWP4wOWyNgcu5Pl/mzFXn3guMZHbouX
   b5eQ2V61hWh+T2beQoknLO6s7AfLevsX8CIgLFSRCmUON/an6jQ7NdHWo
   5b/zNbaSKjeg/uQsGI7k4fRmGFE96ZCWdLPhmaB6whgTcdKkKyhnvY1E5
   dTVKG9id4ir2z4lgOOVQB4VC2rqtHByUULSdxofv2OhnN6I2o1E06073O
   w==;
X-CSE-ConnectionGUID: MmUvesFoRoWQJpekPyBIXg==
X-CSE-MsgGUID: +PpGCcxRTf29hK/gXZxQsA==
X-ESA-Internal_Domain: true
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2GSAACoV1hn/48AEKxaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYMlAYIbhDmRcZIXjX8PAQEBAQEBAQEBCAFEBAEBhQcCFopVJzcGD?=
 =?us-ascii?q?gEBAQQBAQEBAQIFAQEBAQEBAQEBDQEBBgECAQEBBAgBAoEdhTVTgmIBg38BA?=
 =?us-ascii?q?QEBAgEjBA1FBQsCAR8DAiYCAgIvFQgIAQEEDg2FOyOvFnp/M4EB3naBKoEaL?=
 =?us-ascii?q?gGITQGBbIh2gk+CUIIthApQg0SCaQSCPIJng3mcKgkjgSEcA1kyAQ8RNRMXC?=
 =?us-ascii?q?wcFZIERA4EWg2CBA4JJaUk3Ag0CNoIkfIJNhReEaYRZhiaCGU4dQAMLB2Y9N?=
 =?us-ascii?q?xQbBgIBOnueJHM9Un+CI5ZZjBCjIQeCOF2BCKFMEhwXqlEuh2SQaaNnhRkCB?=
 =?us-ascii?q?AIEBQIXgX2CAE2DW1EXAg+OLRbCKIE0AgcLAQEDCYI5jWY0LoEdAQE?=
IronPort-PHdr: A9a23:VIE8zxz+5+kgo1fXCzJ4zVBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 xWZuqUm0g6BHd2Cra4f06yO6+GocFdDyKjCmUhKSIZLWR4BhJdetC0bK+nBJGvFadXHVGgEJ
 vlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+I
 A+5oAjfq8Uam4lvJ6U+xhbIpnZDZuBayX91KV6JkBvx6Nu88IR//yhMvv4q6tJNX7j9c6kkQ
 rNUCygrPXoo78PxrxnDSgWP5noYUmoIlxdDHhbI4hLnUJrvqyX2ruVz1jGVMsHvU706Vims4
 79kRxH0higHMSU58HzMhcxrkK1buhOhqAdhzIPSfYqYKeBxfqLZfdMdWGpBQsNcXDFPD4+gc
 4cCCfcKMP1GpIfhuVQBsRq+BRGtBOzxzD9ImmT21rA+3+g4DA3KwBAsE9cIvX/Jrtv6Kb0SX
 Pi1wqfW0zjNcu9W1zn+5ojGcB8hoO2DU71/fsfK1UkgDAHFgkmMpYD5PT6Y0PkGvWiB7+pnU
 OKik3QpqxttujezxccsjpTCiJwVylDD8CV22p01LsC/RUBle9KqCoFQtzyEOIRqQcMiR3plu
 CYgxb0Hv566fSwKxI49yB7DcvGKdZWD7R3/WuiLOzh4mG5ld6ylhxa06UWs1uPxWMe03ltFs
 CZIjNnBuH8M2hLT6MWKVvVw80W81DuA1A3d5PxJLVwpmaTVJZMs3LE+m5sNvEjeHyL4mFj6g
 amLfUsn4uil8/nrb7f4qpOGKoN5ixvyPrg0lsCiDuk1PBACU3Wf9OiizrHv4Ez0TbZQgvA5i
 KXVrZHXKMYdq6WkGQFayJwj5Ay6Dzq+1dQYmmQII0xddRKciojpJ0nOIPflDfejm1iskClkx
 /TBPrD5AJvDLWXNnrjgcrpg6kNQ0gozwspe55JSC7ABJOj/VVXttNDADx85NRK7w/r/Bdlg1
 I4SR3iDDrKYPa/IrVOE/P8jLuaCaYMNvTbyMfkl5/rgjX8jnl8deLGk04UNZH6iBPRmPluWb
 mbvgtcFCmoKvhAxTO3siFyDVT5ffWy9X74k6jEhFI2mFZvDRpyqgLGZ2Se7HZlWa3teCl+SF
 3foeJiEW+sWaCKVJM9hkzMFWaK8RIA/zR2urhP1y6J7LurI/S0VrYjj28Ru5+LNlhE97yZ0A
 t+G026XSmF0hX4IRzk53KxlvUN9zVKD3bBig/NEDdxT++9JUgAiOJ7Yzux6Dc3yWw3YctiVU
 lmmRM6rAS8+Tt0v2d8CeUV9FMu4jhDFwSWqB6UZl7uRBJw76q7c2WP+KN5ny3nazKkhk0UmQ
 sxXOGConqJ/7RbcB5DKnUuDj6uqdaUc3DXT+2aM0GaDvVtUUA5qXqXEW3AeZ0/Woc7j6UPeV
 7OhFLcnMgpEycOaMqVEZdPmg0taSvr/PtrSe3++m2KqChaS2ryBdJLkdXwF0ivSEEQEiBgT/
 XieOAYmHymvu23QX3RSEgfKalnnucp6pXK9Qwoe0g2GYgU10rmx0gYYg/OBV+kU2LMU/iss/
 WZaBlG4iurMn9GDo0JdfKJZaMh1tGsB7XjEugd+OrSgJqFklFpYehgh7BCm7Al+FogVyZtil
 3gt1gcnbPvAiDt8
IronPort-Data: A9a23:jFWYqKpL0tp83k4JDo088r0PW75eBmJkZBIvgKrLsJaIsI4StFCzt
 garIBmBMvjfZ2LxeNtyaNizoBxTu8DSyYVkTQpupSw9E3sTouPIVI+TRqvSF3jLcpCcFhIPA
 +Y2NoCRcJtsEhcwgj/watANeFEljfngqoLUUbOCZ2YrA1c9GE/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSss9JOGjt8B5mr9lU25pwehBtC5gZiPKoS5AeF/5UoJMt3yZ+ZfiOQrrZ8Q7bSq
 9brlNmR4m7f9hExPdKp+p6TWlEKWLPbIT+VgXNQXaW46jAazsDl+v9mXBa0QR4/ZwShx7id+
 v0U3XCDYVtB0pn3pQgoe0Iw/xdWZvQapeCdcRBThuTIp6HOWyOEL/yDlyjaN6VAkgp8KTkmG
 fD1tFnhx/1M7g676OvTdwViuigsBOzuAZ0SoV9n9zbmNNQ+TJP7Uo/r1dANiV/chugWdRrfT
 +o4UhdfNUqGYxROPEUTTpsi9AuqriCgKXsB9hTN4/NruAA/zyQouFTpGOaTQsaXSM5Wmm6Yr
 2PA7WC/Cw1y2Nm3kGbYrCnw17ancSXTG7oKO5az5sRWjgfCxk9UBy0kRWKgiKzs4qK5c5cFQ
 6AOwQIrrqwa7EGtQcThRRq+oW7CshN0c8BbCOA54Rul0aPR+BufCS4PSTspQNgnstImADcj0
 HeXkN7zQz9iqruYTTSa7Lj8kN+pESgUNmISPHFCTQIE5cvn5ogv5v7Scute/GeOpoWdMVnNL
 /qi9UDSW517YRY36piG
IronPort-HdrOrdr: A9a23:/s9QD66AT5l2JCbjCQPXwOzXdLJyesId70hD6qkoc20zTiSZ//
 rAoB1p726TtN93YgBcpTngAtj7fZqyz+8X3WB8B9qftUzdyQ+VxeJZnPffKl/bak/DH4dmvM
 8KGZSWSueAaGSS5vyV3ODMKbYdKa68kZxA692z854nd3ASV0gp1XYANu+0KDwMeDV7
X-Talos-CUID: 9a23:cYS97W5hxUjS/MM7Atss0UspBM0+XHrny0jpAVe1Cl54YpylRgrF
X-Talos-MUID: 9a23:T1CQXgZodVwk/uBT9Af0qxppJP1U7f7/CGNKnqU0q/CfHHkl
X-IronPort-Anti-Spam-Filtered: true
Received: from hisex16.hainzl.at ([172.16.0.143])
  by spam.hainzl.at with ESMTP; 10 Dec 2024 16:04:30 +0100
Received: from HISEX16.hainzl.at (172.16.0.143) by HISEX16.hainzl.at
 (172.16.0.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 10 Dec
 2024 16:04:29 +0100
Received: from HISEX16.hainzl.at ([172.16.0.143]) by HISEX16.hainzl.at
 ([172.16.0.143]) with mapi id 15.01.2507.044; Tue, 10 Dec 2024 16:04:29 +0100
From: =?utf-8?B?UHLDvGNrbCBUaG9tYXM=?= <T.Prueckl@hainzl.at>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "rcsekar@samsung.com" <rcsekar@samsung.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>
Subject: AW: net: m_can: missing mutexes in tx_work_queue and isr-handler
Thread-Topic: net: m_can: missing mutexes in tx_work_queue and isr-handler
Thread-Index: AdtK4ec6I9ygDd19TmudazmqfTyZegAHQhkAAAU8e4A=
Date: Tue, 10 Dec 2024 15:04:29 +0000
Message-ID: <a1de308c7f96475281612c8ffa6fc820@hainzl.at>
References: <f6a9e128fbc04dcebd70e9b254b344e2@hainzl.at>
 <20241210-sly-impressive-kittiwake-aff4f1-mkl@pengutronix.de>
In-Reply-To: <20241210-sly-impressive-kittiwake-aff4f1-mkl@pengutronix.de>
Accept-Language: de-DE, de-AT, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiBDYW4geW91IHNob3cgdXMgdGhlIHBhdGNoPw0KDQpNeSBjdXJyZW50IHBhdGNoIGN1cnJlbnRs
eSBqdXN0IGxvY2tzIHRoZSBpc3IgYW5kIHdvcmsgcXVldWUuDQpJIGd1ZXNzIHRoYXQgYWRkaXRp
b25hbCBsb2NrcyBhcmUgbmVjZXNzYXJ5IHRvbyAoZS5nLiBpbiBtX2Nhbl9jbG9zZSkNCg0KU3Vi
amVjdDogW1BBVENIXSBjYW46IG1fY2FuOiBhZGRlZCBtdXRleCB0byBsb2NrIGlzciBhbmQgdHgg
d29yayBxdWV1ZQ0KDQotLS0NCiBkcml2ZXJzL25ldC9jYW4vbV9jYW4vbV9jYW4uYyB8IDE3ICsr
KysrKysrKysrKysrKystDQogZHJpdmVycy9uZXQvY2FuL21fY2FuL21fY2FuLmggfCAgMSArDQog
MiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9jYW4vbV9jYW4vbV9jYW4uYyBiL2RyaXZlcnMvbmV0L2Nhbi9t
X2Nhbi9tX2Nhbi5jDQppbmRleCAyMzk1YjEyMjVjYzguLjM0ZGU2YmUyZGI3NiAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvbmV0L2Nhbi9tX2Nhbi9tX2Nhbi5jDQorKysgYi9kcml2ZXJzL25ldC9jYW4v
bV9jYW4vbV9jYW4uYw0KQEAgLTEwODUsNyArMTA4NSw3IEBAIHN0YXRpYyBpbnQgbV9jYW5fZWNo
b190eF9ldmVudChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQ0KIAlyZXR1cm4gZXJyOw0KIH0NCiAN
Ci1zdGF0aWMgaXJxcmV0dXJuX3QgbV9jYW5faXNyKGludCBpcnEsIHZvaWQgKmRldl9pZCkNCitz
dGF0aWMgaXJxcmV0dXJuX3QgbV9jYW5faXNyMihpbnQgaXJxLCB2b2lkICpkZXZfaWQpDQogew0K
IAlzdHJ1Y3QgbmV0X2RldmljZSAqZGV2ID0gKHN0cnVjdCBuZXRfZGV2aWNlICopZGV2X2lkOw0K
IAlzdHJ1Y3QgbV9jYW5fY2xhc3NkZXYgKmNkZXYgPSBuZXRkZXZfcHJpdihkZXYpOw0KQEAgLTEx
NTAsNiArMTE1MCwxNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgbV9jYW5faXNyKGludCBpcnEsIHZv
aWQgKmRldl9pZCkNCiAJcmV0dXJuIElSUV9IQU5ETEVEOw0KIH0NCiANCitzdGF0aWMgaXJxcmV0
dXJuX3QgbV9jYW5faXNyKGludCBpcnEsIHZvaWQgKmRldl9pZCkNCit7DQorCXN0cnVjdCBuZXRf
ZGV2aWNlICpkZXYgPSAoc3RydWN0IG5ldF9kZXZpY2UgKilkZXZfaWQ7DQorCXN0cnVjdCBtX2Nh
bl9jbGFzc2RldiAqY2RldiA9IG5ldGRldl9wcml2KGRldik7DQorCWlycXJldHVybl90IHJldDsN
CisJbXV0ZXhfbG9jaygmY2Rldi0+bG9jayk7DQorCXJldCA9IG1fY2FuX2lzcjIoaXJxLCBkZXZf
aWQpOw0KKwltdXRleF91bmxvY2soJmNkZXYtPmxvY2spOw0KKwlyZXR1cm4gcmV0Ow0KK30NCisN
CiBzdGF0aWMgY29uc3Qgc3RydWN0IGNhbl9iaXR0aW1pbmdfY29uc3QgbV9jYW5fYml0dGltaW5n
X2NvbnN0XzMwWCA9IHsNCiAJLm5hbWUgPSBLQlVJTERfTU9ETkFNRSwNCiAJLnRzZWcxX21pbiA9
IDIsCQkvKiBUaW1lIHNlZ21lbnQgMSA9IHByb3Bfc2VnICsgcGhhc2Vfc2VnMSAqLw0KQEAgLTE3
NzEsNyArMTc4Miw5IEBAIHN0YXRpYyB2b2lkIG1fY2FuX3R4X3dvcmtfcXVldWUoc3RydWN0IHdv
cmtfc3RydWN0ICp3cykNCiAJc3RydWN0IG1fY2FuX2NsYXNzZGV2ICpjZGV2ID0gY29udGFpbmVy
X29mKHdzLCBzdHJ1Y3QgbV9jYW5fY2xhc3NkZXYsDQogCQkJCQkJICAgdHhfd29yayk7DQogDQor
CW11dGV4X2xvY2soJmNkZXYtPmxvY2spOw0KIAltX2Nhbl90eF9oYW5kbGVyKGNkZXYpOw0KKwlt
dXRleF91bmxvY2soJmNkZXYtPmxvY2spOw0KIH0NCiANCiBzdGF0aWMgbmV0ZGV2X3R4X3QgbV9j
YW5fc3RhcnRfeG1pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KQEAgLTE4MjUsNiArMTgzOCw4IEBA
IHN0YXRpYyBpbnQgbV9jYW5fb3BlbihzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQ0KIAlzdHJ1Y3Qg
bV9jYW5fY2xhc3NkZXYgKmNkZXYgPSBuZXRkZXZfcHJpdihkZXYpOw0KIAlpbnQgZXJyOw0KIA0K
KwltdXRleF9pbml0KCZjZGV2LT5sb2NrKTsNCisNCiAJZXJyID0gcGh5X3Bvd2VyX29uKGNkZXYt
PnRyYW5zY2VpdmVyKTsNCiAJaWYgKGVycikNCiAJCXJldHVybiBlcnI7DQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvY2FuL21fY2FuL21fY2FuLmggYi9kcml2ZXJzL25ldC9jYW4vbV9jYW4vbV9j
YW4uaA0KaW5kZXggNTIwZTE0Mjc3ZGZmLi45ZDcyNDUxMDhlNjAgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL25ldC9jYW4vbV9jYW4vbV9jYW4uaA0KKysrIGIvZHJpdmVycy9uZXQvY2FuL21fY2FuL21f
Y2FuLmgNCkBAIC05MSw2ICs5MSw3IEBAIHN0cnVjdCBtX2Nhbl9jbGFzc2RldiB7DQogDQogCWlu
dCBwbV9jbG9ja19zdXBwb3J0Ow0KIAlpbnQgaXNfcGVyaXBoZXJhbDsNCisJc3RydWN0IG11dGV4
IGxvY2s7DQogDQogCXN0cnVjdCBtcmFtX2NmZyBtY2ZnW01SQU1fQ0ZHX05VTV07DQogDQotLSAN
CjIuMzQuMQ0KDQoNCg==

