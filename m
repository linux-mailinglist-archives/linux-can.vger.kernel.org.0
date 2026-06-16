Return-Path: <linux-can+bounces-7852-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jqHFF0kkMWoecgUAu9opvQ
	(envelope-from <linux-can+bounces-7852-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 12:24:09 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF4668E333
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 12:24:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=witekio.com header.s=selector1 header.b=am3l5zeP;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7852-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7852-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=witekio.com;
	arc=reject ("cv is fail on i=3")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C358531C36FE
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 10:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6BE438FEF;
	Tue, 16 Jun 2026 10:15:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relay-p07-hz12.hornetsecurity.com (relay-p07-hz12.hornetsecurity.com [94.100.139.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC38B428470
	for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 10:15:03 +0000 (UTC)
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604907; cv=fail; b=hT1R/UHpzzuq71E9MpWd1CLCO5jt1Pco2eR63Sge1JVArXYiWPNYYG99onJYDNjz1xoAbvwmPtIoYIYdO++CyomWZnnIEKA7WKSbn7BMJnKtn3nDJ0CPIiB6vDCp6YUbnMLrqrWxZbDVXmJZYfcBKws748OQRRBarmbdgEWUju8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604907; c=relaxed/simple;
	bh=C3X/9jsEDZu4NiHTkFma62TCnBOcCGUikknkDLZ1+Fk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tJj3OxhpECieX2qI6QX798P1Prpeon2DESNqP2iecih6CeKJmDgtTl4PH4mS++D/kOT7wGSKwg/RFSJDH/v74TCM2VsVj96SGjWOorur9a8/+jk3i020FTSJT54/Ev0EsfE5FpuSBv4fv2Z1iBhPdYJuP0BbmlRV1t2fHdhwrFQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=am3l5zeP; arc=fail smtp.client-ip=94.100.139.207
ARC-Authentication-Results: i=2; mx-gate31-hz12.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=40.107.130.103, headerfrom=witekio.com)
 smtp.mailfrom=witekio.com
 smtp.helo=mrwpr03cu001.outbound.protection.outlook.com; dkim=pass
 header.d=witekio.com header.s=selector1 header.a=rsa-sha256; dmarc=pass
 header.from=witekio.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=xmkan5Wb0mDtO69ut7pwEUVDe1YHxAIWiwuDxyqkp14=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1781604890;
 b=cMHfdcGzdEA8AXu4aEdLus8q6l1aVz+go+Iy6JmKYiG3majuE8teIIG+ADfnRlM3DVAmOppo
 Bou2drhYpsBcBZ27Re/8gXuGbe12R1P2IU13yhd5qL7lnB6m7XdEKY1nknw5FzZXx2oF1GzdCem
 31nB+w59XXRsMMLUK3r4NNLl1owzo8pC7tXJXsdBhIdcpdYf0ZEs8EOI+ZjN7+1uFgIfh+gz94c
 X2M6g8HEhT+XtW/XecXxVAWAxgOMn09ZkB0n5cnxA+OHKoPOjgKt+4Ccpy6nnP8g/EOL52JChja
 xZk3M0+WFexobZ1YhlVadmIPabtYK6yhwToQa1CsT1SOQ==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1781604890;
 b=lVfVnyf/4Hoye7jLZUysrfKT4H3bFZNcHe+s7e4WPlG78nmQextAm2lva8dvWHzrZCkJWSFx
 4bohFAIQ/fn3tyd1mDW8WcUE20ZnEDx3EeBIg5uH9RPa2EWj3D3FtHRostvJRguAf0N+9STJpjY
 vl2i70Bn8u7MVNUUX7TAfaV1zMJCgzMtZ+ocb/v6n/xUxlo8ZstNEiO3YsRn61Pwq0m8FcjmPsy
 R/ftEGCQF+FAty/oS4dcZzAEdf6w/xA6IZHM4xVLMx3uP4j63rHo/x4SShIRJyRAU+yc00Qzj8k
 RxuuO6ZR2q9GmvDxD36zsa71o+ZQhybkMg9r0EtljTzIA==
Received: from mail-francesouthazon11021103.outbound.protection.outlook.com ([40.107.130.103]) by mx-gate31-hz12;
 Tue, 16 Jun 2026 12:14:50 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohVnQv8dfmouXmvg9v/kbEmZ52bKs2sx9DJrJZg/8SuovtCVhNYB+QSkaOSuxzSlqQ9ier5MnkS2aBFb0OB4DRU9Do35dmhtGr0PtEyOUzZbJvP9BOOqR5XjysZ+auowZz2A5wLqeWDK1PV3q1Ch3U+kzjacBlIb5LjI4vfeeh/MSegYAk4lWIIvOXhUgDCAjybnfzwSLekCCXhLjgP8ckYOLswIj//gpTaaOOMj3hXjAMeCBEuVZoqVNxYjDOVm3KhjBekNQdCjzBdM1xqFYQ0hub/K5u6sJS0vCkKNOq3XVyPRZcGaf2e/chjlOGHAVRATaKpvSo8OZJbMga0hHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmkan5Wb0mDtO69ut7pwEUVDe1YHxAIWiwuDxyqkp14=;
 b=uqmS50JhzSz8Ap4QoANv+sBjCaV79F3LG458IW6QpxbMfylCwgdXYsS9va6qzbI9tK2vEnNfzwuJEcmdP/Ax2qDjrMcoAFWpOdrBbxBaSd/CKrppWPkiStyFxJOgwZ0+iKYRDp6CaEzXdvZfqo5o+TOZI1J4C3eMlZ1XEqeuzwvXMjo7qkCnX1gZflzUja0W6hCgzZwZEyOmhkHvkJmefdeydur3W3o5WYgdJWxSgk7ZNW7wawoEvhdWamOlqt32VGRQkRo87UWABOsh6+1SqtaijhkeukIm2TbBPAdfCGADK6IqtJlIc1n/iflqqSrFpX0ZYH6XU7kNHO49ZDwjRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmkan5Wb0mDtO69ut7pwEUVDe1YHxAIWiwuDxyqkp14=;
 b=am3l5zePvKsvP6tyBBhph+ot1K8twgGzXQTlglBxacNpcPePZIVEczfoQguIa6VhNORzy80qnAIeyJdXAyC7WYelMBy5ub6wffuFX+gCOCiBfs+WLyYFaMAIAXqFJqEy5vXay4rGLG23tqFuckTY0vhk6S36LSJ8k523V9w7jt+CHqnAr2b1VPgAR4d1SOIbMe2lw07SiYd6J1kX7gZ1lil16YoBwOQ3GsCXMOob6U3G5GW+Mg73OnZocEY/iYLl/YWKMn8+Jrg0nfinsyI0A3LY/LQEIN/ks5xgygcH9Mg+gZczWudEgAshMVaGplrxlgbeXfAuJwNUmCjUGdNC6g==
Received: from AM7P192MB0721.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:171::17)
 by PAWP192MB2509.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:4c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 10:14:43 +0000
Received: from AM7P192MB0721.EURP192.PROD.OUTLOOK.COM
 ([fe80::b0ff:c6f6:5761:f666]) by AM7P192MB0721.EURP192.PROD.OUTLOOK.COM
 ([fe80::b0ff:c6f6:5761:f666%5]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 10:14:43 +0000
From: Thomas NIZAN <tnizan@witekio.com>
To: "rcsekar@samsung.com" <rcsekar@samsung.com>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"mkl@pengutronix.de" <mkl@pengutronix.de>
Subject: [RESEND]: m_can: bus-off recovery issue
Thread-Topic: [RESEND]: m_can: bus-off recovery issue
Thread-Index: AQHc4+MgLB8hqxEDH0Gd72gPfOqBKLZBKYoZ
Date: Tue, 16 Jun 2026 10:14:43 +0000
Message-ID:
 <AM7P192MB072141771FB0B0597BFC4034D1E52@AM7P192MB0721.EURP192.PROD.OUTLOOK.COM>
References:
 <AM7P192MB0721CEAC90D73E5FE70EC5EED1072@AM7P192MB0721.EURP192.PROD.OUTLOOK.COM>
In-Reply-To:
 <AM7P192MB0721CEAC90D73E5FE70EC5EED1072@AM7P192MB0721.EURP192.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P192MB0721:EE_|PAWP192MB2509:EE_
x-ms-office365-filtering-correlation-id: 420e6560-2d13-47ab-4b4a-08decb9015fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|6049299003|10070799003|1800799024|56012099006|22082099003|18002099003|6133799003|8096899003|38070700021|4053099003;
x-microsoft-antispam-message-info:
 E2jlGlSXQj+//RJ8xMvvOOP19XNTfepunBPpPKRXlcgG0pi7EaqTfVqPmWA8utADbl5FrMXQVUz0sXY4fwBDyNTaz+41Xee+yjUERoF7HNcDwP2E5LD0zSgmpoEm5RSvTCbYN1dLdT3aaJLhUZn0Yj1J6qbl2n/OQwNSQpOvooIFCVGdowFqvZwYwOhImX8PusCmLjw5IHrmDqJ72WSn1CAxGw9xzf8XH2KGuVMMsNVGpmscivKrSRuKV1qoGIbPWtEhSFxvqgk1IiWnR6pElfQo8n1J73FV19QdIiih+4NOU4kHvlcswH1XHbJekgGfy4OUm5ZEpo7fk62lWbY9LelZ6dVFe/RDH5EOSKHKbQezLI0V8mF5yMC5H/gfxkpzT2X9w6Dqu6O3MQIssP6I0oENBunjiFeCG8aKRwIiEWQ+fSfZQRGGdb1UbpUsNgkkkS6q7SSkLiJjsuv71fxAhj+7orfKlSQ/vtahhd12DLl8w0tsblmmtn4Xewf9jjCgwMQ3sfGrrjFqboSMNAOZp8LTn7B+e2ffIDtusbDy/BlzyquQh3T9zqs57h6E4c7/rmuXQGRdfwuZM69IKsQeDfuU8d64hBf0WfkqSPNqHkxK9wBZvqi75Uw2NnC1j+TnB6im+ANmWx+UCcYkKJBLZzZUY7+F/P4WDbPlt2uscnHGt7z/EnNYPiLsL/sbG40ADf7oCkx+tpVi3QPZOQ/Yge1Wg+U42/JBZCZSs48Kc6dRYuy+Lqf0uqTvH9Az+RtX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P192MB0721.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(6049299003)(10070799003)(1800799024)(56012099006)(22082099003)(18002099003)(6133799003)(8096899003)(38070700021)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?BLSeoh7MGZL1IUUw2V9pSw/5tJ+6SlrdLHQV/G4Ktl4ZMh3/pSAPPnq6Ep?=
 =?iso-8859-1?Q?eQNfSUGSg4eBfjlCs7ypN5Cg2qhyNXzhZZ3jynLh5k3adGxQZqIBlToeIp?=
 =?iso-8859-1?Q?vI32dnsI+ImdzHpTcfB0UmR/bYeItx1FHP9D2QB1sxWCnW5BuULxrUBleg?=
 =?iso-8859-1?Q?/eQzcurftb/qmHsPXyJhbmW3KKcdC1boUxiKOYMXxFRWYr4vgVEFgkoEs9?=
 =?iso-8859-1?Q?BCV7fBn3+PS7xQmK9D0vsTmDAM1usFOXdZm2IhtZC3pqxBk2bq6S1sbqE6?=
 =?iso-8859-1?Q?PbsNNaiKevW/FyJ4Rj4fYLzmA2KEtyNnyl6pqN+i3Q4ty/jEdaZqGaow3U?=
 =?iso-8859-1?Q?wklDaYQgDoAFYfvmQpKd2dsj0c8rN6RA+jROY3Sizbf3QlqkPkqVg9yESj?=
 =?iso-8859-1?Q?LLnh4AJ8kTmzu6FTT0btVDrExiBAVzndQgtn6UA10zwhtLJPvGEuoLWnaZ?=
 =?iso-8859-1?Q?U91XDJKCN3J4hIcOitanYXZoSNRo9Ym44Wh05MDzblkm8wbZ0xy9mxcPra?=
 =?iso-8859-1?Q?28FTj9Z+aoqVaIDL0/r2RFhy9h64jK+MIa8qBMB8Rr7aWaZjGh1nkKJjrS?=
 =?iso-8859-1?Q?J+puIw3F+h1jAdvTBbGXQ9E5/Kp5yFJ9uTYr7psCxiZPrPce7xHmaBq7Zw?=
 =?iso-8859-1?Q?mn19rSUFvRZ+DXX/M/Fe9tSUKd3Oh3RGapwlLAphvs+8EepL1WpLGZSEgn?=
 =?iso-8859-1?Q?94PiFlpAVav/zRKNd5Htyb7L0877XnVVD+ejGyXyqU46QuHpFSVIfXu7x1?=
 =?iso-8859-1?Q?tBJbyF9JrwhMbSiu6LiVmdPsxNiGDKZUNbU1KIVdyElYgQ65j/NvtxB1mP?=
 =?iso-8859-1?Q?1j2TV5o+wp7WWUN49YW4SkQhznlWZt/oU7E/mNH0VhaK7UxMmU3+zDPNSI?=
 =?iso-8859-1?Q?enziv4UA3KLktmkKG9zuqnjrUz8LbjEnOZJmzEx/2wJ4vUPgpNWSKUJbBG?=
 =?iso-8859-1?Q?foguxNYt1ViP1gAG3nzyPkVm0gpQolCOcB05nN/dHdY7yhIELvWArmxvnh?=
 =?iso-8859-1?Q?/m79iOqeneY7ZiIVfUNhiblx6+RHvfzUTPD7qkLjDpBRS8Za2Vmft7s5hF?=
 =?iso-8859-1?Q?JG+qohxjm8XoBGuwggzMuKlicxhoar/WPw6v3NIy87iAFRO3zlVckiRfLM?=
 =?iso-8859-1?Q?GKG276FYzSzNni21AZgEGyDFo/TK47uivgDEElYTtcIicsbpJyWTToP2ED?=
 =?iso-8859-1?Q?2JctHdDwzXNCKOJCOpwfutWZGdADT/hpNadLRYxNxb57KNqO+Jc8s6ZY1v?=
 =?iso-8859-1?Q?0yHawQrnOfFBRf5jLSJ/fd/A3Q3CxkkFHjyLrpAG3bS/8e0AUlUeUr9Qp2?=
 =?iso-8859-1?Q?3U6h9TPJN6fZa6cCGhvfLgZ7aYwsWvlLmM5ODK3aS/diM9dxTc1wRcX6Uq?=
 =?iso-8859-1?Q?H1Lt1wdl+dIekZlWhphKVp/SnkbPPebQfax9z2iZOcOUvdJYYnuogYaKJc?=
 =?iso-8859-1?Q?nABjdlojC8QMzvQiOw99DtiLXrShDq/rUYry3CJC0k7ekK6N81V4QnH63u?=
 =?iso-8859-1?Q?ksuwhkV1F6CssRJkqAeVCQrPPxGq+b3gJ8qtbqu5tXg0fHZsZ9kd9CuWd/?=
 =?iso-8859-1?Q?h/MWFPi/yDCG7JOM7OIRjpiMCC4cShaYeNycEcgpc8ISu5XeCllIPOwIes?=
 =?iso-8859-1?Q?NFz26FRhBnEISho88pW7PKpk7AO/kqQrLfkCTx+EboMCsfb0g9ztLbnxvn?=
 =?iso-8859-1?Q?GvM2qLm1qvYPu0VAMMaVwAEvsQdVxGp5dWllgtW1eqHpgNE44crpZanmgW?=
 =?iso-8859-1?Q?r9LGEiWgFi2FCiV+QwVxG0gH53KdIJNcdKv0KAP2VNISbyIR1YRVLnM0HI?=
 =?iso-8859-1?Q?YACMoxJP/qet/pjAMj8tS5LNga/c++JevsWirX//n6ULKwlqFyyT?=
Content-Type: multipart/mixed;
	boundary="_005_AM7P192MB072141771FB0B0597BFC4034D1E52AM7P192MB0721EURP_"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	kIhLI2HfcjE7Pikz1/VOtViEWi22MO/0pjDZicSlf+2cV++Gw3785YuUd8fSoAt8wqct5LOEWDkIGebOqs7KO6zWhZgxEjCJ2X6305VDzxAdvGSc7aa2aKy4LsA7jaev0EaYHHiazHMW/gCmjjuj6dowe4k/XGzA1c6fm5oyycm0kUJMgrUjgnaas/sqGsuvJg1gHAabt0/oIi9n5iayRDVL5bVPrJti3GHrOcStGz++vOU1rFAKa3duWcMC5ZlF+A8cy5FDdAT1wtkxE36dzjbp8XTmDxN54YBJV/BSUPJtDeEPZN9HGEqarQyV+n2du6Sr8D1cXNUx486a1tJClQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HPCU21sypicS+RDNahh7X39Z0Ggglc42fWHUiAJ96WTteuJxECIY2A6jQoZiA0zeFUSSwiXKVWx9pXpgNaMB6L5Z9XNL8rNGkEGsojgiepgX83PHNzJAithcVMi3jqPCqMKuWpn+48QnHTDoJGb8q3Y9mX0eVQsLwevN5CtsA50IoLjF9GQpT8mohUbKEZ5h39eMKimkhPaih3wyBYGb77BNO5cbhoki4+hmVyhgeOxdJcD2LprPXsGg6IyX1ipWaKG5QQ7OVeaMY3GQfIWGfS4i5JLR2hh7O15ia678e6GqkjvEsAbtRhQT4a9b/eczVy0FRx9SDUEhjkcpnC1LLWeBgfw6WHdaR4l8mY7kyXcZ0qljyej6TtnVkC5aCz3KSxIYy6pB3okuXXLqqLrHYP8uK2AIhteQCbAKVsfRBsgKDBLQMVCnO3yQQarh9g97O9pdZTC2G7u2Dhwat+wuD2pmllcKG/LueDUNlupm9DFWZobld2NeDOTlIt6YNa+PlOMXtILzaIjVWHtDRxTsOmnA8/06NFTda0UV6Pz9S8mD4+d+FiGbMsRUNsrKEqzk1qZx18IaygZHm0NkonVtvSoayp0G5aqK8cy9IUBachYg6AqLyztBQtFAitjuTGwq
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P192MB0721.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 420e6560-2d13-47ab-4b4a-08decb9015fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 10:14:43.7532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6PwTlP+qtQaqV0g6ZXboMBAGmrItMU5LmPxsrIpT9ETQSU1slrfxKn23z/e6KAneyQHoNbu9Jw7kRnQud/HdFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP192MB2509
X-cloud-security-sender:tnizan@witekio.com
X-cloud-security-recipient:linux-can@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: tnizan@witekio.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-gate31-hz12 with 4gfjXQ4ggsz2TSqN
X-cloud-security-connect: mail-francesouthazon11021103.outbound.protection.outlook.com[40.107.130.103], TLS=1, IP=40.107.130.103
X-cloud-security-Digest:bf3c58d42a8868aca5649a4391a892b6
X-cloud-security:scantime:1.507
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.54 / 15.00];
	MIME_BAD_ATTACHMENT(1.60)[c:text/x-csrc];
	ARC_REJECT(1.00)[cv is fail on i=3];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[witekio.com,quarantine];
	R_DKIM_ALLOW(-0.20)[witekio.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain,text/x-patch,text/x-csrc];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7852-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rcsekar@samsung.com,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tnizan@witekio.com,linux-can@vger.kernel.org];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:+,5:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tnizan@witekio.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[witekio.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,witekio.com:dkim,witekio.com:email,witekio.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEF4668E333

--_005_AM7P192MB072141771FB0B0597BFC4034D1E52AM7P192MB0721EURP_
Content-Type: multipart/alternative;
	boundary="_000_AM7P192MB072141771FB0B0597BFC4034D1E52AM7P192MB0721EURP_"

--_000_AM7P192MB072141771FB0B0597BFC4034D1E52AM7P192MB0721EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Chandrasekar,
I am observing what looks like a bus-off recovery issue in the m_can driver=
 since commit e668673 ("can: m_can: Use the workqueue as queue"). The issue=
 is still present in current master.
Setup:

  *   TI K3 J784S4 SoC running Linux with the m_can controller enabled
  *   The CAN interface is connected directly to a Linux PC through a stand=
ard CAN transceiver setup
  *   Both sides are configured identically using:
ip link set can0 type can bitrate 250000
ip link set can0 type can restart-ms 100
  *   Continuous CAN TX traffic is generated from userspace on the J784S4 s=
ide using a simple SocketCAN application that continuously writes frames
  *   During transmission, the CANH/CANL lines are physically shorted to fo=
rce the controller into bus-off
  *   The short is then removed to observe the automatic recovery and TX re=
start behavior

Issue description:
If the CAN bus is shorted only briefly, recovery works correctly once the s=
hort is removed.
However, if the interface stays in bus-off for a longer period while usersp=
ace continues writing frames to the socket, the interface eventually stops =
transmitting permanently. After removing the short, the application only ge=
ts:

  *   Resource temporarily unavailable

and no more TX attempts occur.
From debugging, it looks like the TX path eventually stops being retriggere=
d after repeated restart cycles.
I traced this to the BUS_OFF handling in m_can_start_xmit():

if (cdev->can.state =3D=3D CAN_STATE_BUS_OFF) {
        return NETDEV_TX_OK;
}

Removing this block entirely seems to fix the issue in my testing, includin=
g after prolonged bus-off conditions and repeated restart cycles.

I attached:

  *   the small userspace stress program used to reproduce the issue (test_=
can_send.c)
  *   the experimental patch

My CAN framework knowledge is limited, so the proposed fix may not be the m=
ost appropriate solution, but I wanted to report the behavior in case this =
indicates a regression introduced by the workqueue conversion.

Let me know if you need more information.
Best regards,
Thomas Nizan

--_000_AM7P192MB072141771FB0B0597BFC4034D1E52AM7P192MB0721EURP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Ap=
tos_MSFontService&quot;, Calibri, Helvetica, sans-serif;">Hi Chandrasekar,<=
/span></div>
<div style=3D"direction: ltr; margin-top: 1em; margin-bottom: 1em; font-fam=
ily: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I am observing what looks like a bus-off recovery issue in the m_can driver=
 since commit
<code>e668673</code>&nbsp;(&quot;can: m_can: Use the workqueue as queue&quo=
t;). The issue is still present in current master.</div>
<div style=3D"direction: ltr; margin-top: 1em; margin-bottom: 1em; font-fam=
ily: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Setup:</div>
<ul style=3D"direction: ltr;" data-spread=3D"false">
<li style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apto=
s_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; col=
or: rgb(0, 0, 0); direction: ltr;">
TI K3 J784S4 SoC running Linux with the m_can&nbsp;controller enabled</li><=
li style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos=
_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; colo=
r: rgb(0, 0, 0); direction: ltr;">
The CAN interface is connected directly to a Linux PC through a standard CA=
N transceiver setup</li><li style=3D"font-family: Aptos, &quot;Aptos_Embedd=
edFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-ser=
if; font-size: 12pt; color: rgb(0, 0, 0); direction: ltr;">
Both sides are configured identically using:<br>
<code>ip link set can0 type can bitrate 250000</code><br>
<code>ip link set can0 type can restart-ms 100</code></li><li style=3D"font=
-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&q=
uot;, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
 direction: ltr;">
Continuous CAN TX traffic is generated from userspace on the J784S4 side us=
ing a simple SocketCAN application that continuously writes frames</li><li =
style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MS=
FontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; color: =
rgb(0, 0, 0); direction: ltr;">
During transmission, the CANH/CANL lines are physically shorted to force th=
e controller into bus-off</li><li style=3D"font-family: Aptos, &quot;Aptos_=
EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sa=
ns-serif; font-size: 12pt; color: rgb(0, 0, 0); direction: ltr;">
The short is then removed to observe the automatic recovery and TX restart =
behavior</li></ul>
<div style=3D"direction: ltr; margin-top: 1em; margin-bottom: 1em; font-fam=
ily: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; margin-top: 1em; margin-bottom: 1em; font-fam=
ily: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Issue description:<br>
If the&nbsp;CAN bus is shorted only briefly, recovery works correctly once =
the short is removed.</div>
<div style=3D"direction: ltr; margin-top: 1em; margin-bottom: 1em; font-fam=
ily: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
However, if the interface stays in bus-off for a longer period while usersp=
ace continues writing frames to the socket, the interface eventually stops =
transmitting permanently. After removing the short, the application only ge=
ts:</div>
<ul style=3D"direction: ltr;" data-spread=3D"false">
<li style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apto=
s_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; col=
or: rgb(0, 0, 0); direction: ltr;">
<code>Resource temporarily unavailable</code></li></ul>
<div style=3D"direction: ltr; margin-top: 1em; margin-bottom: 1em; font-fam=
ily: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
and&nbsp;no more TX attempts occur.</div>
<div style=3D"direction: ltr; margin-top: 1em; margin-bottom: 1em; font-fam=
ily: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
From debugging, it looks like the TX path eventually stops being retriggere=
d after repeated restart cycles.</div>
<div style=3D"direction: ltr; margin-top: 1em; margin-bottom: 1em; font-fam=
ily: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I traced this to the BUS_OFF handling in <code>m_can_start_xmit()</code>:</=
div>
<pre><div style=3D"direction: ltr; font-family: Aptos, &quot;Aptos_Embedded=
Font&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif=
; font-size: 12pt; color: rgb(0, 0, 0);"><code>if (cdev-&gt;can.state =3D=
=3D CAN_STATE_BUS_OFF) {=0A=
 &nbsp; &nbsp; &nbsp; &nbsp;return NETDEV_TX_OK;=0A=
}</code></div></pre>
<div style=3D"direction: ltr; font-family: Aptos, &quot;Aptos_EmbeddedFont&=
quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; fon=
t-size: 12pt; color: rgb(0, 0, 0);">
Removing this block entirely seems to fix the issue in my testing, includin=
g after prolonged bus-off conditions and repeated restart cycles.</div>
<div style=3D"direction: ltr; font-family: Aptos, &quot;Aptos_EmbeddedFont&=
quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; fon=
t-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; margin-top: 1em; margin-bottom: 1em; font-fam=
ily: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I attached:</div>
<ul style=3D"direction: ltr;" data-spread=3D"false">
<li style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apto=
s_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; col=
or: rgb(0, 0, 0); direction: ltr;">
the small userspace stress program used to reproduce the issue (<code>test_=
can_send.c</code>)</li><li style=3D"font-family: Aptos, &quot;Aptos_Embedde=
dFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0); direction: ltr;">
the experimental patch</li></ul>
<div style=3D"direction: ltr; margin-top: 1em; margin-bottom: 1em; font-fam=
ily: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
My CAN framework knowledge is limited, so the proposed fix may not be the m=
ost appropriate solution, but I wanted to report the behavior in case this =
indicates a regression introduced by the workqueue conversion.</div>
<div style=3D"direction: ltr; margin-top: 1em; margin-bottom: 1em; font-fam=
ily: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; margin-top: 1em; margin-bottom: 1em; font-fam=
ily: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Let me know if you need more information.</div>
<div style=3D"direction: ltr; margin-top: 1em; margin-bottom: 1em; font-fam=
ily: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Best regards,<br>
Thomas Nizan</div>
</body>
</html>

--_000_AM7P192MB072141771FB0B0597BFC4034D1E52AM7P192MB0721EURP_--

--_005_AM7P192MB072141771FB0B0597BFC4034D1E52AM7P192MB0721EURP_
Content-Type: text/x-patch; name="0001-m_can-bus-off-recovery-fix.patch"
Content-Description: 0001-m_can-bus-off-recovery-fix.patch
Content-Disposition: attachment;
	filename="0001-m_can-bus-off-recovery-fix.patch"; size=822;
	creation-date="Thu, 14 May 2026 21:05:14 GMT";
	modification-date="Tue, 16 Jun 2026 10:12:37 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkYjE0Yjg0ZmYyOTNmYzA1MzU4MGU1NWUxZDNhMGVkNDIyZGY1NDU0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaG9tYXMgTml6YW4gPHRuaXphbkB3aXRla2lvLmNvbT4KRGF0
ZTogVGh1LCAxNCBNYXkgMjAyNiAxMzo1MToxNCAtMDcwMApTdWJqZWN0OiBbUEFUQ0hdIG1fY2Fu
OiBidXMtb2ZmIHJlY292ZXJ5IGZpeAoKU2lnbmVkLW9mZi1ieTogVGhvbWFzIE5pemFuIDx0bml6
YW5Ad2l0ZWtpby5jb20+Ci0tLQogZHJpdmVycy9uZXQvY2FuL21fY2FuL21fY2FuLmMgfCA1IC0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9jYW4vbV9jYW4vbV9jYW4uYyBiL2RyaXZlcnMvbmV0L2Nhbi9tX2Nhbi9tX2Nhbi5jCmlu
ZGV4IGViODU2NTQ3YWU3ZC4uNmQwYjMwYzE4MGJmIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC9j
YW4vbV9jYW4vbV9jYW4uYworKysgYi9kcml2ZXJzL25ldC9jYW4vbV9jYW4vbV9jYW4uYwpAQCAt
MjAzNSwxMSArMjAzNSw2IEBAIHN0YXRpYyBuZXRkZXZfdHhfdCBtX2Nhbl9zdGFydF94bWl0KHN0
cnVjdCBza19idWZmICpza2IsCiAKIAlmcmFtZV9sZW4gPSBjYW5fc2tiX2dldF9mcmFtZV9sZW4o
c2tiKTsKIAotCWlmIChjZGV2LT5jYW4uc3RhdGUgPT0gQ0FOX1NUQVRFX0JVU19PRkYpIHsKLQkJ
bV9jYW5fY2xlYW4oY2Rldi0+bmV0KTsKLQkJcmV0dXJuIE5FVERFVl9UWF9PSzsKLQl9Ci0KIAly
ZXQgPSBtX2Nhbl9zdGFydF90eChjZGV2KTsKIAlpZiAocmV0ICE9IE5FVERFVl9UWF9PSykKIAkJ
cmV0dXJuIHJldDsKLS0gCjIuNDMuMAoK

--_005_AM7P192MB072141771FB0B0597BFC4034D1E52AM7P192MB0721EURP_
Content-Type: text/x-csrc; name="test_can_send.c"
Content-Description: test_can_send.c
Content-Disposition: attachment; filename="test_can_send.c"; size=2642;
	creation-date="Thu, 14 May 2026 21:06:51 GMT";
	modification-date="Tue, 16 Jun 2026 10:12:37 GMT"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN5cy9zb2NrZXQuaD4KI2luY2x1ZGUgPHN5cy90eXBlcy5oPgojaW5jbHVkZSA8
c3lzL2lvY3RsLmg+CiNpbmNsdWRlIDxuZXQvaWYuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5j
bHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGludC5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNp
bmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8c2lnbmFsLmg+CiNpbmNsdWRlIDxmY250bC5oPgoj
aW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHRpbWUuaD4K
I2luY2x1ZGUgPGxpbnV4L2Nhbi5oPgojaW5jbHVkZSA8bGludXgvY2FuL3Jhdy5oPgojaW5jbHVk
ZSA8bGludXgvY2FuL2Vycm9yLmg+CgppbnQgc2VuZF9zb2NrOwoKaW50IG9wZW5fc29ja2V0KHZv
aWQpCnsKCWNoYXIgY2FuX2ludGVyZmFjZV9zdHJbNV0gPSAiY2FuMCI7CglpbnQgZmxhZ3M7Cglz
dHJ1Y3Qgc29ja2FkZHJfY2FuIGFkZHI7CglzdHJ1Y3QgaWZyZXEgaWZyOwogICBpbnQgZXJyb3Jf
Y29kZTsKCglzZW5kX3NvY2sgPSBzb2NrZXQoUEZfQ0FOLCBTT0NLX1JBVywgQ0FOX1JBVyk7Cglp
ZiAoc2VuZF9zb2NrIDwgMCkgewoJCXBlcnJvcigwKTsKCQlyZXR1cm4gLTU7Cgl9CgoJZmxhZ3Mg
PSBmY250bChzZW5kX3NvY2ssIEZfR0VURkwpOwoJZmNudGwoc2VuZF9zb2NrLCBGX1NFVEZMLCBm
bGFncyB8IE9fTk9OQkxPQ0spOwoKCXN0cmNweShpZnIuaWZyX25hbWUsIGNhbl9pbnRlcmZhY2Vf
c3RyKTsKCWlvY3RsKHNlbmRfc29jaywgU0lPQ0dJRklOREVYLCAmaWZyKTsKCglhZGRyLmNhbl9m
YW1pbHkgPSBBRl9DQU47CglhZGRyLmNhbl9pZmluZGV4ID0gaWZyLmlmcl9pZmluZGV4OwoKCWVy
cm9yX2NvZGUgPSBiaW5kKHNlbmRfc29jaywgKHN0cnVjdCBzb2NrYWRkciAqKSZhZGRyLCBzaXpl
b2YoYWRkcikpOwoJaWYgKGVycm9yX2NvZGUgPCAwKSB7CgkJcGVycm9yKDApOwoJCXJldHVybiAt
NjsKCX0KCXNlbmRfc29jayA9IHNvY2tldChQRl9DQU4sIFNPQ0tfUkFXLCBDQU5fUkFXKTsKCWlm
IChzZW5kX3NvY2sgPCAwKSB7CgkJcGVycm9yKDApOwoJCXJldHVybiAtNTsKCX0KCglmbGFncyA9
IGZjbnRsKHNlbmRfc29jaywgRl9HRVRGTCk7CglmY250bChzZW5kX3NvY2ssIEZfU0VURkwsIGZs
YWdzIHwgT19OT05CTE9DSyk7CgoJc3RyY3B5KGlmci5pZnJfbmFtZSwgY2FuX2ludGVyZmFjZV9z
dHIpOwoJaW9jdGwoc2VuZF9zb2NrLCBTSU9DR0lGSU5ERVgsICZpZnIpOwoKCWFkZHIuY2FuX2Zh
bWlseSA9IEFGX0NBTjsKCWFkZHIuY2FuX2lmaW5kZXggPSBpZnIuaWZyX2lmaW5kZXg7CgoJZXJy
b3JfY29kZSA9IGJpbmQoc2VuZF9zb2NrLCAoc3RydWN0IHNvY2thZGRyICopJmFkZHIsIHNpemVv
ZihhZGRyKSk7CglpZiAoZXJyb3JfY29kZSA8IDApIHsKCQlwZXJyb3IoMCk7CgkJcmV0dXJuIC02
OwoJfQogICByZXR1cm4gMDsKfQoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKewoJ
dWludDY0X3QgY2FuX2lkOwoJdWludDY0X3QgY2FuX21lc3NhZ2U7CglzdHJ1Y3QgY2FuX2ZyYW1l
IGZyYW1lOwoJaW50IGVycm9yX2NvZGU7CglpbnQgaTsKCXN0cnVjdCB0aW1lc3BlYyBzcGVjOwoK
CWNhbl9pZCA9IDA7CgogICBpZiAoIChlcnJvcl9jb2RlID0gb3Blbl9zb2NrZXQoKSkgPCAwICkg
cmV0dXJuIGVycm9yX2NvZGU7CgoJZnJhbWUuY2FuX2lkID0gY2FuX2lkOwoJZnJhbWUuY2FuX2lk
IHw9IENBTl9FRkZfRkxBRzsKCWZyYW1lLmNhbl9kbGMgPSA4OwoKICAgbWVtc2V0KGZyYW1lLmRh
dGEsIDAsIDgpOwoKICAgd2hpbGUgKDEpCiAgIHsKICAgICAgZm9yIChpPTA7IGk8MTA7IGkrKykK
ICAgICAgewogICAgICAgICBjbG9ja19nZXR0aW1lKENMT0NLX1JFQUxUSU1FLCAmc3BlYyk7CiAg
ICAgICAgIGVycm9yX2NvZGUgPSBzZW5kKHNlbmRfc29jaywgJmZyYW1lLCBzaXplb2Yoc3RydWN0
IGNhbl9mcmFtZSksIE1TR19ET05UV0FJVCk7CiAgICAgICAgIGlmIChlcnJvcl9jb2RlIDwgMCkK
ICAgICAgICAgewogICAgICAgICAgICBwZXJyb3IoMCk7CiNpZiAwCiAgICAgICAgICAgIGlmICgg
KGVycm5vID09IEVOT0JVRlMpIHx8IChlcnJubyA9PSBFQUdBSU4pICkKICAgICAgICAgICAgewog
ICAgICAgICAgICAgICBjbG9zZShzZW5kX3NvY2spOwogICAgICAgICAgICAgICBpZiAoIChlcnJv
cl9jb2RlID0gb3Blbl9zb2NrZXQoKSkgPCAwICkgcmV0dXJuIGVycm9yX2NvZGU7CiAgICAgICAg
ICAgICAgIHByaW50ZigiQ2xvc2luZyBhbmQgb3BlbmluZyBzb2NrZXQuXG4iKTsKICAgICAgICAg
ICAgfQojZW5kaWYKICAgICAgICAgfQogICAgICAgICBlbHNlCiAgICAgICAgIHsKICAgICAgICAg
ICAgcHJpbnRmKCIlbGxkLiUwOWxkOiAgaWQ9MHglMDh4IGxlbj0leCBtc2dbMF09JXhcbiIsIChs
b25nIGxvbmcpc3BlYy50dl9zZWMsIHNwZWMudHZfbnNlYywgKGZyYW1lLmNhbl9pZCAmIDB4MUZG
RkZGRkYpLCBmcmFtZS5jYW5fZGxjLCBmcmFtZS5kYXRhWzBdKTsKICAgICAgICAgfQogICAgICAg
IAogICAgICAgICBmcmFtZS5jYW5faWQrKzsKICAgICAgICAgZnJhbWUuZGF0YVswXSA9IGZyYW1l
LmNhbl9pZDsKICAgICAgfQogICAgICB1c2xlZXAoMTAwMDApOwogICB9CgoJY2xvc2Uoc2VuZF9z
b2NrKTsKCglyZXR1cm4gMDsKfQo=

--_005_AM7P192MB072141771FB0B0597BFC4034D1E52AM7P192MB0721EURP_--

